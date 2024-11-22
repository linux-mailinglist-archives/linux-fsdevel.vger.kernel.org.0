Return-Path: <linux-fsdevel+bounces-35572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342EF9D5ED3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1F92836C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1201DE8B6;
	Fri, 22 Nov 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2nw4GuXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797231D9598
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278582; cv=none; b=kz02IxRDImXr1FjwQdOfPbelI8Tokt7aggDP/KCWLpBloixatXLQokxQzdzWd3HAOFw23xamvTTUsaJTONsMwWofLW+aXXAEfTnPlpxijCdWaXnovvVO9cMOdfm5lhqPNtRBUDeBGXfdUXZFUUgUJ43nz5zwHff5F14nULV06C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278582; c=relaxed/simple;
	bh=0G1jyanNUGS+vpEp0ExQknkpxKx51AWQUciUms7RFDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcGSUZu5BUc6XSGVCvBSvndFLgSazLHRascjBgk0Xy4GSvjpjrpZgRSPwDBxls1bCIlL7yGYr1wDVnLSqIn5l5IKuKzuJfdbukA1wTx3KClUopF4bbhYICKydQh7SngfpPQEl6TBfN7J9Kik1+b9Kuy/OqahebDuzVLC93fjUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2nw4GuXd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lKnYr94ZGk/mkCFjk8UfkZ0LNtWNM+Slkj8Yi2yiVw8=; b=2nw4GuXdfzR1kExF7pSksU5g3o
	y4VpFlg3U+0cgQItsmRMvA1N6U37K1o6bPQgIA4nkBiAL6peOSJGMCyx1TI4FkMCS9Y000cOSQJnh
	PWkWY3REdNKbQSYM9E4/E0eTb0U+kUoz3IJPkU4QBLEetACM/LQmYJbDvRimgIX67Hot+0Uku83eA
	lpVdnv378pOX6IVavY4R/j/NXZRQNpHaNqtZoE139nKJ2V60q+OWcLU588n437gKvvwWZEEJPzmXZ
	DxN7L6huXYSIE+t6DQWTsYo80Y3MxolO8gLsTMOrfUp4tFrZkq0K+B14ZDNbPPFxPHDTsybnWj8dF
	Nl0H5o/g==;
Received: from 2a02-8389-2341-5b80-6215-0232-ff10-500c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6215:232:ff10:500c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESn4-00000002SEx-3p1Z;
	Fri, 22 Nov 2024 12:29:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: 
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: require inode_owner_or_capable for F_SET_RW_HINT
Date: Fri, 22 Nov 2024 13:29:24 +0100
Message-ID: <20241122122931.90408-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122122931.90408-1-hch@lst.de>
References: <20241122122931.90408-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

F_SET_RW_HINT controls data placement in the file system and / or
device and should not be available to everyone who can read a given file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 22dd9dcce7ec..7fc6190da342 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -375,6 +375,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	u64 __user *argp = (u64 __user *)arg;
 	u64 hint;
 
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
+		return -EPERM;
+
 	if (copy_from_user(&hint, argp, sizeof(hint)))
 		return -EFAULT;
 	if (!rw_hint_valid(hint))
-- 
2.45.2


