Return-Path: <linux-fsdevel+bounces-31919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513699D779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 21:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8CD1F211B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B01CF2BE;
	Mon, 14 Oct 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIRJvgrV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7F1CEE84
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934087; cv=none; b=ciZ6aw/Z2XUiBpZ+ovjNb4kk2lxi0xQoGpGXcbtq4ZmxzH6pzsFw2vMlFLEzV0VlwYAl+daENZTBKHQyUqspGa49+fCd7O/V9zhnKApvsGd+/GbePgUDmQCTWdnyugOj5+CQJ0Rj5r4GtRKE2k6BB6UD8VHAVef9rmxOimAimh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934087; c=relaxed/simple;
	bh=bf/Ovhn3Yk7hJaUtt54sc4CZp0O1Ln9BXHm+ECStcFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ch6t+0y/BLRByQjf+KfhWhDhOsD2u7bHMh3uMdVP7xLT7GTPtfkQoYlSENyV0PiC1rHMUu2mHEgP319rK6PwLof42htf989OLElwtkMCRIJJbOR9LIKhAEMv82eFracLqcIeaTjIayU3QMl3rvRhzee6rV8AA6/q6mq4yejEmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIRJvgrV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso51338105e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728934084; x=1729538884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlOonWCxYkdZVmKONdw6Uq5KArfX/VwV3O/uTkfVJdI=;
        b=OIRJvgrVEpREcLxSgij73MNJn3cYrapjQq0fXtjin/op8GTS51nh9EQ9zK39F8tkLB
         T1tF06PirGs4zqyP3/dduxkR5riOkz3SlWZlgODmIbdT5ZqQHbVV7GOe1wPyDVk0Iffe
         Ysiw55r1yYNC/mE7xT60p5P2qM8dziwm6AAchEmjlxPDOntsEBOlgntMLAKwbj3yG+wT
         L2nj11emZwhFlnvWGIw7rGuKIYX9tPcVQYiQrjfsl8m2Iv+Pr4MWXuXDs7GkxNxgc37Y
         R+yzVdUY09R4zUay6U9Z6/i8ay/Cy2sAIBuYqq8DPK36aoWFOzgoBHT84464sH26Ud5K
         m6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934084; x=1729538884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlOonWCxYkdZVmKONdw6Uq5KArfX/VwV3O/uTkfVJdI=;
        b=s9e2FLj9jxUlNHla2BCHw4Vs2/mAmDmJiVMPAYCSwMbuvfI/zq/xHjytvhAA/cFzDE
         ahoxCCgQKeI9otEfxdoaQWbEjL3on/y4AyRfn10prkAa+nz/MB5/+bbbnA/njmwVL9fH
         roTZmC6QrxiXHkLVflmrgdtR4DfcPVGU9xJJxMcpq8qihj5Za3NX2a8jKSt+QA28bXFo
         Su+JC5wp9jGI0SdDhUD9xgGoD2dnwMtojDmSHF/93QIgU7GaRv/HEZsGEGpx5K5yiAPF
         GuYirhNAAaK+tF1+Hy8GSFclcU5QhS6Q3N+sbsu2qVdZLVoMrOVAOSBoQ+o5/P6RUeZT
         +dwA==
X-Forwarded-Encrypted: i=1; AJvYcCU+/7GDDM4AhgAW0/rle3lxq5klor0MxI809f/2iY1dEWcHq7PgM4iP8EZq/dmf/p8nVhxjHOa6AiGSojlA@vger.kernel.org
X-Gm-Message-State: AOJu0YxYtfHLuT+woxpGLolR9YJ/bnQe9DSvMYP3XOoJBmuHckEIJLkt
	PlfkhV15L2CbhjN0qe+/g10FJ5eq9y45YIPAY0E2o9EcLlmGMQ/l
X-Google-Smtp-Source: AGHT+IGxIZUFPxYUKJ3toAV73H3XN5/DiAz/jt2obnav16X/IxAj5XcRnIbGMwA6X4w/P7TCk5QALA==
X-Received: by 2002:a05:600c:1d93:b0:430:4ed0:d5ce with SMTP id 5b1f17b1804b1-43125617316mr98077765e9.34.1728934084079;
        Mon, 14 Oct 2024 12:28:04 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9d9sm12162673f8f.77.2024.10.14.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:28:03 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	yangyun <yangyun50@huawei.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] fuse: update inode size after extending passthrough write
Date: Mon, 14 Oct 2024 21:27:59 +0200
Message-Id: <20241014192759.863031-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014192759.863031-1-amir73il@gmail.com>
References: <20241014192759.863031-1-amir73il@gmail.com>
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

Fix this by adjusting the fuse inode size after an extending passthrough
write.

This does not provide cache coherency of fuse inode attributes and
backing inode attributes, but it should prevent situations where fuse
inode size is too small, causing read/copy to be wrongly shortened.

Reported-by: yangyun <yangyun50@huawei.com>
Closes: https://github.com/libfuse/libfuse/issues/1048
Fixes: 57e1176e6086 ("fuse: implement read/write passthrough")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/passthrough.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index c80b9712eff7..bbac547dfcb3 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -18,11 +18,11 @@ static void fuse_file_accessed(struct file *file)
 	fuse_invalidate_atime(inode);
 }
 
-static void fuse_passthrough_end_write(struct file *file, loff_t, ssize_t)
+static void fuse_passthrough_end_write(struct file *file, loff_t pos, ssize_t ret)
 {
 	struct inode *inode = file_inode(file);
 
-	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
+	fuse_write_update_attr(inode, pos, ret);
 }
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-- 
2.34.1


