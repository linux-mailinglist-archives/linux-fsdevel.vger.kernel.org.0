Return-Path: <linux-fsdevel+bounces-31630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348B9992D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82271F279D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A91E8837;
	Thu, 10 Oct 2024 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e/wI86TS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE461EABC4;
	Thu, 10 Oct 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589285; cv=none; b=bpO1jtWK5eaQkreJ2I53yTE8SP+Hs8P4LbKg8//D4g4qOrLAT86DpMFw8AxXBWa6IyLPfF/65xm7ROOzQfq3y8A5xZvhm04J9bb8h6RhAC1zvZd5efbNER43retHhtArYYHwj5SKxgS++GUs6YR3Hx2VbIqdRr0771s8VHakWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589285; c=relaxed/simple;
	bh=KuSx5QNW+2mvSoBMyvWxQrxOHyeGg6GA3x70AgHni9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oFe7DUdvPQ0pWwmmHHNgY1Pmh4N7QDjUKOVPqu4cmYPAmJwdL8uFSmgW6Wd1gLPnlbcBNRLMLbCNaT3+zct/mhrMMm40nANj/ZnNVpuwINYE3C2Bz/U2Bi6Wxp89QUg5b1hfAfDQ4MYoQbM0PrE+FZ+D2t/iD+KH0m6GQmioNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e/wI86TS; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yy1QkMBVz1rUhANkqZgd4aZpMCC+lFeHbVpyTkY8ZcE=; b=e/wI86TS/CqLCywlrfiwkp1WUs
	HM/n+0gxZKeHi6CUJE4brwibgsgjJv5gT74ZYWGrFkXmIbYetmTe+Pc4o0xdsLaAhndFe+gcNyVKK
	QiVos7aFwQEM+FSpqTj8Zw/DYljmlNx5FvTjoIHE2/I7FmHETd2nrohp+eDgPu3LlFycnJEd+xb9Y
	P8MLfHz15A6Enve05fWqu+ysOgEIA7H3fypmIMubJzoyA3rnyc6TVbrx/FT911lZmvvVViVyOW2cY
	y8+7EkHtdx05Gskguah8myRuScZEEYfuFa5XTIKIrBUZ+wzJvwHLIoV+SDzmC2ia5jTs5Brqcyot+
	qlMLVCxw==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz2G-007SHz-Nk; Thu, 10 Oct 2024 21:41:20 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:40 -0300
Subject: [PATCH v6 05/10] libfs: Export generic_ci_ dentry functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-5-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
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
index 9b232aee4cd6ad8dce64370db0111bd25d3fedfa..21e183e5041ed029bf47fda018f44b20bcdd4389 100644
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


