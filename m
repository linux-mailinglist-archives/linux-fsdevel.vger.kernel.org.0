Return-Path: <linux-fsdevel+bounces-57933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE627B26D90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B049AA5F1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A623002B3;
	Thu, 14 Aug 2025 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VEKLAHb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665532580CC;
	Thu, 14 Aug 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192155; cv=none; b=KN1dMMasrQTbJJAXIfIe3KJ1faJgZz+W/ukPj60MFj2Moa8+Um1pead7xT+JDuqi4qgXHHJtZx1C263vGOBdMWpinMfXu3q3IeT83JpO4xm/huMMK9FpgvlOpGe1Phg0CPntRpj+zlC6P+KZ5tT4H1Xf06IKDWc9msD7FRzsTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192155; c=relaxed/simple;
	bh=kKttmzAKBEU+JMrfGmDw1I/Taq8RRmS+Xu3vLTzdyjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SY5gQ3gGsgJXp6fnN8CIqnhqwc9h4A/S8cfM2+ru9gpKd02xHiWyjd1u05LZMMP0mfX+UWLb/qBiIRrKichBpMn2FROa1kLHobi5nNDfLakcVjlImtwPJdlW4XbtO3fAj1mE23qGXNOWXih2+DoDwWg38NkAWKOgBsc+anX5qcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VEKLAHb4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XdUqGMi4mHBnbt/DGei0QZf3+togwOyv5rpVfrAr310=; b=VEKLAHb4cSk8mFNDuCm4BBLkio
	/FlBVz5SUXTxLtS+ga1WosuTv/bn5y1xcvAx2mNJnAEwF4jheNQpG26An3RaePSIGH9uir3LP5Dz2
	Qill0BRB/itwXbOkcSr1Ooe+37qw00DaiUNfALbjBmuXfef6SdTVmEFgcHLZdoCBZ64DwNBd7NgBl
	xs7KW9/IVpIO8jtIzscMzy+dc4ZdfNXqaAx/rc5LXIoQErhlPfxJJQYJJT78oj5AryZF3Fip/ryJ+
	qDIraNz+IHKlqtqgqPlE5jS4DUJg5hMz3GpZ03nhAZIkT8UX1osai5AP8jOnQ6Bw9AuKj8cTuvIGf
	Tq593a0g==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umbel-00EDyT-3P; Thu, 14 Aug 2025 19:22:27 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 14 Aug 2025 14:22:13 -0300
Subject: [PATCH v5 2/9] fs: Create sb_same_encoding() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250814-tonyk-overlayfs-v5-2-c5b80a909cbd@igalia.com>
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

For cases where a file lookup can look in different filesystems (like in
overlayfs), both super blocks must have the same encoding and the same
flags. To help with that, create a sb_same_encoding() function.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
Changes from v4:
- Move it to the begin of the series

Changes from v3:
- Improve wording

Changes from v2:
- Simplify the code. Instead of `if (cond) return true`, just do `return
  cond`;
---
 include/linux/fs.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 43b3a7cf6750d3db3e5350908c95bc8a729db41a..ec867f112fd5fce7c1cceeb8598979972688d220 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3754,6 +3754,24 @@ static inline bool sb_has_encoding(const struct super_block *sb)
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


