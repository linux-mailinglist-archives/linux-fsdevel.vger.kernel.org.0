Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61A3AECA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFUPmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 11:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhFUPmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624290017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EGmr8KU/QYvg2NpXPR2eqgVDjMWUnLchWUGphjhj2eI=;
        b=VDz58zXKIB7sXhURp6KbfSpyZ73FO5j6ooKN9J16q2FJtm1OOnbUUpdHmM/kxVVjgLyeAR
        JrgoINpK0Kdtwka99oI0xdmXT9pj83EB6RTDJ2w+fIF7YKb7ukZDggkSyFqLySRIrn3ld9
        27YtlpJTPdDeRGiRnzACxQ9CZq6awPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-rFh51d3EMwupT8yangv-Lw-1; Mon, 21 Jun 2021 11:40:13 -0400
X-MC-Unique: rFh51d3EMwupT8yangv-Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66A2C8042F3;
        Mon, 21 Jun 2021 15:40:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CEE110013D6;
        Mon, 21 Jun 2021 15:40:07 +0000 (UTC)
Subject: [PATCH v3 0/2] netfs, afs: Fix write_begin/end
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Cc:     Andrew W Elble <aweits@rit.edu>, ceph-devel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jun 2021 16:40:06 +0100
Message-ID: <162429000639.2770648.6368710175435880749.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are some patches to fix netfs_write_begin() and afs_write_end() in the
following ways:

 (1) In netfs_write_begin(), extract the decision about whether to skip a
     page out to its own helper and have that clear around the region to be
     written, but not clear that region.  This requires the filesystem to
     patch it up afterwards if the hole doesn't get completely filled.

 (2) Use offset_in_thp() in (1) rather than manually calculating the offset
     into the page.

 (3) Due to (1), afs_write_end() now needs to handle short data write into
     the page by generic_perform_write().  I've adopted an analogous
     approach to ceph of just returning 0 in this case and letting the
     caller go round again.

Also add a note that (in the future) the len parameter may extend beyond
the page allocated.  This is because the page allocation is deferred to
write_begin() and that gets to decide what size of THP to allocate.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David

Link: https://lore.kernel.org/r/20210613233345.113565-1-jlayton@kernel.org/
Link: https://lore.kernel.org/r/162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk/ # v3

Changes
=======

ver #3:
   - Drop the bits that make afs take account of len exceeding the end of
     the page in afs_write_begin/end().

ver #2:
   - Removed a var that's no longer used (spotted by the kernel test robot)
   - Removed a forgotten "noinline".

ver #1:
   - Prefixed the Jeff's new helper with "netfs_".
   - Don't call zero_user_segments() for a full-page write.
   - Altered the beyond-last-page check to avoid a DIV.
   - Removed redundant zero-length-file check.
   - Added patches to fix afs.

---
David Howells (1):
      afs: Fix afs_write_end() to handle short writes

Jeff Layton (1):
      netfs: fix test for whether we can skip read when writing beyond EOF


 fs/netfs/read_helper.c | 49 +++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)


