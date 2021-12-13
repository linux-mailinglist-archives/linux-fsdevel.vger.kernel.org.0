Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2954737BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 23:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbhLMWnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 17:43:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243736AbhLMWnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639435386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vW4X6Ke5veUZbybwsL96gvfHgtgqWjDKHvFvdIhk4m4=;
        b=NBxEt+SbWT+YscEB9CB5jPPFaENDkBQxV3GFSqOUuc3H/5U7egMDXlMeDNGBdkhyAkvTg2
        u1adKcEIcDlTE2RNozLU2NGzQZzjHLOTF3S/UIo4l0VgWQSdte5UkbAUVbJH6GLbjM1T1D
        Yqm9NOeHHeT00039bGIIlezsU2Iz9vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-rlMMXtpWPBWNVWL8hbTtMQ-1; Mon, 13 Dec 2021 17:43:03 -0500
X-MC-Unique: rlMMXtpWPBWNVWL8hbTtMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78D1681EE61;
        Mon, 13 Dec 2021 22:43:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A05F7AB41;
        Mon, 13 Dec 2021 22:43:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <163941464554.620822.14509008966840730864.stgit@warthog.procyon.org.uk>
References: <163941464554.620822.14509008966840730864.stgit@warthog.procyon.org.uk>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix mmap
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <686464.1639435380.1@warthog.procyon.org.uk>
Date:   Mon, 13 Dec 2021 22:43:00 +0000
Message-ID: <686465.1639435380@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I forgot to commit the patch and so lost part of it.  Full patch below.

David
---
commit 23e7d72edeeff56d7bfa47c32c9638385c90eddd
Author: David Howells <dhowells@redhat.com>
Date:   Mon Dec 13 16:26:44 2021 +0000

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
    cc: linux-afs@lists.infradead.org

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
 

