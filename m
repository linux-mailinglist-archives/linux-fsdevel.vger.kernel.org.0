Return-Path: <linux-fsdevel+bounces-49009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E198AB77FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E3917456D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC81E9B1D;
	Wed, 14 May 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vUIQhp6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF354C6D;
	Wed, 14 May 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258366; cv=none; b=PBbKgTQXA0+cyYy3N/0X4DyP2UXPkkpS2G3O0a9UhlzkQkGPH74k5VMvflMzt9dM43NOg/xg77zUWcPm0RxU2Eehx0rrEjgCg+z4ENCxyCPdvPIuaITcrq0vybEPMDpwGv/vVK67Xtc4SjMsDQcoZ5knKkM9fzlq7bj0fZyeKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258366; c=relaxed/simple;
	bh=RC5fmh5roIicKEjisa/u+zzgbg9XEtk6Plu0+SmtQu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJA2i3J06G40TBGJjjE1nRd9HfFsdETbtNYR7p9MV6az/fMWVGMXl7BDsJM4Tc3fDxq+ujKRrLyg7Nh9FYtCbyJedKJe8DGNx2LcHFRu4dVhTWTFwIknKZHfS3AkkW2+0S89DRRTTv4xfB4qTBxIHHU02zhbCFLsEKCU0a38QTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vUIQhp6Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PeJJjp4f4LB9WolqfCSgCTxrRZ+eAI3I62Gy14YqPtc=; b=vUIQhp6QtF12At3r0x+162hvsI
	KD7Sa3V5GCJ+cek4iBNbTjrL7TWqcqBvyYUAm7JsTnXEEdbwVen/8k9wIZHNCYaLUz+ntjUzMsmxK
	HYPhlAnc8HlzoRM4IL4ZJJcF7Td4+OVW19U76jyGYj2pxGbglEcWn8tsU3ASz7LPWyP43vOaW2+8U
	B+r0C7pB7yS4CcplSID5lKhuhUHeq9v5UIgPQhXziUrouDoVv7aMqdyQiD4dy0Y7StYfO+lQsQMTN
	eBeagqWmY6gNm3MhDsEYrdDzV9RuHPiRyxfZ8XkQfSzZUGMek4ZOo5eoV6iHAFVLmREycINCIjqFA
	BuVR/GJw==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFJiW-0000000GOk0-0I2x;
	Wed, 14 May 2025 21:32:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Chen Linxuan <chenlinxuan@uniontech.com>
Subject: [PATCH] fuse: dev: avoid a build warning when PROC_FS is not set
Date: Wed, 14 May 2025 14:32:43 -0700
Message-ID: <20250514213243.3685364-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a build warning when CONFIG_PROC_FS is not set by surrounding the
function with #ifdef CONFIG_PROC_FS.

fs/fuse/dev.c:2620:13: warning: 'fuse_dev_show_fdinfo' defined but not used [-Wunused-function]
 2620 | static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file)

Fixes: 514d9210bf45 ("fs: fuse: add dev id to /dev/fuse fdinfo")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@uniontech.com>
---
 fs/fuse/dev.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20250514.orig/fs/fuse/dev.c
+++ linux-next-20250514/fs/fuse/dev.c
@@ -2617,6 +2617,7 @@ static long fuse_dev_ioctl(struct file *
 	}
 }
 
+#ifdef CONFIG_PROC_FS
 static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
@@ -2625,6 +2626,7 @@ static void fuse_dev_show_fdinfo(struct
 
 	seq_printf(seq, "fuse_connection:\t%u\n", fud->fc->dev);
 }
+#endif
 
 const struct file_operations fuse_dev_operations = {
 	.owner		= THIS_MODULE,

