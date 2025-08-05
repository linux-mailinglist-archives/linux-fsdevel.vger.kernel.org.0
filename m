Return-Path: <linux-fsdevel+bounces-56716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A2AB1ACEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA546212CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBFC1F473A;
	Tue,  5 Aug 2025 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HCqttV7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885E204583;
	Tue,  5 Aug 2025 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754365724; cv=none; b=iY352Ey/9NoKj8z4aJjYFpr8nSUdGsS8Sr2QuflqXNSKWoszNiPdab7nAawPcsgWq1W+US+xCyUdek6wIybDAZnB0tuYUVVnVf99k4Sc2hNZjsLqu53BH2bzTPCxXfcCMlYDJJsXRjTJk1tgqEwEn9JoR4wctTxxgfP8CXhgb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754365724; c=relaxed/simple;
	bh=38BjtSCjK+HP9uqEYbMeA3yku5edNnFjXtFDcME+jqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6xSK6gYiizOXg8HOtpSpyMPIAPi1FysZ+RuU+aE0Thi+dgRcWOT4hTSVG9v3IF+m7xl6kIX+AsHg6qXMOqIaKBTa1YVUMXqLXKEKqGutY2Hi8HuEQVxwlUDPc/iRNKOqqYoEibd65/C2yikimEqVux+tjIFpuXRaqUxOLF45FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HCqttV7M; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZDamLIHjZ0U9g0xjh5flX+ookgZBZvbyP3scFrG6bUU=; b=HCqttV7Mw6lfzGp5OiCVf4riHQ
	36OMv+uyEx24Ks+/XLzf5dKKq2KU1vVtrUqI29xhboQvRsHvKNGVPv/ggI72P4HDu9YnH2rHp+iyM
	qEv3qzioCOMauxuSVQJdJgcMxWBDRwTPKy0ECBOLh2MlFf9+rVxfOL1Tr4RLFBOZFYY1GNQ5V48fV
	BbvgKHZX2iTudMMdXJqxHW8cNvVQt9K6EfVroFWZ9KB0QUVBBgqf7GoAWSldCBRJ3UGoca4PtdO0A
	yZpgt5Ws47P7WSI5bTOzRKTHOii+zOXnlhE7hg2wuqkmLxTc35pL+0mFvRJloEoSx27vXvl733oe+
	+m4ukxLQ==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj83G-009TiJ-Sf; Tue, 05 Aug 2025 05:09:23 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 05 Aug 2025 00:09:07 -0300
Subject: [PATCH RFC v2 3/8] fs: Create sb_same_encoding() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-tonyk-overlayfs-v2-3-0e54281da318@igalia.com>
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

For cases where a file lookup can go to different mount points (like in
overlayfs), both super blocks must have the same encoding and the same
flags. To help with that, create a sb_same_encoding() function.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/fs.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1948b2c828d3e83691f0b0892b4a7a87501c11db..413d4b2b7a41c0706324d01e71963bc481f383e4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3744,6 +3744,28 @@ static inline bool sb_has_encoding(const struct super_block *sb)
 #endif
 }
 
+/*
+ * Compare if two super blocks have the same encoding and flags
+ */
+static inline bool sb_same_encoding(const struct super_block *sb1,
+				    const struct super_block *sb2)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb1->s_encoding == sb2->s_encoding)
+		return true;
+
+	if (sb1->s_encoding && sb2->s_encoding &&
+	    (sb1->s_encoding->version == sb2->s_encoding->version) &&
+	    (sb1->s_encoding_flags == sb2->s_encoding_flags))
+		return true;
+	else
+		return false;
+#else
+	return true;
+#endif
+}
+
+
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);

-- 
2.50.1


