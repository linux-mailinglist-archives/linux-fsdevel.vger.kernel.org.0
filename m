Return-Path: <linux-fsdevel+bounces-32275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F8A9A2F8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CDDB258B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB01D5142;
	Thu, 17 Oct 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZSU3viWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE81F426B;
	Thu, 17 Oct 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199711; cv=none; b=kKQY6+LrBflL+s73a01VghUonsT+0j5c8JLOOt2FOOwVRXUfa5WnaUuHK6fZyID1d6GJZkPseER2fOqKtgYuSPfD69TPZCVyZbC/8HhrdVdyeES5D8h8qBZtcrsGNHjI4bJH13vn4yX2HAeQnTefbTfTXFrlBM5ltTcAQ9seW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199711; c=relaxed/simple;
	bh=oIrfqsORWGCVGfSbKGOfKWJoArsvNYpCyUpdFo5mk1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8B5zRNbPs8BGfw1R3sHqU1gl2hiTlYBnx83eYrlmOKyiY8hxUAEOhRKj1o9b8DXP7SkUymRC90yjP0NAW2mtL/4akOFEWp58hgPkH+pWUVfDKWqCcZtxX/2yq7z0hIvXz/bycMowKHRkN60jV1LbwO+eCfVloJJtaNmYwUHCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZSU3viWE; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aKJMGqqg8ysmtiudHOn7uT8eJFcRURlMkiN4L56Qckc=; b=ZSU3viWEHOv4TQ3rGzE4Erk1QD
	W+mN+D1C2qbhbTnu60ta8qy5ip+a2dkEYa390eqEWeMNJx/vnfPeXypnY9OArnPxS7Au9NXfY5KR9
	ldOBLy5YqGIUSsbKit3tgNPpXFdn+W0EccgUA4muWMNsv3hLGu53IZEq9Sp0avMykt0xq5X/S3hlk
	FG7E6uLKrE3hx6p5yvjOD+YSZRJm0egFSERtqS8FyqTV3fevHZC34WwdMG8VKVD51ZAbkd0FCDrvQ
	N9fLsK9RyfmEaaPb1EhGr9JjsBwn60cstu7Z1cjMA1T/EBDARmIwLlk8+rmeHcocA3whxP/tusFfp
	kTr4I4Ow==;
Received: from [179.118.186.49] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Xpn-00Bnlc-RU; Thu, 17 Oct 2024 23:15:04 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Oct 2024 18:14:15 -0300
Subject: [PATCH v7 5/9] libfs: Export generic_ci_ dentry functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-tonyk-tmpfs-v7-5-a9c056f8391f@igalia.com>
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
In-Reply-To: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Export generic_ci_ dentry functions so they can be used by
case-insensitive filesystems that need something more custom than the
default one set by `struct generic_ci_dentry_ops`.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
- Guard func signatures inside IS_ENABLED(CONFIG_UNICODE)
Changes from v3:
- New patch
---
 fs/libfs.c         | 8 +++++---
 include/linux/fs.h | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 46966fd8bcf9f042e85d0b66134e59fbef83abfd..7b290404c5f9901010ada2f921a214dbc94eb5fa 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1791,8 +1791,8 @@ bool is_empty_dir_inode(struct inode *inode)
  *
  * Return: 0 if names match, 1 if mismatch, or -ERRNO
  */
-static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
-				const char *str, const struct qstr *name)
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			 const char *str, const struct qstr *name)
 {
 	const struct dentry *parent;
 	const struct inode *dir;
@@ -1835,6 +1835,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 
 	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
 }
+EXPORT_SYMBOL(generic_ci_d_compare);
 
 /**
  * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
@@ -1843,7 +1844,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  *
  * Return: 0 if hash was successful or unchanged, and -EINVAL on error
  */
-static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	const struct inode *dir = READ_ONCE(dentry->d_inode);
 	struct super_block *sb = dentry->d_sb;
@@ -1858,6 +1859,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(generic_ci_d_hash);
 
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 403ee5d54c60a0a97e2eba9ef80d8fb4bbd2288f..b277369672a140eba13dce7fa7b0883359c643f8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3458,6 +3458,10 @@ extern int generic_ci_match(const struct inode *parent,
 			    const u8 *de_name, u32 de_name_len);
 
 #if IS_ENABLED(CONFIG_UNICODE)
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			 const char *str, const struct qstr *name);
+
 /**
  * generic_ci_validate_strict_name - Check if a given name is suitable
  * for a directory

-- 
2.47.0


