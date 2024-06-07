Return-Path: <linux-fsdevel+bounces-21149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A88FF9CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6314284AE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4911CA84;
	Fri,  7 Jun 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QZCVt7qM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9A14006
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725603; cv=none; b=hsML7+IyJ6RSmPhQtCZYwBjlMSSoc6+A93qMeSVfmhLBob7t5vcEDDx/CcBNt/C6QMcZbCp/GZ6Hvnb2c0C/EsM0dWyZSMbpXdbPDaOZN7Mz5eyf67gPsrknc+W6VSzzv6p/RGa/SrDykRzxRWlwNVWnE8ok2gp5ge7TDmGhtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725603; c=relaxed/simple;
	bh=238ITop5zgw47P6cKcj0FJSRnfIHutok/+7yi1YPHQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqzdjirfpqaXwNvQHXTG0U6Ojd+XwEzC+3Ss8S90PMhvyqHDLIQa73gKKDA370WC9vheSADMn3Yh7Xmt6dgdTIaBgr43k4iJYiMRo52kTVWB0aGFzrKMAN7z97WlDvl+z16BNrXiJ1wEehIdxxKzXbDUKUve6WgvrlPbqRGq2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QZCVt7qM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MwmcXg7tR969Vt74h171bcBgtB/eO98pk7IcSbDC5Ms=; b=QZCVt7qMMmWmQfL6sVhyjCl8BX
	1Vko81HgYIDoB6uFRPLEaSqRieFW1PPaXW7d3U4AKUBrfQ7MSZyNdUS9Q1kmCU7eXjgcMuNkECnyK
	iJBRKkMGqQ362GWwcMaZw132CPy3cnLA6p4ZKLcVxIYkqc/uO0X4xzVVBpNSxoiZ0alo4rRKXSATB
	2Oz1f5O+egbJluPGZ8XmtgUmsbN+UK+G/IfI27VAI4uFk4JWszXLM+a36Yt2QEO8h1IMngLIUuAzB
	uIMBK+ZFSgFOK+bdnpRS3tW2CkNCh/q4QtQ3x/0EsIYUm0WT12iYqW7lJzYv9H1jhh/2PcdxShqfa
	Qy6SgkRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtc-009xCV-0X;
	Fri, 07 Jun 2024 02:00:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 14/19] finit_module(): convert to CLASS(fd, ...)
Date: Fri,  7 Jun 2024 02:59:52 +0100
Message-Id: <20240607015957.2372428-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Slightly unidiomatic emptiness check; just lift it out of idempotent_init_module()
and into finit_module(2) and that's it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/module/main.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fda13fdca7..f2f045b3740d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3177,7 +3177,7 @@ static int idempotent_init_module(struct file *f, const char __user * uargs, int
 {
 	struct idempotent idem;
 
-	if (!f || !(f->f_mode & FMODE_READ))
+	if (!(f->f_mode & FMODE_READ))
 		return -EBADF;
 
 	/* See if somebody else is doing the operation? */
@@ -3193,10 +3193,7 @@ static int idempotent_init_module(struct file *f, const char __user * uargs, int
 
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
-	int err;
-	struct fd f;
-
-	err = may_init_module();
+	int err = may_init_module();
 	if (err)
 		return err;
 
@@ -3207,10 +3204,10 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_COMPRESSED_FILE))
 		return -EINVAL;
 
-	f = fdget(fd);
-	err = idempotent_init_module(fd_file(f), uargs, flags);
-	fdput(f);
-	return err;
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+	return idempotent_init_module(fd_file(f), uargs, flags);
 }
 
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
-- 
2.39.2


