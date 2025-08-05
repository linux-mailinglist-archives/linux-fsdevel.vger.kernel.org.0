Return-Path: <linux-fsdevel+bounces-56712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9AAB1ACA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7D13BF840
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE320101D;
	Tue,  5 Aug 2025 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="G1rFRbYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D831DED49;
	Tue,  5 Aug 2025 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754363380; cv=none; b=Bh81M71Fn5k06C1NpKD+65qAPQwi3i2mkwi8Z+QK5NlXbszNWd+NpQGLG9jVoNhe+/SEchBfYN7sdxSng3oOw6a2VW/AHGYofwtUOVtRMcVMqruYpjRX7+l+bF25Txzlg+JVWacFXP2qBg5uAjtWc4IwuP8SKjVQPqB3ClF/Yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754363380; c=relaxed/simple;
	bh=KXRKtpIorrVSm+ENgWZSMXbBbvXp7K4wV9sI2VRsD9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3aqm0qyAjFhpbMRf1NtdTHddk5irY1L1Q6ZxYdLqFjZXL3huTOxfbRnUhUgpTPZnAllOXrhP400F3B8HHyV8KkJcOIaJo/VSSmOpUQDKCgui1vVsEfuZIEnmURzVyzLFKaqDqwlxfqQGgJYksAk0mOSEQzF8RcAgmQj39wQEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=G1rFRbYB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MAYPBEI5qE+orymxndgIHcMY+kCdXPZFTQwApjcA/OI=; b=G1rFRbYBbWZggMuAeUHsub6NNp
	EBv2R1BInLgB+VbP5ChOi2/N/Vkcep6auP6mBCS4JV2sa6bZ5kg/B/Ucu4nRQQ/Me9E9vOoYfLy5M
	CT5Io59c2bTv38lhReAZMikXznOm+I2Z4YXG9LFdhQczflcEsUzvSlSAsLANS/LgLN3VUQREnMoqd
	9D1D06lQaso1ydL/42tDkHbWwROw34Y/dqy0RpZsYGkgXb/5u0Mw0INUhYE/BFVYkVhoIOEQTBSwc
	bzvybEnU6XgTpHnX7UjDoHBPgLwK/4go7OkugenVbd20BwazSmNJ12RJf/QzeJXH9OfRhLKJ+jjzI
	ntL/XJUw==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj83U-009TiJ-VU; Tue, 05 Aug 2025 05:09:37 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 05 Aug 2025 00:09:12 -0300
Subject: [PATCH RFC v2 8/8] ovl: Drop restrictions for casefolded dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-tonyk-overlayfs-v2-8-0e54281da318@igalia.com>
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
In-Reply-To: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Drop the restriction for casefold dentries to enable support for
casefold filesystems in overlayfs.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/params.c | 7 -------
 fs/overlayfs/util.c   | 8 ++++----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index f4e7fff909ac49e2f8c58a76273426c1158a7472..dd3a893d37603842f7d19d90accb981f0d12e971 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -281,13 +281,6 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 	if (!d_is_dir(path->dentry))
 		return invalfc(fc, "%s is not a directory", name);
 
-	/*
-	 * Allow filesystems that are case-folding capable but deny composing
-	 * ovl stack from case-folded directories.
-	 */
-	if (ovl_dentry_casefolded(path->dentry))
-		return invalfc(fc, "case-insensitive directory on %s not supported", name);
-
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


