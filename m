Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95E35F405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhDNMjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbhDNMjC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:39:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BA83611B0;
        Wed, 14 Apr 2021 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618403921;
        bh=McPw3CpQkPn0LPU4NbjINIKS3JUko4oWL/Fgux77pnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eM5p60YdcWgwuMo6Xo5LAPmv31aqq8xnsvIq4obDU/7w3T76Ae7YZo9MrJ/rqImGT
         pnsB9r4BqCTDWtGprfwoXvc4QY7HvRKf2M6I9zAp2yeUJnE5MTuNXLqHcTV0tpOzyw
         iUtan51RXRItvYkROTVYHQljEJLxr3I+Vt4Y5fwq5OMUh7vAcOJVMqil/GLM1bvhBS
         aBLSd0LMINXoTyP3mYR161Z7qOBD6prVhTz1FUhNc1Z5c829b2pTDkd1lWaU/pwkPW
         TSYU40A6ZsuPwMfkIh90ZML4LNWSRYAQRIJgfZggsamUnNBRgdndNVmLOdTHQebgtq
         Z5nCSImECMEuQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/7] namespace: add kernel doc for mnt_clone_internal()
Date:   Wed, 14 Apr 2021 14:37:46 +0200
Message-Id: <20210414123750.2110159-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414123750.2110159-1-brauner@kernel.org>
References: <20210414123750.2110159-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=jBO34yTxB8bcJDNJq5wyTUQeL0/1ZCfYS2ZDxiTmIdE=; m=IiCeUIXZorhQEWHc615NYZk6WrnbxHgrkwHPs6aKB6E=; p=yfLKT3q8PN5tBMAd2IiBeetSQMKvFza+4gNsKpOHu3w=; g=0fda3c9759267fe5b2a619ffc64ace4696480ec8
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHbh3wAKCRCRxhvAZXjcong/AP9hXfZ 8QGHNXycaEHAq1UnQs/HQfdCYLk9erfJSyRxvrQD/S2GXC1LEKEP2hVXyl55xNJjAtBVkvQ3CMI+N LuYwFAc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Document mnt_clone_internal().

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namespace.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 02f415061efe..7ffefa8b3980 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1271,6 +1271,22 @@ bool path_is_mountpoint(const struct path *path)
 }
 EXPORT_SYMBOL(path_is_mountpoint);
 
+/**
+ * mnt_clone_internal - create a private clone of a path
+ * @path: path from which the mnt to clone will be taken
+ *
+ * This creates a new vfsmount, which will be a clone of @path's vfsmount.
+ *
+ * In contrast to clone_private_mount() the new mount will be marked
+ * MNT_INTERNAL and will note have any mount namespace attached making it
+ * suitable for short-lived internal mounts since mntput()ing it will always
+ * hit the slowpath taking the mount lock.
+ *
+ * Since the mount is not reachable anwyhere mount properties and propagation
+ * properties remain stable, i.e. cannot change.
+ *
+ * Return: A clone of @path's vfsmount on success, an error pointer on failure.
+ */
 struct vfsmount *mnt_clone_internal(const struct path *path)
 {
 	struct mount *p;
-- 
2.27.0

