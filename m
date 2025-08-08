Return-Path: <linux-fsdevel+bounces-57157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF30B1F00C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 23:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E005D189A94A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F16261595;
	Fri,  8 Aug 2025 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aVvmi+wL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F125C6F3;
	Fri,  8 Aug 2025 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686770; cv=none; b=SfTo58CaVDp+ANz4mIHBjSPZZEPNQTdlWVgro5GG96U3xa66JDy1K+cwOSCv9wCwCyFvYpL8QeFdZ8mKClLxCv0eTCIZawKuCBdV3VCwoBZEUN+QxDqkoG0EZ6CUrHSXOoFGxDmTNk85e6bFYBMp4lx37EQxG8Cbb51qK6dyw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686770; c=relaxed/simple;
	bh=q1lbE9HSCF1yjwRx8M5o+xiG7oe2jBvw8fhVmn5mcYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNTi2/WffW1Ay8mH7AHs+p1I69+EvmE9auZ5Dl1Gu09TGqOFZ9+jkxx8ZsJvbJDjyJb+1tmLmdtow3tLoj48bik6fjtSnlfxuN6f5lc7782mh47pBfcV8tvq9gOfZO8qqqPPDF3vWdLaC8w2Osfp9cIYzwCzGJUEqMzv3swIsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aVvmi+wL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zSQ8Tf8QHrXG591Xmuim+Lx3lqmCvhyjmipeObN9FzE=; b=aVvmi+wL00KjkyRw6GPTcULgiI
	UF5ODTwrhIERfLW/kCA/5Cc1uCBatPnK5a2nQM42J4nRKU2sv/p6JZIIYtabU9i3g4BXpqJajtFFm
	1teu2OTZ/VM2exwbQVxEs12iurCcn4Ez0C+VYQ8W8ywUX78fKPgzk2LdZoLXN+bQsLGejqC1mj/Z6
	r23k7UhI35t8Oh3EZIn4aut/nCXxT3Mb1mGW3JATp0b60OGfohtWj0jI4nsczA1kS4NCdnOjaPFP9
	0RccrWHoQ2NKd7S32s6SRLl0Z3wcwx9QK3j3Joy4bWz3/lkxafj+kPGAtVukA+QYLNoL5XxPABMLc
	4Nu/OWVQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ukUBP-00BiQh-5G; Fri, 08 Aug 2025 22:59:23 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 08 Aug 2025 17:58:46 -0300
Subject: [PATCH RFC v3 4/7] ovl: Ensure that all mount points have the same
 encoding
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-tonyk-overlayfs-v3-4-30f9be426ba8@igalia.com>
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

When mounting different mount points with casefold support, they should
use the same encoding version and have the same flags to avoid any kind
of incompatibility issues.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index df85a76597e910d00323018f1d2cd720c5db921d..bcb7f5dbf9a32e4aa09bc41596be443851e21200 100644
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


