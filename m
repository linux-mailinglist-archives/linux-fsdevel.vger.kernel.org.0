Return-Path: <linux-fsdevel+bounces-3194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44A7F1006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 11:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83461C21444
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A989112B93;
	Mon, 20 Nov 2023 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2Xm9gmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC16A7
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 02:14:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a3b8b113so5960594e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 02:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700475269; x=1701080069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIFEH9J46dnQc4NNK79UsV/YpAUrG1xOxVxexAT8zUM=;
        b=d2Xm9gmgzQD7mHBLjSLvy0B4GTHCKl6+NWspEKJgFWzawKj+6gj6TvbSTIWH8GVAw0
         xNRQE3BtmhJlngPjEm9W5QSu3au3pX/g9i+etrDYBmx1FuApTF6qPUPdrACHlhIxAvWQ
         O2+b1iTocvVPoOV81/HH4rQVHBLAX9JIlYWb4o9IUrXcIM63Xif8d5QjUyqmqekP8fLS
         F2dtrj0xOT4+pDoawet5H2UYhsu97J0lRk0rR3a89D2N2a0LiAZmUAeAsLm8y3cdkZxN
         etXOE1vtws3X70a540AbKWPqcenlSYLNEjlfFLB/2Gmvxa2JlKc3s1Kbf+atta+jJhbB
         Fxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700475269; x=1701080069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIFEH9J46dnQc4NNK79UsV/YpAUrG1xOxVxexAT8zUM=;
        b=Uz5w1dpoc7izGSLXzDIP4kehCarG+fdtqM4vucM/5tfBfs8nfSbT+8Ru1MANHGASaL
         b58LCHl4tINYeg04mCdDUc54/Q3KxpQclig/qOumzcYbJfSzpF9rAmK9sdzowrhLTNDK
         EaRUXzpvp7J9j514eTngX75HhRJcGdvizhsiVTI6+jhFEkZurjAkrcmoH1AsvBxRSiS0
         bmJSw//aR6IdVSqQ9e8wu1S7Dd/5pXzHThzZG+rn7ja2pLy9eI0VkpVMvcbTk4Qty364
         xqLu6rNm6L4ri/oKJ6c/GemLxXNTweBFDCRGm7oBvAE5RIj+O0WXWOUhY0D12s0z6hTF
         1bSA==
X-Gm-Message-State: AOJu0Ywm9kOaPjXGJhYpqjH9uXAzShQx+LUMtJAXO0dBZNEUNL39Yaxn
	kNQyO5fd3Dr0BSkfukcaLa8=
X-Google-Smtp-Source: AGHT+IHJFl6lVDLKoa5bRCqPnEN33PhV5IJtJ3jpYe1vavpty6S3awDwBhML9M+98Sro/1PFVXNutQ==
X-Received: by 2002:ac2:4566:0:b0:509:4ab3:a8a3 with SMTP id k6-20020ac24566000000b005094ab3a8a3mr5681280lfm.22.1700475268592;
        Mon, 20 Nov 2023 02:14:28 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id b15-20020a056000054f00b0031980294e9fsm10678282wrf.116.2023.11.20.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:14:27 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] cachefiles: move kiocb_start_write() after error injection
Date: Mon, 20 Nov 2023 12:14:24 +0200
Message-Id: <20231120101424.2201480-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to move kiocb_start_write() into vfs_iocb_iter_write(), but
first we need to move it passed cachefiles_inject_write_error() and
prevent calling kiocb_end_write() if error was injected.

We set the IOCB_WRITE flag after cachefiles_inject_write_error()
and use it as indication that kiocb_start_write() was called in the
cleanup/completion handler.

Link: https://lore.kernel.org/r/CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88rH1UfEeP8AtP+w@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi David,

Can you please review this patch so that I can add it to my series
and send it to Christian?

I do not have a cachefiles setup - this is only build tested.

Thanks,
Amir.

 fs/cachefiles/io.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 009d23cd435b..3e000d6ef9fc 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -259,7 +259,8 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 
 	_enter("%ld", ret);
 
-	kiocb_end_write(iocb);
+	if (iocb->ki_flags & IOCB_WRITE)
+		kiocb_end_write(iocb);
 
 	if (ret < 0)
 		trace_cachefiles_io_error(object, inode, ret,
@@ -305,7 +306,6 @@ int __cachefiles_write(struct cachefiles_object *object,
 	refcount_set(&ki->ki_refcnt, 2);
 	ki->iocb.ki_filp	= file;
 	ki->iocb.ki_pos		= start_pos;
-	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->object		= object;
 	ki->start		= start_pos;
@@ -319,16 +319,17 @@ int __cachefiles_write(struct cachefiles_object *object,
 		ki->iocb.ki_complete = cachefiles_write_complete;
 	atomic_long_add(ki->b_writing, &cache->b_writing);
 
-	kiocb_start_write(&ki->iocb);
-
 	get_file(ki->iocb.ki_filp);
 	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
 
 	trace_cachefiles_write(object, file_inode(file), ki->iocb.ki_pos, len);
 	old_nofs = memalloc_nofs_save();
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
+	if (ret == 0) {
+		ki->iocb.ki_flags = IOCB_DIRECT | IOCB_WRITE;
+		kiocb_start_write(&ki->iocb);
 		ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
+	}
 	memalloc_nofs_restore(old_nofs);
 	switch (ret) {
 	case -EIOCBQUEUED:
-- 
2.34.1


