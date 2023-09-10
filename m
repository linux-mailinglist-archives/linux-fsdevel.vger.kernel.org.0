Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE3799F7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 21:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjIJTbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 15:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIJTbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:31:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01438F5;
        Sun, 10 Sep 2023 12:31:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D595FC433C7;
        Sun, 10 Sep 2023 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694374265;
        bh=I/kP+37/K+lXfBQv+3hW3TvS0OronJ3WjCcDiC1ontQ=;
        h=From:Date:Subject:To:Cc:From;
        b=B6pMg4gAlit/BExol/+r1OCdxqT8SMRltzVW4u9S1Z9bLBOHECHrsi7oS9Jxhud7j
         f2YCfofwBe1VpYmUJv9m0jcP1Aqav3MQs/QXAGtBRr/UAaZGCCR+TCuy+OrEw6sLe5
         pwj6zXI2whMfByBRo9E6hj2HIX0YcLS9eGvVMlpHJISA7MSo5ByPCMxgFYtNcnvCvx
         4bRKjsJQ9qm0qZoTSzmcIFz/XcKD8CW1YzfEgP+elUblfanMwdkO0ekHvOZKhG6Kzl
         Iz7j1oWb/eEP2AaFTc2q2NES6AaNTjUY2Rl5p3ftrICro3Xd02ewcxiO1IN7szTnY/
         2o8Etckjfm+dA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Sun, 10 Sep 2023 15:30:48 -0400
Subject: [PATCH v2] fs: add a new SB_NOUMASK flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230910-acl-fix-v2-1-38d6caa81419@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGcZ/mQC/2WMQQrCMBBFr1JmbSRNIKauvEfpoqaTdrCkMpGgl
 NzdsVv5q/f4vB0yMmGGa7MDY6FMWxIwpwbCMqYZFU3CYLSxutNejWFVkd7KRR+966yO1oC8n4y
 ij1I/CC+UXxt/jnBpf/a/UVolQ3e/uOCnEPztgZxwPW88w1Br/QIxLGcqnwAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4464; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=I/kP+37/K+lXfBQv+3hW3TvS0OronJ3WjCcDiC1ontQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk/hlyPgcnqzVp4IjuxmkebqY56MJ30B/+4sf9N
 YFs7m/So2mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZP4ZcgAKCRAADmhBGVaC
 Ffb5EADDQdOcYm7xTa2UNEse4OkFjM6K48Pi7zTQcf0FEQrDqrDsZyT+tDoiOedfg7CJGTCrCrZ
 3MYC4WYfDVTfdjRKSradTC1TcCmIxNU2o4KXLSYenzeIaDHeq2fDiJQitMKaEbpoUeM/WH/xg3H
 kOyKtnn9BuVIbTpdFmzWmIqw5WWRkyRy+1eN1D1N/8DtDmhzhE20aBu4xWA9uIJER93XDm1GZtN
 p1OUxnvXPjWsnxYl7ORCLPRrS7JfLlokYzNLS+HfI+SU1EjFaQXaZZPLyWgBRcDCAn7set7nnXP
 1HY5349GlmeB7p2YreJBFGcyqaUQcB6Iglha25NRTrSM53IvMQF0eHz7vIld4WzaggPyu+GMSoz
 m+m5I+l32oM7ooxOkiECWTBu6ILFAHFFaw0JF9ZAuT8b3jpdWFG+VKt4HEawCbZzEwmrqLJQ/Kt
 CSrDD+MQTP5DT0dBNe1659Dj1izmPTk4YysdpJoxFRquyk5ANXSeK2EH0lTGNT9M20dIDr6qLJo
 L4SCKUAI/UnBLKmTibr8pUvzMTAnbgzJOnN1EjYPCYmA/f6VDIlQc9bgk4kdjj68QP4t5hc+LC3
 B8Cm7OHpdEhH8AoA4lwzh+bNgBuH6JF2pYavr3fZQZXTch6aZhPFkEocvNXmmKtQHLEhzIjLgMu
 vDaXsOre8FgsFBQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SB_POSIXACL must be set when a filesystem supports POSIX ACLs, but NFSv4
also sets this flag to prevent the VFS from applying the umask on
newly-created files. NFSv4 doesn't support POSIX ACLs however, which
causes confusion when other subsystems try to test for them.

Split the umask-stripping opt-out into a separate SB_NOUMASK flag, and
have NFSv4 set that instead of SB_POSIXACL. Fix the appropriate places
in the VFS to check for that flag (in addition to SB_POSIXACL) when
stripping the umask.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Yet another approach to fixing this issue. I think this way is probably
the best, since makes the purpose of these flags clearer, and stops NFS
from relying on SB_POSIXACL to avoid umask stripping.
---
Changes in v2:
- new approach: add a new SB_NOUMASK flag that NFSv4 can use instead of
  SB_POSIXACL
- Link to v1: https://lore.kernel.org/r/20230908-acl-fix-v1-1-1e6b76c8dcc8@kernel.org
---
 fs/init.c          | 4 ++--
 fs/namei.c         | 2 +-
 fs/nfs/super.c     | 2 +-
 include/linux/fs.h | 4 +++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 9684406a8416..157404bb7d19 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -153,7 +153,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
+	if (!IS_NOUMASK(path.dentry->d_inode))
 		mode &= ~current_umask();
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (!error)
@@ -229,7 +229,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 	dentry = kern_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-	if (!IS_POSIXACL(path.dentry->d_inode))
+	if (!IS_NOUMASK(path.dentry->d_inode))
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error)
diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..905fdfec5d26 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3117,7 +3117,7 @@ EXPORT_SYMBOL(unlock_rename);
  */
 static inline umode_t mode_strip_umask(const struct inode *dir, umode_t mode)
 {
-	if (!IS_POSIXACL(dir))
+	if (!IS_NOUMASK(dir))
 		mode &= ~current_umask();
 	return mode;
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0d6473cb00cb..81cd11c4db3d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1071,7 +1071,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 		sb->s_export_op = &nfs_export_ops;
 		break;
 	case 4:
-		sb->s_flags |= SB_POSIXACL;
+		sb->s_flags |= SB_NOUMASK;
 		sb->s_time_gran = 1;
 		sb->s_time_min = S64_MIN;
 		sb->s_time_max = S64_MAX;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4aeb3fa11927..51ad013ca716 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1119,13 +1119,14 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NOATIME      BIT(10)	/* Do not update access times. */
 #define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
 #define SB_SILENT       BIT(15)
-#define SB_POSIXACL     BIT(16)	/* VFS does not apply the umask */
+#define SB_POSIXACL     BIT(16)	/* POSIX ACLs are supported (implies NOUMASK) */
 #define SB_INLINECRYPT  BIT(17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT    BIT(22)	/* this is a kern_mount call */
 #define SB_I_VERSION    BIT(23)	/* Update inode I_version field */
 #define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
+#define SB_NOUMASK	BIT(20)	/* VFS does not apply the umask */
 #define SB_DEAD         BIT(21)
 #define SB_DYING        BIT(24)
 #define SB_SUBMOUNT     BIT(26)
@@ -2111,6 +2112,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_POSIXACL(inode)	__IS_FLG(inode, SB_POSIXACL)
+#define IS_NOUMASK(inode)	__IS_FLG(inode, SB_POSIXACL|SB_NOUMASK)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)

---
base-commit: a48fa7efaf1161c1c898931fe4c7f0070964233a
change-id: 20230908-acl-fix-6f8f86930f32

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

