Return-Path: <linux-fsdevel+bounces-57934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466AB26D92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B387BECBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B13019D8;
	Thu, 14 Aug 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Zil5TAjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414282FF65D;
	Thu, 14 Aug 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192157; cv=none; b=knJWaD2etzzOk6vKjD7/Hs5DHerp336AuyDD7myGWAOK9ck98nJ9f7L7CHxcsk6hmAzAZbGE65iblOX3ohW+CkEFKtcJqz64A5WPjjUDpq859DoZ8E9ff//9qkhk+x2pIoZkL8E84q7guG9P6hxujkHDtAQOuC7NNJl6Hiu5P4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192157; c=relaxed/simple;
	bh=bKVFrBqGvAD3vVqLD4NuKolXrYOcV4cywgK8Bf20XwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxaDZETACglHX3rzwt+YW2HpK6n7/8+XOvsAN98zgXeOUaqoYFt8d9dfKDwrzn5bIgO2fR7PuTXGFkVxp0m7ONwe8KISx7EnoULvV7k0IZVEuLZA6SU+9eRoohjiW5b4vGZAB3kY8Pl/tIUn1l1QJnEDAIzC2j64WcIt+6DGepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Zil5TAjG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gjrftLA6H/CDpl1y0yRuntaxWCtziLrcQi4OYIkb7ko=; b=Zil5TAjGj4oBsXZBIKDMpSqWp0
	81gUEj11ZLnsEDhQVDCAnyyf5HyeDh09BBy5dN18mWQx99J/iXR/FaRM8h3sAJT3w9ZoV3olYZP7Y
	/em9gGP5tIfsjLKW5BO1zJ5Vz+kMuATZicPZWW1nsCWif3mXVp2jKRvZMPkDTH5blhjKa0Cp38ENf
	uGK5QQb8hRmt5ipiYTCWazXrTFxrf2iSsWw/xgSMSqv4YxaL0jEQD6C9PPhX2L1MfPukqxOw/4qD4
	r5nsXBZHd5m44P+J9iv7MhdSbNISKNbwFcXoiSSwdnwje24+M1k0SqVsMUkKVNBBJtqLLWUVs9DQa
	FmIBOo+w==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbeo-00EDyT-0i; Thu, 14 Aug 2025 19:22:30 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 14 Aug 2025 14:22:14 -0300
Subject: [PATCH v5 3/9] ovl: Prepare for mounting case-insensitive enabled
 layers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250814-tonyk-overlayfs-v5-3-c5b80a909cbd@igalia.com>
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Prepare for mounting layers with case-insensitive dentries in order to
supporting such layers in overlayfs, while enforcing uniform casefold
layers.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
- Move relaxation of dentry_weird to the last patch
- s/filesystems/layerss
- Commit now says "Prepare for" instead of "Support"
---
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/params.c    | 15 ++++++++++++---
 fs/overlayfs/params.h    |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

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

-- 
2.50.1


