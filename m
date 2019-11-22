Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62D8107BAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 00:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKVXxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 18:53:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39575 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726666AbfKVXxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574466818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e8LnAK96cO1Kj05+ukhpTbSenDBS0l/Ge53Izwdy1dc=;
        b=egY9Rh7vKwRVZES4wbxgy9mEEMmdPJggnSamzXldkT/26iUHRDd96k8Xgtx5lfTKfdszsw
        zt+dDgSER2FZY00jEoR9q7aMmj8fxBtPnFxU8nv9yp+AwKupd2grgCIL8tRncMzrsRXtq2
        12pVxn3WFjiAUMlZ9mx6hlC7InQDlyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-oS30aRTpOTqH0Wo7idawag-1; Fri, 22 Nov 2019 18:53:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B6DE801E74;
        Fri, 22 Nov 2019 23:53:34 +0000 (UTC)
Received: from max.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF6275C1B5;
        Fri, 22 Nov 2019 23:53:26 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>, cluster-devel@redhat.com,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC PATCH 0/3] Rework the gfs2 read and page fault locking
Date:   Sat, 23 Nov 2019 00:53:21 +0100
Message-Id: <20191122235324.17245-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: oS30aRTpOTqH0Wo7idawag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this patch series moves the glock lock taking in gfs2 from the
->readpage and ->readpages inode operations to the ->read_iter file and
->fault vm operations.  To achieve that, we add flags to the
generic_file_read_iter and filemap_fault generic helpers.

This proposal was triggered by the following discussion:

https://lore.kernel.org/linux-fsdevel/157225677483.3442.4227193290486305330=
.stgit@buzz/

In that thread, Linus argued that filesystems should make sure the inode
size is sufficiently up-to-date before calling the generic helpers, and
that filesystems can do it themselves if they want more than that.
That's surely doable.  However, implementing those operations properly
at the filesystem level quickly becomes complicated when it gets to
things like readahead.  In addition, those slightly modified copies of
those helpers would surely diverge from their originals over time, and
maintaining them properly would become hard.  So I hope the relatively
small changes to make the original helpers slightly more flexible will
be acceptable instead.

With the IOCB_CACHED flag added by one of the patches in this series,
the code that Konstantin's initial patch adds to
generic_file_buffered_read could be made conditional on the IOCB_CACHED
flag being cleared.  That way, it won't misfire on filesystems that
allow a stale inode size.  (I'm not sure if any filesystems other than
gfs2 are actually affected.)

Some additional explanation:

The cache consistency model of filesystems like gfs2 is such that if
pages are found in an inode's address space, those pages as well as the
inode size are up to date and can be used without taking any filesystem
locks.  If a page is not cached, filesystem locks must be taken before
the page can be read; this will also bring the inode size up to date.

Thus far, gfs2 has taken the filesystem locks inside the ->readpage and
->readpages address space operations.  A better approach seems to be to
take those locks earlier, in the ->read_iter file and ->fault vm
operations.  This would also avoid a lock inversion in ->readpages.

We obviously want to avoid taking the filesystem locks unnecessarily
when the pages we are looking for are already cached; otherwise, we
would cripple performance.  So we need to check if those pages are
present first.  That's actually exactly what the generic_file_read_iter
and filemap_fault helpers do already anyway, except that they will call
into ->readpage and ->readpages when they find pages missing.  Instead
of that, we'd like those helpers to return with an error code that
allows us to retry the operation after taking the filesystem locks.

Thanks,
Andreas

Andreas Gruenbacher (3):
  fs: Add IOCB_CACHED flag for generic_file_read_iter
  fs: Add FAULT_FLAG_CACHED flag for filemap_fault
  gfs2: Rework read and page fault locking

 fs/gfs2/aops.c     | 36 +++++--------------------
 fs/gfs2/file.c     | 66 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  1 +
 include/linux/mm.h |  4 ++-
 mm/filemap.c       | 60 ++++++++++++++++++++++++++++++-----------
 5 files changed, 119 insertions(+), 48 deletions(-)

--=20
2.20.1

