Return-Path: <linux-fsdevel+bounces-58818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF67B31B40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6CCB2557B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29D30AAD4;
	Fri, 22 Aug 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ipoYR2z6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933127511A;
	Fri, 22 Aug 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872251; cv=none; b=C8T3lKm0rb47vjAJ+92K912CuqfBv4ku8C9xGz+wR4Tyry5aSxc9RoqEMO7dythk02NNttMTIHNOJUjBxAwsZUplyBlbKBeT5gSYvz8hQvzXlHX0fGBGChgawnpFinrigzapiDGT4LLAJsysrRSle8s+YugOITr+PiXV45t9DMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872251; c=relaxed/simple;
	bh=4Y/tloE8879M1KX5EI2MrQlo3AnJR9c0+ORkZE1z5WE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtCwSHp27QcnZGKyGcnufhFAw4Z+2jf/yTS4iF1eQUWpzzFXzScNR7IOg9fblDbKwbMHZyGVMEk+rtguqO5olic1HCPqvmaQc4Uow4bwL4cW4Ey/EWmYxloBNA1XGQvgatFxZ9orU9eUqpOPNYE4FxqvnAMxzXvqqWNJeCgTCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ipoYR2z6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ELBStr8/C5FITsG6YtRLizalkpojCNupoxSwZOodRWs=; b=ipoYR2z6lX/cvxzjGw+N/5aUZq
	GgeVAJ/p81COIZhldxSoItEQb1zYUqURq0xTuWdb+s/cpm2M8WnwgutFWJocOhurk6qCZGuy+RcgJ
	9T4rsOD86QB4cUTKgVk4Ti2ZkNqLmwNTSNgXGvfH8bg4D0J5ImCO6EalzQpaM+FvHLofHP7tOH2n5
	7x+l+uV61WkiNW+bRu5IX8vjMYxsTSpqPyBmmYgTNUlcfMjI4zxILkeGB3lA09kNLESE45DkmRunR
	LOvnDPme/vh7jsJ/uJtKMylZ0FPAG5s+E9+eWGsuGcL+YgLKpCkCmNa/hVarAtPZ7wbYgy9LWYqRH
	ofCfs+IA==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSa4-0008Fn-1T; Fri, 22 Aug 2025 16:17:24 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:06 -0300
Subject: [PATCH v6 3/9] ovl: Prepare for mounting case-insensitive enabled
 layers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-3-8b6e9e604fa2@igalia.com>
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
In-Reply-To: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
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
index f4e7fff909ac49e2f8c58a76273426c1158a7472..63b7346c5ee1c127a9c33b12c3704aa035ff88cf 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -276,17 +276,26 @@ static int ovl_mount_dir(const char *name, struct path *path)
 static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 			       enum ovl_opt layer, const char *name, bool upper)
 {
+	bool is_casefolded = ovl_dentry_casefolded(path->dentry);
 	struct ovl_fs_context *ctx = fc->fs_private;
+	struct ovl_fs *ofs = fc->s_fs_info;
 
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


