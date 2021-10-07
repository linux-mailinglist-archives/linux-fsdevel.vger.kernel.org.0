Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552294257D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbhJGQYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 12:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242274AbhJGQYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633623768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YlCCMepVWxlDt+ZxOI3nKL7iXR5cvBw/XyYjKdfC9HI=;
        b=fUavj23ZigkAvEdjb5ndLkA6zpmymOKH1L6BpkYgxA5QswTZhprXTP6fGJYKcxkO12G37c
        rKpmpl7WMG4aankc7ce1lac69z5alpL14NaINSVXG28raC9HaqO8ceHjwTGopNrgmTKGB6
        8MWhzdbDAO73E71M5kGpQdHsPPhSDJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-niXwdHv8Pz2BQVcuslP5yQ-1; Thu, 07 Oct 2021 12:22:45 -0400
X-MC-Unique: niXwdHv8Pz2BQVcuslP5yQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D97614242DB;
        Thu,  7 Oct 2021 15:53:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABDA8D1F28;
        Thu,  7 Oct 2021 15:53:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@kvack.org
Subject: [GIT PULL] netfs, cachefiles, afs: Collected fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1961631.1633621984.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 07 Oct 2021 16:53:04 +0100
Message-ID: <1961632.1633621984@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull this set of collected fixes please?  There are three:

 (1) Fix another couple of oopses in cachefiles tracing stemming from the
     possibility of passing in a NULL object pointer[1].

 (2) Fix netfs_clear_unread() to set READ on the iov_iter so that source i=
t
     is passed to doesn't do the wrong thing (some drivers look at the fla=
g
     on iov_iter rather than other available information to determine the
     direction)[2].

 (3) Fix afs_launder_page() to write back at the correct file position on
     the server so as not to corrupt data[3].

David

Link: https://lore.kernel.org/r/162729351325.813557.9242842205308443901.st=
git@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/162886603464.3940407.3790841170414793899.s=
tgit@warthog.procyon.org.uk [1]
Link: https://lore.kernel.org/r/163239074602.1243337.14154704004485867017.=
stgit@warthog.procyon.org.uk [1]
Link: https://lore.kernel.org/r/162729351325.813557.9242842205308443901.st=
git@warthog.procyon.org.uk/ [2]
Link: https://lore.kernel.org/r/162886603464.3940407.3790841170414793899.s=
tgit@warthog.procyon.org.uk [2]
Link: https://lore.kernel.org/r/163239074602.1243337.14154704004485867017.=
stgit@warthog.procyon.org.uk [2]
Link: https://lore.kernel.org/r/162880783179.3421678.7795105718190440134.s=
tgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/162937512409.1449272.18441473411207824084.=
stgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/162981148752.1901565.3663780601682206026.s=
tgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/163005741670.2472992.2073548908229887941.s=
tgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/163221839087.3143591.14278359695763025231.=
stgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/163292980654.4004896.7134735179887998551.s=
tgit@warthog.procyon.org.uk/ [3]

---
The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae4089=
6:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/misc-fixes-20211007

for you to fetch changes up to 5c0522484eb54b90f2e46a5db8d7a4ff3ff86e5d:

  afs: Fix afs_launder_page() to set correct start file position (2021-10-=
05 11:22:06 +0100)

----------------------------------------------------------------
netfslib, cachefiles and afs fixes

----------------------------------------------------------------
Dave Wysochanski (1):
      cachefiles: Fix oops with cachefiles_cull() due to NULL object

David Howells (2):
      netfs: Fix READ/WRITE confusion when calling iov_iter_xarray()
      afs: Fix afs_launder_page() to set correct start file position

 fs/afs/write.c                    | 3 +--
 fs/netfs/read_helper.c            | 2 +-
 include/trace/events/cachefiles.h | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

