Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC53338111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 00:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCKXGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 18:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhCKXGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615503998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sa6wetqoaJXD5avPHDgES9Xzvvsmx+M+iS9y4Mh8zBg=;
        b=OzdyBMXxQTiMUe9vYpKLmcDEGNH1BlmnoFw2nzNwX0R89ISO/XyQCMiEKIbgkKMfA7xB5q
        oaD4vgaFWUZGylFtpJFBefWJBCN15zQY3JxmvOyg4o5mf3S819lMr+QoV6CiflQHHAO8MS
        WQzmWNOucLXBf1DMX7Y2KryByBW6YeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-9H2dl-48Pv6GyHW72EhGLQ-1; Thu, 11 Mar 2021 18:06:34 -0500
X-MC-Unique: 9H2dl-48Pv6GyHW72EhGLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240DD83DE7F;
        Thu, 11 Mar 2021 23:06:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C6A310013C1;
        Thu, 11 Mar 2021 23:06:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 1/2] afs: Fix accessing YFS xattrs on a non-YFS server
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        dhowells@redhat.com,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Mar 2021 23:06:31 +0000
Message-ID: <161550399136.1983424.7800131837410640702.stgit@warthog.procyon.org.uk>
In-Reply-To: <161550398415.1983424.4857046033308089813.stgit@warthog.procyon.org.uk>
References: <161550398415.1983424.4857046033308089813.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If someone attempts to access YFS-related xattrs (e.g. afs.yfs.acl) on a
file on a non-YFS AFS server (such as OpenAFS), then the kernel will jump
to a NULL function pointer because the afs_fetch_acl_operation descriptor
doesn't point to a function for issuing an operation on a non-YFS
server[1].

Fix this by making afs_wait_for_operation() check that the issue_afs_rpc
method is set before jumping to it and setting -ENOTSUPP if not.  This fix
also covers other potential operations that also only exist on YFS servers.

afs_xattr_get/set_yfs() then need to translate -ENOTSUPP to -ENODATA as the
former error is internal to the kernel.

The bug shows up as an oops like the following:

	BUG: kernel NULL pointer dereference, address: 0000000000000000
	[...]
	Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
	[...]
	Call Trace:
	 afs_wait_for_operation+0x83/0x1b0 [kafs]
	 afs_xattr_get_yfs+0xe6/0x270 [kafs]
	 __vfs_getxattr+0x59/0x80
	 vfs_getxattr+0x11c/0x140
	 getxattr+0x181/0x250
	 ? __check_object_size+0x13f/0x150
	 ? __fput+0x16d/0x250
	 __x64_sys_fgetxattr+0x64/0xb0
	 do_syscall_64+0x49/0xc0
	 entry_SYSCALL_64_after_hwframe+0x44/0xa9
	RIP: 0033:0x7fb120a9defe

This was triggered with "cp -a" which attempts to copy xattrs, including
afs ones, but is easier to reproduce with getfattr, e.g.:

	getfattr -d -m ".*" /afs/openafs.org/

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Reported-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
cc: linux-afs@lists.infradead.org
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003498.html [1]
---

 fs/afs/fs_operation.c |    7 +++++--
 fs/afs/xattr.c        |    8 +++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 97cab12b0a6c..71c58723763d 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -181,10 +181,13 @@ void afs_wait_for_operation(struct afs_operation *op)
 		if (test_bit(AFS_SERVER_FL_IS_YFS, &op->server->flags) &&
 		    op->ops->issue_yfs_rpc)
 			op->ops->issue_yfs_rpc(op);
-		else
+		else if (op->ops->issue_afs_rpc)
 			op->ops->issue_afs_rpc(op);
+		else
+			op->ac.error = -ENOTSUPP;
 
-		op->error = afs_wait_for_call_to_complete(op->call, &op->ac);
+		if (op->call)
+			op->error = afs_wait_for_call_to_complete(op->call, &op->ac);
 	}
 
 	switch (op->error) {
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index c629caae5002..4934e325a14a 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -231,6 +231,8 @@ static int afs_xattr_get_yfs(const struct xattr_handler *handler,
 			else
 				ret = -ERANGE;
 		}
+	} else if (ret == -ENOTSUPP) {
+		ret = -ENODATA;
 	}
 
 error_yacl:
@@ -256,6 +258,7 @@ static int afs_xattr_set_yfs(const struct xattr_handler *handler,
 {
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
+	int ret;
 
 	if (flags == XATTR_CREATE ||
 	    strcmp(name, "acl") != 0)
@@ -270,7 +273,10 @@ static int afs_xattr_set_yfs(const struct xattr_handler *handler,
 		return afs_put_operation(op);
 
 	op->ops = &yfs_store_opaque_acl2_operation;
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+	if (ret == -ENOTSUPP)
+		ret = -ENODATA;
+	return ret;
 }
 
 static const struct xattr_handler afs_xattr_yfs_handler = {


