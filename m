Return-Path: <linux-fsdevel+bounces-58817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A96B31B32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58B91CC0AC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98AA309DAA;
	Fri, 22 Aug 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Edb6G7cY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E893093CE;
	Fri, 22 Aug 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872249; cv=none; b=Qx83Wzl1/30nIPohqNX7rqvrjkaKNsa7B9uqMs/bnAizLjijZWcVXg6xdEYrOZYvvKKNk5sZwArztp0dyLOgErbufpMURG9r6yRP/g57YcTpa8UGaTE5Pc1kQJLkLMR/eImKmUTc27YOJFrgA2kZJKByLRk8CEKloK/AqM4e8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872249; c=relaxed/simple;
	bh=64EfOAJcRYK5YZfzicvstPgggpHXkHVvupCKq4e0Xd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUPiD/MsuL529YxCXjkZhc5Da2GWxCQm9r0xEUL3TYlUfp7jC0bMPKyYVUuUvKbu7kfmbswRj70GfzTO9iEA52K8GTQ0JBg0nVVPO9/MLHwYy+1sgjth1RSJSVk7kMuq6iWEqVxMF4YGrJs8kWd3H2F72R7/B6n8fzoI46O9edA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Edb6G7cY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pzWqMgKLsmEWWxxW2dCCfSH+z4bHQFSst+1kAmOTkXU=; b=Edb6G7cYZwYAebOJ8/l8tfuLpd
	0APSJhB5e3tfdQXK7mMy5RJPt73XhFOW30PW5dD3/f2na4NbCAHdOPgKHef215z5FZDkp4JNfhKw0
	ztz3AtwF4dyUDWDDSt5MGZMSIVveKHmKaui0gJYmd15mOoCb/+dfKb0pkNrer3vd1ZOabJgfC8usx
	08C+kTo0Dq9xEBeTPBZaUfXO4xxIdaVIhhkUTyoPFGVbJG/6wn4N3+PH8GrCKkGs8lx9/pN3t346t
	pC/iOJGGsMVPkVrfE4t0vNiSymEhikIA49VxdwE1QUZek4oX/1H4XQNl/x1Wd2h1ebvetv6l6ppF1
	nHBeadhw==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSa1-0008Fn-6r; Fri, 22 Aug 2025 16:17:21 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:05 -0300
Subject: [PATCH v6 2/9] fs: Create sb_same_encoding() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-2-8b6e9e604fa2@igalia.com>
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

For cases where a file lookup can look in different filesystems (like in
overlayfs), both super blocks must have the same encoding and the same
flags. To help with that, create a sb_same_encoding() function.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/fs.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a4d353a871b094b562a87ddcffe8336a26c5a3e2..7de9e1e4839a2726f4355ddf20b9babb74cc9681 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3747,6 +3747,24 @@ static inline bool sb_has_encoding(const struct super_block *sb)
 	return !!sb_encoding(sb);
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
+	return (sb1->s_encoding && sb2->s_encoding &&
+	       (sb1->s_encoding->version == sb2->s_encoding->version) &&
+	       (sb1->s_encoding_flags == sb2->s_encoding_flags));
+#else
+	return true;
+#endif
+}
+
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);

-- 
2.50.1


