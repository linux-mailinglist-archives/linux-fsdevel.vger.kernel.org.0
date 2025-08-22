Return-Path: <linux-fsdevel+bounces-58820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F267B31B48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB226A01732
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC330EF8F;
	Fri, 22 Aug 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HaIc1leq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC23074A9;
	Fri, 22 Aug 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872256; cv=none; b=URZghw1dvm1+rzBv0p9SOBB9xo3jUwAr2TWYBHoTHhG+GmhWj5wIB9J9yfXwp2bculxA/DVOcTmTUVwPPMmT6VxKv8gizLQuWf5Sqbje2I7vNnapMPVXcMEEH2F8SzT7Ep1lWIz6emCxhw/75wgf5iyzvi2alGAeLlj/Ksf9yPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872256; c=relaxed/simple;
	bh=iXgNDVeuDHEdNjVhe+dRdErlGblRCtks3LLnc8UIZS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMsYVI3U0iKW1EElYf7bQjnq5pvSZqWL+8PED80k+Nxoh5LUISR6tY7quXiOJ9AGQu7x+6D2t+UIOiqyLkujcN+IDhmGohEBqWui+mB9OO+6KkYvlQiPxhcOKJgl6QvLot7bHcxcQSvTGcUHGfH8DnfyXuug8Ra45e5JIFv7dJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HaIc1leq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vdn5t2KcLULewiHGwHldLGCoPW67I7GBdBrA/rg95qY=; b=HaIc1leqcbOY30d1Ul/7umNdcA
	AL1ksAaVVYMEqBzfXDUPeajlWx/R6XttR0L/Whu+KzgLv8376ZOxafPjVoOxs4ds7q8C+qc9nqB3H
	8WuuUfSH3fu/xFUpj7pnasCUyks2uO0DX8F+OH5gY1RRJLruWOxlfe/gKO+aA0aOfX5x41zXWkMNr
	eivJ6ByXo/JnC1EnmnN45sohkEiTxxxFQAaJouI+lHpC57Vz/+ZUZFMMUPUuhql5zKlKm8FBYeVuq
	oAQxRy0GPTwn7qGG2GkLR/FCTcEBHHhYH97OmnSsnK6xWFjuHDoTpvBO7k6o4RS+vv5LxSVsEZ67z
	nE6XIyaw==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSa9-0008Fn-NS; Fri, 22 Aug 2025 16:17:29 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:08 -0300
Subject: [PATCH v6 5/9] ovl: Ensure that all layers have the same encoding
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-5-8b6e9e604fa2@igalia.com>
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

When merging layers from different filesystems with casefold enabled,
all layers should use the same encoding version and have the same flags
to avoid any kind of incompatibility issues.

Also, set the encoding and the encoding flags for the ovl super block as
the same as used by the first valid layer.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
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


