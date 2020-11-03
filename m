Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3A2A4B9B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgKCQdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 11:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728377AbgKCQdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604421193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZCzKRL0ECnadUQEwWKEdmBBdVE87yV+82kbNuBkIxQ=;
        b=Atu3ex4NvO7uIjvgxc9S/mHHUHuyY0KgpfZ7Y1ZKuZ2qu6G4pxVqk6UhP80lZehbWP7DkA
        JewZNy55D3F8D47j9a0vXZWqcxfL8NzuBVXkiIv5lAFZQ4d2sZH4DsoqFQNM6tYDnJUwb/
        KoqYU4VeLURE32w3zB3NbhX1lkMiM0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-eUVIqRGOOpSr9wJJKfiBlQ-1; Tue, 03 Nov 2020 11:33:10 -0500
X-MC-Unique: eUVIqRGOOpSr9wJJKfiBlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F30CC1009E2E;
        Tue,  3 Nov 2020 16:33:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE8921EC3;
        Tue,  3 Nov 2020 16:33:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] afs: Fix incorrect freeing of the ACL passed to the YFS
 ACL store op
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Nov 2020 16:33:07 +0000
Message-ID: <160442118721.677368.3384443620412523954.stgit@warthog.procyon.org.uk>
In-Reply-To: <160442117884.677368.3642109457622229990.stgit@warthog.procyon.org.uk>
References: <160442117884.677368.3642109457622229990.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cleanup for the yfs_store_opaque_acl2_operation calls the wrong
function to destroy the ACL content buffer.  It's an afs_acl struct, not a
yfs_acl struct - and the free function for latter may pass invalid pointers
to kfree().

Fix this by using the afs_acl_put() function.  The yfs_acl_put() function
is then no longer used and can be removed.

	general protection fault, probably for non-canonical address 0x7ebde00000000: 0000 [#1] SMP PTI
	...
	RIP: 0010:compound_head+0x0/0x11
	...
	Call Trace:
	 virt_to_cache+0x8/0x51
	 ? yfs_free_opaque_acl+0x16/0x29
	 kfree+0x5d/0x79
	 yfs_free_opaque_acl+0x16/0x29
	 afs_put_operation+0x60/0x114
	 __vfs_setxattr+0x67/0x72
	 __vfs_setxattr_noperm+0x66/0xe9
	 vfs_setxattr+0x67/0xce
	 setxattr+0x14e/0x184
	 ? __handle_mm_fault+0x4c8/0x4f8
	 ? handle_mm_fault+0x123/0x1ef
	 __do_sys_fsetxattr+0x66/0x8f
	 do_syscall_64+0x2d/0x3a
	 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/xattr.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 38884d6c57cd..95c573dcda11 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -148,11 +148,6 @@ static const struct xattr_handler afs_xattr_afs_acl_handler = {
 	.set    = afs_xattr_set_acl,
 };
 
-static void yfs_acl_put(struct afs_operation *op)
-{
-	yfs_free_opaque_acl(op->yacl);
-}
-
 static const struct afs_operation_ops yfs_fetch_opaque_acl_operation = {
 	.issue_yfs_rpc	= yfs_fs_fetch_opaque_acl,
 	.success	= afs_acl_success,
@@ -246,7 +241,7 @@ static int afs_xattr_get_yfs(const struct xattr_handler *handler,
 static const struct afs_operation_ops yfs_store_opaque_acl2_operation = {
 	.issue_yfs_rpc	= yfs_fs_store_opaque_acl2,
 	.success	= afs_acl_success,
-	.put		= yfs_acl_put,
+	.put		= afs_acl_put,
 };
 
 /*


