Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8867A339BC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhCMEk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:40:59 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33560 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005O0N-Sp; Sat, 13 Mar 2021 04:38:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 15/15] spufs: fix bogosity in S_ISGID handling
Date:   Sat, 13 Mar 2021 04:38:24 +0000
Message-Id: <20210313043824.1283821-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
 <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

clearing everything *except* S_ISGID (including the S_IFDIR, among
other things) is wrong.  Just use init_inode_owner() and be done
with that...

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index b83a3670bd74..bed05b644c2c 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -236,10 +236,7 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 	if (!inode)
 		return -ENOSPC;
 
-	if (dir->i_mode & S_ISGID) {
-		inode->i_gid = dir->i_gid;
-		inode->i_mode &= S_ISGID;
-	}
+	inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
 	ctx = alloc_spu_context(SPUFS_I(dir)->i_gang); /* XXX gang */
 	SPUFS_I(inode)->i_ctx = ctx;
 	if (!ctx) {
@@ -470,10 +467,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out;
 
 	ret = 0;
-	if (dir->i_mode & S_ISGID) {
-		inode->i_gid = dir->i_gid;
-		inode->i_mode &= S_ISGID;
-	}
+	inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
 	gang = alloc_spu_gang();
 	SPUFS_I(inode)->i_ctx = NULL;
 	SPUFS_I(inode)->i_gang = gang;
-- 
2.11.0

