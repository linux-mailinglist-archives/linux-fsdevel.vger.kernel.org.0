Return-Path: <linux-fsdevel+bounces-58824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970AEB31B4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F87716CA27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5749307AF0;
	Fri, 22 Aug 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NqtK8EZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797303126D7;
	Fri, 22 Aug 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872268; cv=none; b=i3bR6iMnusjlyQ2Pw7GQ6kKs97OKsDLRsILYPiGihWSh/kW6DNEtH6sA3kYFLeANIbQHPbnfx0mi4D61glAHLSHlUSiP/CSfQNDKicd9nC2HddDxwIIP+BVie+WI/s1GWe3pxhYc16nkSv6vZjoBgy4CSBYG2xmcut2cu9IgJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872268; c=relaxed/simple;
	bh=x4GIvsnaFstOMmOBwXDM+594L7MHxBPoRgjSdURJhGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aP0TQjl3MfyQVpVB/OrWjXT1fp5Ihj+X3B20ZFFSTQCGzws2SrYowl2Ozy1C3C3/OywIzbb3wXAO4NNTdxGi2l61Yw599BCubOmtru2kHPqaD40i15w2dWkUD1ELBqzlNL31UgiqVh3XIsHbpr7j8QlBfQDNYJ1+jPSpOs56QIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NqtK8EZV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JGTiZxRmj6JH4X0L7nkW20BnnStEx5Bz8ugRV0G6/pk=; b=NqtK8EZVhTNUgBoslKePg73Wxv
	cu+748t16yyJIScOhOHL1SMyqbY9E7i5+zayKIoTJ2x8pZpOYTbYUjnohtrnxUuAAR0WlA9YBWFZp
	yV9r3YsoL6KpsPVnvvQeWmAUVjJ5JkQHHtP29wldWSzvkWzEXTPfQJwhsLIFewdcGC5WLq6GcQZBL
	gr0iVVFdsjCyRoMmRbuA5Nvi0+Yomh++jQMRSP5qh7Vh6k6RDJ8cZlmPvF+nTCbwSMJ2luD3jF6z3
	Kp+/0XBh50PDYv+szdko0tkG0g/PtwAjwaI215tSy7la8cXuzkmQvo5PfGWf5xGaN/QF1t16YdCYG
	aFynchfw==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSaL-0008Fn-33; Fri, 22 Aug 2025 16:17:41 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:12 -0300
Subject: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled
 layers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com>
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

Drop the restriction for casefold dentries lookup to enable support for
case-insensitive layers in overlayfs.

Support case-insensitive layers with the condition that they should be
uniformly enabled across the stack and (i.e. if the root mount dir has
casefold enabled, so should all the dirs bellow for every layer).

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v5:
- Fix mounting layers without casefold flag
---
 fs/overlayfs/namei.c | 17 +++++++++--------
 fs/overlayfs/util.c  | 10 ++++++----
 2 files changed, 15 insertions(+), 12 deletions(-)

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
index a33115e7384c129c543746326642813add63f060..52582b1da52598fbb14866f8c33eb27e36adda36 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -203,6 +203,8 @@ void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperdentry,
 
 bool ovl_dentry_weird(struct dentry *dentry)
 {
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+
 	if (!d_can_lookup(dentry) && !d_is_file(dentry) && !d_is_symlink(dentry))
 		return true;
 
@@ -210,11 +212,11 @@ bool ovl_dentry_weird(struct dentry *dentry)
 		return true;
 
 	/*
-	 * Allow filesystems that are case-folding capable but deny composing
-	 * ovl stack from case-folded directories.
+	 * Exceptionally for layers with casefold, we accept that they have
+	 * their own hash and compare operations
 	 */
-	if (sb_has_encoding(dentry->d_sb))
-		return IS_CASEFOLDED(d_inode(dentry));
+	if (ofs->casefold)
+		return false;
 
 	return dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE);
 }

-- 
2.50.1


