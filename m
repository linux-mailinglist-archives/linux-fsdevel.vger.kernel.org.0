Return-Path: <linux-fsdevel+bounces-30818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F3198E74D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74111C255A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BF81C2451;
	Wed,  2 Oct 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GRS0ZU4D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8921C0DCB;
	Wed,  2 Oct 2024 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912730; cv=none; b=U+yJZOk/L9a+PgdjkcLaQPPujqaLmtRheFVzqzxFsRSQqKszQZvITDoz7vkG4tGiURtNPsXtv9ldAEzdVULiKYN9oXMsFi2truEVXEhou+PiHtspCnWQZ5Sf/GxM7o/wWLL4Or/IBPRt4gNYdXRrA+n3O8VuTVi3JOK7ClIxPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912730; c=relaxed/simple;
	bh=YxdydQxEeqgWOKZDzzhLVNxkB+ZO7uV8OQ8R50Iwbbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYD5Vx3uj1DXcEOF1xXREXd3Yc5uOLtHOzToyTR/Or/4d+S4L4LLciygPDOQDnaZpBo+6RBUkBT9UIw0XOiQD1AtA1x/9kDx2dijVTIfSx1s9NiRu4afH+W/XKNV7bZ7I1uunee3tdOued7PXWRZzsD/JuzSKTc3o4MTfyxGPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GRS0ZU4D; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AQXk6ztfHTUQteq8elPhWhUuCISghcvWoGYTPvw/Cw8=; b=GRS0ZU4D/LbdgGtJz8RqDet2I/
	kBSmua98CNEkx9YC1kQqu5FoWtonv8v6mjKUDDc+4jt2vUVc3H6KfulRVGlmnmc77P+HgeXkffCxc
	ylDiVRu9Ko+fcofddOY/MotK4SzHmfX/qso/QhYfbjx+NngmuqyXbkJsJKWcizQVxvqWLiSXbitLm
	7N5QOFhclCGI2g2TRhiPKOVDDFSHwO19js7JLFOv+9TrSrB6I5oA81S9Gzs6k2x9duS/K3VXWggQY
	rjF7yM0fWEyE+RAq7rdWWkODzySa7GRoaOxdV0lHMyk6n0mrrCOHOXnjiIU+96+GbfoKG8yqtGoj/
	1ycf+wPA==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw920-0045tc-HW; Thu, 03 Oct 2024 01:45:20 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 05/10] libfs: Export generic_ci_ dentry functions
Date: Wed,  2 Oct 2024 20:44:39 -0300
Message-ID: <20241002234444.398367-6-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002234444.398367-1-andrealmeid@igalia.com>
References: <20241002234444.398367-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index 46966fd8bcf9..7b290404c5f9 100644
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
index 9a5d38fc3b67..400d070d9a9b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3453,6 +3453,10 @@ extern int generic_ci_match(const struct inode *parent,
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
2.46.0


