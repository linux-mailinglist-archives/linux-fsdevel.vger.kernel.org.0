Return-Path: <linux-fsdevel+bounces-57806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446ACB256C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E717B3C45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A52FE05E;
	Wed, 13 Aug 2025 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="A0RLp/LM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF62FE046;
	Wed, 13 Aug 2025 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124660; cv=none; b=LNaN5H7cbTBMwdIsA6GCA0lM6Qxp3odjDf6eWiCzdEhvFwi0RqsDaa1982EkYbsThZyTCY2SNZkSzVHiQkkQYVWHBfKhrmMKLSYCnBWcPiHzQJXj8IEvxEmNDzU0FB168uGWxPConfVKqQhKXqc0FWj62HlKeBSZZQ4senNIETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124660; c=relaxed/simple;
	bh=X39MqHXmTeSV04lEJCr/hfDy5i9HKws2LW2AOMXHYtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyAL7Z5xkyYuLPHDxwmbEntiWadelmQNROm6tk2wDn53qNU9spqr+luEqCHcGytKxSvtslFPIN1h+RgDkeirGoupAmG8k3YQbfBSs6u6hciGIw7WjzT42o/jiM54KutOt1roi0ChNG/+SLN/gdvJEuwL4Kk1RF7RcLuGOOoHY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=A0RLp/LM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5Di4wyXpTU1fyh8jS+LP8oqtfgllHLD4rtLwJ213bS8=; b=A0RLp/LMS09vTNizFWx8SdKjoO
	ihY9tnDfd4OGhQJp7aAUNnE7VWJlOxfRH0kMjYu4uSvZcgbp275L3VKS/LJFHWALZtZshhnLq40QT
	wbPHLDKICpjwJ0gUt77W1U9SdHKLRNzh76hFd2oXfvJn8SPD6vo5p9blZzKZmM6Dpb8gNiNSxX2Q4
	8S/inZoB3fFcPrlLnCjZnGedV22x+5if9+dFwk1pZSXUc5DxA7vBuCkgJDemmC5zbWxMdaiEjvZ0D
	rf5JwzHudED9oI3phQxCOX+jF2qJhXPWDr+E4swK+fwkSezqND5p0zBobtxHzL9v0EW1EvWzRjveF
	vRUtAemg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK69-00Ds0c-3q; Thu, 14 Aug 2025 00:37:33 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:41 -0300
Subject: [PATCH v4 5/9] ovl: Ensure that all layers have the same encoding
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-5-357ccf2e12ad@igalia.com>
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

When merging layers from different filesystems with casefold enabled,
all layers should use the same encoding version and have the same flags
to avoid any kind of incompatibility issues.

Also, set the encoding and the encoding flags for the ovl super block as
the same as used by the first valid layer.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- Check this restriction just when casefold is enabled
- Create new helper ovl_set_encoding() and change the logic a bit
---
 fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index df85a76597e910d00323018f1d2cd720c5db921d..b1dbd3c79961094d00c7f99cc622e515d544d22f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -991,6 +991,18 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
 	return ofs->numfs;
 }
 
+/*
+ * Set the ovl sb encoding as the same one used by the first layer
+ */
+static void ovl_set_encoding(struct super_block *sb, struct super_block *fs_sb)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb_has_encoding(fs_sb)) {
+		sb->s_encoding = fs_sb->s_encoding;
+		sb->s_encoding_flags = fs_sb->s_encoding_flags;
+	}
+#endif
+}
 
 static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			  struct ovl_fs_context *ctx, struct ovl_layer *layers)
@@ -1024,6 +1036,9 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	if (ovl_upper_mnt(ofs)) {
 		ofs->fs[0].sb = ovl_upper_mnt(ofs)->mnt_sb;
 		ofs->fs[0].is_lower = false;
+
+		if (ofs->casefold)
+			ovl_set_encoding(sb, ofs->fs[0].sb);
 	}
 
 	nr_merged_lower = ctx->nr - ctx->nr_data;
@@ -1083,6 +1098,16 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		l->name = NULL;
 		ofs->numlayer++;
 		ofs->fs[fsid].is_lower = true;
+
+		if (ofs->casefold) {
+			if (!ovl_upper_mnt(ofs) && !sb_has_encoding(sb))
+				ovl_set_encoding(sb, ofs->fs[fsid].sb);
+
+			if (!sb_has_encoding(sb) || !sb_same_encoding(sb, mnt->mnt_sb)) {
+				pr_err("all layers must have the same encoding\n");
+				return -EINVAL;
+			}
+		}
 	}
 
 	/*

-- 
2.50.1


