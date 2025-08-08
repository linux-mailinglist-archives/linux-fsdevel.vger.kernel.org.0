Return-Path: <linux-fsdevel+bounces-57156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66618B1F009
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 23:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C88718903CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3325A320;
	Fri,  8 Aug 2025 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T3FmJROP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5F25524C;
	Fri,  8 Aug 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686767; cv=none; b=JOjHHHzDu2QBJ+6+JAIRiECfPXMUg1mpMbN1hZjtPpFqzyxSfz+NE5xgEYZq0zqxRKFJGLHRUAkFPN4TDW5UdhUubqJPvh8SblTpGIML7aH6mNkmmEfS2OEEyeCM+BoML8AiPJAaZJGbclGxl2q3PrW6ZqbQZM8jxnSuxJMp50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686767; c=relaxed/simple;
	bh=djAE3+KTca4H0eGN3gMcAVWEOhSzFrqAZXDBcHDsMas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3q8ptuyDhuUxcJvQ7mp+0zxFUvBlT+DmzDcD7KbdyFTdy2dbvxp/4LgQmMMYVkQB1UEAa2WVdRc8Xxeimv8fBJygP3z1Uhrdej1g0EhfEz+ERVT5ehKC1tu06sO7nwY6sSi+bIKIXoYwj1i9TfQc4eQSX9DKhUOa6SzGYWkKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T3FmJROP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=llr4kRx4/thM8+LDGQQkN5Et657lWBPXda6h0VtAk0s=; b=T3FmJROPEPMn9k5CrK+rgT6I1S
	VltSXpa1gx9wgjKsv0ArizWzl7KZRmZMSe6s1CHSWkEMaSap9P8zkFzMTeC1bKBc35tkTqdwMwRrm
	V2VYJ9Q8z8icALu85Wbr/GSsdQ1mP6NOulla7T7i5xQufGHqqVhXB2dspuDMzxe9TahC53+DQv2n/
	7fW8NW90S09nweLjuisZlPMZO5ZptXC6cmFrBafKCc6QHqOwAjXhwsEu7W1QUkntM2ePO77M39KDK
	Hkfw/t8uC2jtZc+pQDZ56b5tuSlxNtQaqXj64vhi2dUpgx622h5jFYuUsTB96sUxvhNEgVViAXVkR
	UXNb9TkQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ukUBM-00BiQh-BE; Fri, 08 Aug 2025 22:59:20 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 08 Aug 2025 17:58:45 -0300
Subject: [PATCH RFC v3 3/7] fs: Create sb_same_encoding() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-tonyk-overlayfs-v3-3-30f9be426ba8@igalia.com>
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

For cases where a file lookup can go to different mount points (like in
overlayfs), both super blocks must have the same encoding and the same
flags. To help with that, create a sb_same_encoding() function.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v2:
- Simplify the code. Instead of `if (cond) return true`, just do `return
  cond`;
---
 include/linux/fs.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index db49a17376d124785b87dd7f35672fc6e5434f47..d1fe69f233c046a960a60072d5ac3f6286d32c17 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3746,6 +3746,25 @@ static inline bool sb_has_encoding(const struct super_block *sb)
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
+	return (sb1->s_encoding && sb2->s_encoding &&
+	       (sb1->s_encoding->version == sb2->s_encoding->version) &&
+	       (sb1->s_encoding_flags == sb2->s_encoding_flags));
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


