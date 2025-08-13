Return-Path: <linux-fsdevel+bounces-57803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3688B256C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D743B8B90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5A2FA0CE;
	Wed, 13 Aug 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="C5R7FfyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36EA2F0674;
	Wed, 13 Aug 2025 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124650; cv=none; b=PUDMPKLE6c/Cm9EH939VcWq8DPCdFZyAZxk68DUgZ5qY6IJhAwmhh+zOAP2Z9C8M1uTSZI3bqG/Iqkzc1OMa/qI+fLgDABRA8R/uvY1wB1HAtb9wjP+i6ZAFH9Oxy49HDM05aGCSVuxDeUuu6x03tzYtVdkFQwZiRjtIlQGGBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124650; c=relaxed/simple;
	bh=OPeMQsk8BoRgHppPZHOa9RVcQUOGLCSU6K1K7TDW7cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRfsAPfxXML3gjZ4fFlOfNcA4Jtex1ltC+TnjKOekAbqAha5IpGfWPRA1U311fCYRgQYQEGUYugHJ7bYz1mD54AsusX+v5AocH8m9iHDJDUBcEmrJ3/cZb75DeWbYMoGY71S8LW3uovLx4kVIGsblVJ07jikiD5S1LzawbEk0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=C5R7FfyH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vRQkLPW3DaftyWPvFVw/R4A+CFDU9La6tVNmESyuXqo=; b=C5R7FfyHabaB4j+X6dA0Ow3tCy
	B9x+giwkXc5YrYG6Q1kU6ntDiEnl1pbWvVX5rNakhomrxERCu5CqxlGp2tHkkjABhV12+FQhesF7+
	LkZ2ky+jlpucd1TH8uEwkR7mubmGzKRYX8Ichtv7b2dPyDdHctI/f2dXPTFnSfm5Z7EWmkTbvdha/
	CirvY637GEfSget7y6TojpWyOcagy0CSs/07bV6OIxf/JeUySjz9fDplqZfnzcuNP6ryGnMwqq3ZL
	fybsySZoLjlfnCIa96KOgK877QtCAkgBDHNJ70ijCfkYGvOqp8mGyj1t0p88AZEXvr8cIONkfU5Nr
	6YuhGEJQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK60-00Ds0c-H5; Thu, 14 Aug 2025 00:37:24 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:38 -0300
Subject: [PATCH v4 2/9] fs: Create new helper sb_encoding()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-2-357ccf2e12ad@igalia.com>
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

Filesystems that need to deal with the super block encoding need to use
a if IS_ENABLED(CONFIG_UNICODE) around it because this struct member is
not declared otherwise. In order to move this if/endif guards outside of
the filesytem code and make it simpler, create a new function that
returns the s_encoding member of struct super_block if Unicode is
enabled, and return NULL otherwise.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- New patch
---
 include/linux/fs.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 796319914b0a063642c2bd0c0140697a0eb651f6..20102d81e18a59d5daaed06855d1f168979b4fa7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3739,15 +3739,20 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qst
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


