Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6F473F42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhLNJWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 04:22:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232338AbhLNJWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639473754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Qo42twS75Z7ZJR7C1TBiiKdNQ/xVKTbtAvqEJPzZdyQ=;
        b=LXmQIQKVMriGrHHN9BdLJ7KDtkTdhS3kxdHbOy529HDYVowiLvYBr3hIIUgRRQApfF0tM9
        Hvn6EU691LmXK0sSqsLOcQOxR8Assg1cXe1lXESB33OM6r63yLXvCcOq7wnSKTtTxocMxG
        ZEKyJ0qeN7jI4uComgqI3Xtyk6RS4u0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-1NNENfjxOvC5CXdbcZ6xsw-1; Tue, 14 Dec 2021 04:22:30 -0500
X-MC-Unique: 1NNENfjxOvC5CXdbcZ6xsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 738411006AAB;
        Tue, 14 Dec 2021 09:22:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA14D60C9F;
        Tue, 14 Dec 2021 09:22:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        jaltman@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix mmap
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <759479.1639473732.1@warthog.procyon.org.uk>
Date:   Tue, 14 Dec 2021 09:22:12 +0000
Message-ID: <759480.1639473732@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply this patch please?  Note the odd email address in the
Reported-by and Tested-by fields.  That's an attempt to note Auristor's
internal testcase ID for their tracking purposes.  Is this a reasonable way
to do it?  It's kind of modelled on what syzbot does.  Would it be
preferable to use some other field or a comment after the Reported-by
instead?

David
---
afs: Fix mmap

Fix afs_add_open_map() to check that the vnode isn't already on the list
when it adds it.  It's possible that afs_drop_open_mmap() decremented the
cb_nr_mmap counter, but hadn't yet got into the locked section to remove
it.

Also vnode->cb_mmap_link should be initialised, so fix that too.

Fixes: 6e0e99d58a65 ("afs: Fix mmap coherency vs 3rd-party changes")
Reported-by: kafs-testing+fedora34_64checkkafs-build-300@auristor.com
Suggested-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: kafs-testing+fedora34_64checkkafs-build-300@auristor.com
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/686465.1639435380@warthog.procyon.org.uk/ # v1
---
 fs/afs/file.c  |    5 +++--
 fs/afs/super.c |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)


diff --git a/fs/afs/file.c b/fs/afs/file.c
index cb6ad61eec3b..afe4b803f84b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -514,8 +514,9 @@ static void afs_add_open_mmap(struct afs_vnode *vnode)
 	if (atomic_inc_return(&vnode->cb_nr_mmap) == 1) {
 		down_write(&vnode->volume->cell->fs_open_mmaps_lock);
 
-		list_add_tail(&vnode->cb_mmap_link,
-			      &vnode->volume->cell->fs_open_mmaps);
+		if (list_empty(&vnode->cb_mmap_link))
+			list_add_tail(&vnode->cb_mmap_link,
+				      &vnode->volume->cell->fs_open_mmaps);
 
 		up_write(&vnode->volume->cell->fs_open_mmaps_lock);
 	}
diff --git a/fs/afs/super.c b/fs/afs/super.c
index d110def8aa8e..34c68724c98b 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -667,6 +667,7 @@ static void afs_i_init_once(void *_vnode)
 	INIT_LIST_HEAD(&vnode->pending_locks);
 	INIT_LIST_HEAD(&vnode->granted_locks);
 	INIT_DELAYED_WORK(&vnode->lock_work, afs_lock_work);
+	INIT_LIST_HEAD(&vnode->cb_mmap_link);
 	seqlock_init(&vnode->cb_lock);
 }
 

