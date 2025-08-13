Return-Path: <linux-fsdevel+bounces-57802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC2B256B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EAF1C83420
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26592F9996;
	Wed, 13 Aug 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dSlAVxjp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D2CA6F;
	Wed, 13 Aug 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124650; cv=none; b=o6YGCu2i1Io7wsgjOa9N5JcjJxOJNS8xNV5A/H8X8BRXkLicx29PiLF16EiNJFkcqR6UFesAHVDQCAb3bOcZOjzy8mf4EwjDDahxu44z2BNkwEsEPdk/NhQw920ZagWoHLdEeYNbvmepZiuotwDGLy7J4OiAHA7YIjX9arEsMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124650; c=relaxed/simple;
	bh=X/fO0GOCJpN1hlj3TzEzs01UiFIXftYSPSXU5prSAwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuyPqEqwo+znw5nxkx/VNWvoRp4pVt8O2hscZrw7jSwvxA9DLRNjhlqA+AMY7/tAJjz5euH5eCBLjwjr4CZr/swQCltQ5wMO/Exd37UNktDz9IuvAHOihLetiFUTbDhW3uCLvUIl6wt0i6yaU3PSgMqCTuzMSAOEHNLSO4H+pUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dSlAVxjp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dh6yG5aAgfX0/3d+DjovlG203DWq6woQApiMbypwYe4=; b=dSlAVxjphnTuZItFQbCc82HEI1
	5/TvsVKRgkyDdJ/9KNO5VcUa2Xbcqmn2dIXF3PAbXWMAlRoA6U7SUj7CPMM63Uknew0Fd5m72VVJS
	TKsUAn6OgibE2RMDZs8bQA4CkwIBGZiTbX46ZjP+GYsYZv8pvW31OiHE25w8sS69c1c6AxJvrNvko
	ICRyTNmiUIw+oo5zoduYgCaqGFQAWhrS/rAzKWrK18yOqiCa4pXhIRohsVU9pihijx1ck0p+hJY3p
	2tvfWMfqpfPjPJ6pIIMAkfyhVIY9siYx/UL+4+SG5V7sfrIoN5WgClXiDNenZblH19zzaaw4QyjlD
	h3roEw1g==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK5x-00Ds0c-LL; Thu, 14 Aug 2025 00:37:21 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:37 -0300
Subject: [PATCH v4 1/9] ovl: Support mounting case-insensitive enabled
 filesystems
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-1-357ccf2e12ad@igalia.com>
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Enable mounting filesystems with case-insensitive dentries in order to
support such filesystems in overlayfs.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- Move this patch to be ealier in the series
- Split this patch with the ovl_lookup_single() restriction patch
---
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/params.c    | 15 ++++++++++++---
 fs/overlayfs/params.h    |  1 +
 fs/overlayfs/util.c      |  8 ++++----
 4 files changed, 18 insertions(+), 7 deletions(-)

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
index f4e7fff909ac49e2f8c58a76273426c1158a7472..17d2354ba88d92e1d9653e8cb1382d860a7329c5 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -277,16 +277,25 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 			       enum ovl_opt layer, const char *name, bool upper)
 {
 	struct ovl_fs_context *ctx = fc->fs_private;
+	struct ovl_fs *ofs = fc->s_fs_info;
+	bool is_casefolded = ovl_dentry_casefolded(path->dentry);
 
 	if (!d_is_dir(path->dentry))
 		return invalfc(fc, "%s is not a directory", name);
 
 	/*
 	 * Allow filesystems that are case-folding capable but deny composing
-	 * ovl stack from case-folded directories.
+	 * ovl stack from inconsistent case-folded directories.
 	 */
-	if (ovl_dentry_casefolded(path->dentry))
-		return invalfc(fc, "case-insensitive directory on %s not supported", name);
+	if (!ctx->casefold_set) {
+		ofs->casefold = is_casefolded;
+		ctx->casefold_set = true;
+	}
+
+	if (ofs->casefold != is_casefolded) {
+		return invalfc(fc, "case-%ssensitive directory on %s is inconsistent",
+			       is_casefolded ? "in" : "", name);
+	}
 
 	if (ovl_dentry_weird(path->dentry))
 		return invalfc(fc, "filesystem on %s not supported", name);
diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
index c96d939820211ddc63e265670a2aff60d95eec49..ffd53cdd84827cce827e8852f2de545f966ce60d 100644
--- a/fs/overlayfs/params.h
+++ b/fs/overlayfs/params.h
@@ -33,6 +33,7 @@ struct ovl_fs_context {
 	struct ovl_opt_set set;
 	struct ovl_fs_context_layer *lower;
 	char *lowerdir_all; /* user provided lowerdir string */
+	bool casefold_set;
 };
 
 int ovl_init_fs_context(struct fs_context *fc);
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


