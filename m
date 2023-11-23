Return-Path: <linux-fsdevel+bounces-3517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55467F5AEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 10:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55BF1C20D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B021117;
	Thu, 23 Nov 2023 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKqERmlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F71AE;
	Thu, 23 Nov 2023 01:20:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4094301d505so3746615e9.2;
        Thu, 23 Nov 2023 01:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700731210; x=1701336010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agWSrKHOHYuZjNUZSTGfhGdN53IKkDI5ATnREaAaw0E=;
        b=BKqERmlcT/e/kUtq4+VGfNxG4rVteZyxvLM+2RFXpHfRvvCcJmUJl3EKNshqU8Eekx
         O51iK2kpfwiBYr/lwJvIh7ScT3YRP2zHD6+Nv+uPCN5UirTH6m0nGRw2uiGqdYJIrs41
         G8RwpbC03gJ2iCaQafxQRkHca5jjkszLaRfdawNsXBmATfarTZp+/41CbVbbd//9e1De
         50Hck6lp30kP/PmWxXfpPdTPG7sbElaPDFCnxqmHo7FfCYdQdT7uQWUd8kE74GP7Cv6E
         TFUqeZbm1qaNAeunp9nGSep8K+sg4X36hRWAX2Q+eyOYP7qTR9fbNLA8SFctDxOuMxzg
         UQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700731210; x=1701336010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agWSrKHOHYuZjNUZSTGfhGdN53IKkDI5ATnREaAaw0E=;
        b=dvSckkugIXlZpqUhOBNdTc0F3HqFt3obXfIEU7q4s87ZxXGEmYD8NVAY7sfot+CMot
         Vngg/zDApbrZP82MPI6XLOl9JSdvCdOXcAHvB2zl6YVZVU0hNckVhZQXZOpqE0MvJI78
         OYnWxYrIC1hVGPJIKzAk1NlVg71LpTqKC0BV9rw+vT/2TUnyuWVvvpG/RVhicExt67zJ
         jAbYZoQKsnzei6B0QZ423XTGpAeVflawaAPd0BctAEdMCqOKkceo0n00AnYCibZBUPQO
         Xgvo5ixCiSqL70MyQfqXyZwYB7AI7jsgOl1F2bFa3vlHv6bIpZD6iJt1M/g4RnJuWykl
         fpYA==
X-Gm-Message-State: AOJu0YxtbOUoZpXySIHCJQVfxobatGG16JQgY6nk+bK4UYHmMxQAvM9s
	3IEfyxiMCnAOiv3AMnf39P7MnkPofBI=
X-Google-Smtp-Source: AGHT+IFCzqERQRf3kI6frXxEB17qyukCZx9xxj2dvuRXtr7+/PbpuiA3nV5Olnycm/GRCR4ZJI+Tzw==
X-Received: by 2002:a05:600c:4514:b0:409:787b:5ab5 with SMTP id t20-20020a05600c451400b00409787b5ab5mr3682862wmo.23.1700731210011;
        Thu, 23 Nov 2023 01:20:10 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id x12-20020adff64c000000b0032dcb08bf94sm1094868wrp.60.2023.11.23.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:20:09 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: core: add missing file_{start,end}_write()
Date: Thu, 23 Nov 2023 11:20:00 +0200
Message-Id: <20231123092000.2665902-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callers of vfs_iter_write() are required to hold file_start_write().
file_start_write() is a no-op for the S_ISBLK() case, but it is really
needed when the backing file is a regular file.

We are going to move file_{start,end}_write() into vfs_iter_write(), but
we need to fix this first, so that the fix could be backported to stable
kernels.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/ZV8ETIpM+wZa33B5@infradead.org/
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Martin,

This bug is already fixed by commit "fs: move file_start_write() into
vfs_iter_write()" on the vfs.rw branch in Christian's vfs tree, but
Christoph suggested that I post a separate backportable fix for the scsi
target code.

You may decide if this is worth expediting to v6.7-rc or not.
If not, then I think it would be best if Christian insert this patch
at the bottom of the vfs.rw branch and revert in the later aformentioned
commit.

If you prefer to expedite it to v6.7-rc, then it's probably best to
rebase vfs.rw branch after the fix hits master.

Please let us know how you prefer to handle this patch.

Thanks,
Amir.

 drivers/target/target_core_file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 4d447520bab8..4e4cf6c34a77 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -332,11 +332,13 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *fd,
 	}
 
 	iov_iter_bvec(&iter, is_write, bvec, sgl_nents, len);
-	if (is_write)
+	if (is_write) {
+		file_start_write(fd);
 		ret = vfs_iter_write(fd, &iter, &pos, 0);
-	else
+		file_end_write(fd);
+	} else {
 		ret = vfs_iter_read(fd, &iter, &pos, 0);
-
+	}
 	if (is_write) {
 		if (ret < 0 || ret != data_length) {
 			pr_err("%s() write returned %d\n", __func__, ret);
@@ -467,7 +469,9 @@ fd_execute_write_same(struct se_cmd *cmd)
 	}
 
 	iov_iter_bvec(&iter, ITER_SOURCE, bvec, nolb, len);
+	file_start_write(fd_dev->fd_file);
 	ret = vfs_iter_write(fd_dev->fd_file, &iter, &pos, 0);
+	file_end_write(fd_dev->fd_file);
 
 	kfree(bvec);
 	if (ret < 0 || ret != len) {
-- 
2.34.1


