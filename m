Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F74339BCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhCMElA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:41:00 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33582 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005Nzv-9t; Sat, 13 Mar 2021 04:38:25 +0000
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
Subject: [PATCH v2 08/15] gfs2: be careful with inode refresh
Date:   Sat, 13 Mar 2021 04:38:17 +0000
Message-Id: <20210313043824.1283821-8-viro@zeniv.linux.org.uk>
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

1) gfs2_dinode_in() should *not* touch ->i_rdev on live inodes; even
"zero and immediately reread the same value from dinode" is broken -
have it overlap with ->release() of char device and you can get all
kinds of bogus behaviour.

2) mismatch on inode type on live inodes should be treated as fs
corruption rather than blindly setting ->i_mode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/glops.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 8e32d569c8bf..ef0b583c3417 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -394,18 +394,24 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	const struct gfs2_dinode *str = buf;
 	struct timespec64 atime;
 	u16 height, depth;
+	umode_t mode = be32_to_cpu(str->di_mode);
+	bool is_new = ip->i_inode.i_flags & I_NEW;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr)))
 		goto corrupt;
+	if (unlikely(!is_new && inode_wrong_type(&ip->i_inode, mode)))
+		goto corrupt;
 	ip->i_no_formal_ino = be64_to_cpu(str->di_num.no_formal_ino);
-	ip->i_inode.i_mode = be32_to_cpu(str->di_mode);
-	ip->i_inode.i_rdev = 0;
-	switch (ip->i_inode.i_mode & S_IFMT) {
-	case S_IFBLK:
-	case S_IFCHR:
-		ip->i_inode.i_rdev = MKDEV(be32_to_cpu(str->di_major),
-					   be32_to_cpu(str->di_minor));
-		break;
+	ip->i_inode.i_mode = mode;
+	if (is_new) {
+		ip->i_inode.i_rdev = 0;
+		switch (mode & S_IFMT) {
+		case S_IFBLK:
+		case S_IFCHR:
+			ip->i_inode.i_rdev = MKDEV(be32_to_cpu(str->di_major),
+						   be32_to_cpu(str->di_minor));
+			break;
+		}
 	}
 
 	i_uid_write(&ip->i_inode, be32_to_cpu(str->di_uid));
-- 
2.11.0

