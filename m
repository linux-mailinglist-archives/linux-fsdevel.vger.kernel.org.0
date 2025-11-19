Return-Path: <linux-fsdevel+bounces-69077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDEDC6DF55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A4524F9F51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADB9347FFA;
	Wed, 19 Nov 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q8g9lEJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396C349AE1
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547266; cv=none; b=mPbx6ZSQvPv9FmUt8rl4udwrEFpDie21i084ClEKv8PSeF+Gf32DpEjqTb2Xhhv5hBZWMoOh3Ct2nRn84E1MYRoY5lW4fSoLs2hxHdJpp5kzpZn4tQhTJehoN1lztiOhdS9PLJAj0ZhHCNIz4KDZXYPqzuscAGy9PsYXKIX6PY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547266; c=relaxed/simple;
	bh=pFy+qi+KQMrFT81uvuVvey4h2O+273gG7N6dXlT0s0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSMCfuIrEbLbStFG+YeS5RsxBCj8HJG213V0sh2qUDR6iIGfybq8wPiyYhxmR4+A4BGESxgrZpl0inJFOgFUKTYoFGVZN1MO9plTd27GHG9d/oRSzcs9udKkoA2yd1M7ALxGKIHLEMmXXmNGQBULN0YE/g1k33PveMBiyOUBHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q8g9lEJG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LBZbpWAl2kSwbOy4eK4JP+qjdiXAXjfeJWmSsIuUX98=; b=q8g9lEJGb7U3YomCHJpYpbN7sa
	KG9dY6ootlhQB3daKQU/O4iOgx3OZeNfZMkSCUXesjHSPitYGd5UzF2L5pF5CZWmseAlMECZs5mPp
	g+MSu5t0khS5xxM8KyrRotIyaUTuEG4UnhkjSi/vOiiPnzD+iE80vPJ32Jkv84UuJ2zW4TPlH8lyr
	8z52pqvaWvkkvlwe2oahvGz4rkjpIQ4lKvsnShzyN/wrkN034UBr5DXZrQ4XzJrlRS185uuwp7g0u
	Nq/buAA3EMsH5kxJf5UvQN3K6yfEwI69fjNeEhRnbEyHVvnp9iAIDrU+5vHnVcHPsgLXZY8CG1PCz
	wFP7J4rg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfCd-00000002wnN-0w9a;
	Wed, 19 Nov 2025 10:14:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: aalbersh@redhat.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: remove spurious exports in fs/file_attr.c
Date: Wed, 19 Nov 2025 11:14:15 +0100
Message-ID: <20251119101415.2732320-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit 2f952c9e8fe1 ("fs: split fileattr related helpers into separate
file") added various exports without users despite claiming to be a
simple refactor.  Drop them again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/file_attr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 1dcec88c0680..4c4916632f11 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -316,7 +316,6 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
 		err = put_user(fa.flags, argp);
 	return err;
 }
-EXPORT_SYMBOL(ioctl_getflags);
 
 int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
@@ -337,7 +336,6 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 	}
 	return err;
 }
-EXPORT_SYMBOL(ioctl_setflags);
 
 int ioctl_fsgetxattr(struct file *file, void __user *argp)
 {
@@ -350,7 +348,6 @@ int ioctl_fsgetxattr(struct file *file, void __user *argp)
 
 	return err;
 }
-EXPORT_SYMBOL(ioctl_fsgetxattr);
 
 int ioctl_fssetxattr(struct file *file, void __user *argp)
 {
@@ -369,7 +366,6 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 	}
 	return err;
 }
-EXPORT_SYMBOL(ioctl_fssetxattr);
 
 SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 		struct file_attr __user *, ufattr, size_t, usize,
-- 
2.47.3


