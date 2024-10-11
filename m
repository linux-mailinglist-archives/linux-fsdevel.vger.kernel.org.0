Return-Path: <linux-fsdevel+bounces-31713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB54699A556
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273C81C21577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3202194AD;
	Fri, 11 Oct 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9PxUVdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B907219488
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654371; cv=none; b=h9Lsx7HVMlgeSsZtTkjie/d/JvP59+5VuxD99TGI0+COItkTxyfVQZKmWeZIr5VJPKQdpd0SYU+CbfEpOr7+GPofbC3h09HXNteT3jRcLZ5FoQeTvLScP1akd1QAmOed5uqijUtWlXjADwxrIYbEsDkYt6nqQvzQDniFp6lo+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654371; c=relaxed/simple;
	bh=irWxn9y3gfQEpWGmf6kmundSrrggF9aMOMV5XKsybGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oNphMAC1f6pB47F4YJviCtAouBwpOpWJCe4YalBd12MW4OmXJvVRUvn8IOTOEMFSnnjU+P6ho41xpEPm/r5hXhyjBCFifqimmbNsXaQGGoFMw+niq7JOYEb4n4qi1uxU6jU9Ybn7TPZG/hOk6GFyncPjPaAPfNMsjpZs4vzc5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9PxUVdg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4311420b63fso15026565e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728654368; x=1729259168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2qp85caGkHrNfR7469NqoR0KI++fVRvHImGSKJSP7w=;
        b=H9PxUVdg3t3mjHJaz2zWcv4WXpkOS+3pMF8pMYEwWMkXheqzUxocabnGMRw6ATm1tj
         t0ysbJYhgHfUXvOd3lvd/NJZftc7oQjYsCrEb5TTECfneqFqJlMZtGVoDzkPMdrPdTVZ
         vz7pRPYf2u6Mgl1+LWxd/tOq2ZgymT5I8p8y4IzMGc2/FmStBlKJ8ieruYuTOELkTocr
         cZho7f7n+zSMTcNxkOQiFcoizej/tvUEtEK1OecMsgKjCRRN/S6udnRzVk0TM/m9BtUG
         Yn9FijgafVGG5/7/SIXf1kJBQsB9AxhHXtbEUtrVZmHemErCkz8flVTgHYRaQDwiHJnl
         2gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654368; x=1729259168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2qp85caGkHrNfR7469NqoR0KI++fVRvHImGSKJSP7w=;
        b=skVDlUeQYmcY7pCUc6EzvJP4N61JVdhZm8XWHRSVrkzlHejAxafvtDVMOTFKUfegBH
         Y0Yxime5Oy8y79/1wXTGJUnnPV0vYxZepTO7Fgn1Qi9GQBevUOtfdu3BvAV8fb7/WT9m
         Ql7d47Q9WJLEFrG9rgklc+bt63qj5veIssxH1vuPs/fYNyzqrdODJD3lclndXQWsVapV
         JJHgBaPMxkI4hANYUTzkn/LspnElT7rfiihfldkgLKvvM8EQtH3N8Dtyx1HzYqZtAdvN
         nhYgtK1n7mVf6qszv7i3rlSmzazk9eVam11CzEE8ubpAdJbdhXY3b/bN2b57/YE50dgw
         Z92g==
X-Forwarded-Encrypted: i=1; AJvYcCVqoLAM3UZ7aMe6yfGzONB1pWeNKUkro76QEKQrqMnmOxC1VvfrnN8PSQ2+uIjAa13/VHJfJgOjxRiiildn@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOF2nEhJjJVJwFRjSyDUxj5KsrEgetCgojbBfjGiEXiestK99
	bCMmVhTBaOiodkO/uMTE9LcO2sc/gPY5JL/c/YHXk7K7YCchjqG2hhniwK9H
X-Google-Smtp-Source: AGHT+IH7eUfGQHY4WtDe22cfNkE+AaccwDz7YYRgreDlA+DMf6mon2qwh1DXP5Jbd16qXIbHRcoixw==
X-Received: by 2002:adf:f189:0:b0:37d:5338:872c with SMTP id ffacd0b85a97d-37d551afa0emr1739957f8f.1.1728654368113;
        Fri, 11 Oct 2024 06:46:08 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79faa8sm3992870f8f.66.2024.10.11.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:46:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	yangyun <yangyun50@huawei.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ovl: update inode size after extending passthrough write
Date: Fri, 11 Oct 2024 15:46:01 +0200
Message-Id: <20241011134601.667572-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yangyun reported that libfuse test test_copy_file_range() copies zero
bytes from a newly written file when fuse passthrough is enabled.

The reason is that extending passthrough write is not updating the fuse
inode size and when vfs_copy_file_range() observes a zero size inode,
it returns without calling the filesystem copy_file_range() method.

Extend the fuse inode size to the size of the backing inode after every
passthrough write if the backing inode size is larger.

This does not yet provide cache coherency of fuse inode attributes and
backing inode attributes, but it should prevent situations where fuse
inode size is too small, causing read/copy to be wrongly shortened.

Reported-by: yangyun <yangyun50@huawei.com>
Closes: https://github.com/libfuse/libfuse/issues/1048
Fixes: 57e1176e6086 ("fuse: implement read/write passthrough")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/passthrough.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index ba3207f6c4ce..d3047a4bc40e 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -20,9 +20,18 @@ static void fuse_file_accessed(struct file *file)
 
 static void fuse_file_modified(struct file *file)
 {
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
 	struct inode *inode = file_inode(file);
-
-	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
+	loff_t size = i_size_read(file_inode(backing_file));
+
+	/*
+	 * Most of the time we will be holding inode_lock(), but even if we are
+	 * called from async io completion without inode_lock(), the last write
+	 * will update fuse inode size to the size of the backing inode, even if
+	 * the last write was not the extending write.
+	 */
+	fuse_write_update_attr(inode, size, size);
 }
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-- 
2.34.1


