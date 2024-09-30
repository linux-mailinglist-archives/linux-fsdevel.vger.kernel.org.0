Return-Path: <linux-fsdevel+bounces-30341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23198A054
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3CF1C219DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8C1917E4;
	Mon, 30 Sep 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="vr4z8+uH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6F18DF66;
	Mon, 30 Sep 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695307; cv=none; b=c8f+VhHa8pcn12BiSRa+MmKLb+u7GtVQYjpAT5BQbFT3kSqUkAeM6ZXj8PLyvIU8u6nlIw9k2+kEQaYDc7puONwTXB5qR9XUEseOqdhD+TRFT3nvZS1A+aDV8826tU0HdtrqdUM7ZMyZ5FgyyvvRVYTqkYCWeqm/QNKQHlSezxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695307; c=relaxed/simple;
	bh=tiPypvdgIX3UNjxLor6apsPW9dMipmDIhqCV9bEUOD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReEQhXFnL6l+W2AsabGEW/ZdXTcYngpd2QsAU7IbcpZWRcCFQM4IqJMZj4N0MBjdWXcIhq8RL0Xpq2J/WytgfbQWWQrtSNbvl5E9d2OkIDgQDQWBjFuTFDyIeg2ujHStfIQZxnbPmh8vYgxuOo3JLoTqdhsHuVov7HgIv/yzWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=vr4z8+uH; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+p76pyonorQH0EdArmWLA7KPzT5wrEkQVbK8fq3xix0=;
  b=vr4z8+uHFG1CzL+hFBLDIvd1zO/XG2c9OBw801pU4u0CwGqemBa+oWRF
   /zNyWA6zlGk5bHgTv/wvpJ+JbGhjXIpYO9N2Nw4VCgl2zp8ka3xduxDH9
   p0nOVcdno6NUqk48zzoAS0iKt5h7m6wgQvj/xsO7XsUKhl5tRkWtA+9hJ
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956879"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: kernel-janitors@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/35] fs: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:54 +0200
Message-Id: <20240930112121.95324-9-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 fs/char_dev.c |    2 +-
 fs/dcache.c   |    4 ++--
 fs/seq_file.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 57cc096c498a..c2ddb998f3c9 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -562,8 +562,8 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
 
 /**
  * cdev_device_del() - inverse of cdev_device_add
- * @dev: the device structure
  * @cdev: the cdev structure
+ * @dev: the device structure
  *
  * cdev_device_del() is a helper function to call cdev_del and device_del.
  * It should be used whenever cdev_device_add is used.
diff --git a/fs/dcache.c b/fs/dcache.c
index d7f6866f5f52..2894b30d8e40 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2039,8 +2039,8 @@ EXPORT_SYMBOL(d_obtain_root);
 
 /**
  * d_add_ci - lookup or allocate new dentry with case-exact name
- * @inode:  the inode case-insensitive lookup has found
  * @dentry: the negative dentry that was passed to the parent's lookup func
+ * @inode:  the inode case-insensitive lookup has found
  * @name:   the case-exact name to be associated with the returned dentry
  *
  * This is to avoid filling the dcache with case-insensitive names to the
@@ -2093,8 +2093,8 @@ EXPORT_SYMBOL(d_add_ci);
 
 /**
  * d_same_name - compare dentry name with case-exact name
- * @parent: parent dentry
  * @dentry: the negative dentry that was passed to the parent's lookup func
+ * @parent: parent dentry
  * @name:   the case-exact name to be associated with the returned dentry
  *
  * Return: true if names are same, or false
diff --git a/fs/seq_file.c b/fs/seq_file.c
index e676c8b0cf5d..8bbb1ad46335 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -343,8 +343,8 @@ EXPORT_SYMBOL(seq_lseek);
 
 /**
  *	seq_release -	free the structures associated with sequential file.
- *	@file: file in question
  *	@inode: its inode
+ *	@file: file in question
  *
  *	Frees the structures associated with sequential file; can be used
  *	as ->f_op->release() if you don't have private data to destroy.


