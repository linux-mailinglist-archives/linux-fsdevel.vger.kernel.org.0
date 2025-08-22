Return-Path: <linux-fsdevel+bounces-58816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78602B31B38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816A8A23671
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D1307ADE;
	Fri, 22 Aug 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Bmmbd/8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34E2FC003;
	Fri, 22 Aug 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872244; cv=none; b=Zu4SMlDU/FInHoqvD+M50jqY+ReSXSt1NeEqazHji4nBEuztR1Si91s5AqcRBu9EBnETg8VfcJCzXyjrN3JaOUWS3eatO3EVYscM8jMYSGpXe56NivD2yyUNtHE370gx6RQ6Ei17TKLqz3cm+WfhHJPio7Nr1GOUp+pBHwV8d88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872244; c=relaxed/simple;
	bh=7TdCyu4yqZuiA8UFcm7Yf2UhyqWXFk7GjVoHZqQt92o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpBBzHgDR5w13wOFW41KDV3xtksTLJGrIGmgLLG/BJGCx1MA7g8odmTgj6SMnB/2s0Fg/RQ/XspPdMAM2VDln7e7/75vZz5UlLOqUAxUbyBP5xdM4myFzkflwPIKXWnKM1KI7oi0fIVOAtDoy2+ckqRV/VcPX216airOeWvyo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Bmmbd/8M; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ag6+41iv8v2agN0gxO8OgSO0rfv5iz6GanijgKocBrs=; b=Bmmbd/8MTLFVQWMTKss+F8TSCL
	Ba/7yCQ2pUn5VMkshQ/P+XY2rLNkWGTz0jjj2vC6BNwoM5qFWepJV+FzTp/ttMGL0lW5ZdAJl7/jY
	/sb4A68fdeniU+72TLStuYsS06Cv45YxdjYe5aI9Q2/qOp2CHGI9H7x8SFsYyEIY8c4L2KwqduvOv
	3YDTHcp4nMvGHpNUWb7EsmUf4b+Z5OX6CAuEX7DpwQRRseSZv/GP9JjbnxoEvREdYchlHQLt4h0iq
	fbxos9hDURsV3gywR8ez0LtpRXqj+H+WLQxLK8zER6wDeNT/cpvELKRPvL9KfmWWTMHQK7FrHjWvr
	CxBDHsUA==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1upSZy-0008Fn-C5; Fri, 22 Aug 2025 16:17:18 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 22 Aug 2025 11:17:04 -0300
Subject: [PATCH v6 1/9] fs: Create sb_encoding() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-tonyk-overlayfs-v6-1-8b6e9e604fa2@igalia.com>
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

Filesystems that need to deal with the super block encoding need to use
a if IS_ENABLED(CONFIG_UNICODE) around it because this struct member is
not declared otherwise. In order to move this if/endif guards outside of
the filesytem code and make it simpler, create a new function that
returns the s_encoding member of struct super_block if Unicode is
enabled, and return NULL otherwise.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/fs.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e1d4fef5c181d291a7c685e5897b2c018df439ae..a4d353a871b094b562a87ddcffe8336a26c5a3e2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3733,15 +3733,20 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qst
 }
 #endif
 
-static inline bool sb_has_encoding(const struct super_block *sb)
+static inline struct unicode_map *sb_encoding(const struct super_block *sb)
 {
 #if IS_ENABLED(CONFIG_UNICODE)
-	return !!sb->s_encoding;
+	return sb->s_encoding;
 #else
-	return false;
+	return NULL;
 #endif
 }
 
+static inline bool sb_has_encoding(const struct super_block *sb)
+{
+	return !!sb_encoding(sb);
+}
+
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);

-- 
2.50.1


