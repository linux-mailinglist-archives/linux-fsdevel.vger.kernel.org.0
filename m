Return-Path: <linux-fsdevel+bounces-16187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75702899CAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A50283F41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF416E86F;
	Fri,  5 Apr 2024 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="df8xZznr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5A16D9D2;
	Fri,  5 Apr 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319252; cv=none; b=RGcdT8BULL7DglXuUGYe1dN+/83pWk9rGPZhhCQL6sjvhje5NsN1+mT5nveuw21yzcEM9Xfp9n1bJV5aHfVMQaDi0hUf5wzeH/27ne3qBRgGIFegpb2oEpu/n9J1PDa+dlng7J8Rfb9fWY76tIGjAhjnN5PVZDozQwlmSUi9IMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319252; c=relaxed/simple;
	bh=Yqu0eGYoz7+oBoYtg2t/IEEnKe5iA2fOw8gbynJ9Ihs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NS9fRLOrYIJqG3lqhmAvHjzeAMoXAcrEoHpdw+zMILk2TJ6vZiduCCBjxSn0m44Mfm7nqxjXGHxv4FqjWwMMsioE9MB0by6eO6W4Rv1rlZF9yECzvya3hZGqfakgdjaVg5wKcLBYXb+1PrFdHXg/+4O1PIrnzWDxjMIDCpxkMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=df8xZznr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712319249;
	bh=Yqu0eGYoz7+oBoYtg2t/IEEnKe5iA2fOw8gbynJ9Ihs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=df8xZznrABuMa8M76D/XsfV8axeXxvQxOkVf47zrMlcghtQDKi7QspHB/bIuP4gao
	 l/2+hvqJdnjEEoG3F2mILMO2cusG1vFGc4ViArSz/Vf1jtvzB5eVUV9uLymYvLONza
	 eSm6fbscy8EdR9KmWLUqeT76t/WcZ1AiahVLRU81iX5Zll6A5QsAT2QhupFby26xYU
	 3DgfXtyfCDBNHeA2UArVpEv8OTo5/4/xgpfOoAh13wtwWoR6t6kzF2WJsaPI3DbeQ8
	 bVtuPaXwjW56g7kS9VRALJkS6F1sCQZQgExEwupzhfU0Wsco8l3/DZlBs2qtNQwLbp
	 k3lrTGi18YKTQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4558B3782135;
	Fri,  5 Apr 2024 12:14:08 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de,
	ebiggers@kernel.org
Subject: [PATCH v16 7/9] f2fs: Log error when lookup of encoded dentry fails
Date: Fri,  5 Apr 2024 15:13:30 +0300
Message-Id: <20240405121332.689228-8-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405121332.689228-1-eugen.hristev@collabora.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the volume is in strict mode, generi c_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/f2fs/dir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index cbd7a5e96a37..376f705aa3f1 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -192,11 +192,16 @@ static inline int f2fs_match_name(const struct inode *dir,
 	struct fscrypt_name f;
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (fname->cf_name.name)
-		return generic_ci_match(dir, fname->usr_fname,
-					&fname->cf_name,
-					de_name, de_name_len);
-
+	if (fname->cf_name.name) {
+		int ret = generic_ci_match(dir, fname->usr_fname,
+					   &fname->cf_name,
+					   de_name, de_name_len);
+		if (ret == -EINVAL)
+			f2fs_warn_ratelimited(F2FS_SB(dir->i_sb),
+				"Directory contains filename that is invalid UTF-8");
+
+		return ret;
+	}
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-- 
2.34.1


