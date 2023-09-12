Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824F79C481
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 06:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbjILEHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 00:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjILEHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:07:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4441116B0D;
        Mon, 11 Sep 2023 18:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA4CC3278B;
        Tue, 12 Sep 2023 00:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694478354;
        bh=tD9NzdPi0n+6/q/ei8D+JYpG03kuhSE26vfxhrlYyJ4=;
        h=From:Date:Subject:To:Cc:From;
        b=alpz5ar+8isfTUMyCS9pKlqXivp1UTrLeVkhzrok/LdWZuJM5xBA+hMO6ZV5hwPkP
         W41Q42LcXQ0BfrgB3xZN0ex+ruNqxxqwm3RMzeP3B5LYUtzo0AJPWZvKOfAie7uddW
         aDqvFcJPF1eOT5FFe/WfkkuoDwnqO3hxuus52HJ51ZvE54mNk+uiWiDUb+xATDA+XB
         m9FVC682PwFtts23BG4O4sn/loy6Dg/IXRfLM134+6yoN0V56gCnPXWz/yI8beBQLU
         w3GLOiJ80HcCq7MXfgmbnjuks2TauuD3KSSNDpYtz3Xol478RLvc9+MNwMgTIe5Vjt
         nkZgBWdVes5Cg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 11 Sep 2023 20:25:50 -0400
Subject: [PATCH v3] fs: add a new SB_I_NOUMASK flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-acl-fix-v3-1-b25315333f6c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA2w/2QC/2WMzQrCMBAGX6Xs2Uh+JG49+R7iIaabNljakkhQS
 t/dbS8qsqf52JkZMqVIGU7VDIlKzHEcGMyuAt+5oSURG2bQUhtZSxTO9yLEp7ABA9rayGA08Pe
 UiOetdLkydzE/xvTawkWt63+jKMFH9na0Hhvv8XynNFC/H1MLa6ToL1HJj6hZNNhY7xyqg6p/x
 GVZ3rk4LUnYAAAA
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6719; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tD9NzdPi0n+6/q/ei8D+JYpG03kuhSE26vfxhrlYyJ4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk/7ARBIl+azvW8jm4zOr4Qh6VXensl1h81RNHB
 fn0oF4S0dWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZP+wEQAKCRAADmhBGVaC
 FQkxEACKdD2Dg6e7Fxoj9s5y83ucw318Gz1Vs8Q3RTp1si97ez6GXu4UdBPXU6hC6UvocycIgqV
 SnUoIXyys6OUpiVRT4EeLPs5BSrn7PtJ/cf3E3RT/l7EeVR7rm9uiCM1tlX6TrucMpUGkSMR+Yd
 JWOIBzP6PisDPkcUFLtiQMAb9z4+BfFc3FCFahKubLR1mmJsdWXLQ0Eqioq4RkSz3M2pBvyDrH3
 JKZGN2kOQvtFXu6Z/iAv5laE+mn9orDjge48GIFkPWyWgBrwkAjI/ZWY1Uo96zCAwwtXqsUT/Fk
 Sv5uL/UWMALdUvsiX4rcLTlxndQjMGv7KfUQAxyEhSxhc+sQBfHLJ9iFmY690R3C3A2+aaPDAx4
 O/cq7TF0zTRCDn1SEOjB7vDblHjVmaYfquMiMLV8rbqOL+t4M7DfziWZqLHo45G0/s+va59UaeA
 HLe7aQ1OGlVUt8F66gxEXZTqoVIwW2ePMQWB30p8sv1+6xlWl+MoTZwkTU9NZLI/qhEMpjlHUfa
 Yetz9zgf5N4oKgQiHwJsmEPa8vASv62k5IB/C5CNsKS2503I0JCb69p1ynzX8T8ACpTJ6Cr9d3D
 1GfLrPqvbGfDnHJLGAW0G6uMJ8fijpqJ/FZVGJx0/eJSdTCfhfWGHbVafqhHQR45OookX1V8K3e
 myN+Bzb2noLijDw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SB_POSIXACL must be set when a filesystem supports POSIX ACLs, but NFSv4
also sets this flag to prevent the VFS from applying the umask on
newly-created files. NFSv4 doesn't support POSIX ACLs however, which
causes confusion when other subsystems try to test for them.

Add a new SB_I_NOUMASK flag that allows filesystems to opt-in to umask
stripping without advertising support for POSIX ACLs. Set the new flag
on NFSv4 instead of SB_POSIXACL.

