Return-Path: <linux-fsdevel+bounces-56708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0AB1AC9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395EC18A206F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB011DED4A;
	Tue,  5 Aug 2025 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZKZQ7dx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBF2AF03;
	Tue,  5 Aug 2025 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754363371; cv=none; b=cqtOX1r/1JG3HL1RpRAuG16G6mi2YMfNpejZIjBmF4GBnBd9a6KC8NIuExCF75BHkKfeNDT2RMGubYc0W/0rf2dpYhlzgWCEqGp3rtSWjPscYdg6X5TbMAn7y4Nejd4p22jHPc163XlPfDWwxRjsDL9T1gyYonvKj1q+/HYO/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754363371; c=relaxed/simple;
	bh=5IPxB+ennw3I1nBRGMF7zsWHckDZLsz9IvAqp7Bwcsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ml/IdQHv2YQx59yLrXr955gGRipsNP0iYJSJUVTjmT2T0XwUdTwxs9wTjcu1ZpziGAsZXbWT8D3cMGjpBhqF6h2cGY2lFGRK4dzeiXtNy1gx2g+iDMUcic7+7X5Uf1WK7W+YBu8eO9EdpxyT76gqcly5JZUM6Xp8V6ohLpDbgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZKZQ7dx4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ojr9sG0RRJKao/SYLMHXpb4M+5kUiC+kbpn9/C/Ofw4=; b=ZKZQ7dx45JOoO3Mg1wBFlRkQ0M
	OWBfS3CNRSDmgXvrWzeOfXVL3BZv8hlOdvopil3vQX1XQlq0a0wrvAzh9IIaNf0MY3pxrwdAOWJJc
	BpRzXphhAzet0l9R1+wR+Bii9PM7pgzYt4als1oiJjFFMie29Y/zb4wY8WUTyrNN/figifbQ2C64J
	cIeiE9MgC5USOFvxcdRtRI66dpLMJlIfUOL5S0OMWe7h4KkJ8SxmhGoyvUx5zESlyLzC+g54Smbz+
	RSgmrKwRCPQFMvpuMC1GVyJB10vLFr6k98bj7mdhwTUMqmeS3lk2LQbvkjmtTsB3NADEP6qjAnfPI
	5ifAvwIw==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj83J-009TiJ-Mm; Tue, 05 Aug 2025 05:09:25 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 05 Aug 2025 00:09:08 -0300
Subject: [PATCH RFC v2 4/8] ovl: Ensure that all mount points have the same
 encoding
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-tonyk-overlayfs-v2-4-0e54281da318@igalia.com>
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

When mounting different mount points with casefold support, they should
use the same encoding version and have the same flags to avoid any kind
of incompatibility issues.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 4afa91882075110fdeb5e265ce207236c9eff28e..cfe8010616414a5ec0421b9ac5947596bfd0a5bd 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -998,6 +998,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	int err;
 	unsigned int i;
 	size_t nr_merged_lower;
+	struct super_block *sb1 = NULL;
 
 	ofs->fs = kcalloc(ctx->nr + 2, sizeof(struct ovl_sb), GFP_KERNEL);
 	if (ofs->fs == NULL)
@@ -1024,6 +1025,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	if (ovl_upper_mnt(ofs)) {
 		ofs->fs[0].sb = ovl_upper_mnt(ofs)->mnt_sb;
 		ofs->fs[0].is_lower = false;
+
+		sb1 = ofs->fs[0].sb;
 	}
 
 	nr_merged_lower = ctx->nr - ctx->nr_data;
@@ -1067,6 +1070,9 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			return err;
 		}
 
+		if (!sb1)
+			sb1 = mnt->mnt_sb;
+
 		/*
 		 * Make lower layers R/O.  That way fchmod/fchown on lower file
 		 * will fail instead of modifying lower fs.
@@ -1083,6 +1089,11 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		l->name = NULL;
 		ofs->numlayer++;
 		ofs->fs[fsid].is_lower = true;
+
+		if (!sb_same_encoding(sb1, mnt->mnt_sb)) {
+			pr_err("all layers must have the same encoding\n");
+			return -EINVAL;
+		}
 	}
 
 	/*

-- 
2.50.1


