Return-Path: <linux-fsdevel+bounces-57940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A218BB26DAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432621888560
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662F2DE6F3;
	Thu, 14 Aug 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pv9gpejM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C83093C6;
	Thu, 14 Aug 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192174; cv=none; b=smIgeIa9fIRIa6EbB1BwherjK+0SsUH+ouo56LtpY+YjsDFo5GvZr/tv7PzkJe4SqmyrtmpxvOE4wLWCHWwLZZQUbH0gHrag6KeBlr2pHgUkNX64ltdFfYOSLyuQQmVUlZnKTG2RDB0RKeb0Eqt3LgTpSsohO0fHxIemMxd6e/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192174; c=relaxed/simple;
	bh=FE6IiuF7ibSfnDlUDob3b3/mSLU9I65WnSEMnLWScBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f49YI1GaEKSjIn6u5o1Wa1trdoWS2Y2W8UBNDkxtR1R2NSj0jKVOtQW3gkhyGRbV8g5IFnTAmiDbvfcK6n8iM0bZNfe+weuMuee2AIQolnzWwLHHUCVD3cgPyHwu/QIbyF0ws2SuwtGqSJl+H3KJgtbNdssWCumxSdFmeIllHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pv9gpejM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/6SiNvt3DdtIYud9Qn67kfnp4qBDRY0tgKMMGOiKAWk=; b=pv9gpejMI+Wtw4hYUG5E7lhXjG
	Kv9JWJ8ZuveFjNT3DRns/Pch557GZ5UiyKwU+3vOlFRLw8GkNmfKfiA0q3+oq/gcD4bc2NWHNMKWp
	U5GKpa1muYpYLjv4X2Kv/84gs/irE9GTjImYNB7J4x0AezkJyv3XwIxBNkVKs/PQJdiJr0D/yDDlv
	So3y0Qwm1sr6fyy68pVHjPDIXC8vyBbAPQ+ITR39EgynoWJcIHErH+4UDObitHm2ZU/pvjDM1RVrc
	5uGXUvBVPL3ceW1YyWQq+AeMB2/y1ifDbfbNQqpKvZfgPc6L9KcZJOkBfplUQEsMM/uwPITpzCqDw
	iR3Fo/tA==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbf5-00EDyT-G9; Thu, 14 Aug 2025 19:22:47 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 14 Aug 2025 14:22:20 -0300
Subject: [PATCH v5 9/9] ovl: Support mounting case-insensitive enabled
 layers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250814-tonyk-overlayfs-v5-9-c5b80a909cbd@igalia.com>
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

Drop the restriction for casefold dentries lookup to enable support for
case-insensitive layers in overlayfs.

Support case-insensitive layers with the condition that they should be
uniformly enabled across the stack and (i.e. if the root mount dir has
casefold enabled, so should all the dirs bellow for every layer).

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
- Move the dentry_weird relaxation to this patch
- Reword the commit title and message

Changes from v3:
- New patch, splited from the patch that creates ofs->casefold
---
 fs/overlayfs/namei.c | 17 +++++++++--------
 fs/overlayfs/util.c  |  8 ++++----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 76d6248b625e7c58e09685e421aef616aadea40a..e93bcc5727bcafdc18a499b47a7609fd41ecaec8 100644
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
+	 * or disabled in all dirs. If someone has modified case folding on a
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