Also, move mode_strip_umask to namei.h and convert init_mknod and
init_mkdir to use it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Yet another approach to fixing this issue. I think this way is probably
the best, since makes the purpose of these flags clearer, and stops NFS
from relying on SB_POSIXACL to avoid umask stripping.
---
Changes in v3:
- move new flag to s_iflags
- convert init_mkdir and init_mknod to use mode_strip_umask
- Link to v2: https://lore.kernel.org/r/20230910-acl-fix-v2-1-38d6caa81419@kernel.org

Changes in v2:
- new approach: add a new SB_NOUMASK flag that NFSv4 can use instead of
  SB_POSIXACL
- Link to v1: https://lore.kernel.org/r/20230908-acl-fix-v1-1-1e6b76c8dcc8@kernel.org
---
 fs/init.c             |  6 ++----
 fs/namei.c            | 19 -------------------
 fs/nfs/super.c        |  2 +-
 include/linux/fs.h    |  3 ++-
 include/linux/namei.h | 24 ++++++++++++++++++++++++
 5 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 9684406a8416..e9387b6c4f30 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -153,8 +153,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
+	mode = mode_strip_umask(d_inode(path.dentry), mode);
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (!error)
 		error = vfs_mknod(mnt_idmap(path.mnt), path.dentry->d_inode,
@@ -229,8 +228,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 	dentry = kern_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
+	mode = mode_strip_umask(d_inode(path.dentry), mode);
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error)
 		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..94b27370f468 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3103,25 +3103,6 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
-/**
- * mode_strip_umask - handle vfs umask stripping
- * @dir:	parent directory of the new inode
- * @mode:	mode of the new inode to be created in @dir
- *
- * Umask stripping depends on whether or not the filesystem supports POSIX
- * ACLs. If the filesystem doesn't support it umask stripping is done directly
- * in here. If the filesystem does support POSIX ACLs umask stripping is
- * deferred until the filesystem calls posix_acl_create().
- *
- * Returns: mode
- */
-static inline umode_t mode_strip_umask(const struct inode *dir, umode_t mode)
-{
-	if (!IS_POSIXACL(dir))
-		mode &= ~current_umask();
-	return mode;
-}
-
 /**
  * vfs_prepare_mode - prepare the mode to be used for a new inode
  * @idmap:	idmap of the mount the inode was found from
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0d6473cb00cb..9b1cfca8112a 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1071,7 +1071,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 		sb->s_export_op = &nfs_export_ops;
 		break;
 	case 4:
-		sb->s_flags |= SB_POSIXACL;
+		sb->s_iflags |= SB_I_NOUMASK;
 		sb->s_time_gran = 1;
 		sb->s_time_min = S64_MIN;
 		sb->s_time_max = S64_MAX;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4aeb3fa11927..58dea591a341 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1119,7 +1119,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NOATIME      BIT(10)	/* Do not update access times. */
 #define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
 #define SB_SILENT       BIT(15)
-#define SB_POSIXACL     BIT(16)	/* VFS does not apply the umask */
+#define SB_POSIXACL     BIT(16)	/* Supports POSIX ACLs */
 #define SB_INLINECRYPT  BIT(17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT    BIT(22)	/* this is a kern_mount call */
 #define SB_I_VERSION    BIT(23)	/* Update inode I_version field */
@@ -1166,6 +1166,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
+#define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 
 /* Possible states of 'frozen' field */
 enum {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 1463cbda4888..e3619920f9f0 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -92,6 +92,30 @@ extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
+/**
+ * mode_strip_umask - handle vfs umask stripping
+ * @dir:	parent directory of the new inode
+ * @mode:	mode of the new inode to be created in @dir
+ *
+ * In most filesystems, umask stripping depends on whether or not the
+ * filesystem supports POSIX ACLs. If the filesystem doesn't support it umask
+ * stripping is done directly in here. If the filesystem does support POSIX
+ * ACLs umask stripping is deferred until the filesystem calls
+ * posix_acl_create().
+ *
+ * Some filesystems (like NFSv4) also want to avoid umask stripping by the
+ * VFS, but don't support POSIX ACLs. Those filesystems can set SB_I_NOUMASK
+ * to get this effect without declaring that they support POSIX ACLs.
+ *
+ * Returns: mode
+ */
+static inline umode_t __must_check mode_strip_umask(const struct inode *dir, umode_t mode)
+{
+	if (!IS_POSIXACL(dir) && !(dir->i_sb->s_iflags & SB_I_NOUMASK))
+		mode &= ~current_umask();
+	return mode;
+}
+
 extern int __must_check nd_jump_link(const struct path *path);
 
 static inline void nd_terminate_link(void *name, size_t len, size_t maxlen)

---
base-commit: a48fa7efaf1161c1c898931fe4c7f0070964233a
change-id: 20230908-acl-fix-6f8f86930f32

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

