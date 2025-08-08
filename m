Return-Path: <linux-fsdevel+bounces-57160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C373B1F012
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 23:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC403BB47B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D26288C1C;
	Fri,  8 Aug 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ULwmOTti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC5242D78;
	Fri,  8 Aug 2025 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686778; cv=none; b=oPHftiE4oG9sVo//ciKBLhpupTeQ7tzeFlmw7HWerL1RQPnrbqDfPLr0N4eRBMXS6Z2AP1MjF7wgy1eqUP6YqT84kN2cO6fWRMexL0SJGuPJEMqPvNgmXedeB44WSZecqdzzG5i7nTP6pwaJqUhtDnJ3pZcTSqKv5xA0Jt5ViCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686778; c=relaxed/simple;
	bh=3j//bm9wrCCu/luOkjMaWoCCo3aMUVnc2+JWWKJ7n7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SksDCpMusl4kEnLGAXPJXc5NBJ1JxnQIhsKvAGXlSuB67hGk+u/T2vNjmAN6UOd21hClWsyFx+KA8hSo8gh6+bjqsoBEgYSRDRrCDK/uafOHrAw/DwXajnc5EVmm7Uvu26H64+iz1Hl9Pe8d1Dw9U8DnZ27YsaDj4FtaMiobwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ULwmOTti; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r2xKDwZZxr802QgfDROUhXUb+UwSwmSz5Q4cP/5SKJI=; b=ULwmOTtiPDusUAEe4bhfX2R49n
	gkaqfjarpBteTrzodMqHMXQi/Oaz2ymiG0j+M7ETBfVCed62VdaGEAHAXLMe7JjHd1Zel0x9QIcW6
	NC10FmMzkj7pARLS5CAp/rzx/TCsScQy2UjIwAhjMK3UWPRqHhnBXOuZ3an/UvJ4RPGPqeUKONGeW
	8X8FkGTNPV1W/XYU9AsOXEsw6O+jDLQOWAckSBu2vTOekCYlFgy0HoxAGI/JfwxPC7r9YulPMYkzV
	nQRF3HBZMYsAzfL99y18zum7rek/CsHGjOIY2iTQcYpcN3Is8V3kffgsgpoKApdBnacIYD6/cAURN
	pzIU/kbA==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ukUBX-00BiQh-K9; Fri, 08 Aug 2025 22:59:31 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 08 Aug 2025 17:58:49 -0300
Subject: [PATCH RFC v3 7/7] ovl: Support case-insensitive lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-tonyk-overlayfs-v3-7-30f9be426ba8@igalia.com>
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Drop the restriction for casefold dentries to enable support for
case-insensitive filesystems in overlayfs.

Support case-insensitive filesystems with the condition that they should
be uniformly enabled across the stack and the layers (i.e. if the root
mount dir has casefold enabled, so should all the dirs bellow for every
layer).

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v2:
- Create new ovl_fs flag, bool casefold
- Check if casefolded dentry is consistent with the root dentry
---
 fs/overlayfs/namei.c     | 17 +++++++++--------
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/params.c    |  7 ++-----
 fs/overlayfs/util.c      |  8 ++++----
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 76d6248b625e7c58e09685e421aef616aadea40a..08b34e52b36f93d4da09e4d13b51d23dc99ca6d6 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -239,13 +239,14 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 	char val;
 
 	/*
-	 * We allow filesystems that are case-folding capable but deny composing
-	 * ovl stack from case-folded directories. If someone has enabled case
-	 * folding on a directory on underlying layer, the warranty of the ovl
-	 * stack is voided.
+	 * We allow filesystems that are case-folding capable as long as the
+	 * layers are consistently enabled in the stack, enabled for every dir
+	 * or disabled in all dirs. If someone has enabled case folding on a
+	 * directory on underlying layer, the warranty of the ovl stack is
+	 * voided.
 	 */
-	if (ovl_dentry_casefolded(base)) {
-		warn = "case folded parent";
+	if (ofs->casefold != ovl_dentry_casefolded(base)) {
+		warn = "parent wrong casefold";
 		err = -ESTALE;
 		goto out_warn;
 	}
@@ -259,8 +260,8 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		goto out_err;
 	}
 
-	if (ovl_dentry_casefolded(this)) {
-		warn = "case folded child";
+	if (ofs->casefold != ovl_dentry_casefolded(this)) {
+		warn = "child wrong casefold";
 		err = -EREMOTE;
 		goto out_warn;
 	}
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 4c1bae935ced274f93a0d23fe10d34455e226ec4..1d4828dbcf7ac4ba9657221e601bbf79d970d225 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -91,6 +91,7 @@ struct ovl_fs {
 	struct mutex whiteout_lock;
 	/* r/o snapshot of upperdir sb's only taken on volatile mounts */
 	errseq_t errseq;
+	bool casefold;
 };
 
 /* Number of lower layers, not including data-only layers */
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index f4e7fff909ac49e2f8c58a76273426c1158a7472..afa1c29515a9729bfe88c8166da4aefa6cddc5a5 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -277,16 +277,13 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 			       enum ovl_opt layer, const char *name, bool upper)
 {
 	struct ovl_fs_context *ctx = fc->fs_private;
+	struct ovl_fs *ovl = fc->s_fs_info;
 
 	if (!d_is_dir(path->dentry))
 		return invalfc(fc, "%s is not a directory", name);
 
-	/*
-	 * Allow filesystems that are case-folding capable but deny composing
-	 * ovl stack from case-folded directories.
-	 */
 	if (ovl_dentry_casefolded(path->dentry))
-		return invalfc(fc, "case-insensitive directory on %s not supported", name);
+		ovl->casefold = true;
 
 	if (ovl_dentry_weird(path->dentry))
 		return invalfc(fc, "filesystem on %s not supported", name);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a33115e7384c129c543746326642813add63f060..7a6ee058568283453350153c1720c35e11ad4d1b 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -210,11 +210,11 @@ bool ovl_dentry_weird(struct dentry *dentry)
 		return true;
 
 	/*
-	 * Allow filesystems that are case-folding capable but deny composing
-	 * ovl stack from case-folded directories.
+	 * Exceptionally for casefold dentries, we accept that they have their
+	 * own hash and compare operations
 	 */
-	if (sb_has_encoding(dentry->d_sb))
-		return IS_CASEFOLDED(d_inode(dentry));
+	if (ovl_dentry_casefolded(dentry))
+		return false;
 
 	return dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE);
 }

-- 
2.50.1


