Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9135F401
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhDNMjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhDNMi7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:38:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E852761158;
        Wed, 14 Apr 2021 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618403917;
        bh=XhcJ6hhr3dEm4tbK7n/9JaZNYoF4yEz/sBw0pVLhavQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryjltU1t50M1EJiBASTuYuaDqzLTpoOuOQH9TL/og6QAk5bYkiOBKJaeIBJPJRAKx
         tR3w4nUXmqibLILQMJqFR5BjlpRibSZZkBfGvIHbm1Wr0k9p1IXVLlgOquXhMwcImc
         Qx/qNAVTs5Blbj6ZwmyalhKacVGOPOe2i5c+Vpg6bzQf3M/RQBK2xYnid6hh0yhopc
         l+5RLeq9jM7kctH6gML8/WPhD0yQMK6moRD2o0GmZsOv8taBVsUq7ZQ1ZSKFDnsN0a
         371eaC1TIoWaod6oazNOwdRwdryxhYySB5iB5h/rNAQm7EOoHjk9SCpQ74bplDs8T4
         7hBOXK41AVIlA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/7] namespace: fix clone_private_mount() kernel doc
Date:   Wed, 14 Apr 2021 14:37:45 +0200
Message-Id: <20210414123750.2110159-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414123750.2110159-1-brauner@kernel.org>
References: <20210414123750.2110159-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=Ug070dnCYtvoTTL9sM+KCsYvFzZzgfpQ1rAeZsa4E0c=; m=Nyy5JV6keYRz9DaoVlPSewQmP7/guf8xde0k24FEh8I=; p=Ez0P8VpCpQt2UopiUYXdmn61d6ikUXWbnh4YqIFsC/g=; g=e2958c68e45ab891ebc18d84945f46ea030fd186
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHbh3wAKCRCRxhvAZXjcoufWAP9xjcj 8M8rEHzBJtuKW2qoVv2jPFVwHN8aJICtFeGnOWQEAlTvTfEAfp8jjIc53K83adZs9p6OiZMZJhrA/ 5TLbaw4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Extend the kernel documentation for clone_private_mount(). Add some more
detailed info about its usage and convert it into proper kernel doc.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namespace.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 56bb5a5fdc0d..02f415061efe 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1939,12 +1939,21 @@ void drop_collected_mounts(struct vfsmount *mnt)
 
 /**
  * clone_private_mount - create a private clone of a path
+ * @path: path from which the mnt to clone will be taken
  *
- * This creates a new vfsmount, which will be the clone of @path.  The new will
- * not be attached anywhere in the namespace and will be private (i.e. changes
- * to the originating mount won't be propagated into this).
+ * This creates a new vfsmount, which will be a clone of @path's vfsmount.
  *
- * Release with mntput().
+ * In contrast to mnt_clone_internal() the new mount will not be marked
+ * MNT_INTERNAL but will have MNT_NS_INTERNAL attached as its mount namespace
+ * making it suitable for long-term mounts since mntput()ing it will always hit
+ * the fastpath as long as kern_unmount() hasn't been called.
+ *
+ * Since the mount is not reachable anwyhere mount properties and propagation
+ * properties remain stable, i.e. cannot change.
+ *
+ * Useable with mntget()/mntput() but needs to be released with kern_unmount().
+ *
+ * Return: A clone of @path's vfsmount on success, an error pointer on failure.
  */
 struct vfsmount *clone_private_mount(const struct path *path)
 {
-- 
2.27.0

