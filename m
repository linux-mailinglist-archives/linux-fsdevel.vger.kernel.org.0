Return-Path: <linux-fsdevel+bounces-5433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CBE80BB97
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8421C20930
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031E15AF9;
	Sun, 10 Dec 2023 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5OcSNjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A531CF4
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2a444311so35557035e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702217952; x=1702822752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea0v+/7dOe+rK7fNBTUS0Q19FYSn+8LMd/kdGTAt84g=;
        b=C5OcSNjJ8hP8+DUQx9P7OxpwhHeFThfKAfN2p6OzfkIItslGGMvzasYuCVEkSVdK1i
         hsQ8A9Tbez/l7QZV0BtgyUgjSnAD9xRp77vNU8yDoC0FPJgXua1CtdPyOh3/ZTRdu8c0
         qxmN/n2IWGzoovPI6M07JXuJpM08FC0SjlKacWOSmB7W2ikdQ1MjDKIP+wt5q7KtPFZ1
         HrDLLnM4F2rca4SuOtttpnvMOjVCs7jWr5Bkq6sELY/X6lsrtMYXFwreUhgDnHlpEKNF
         EDa0Taa5uOQwPWlEJxuqoJ3Xv4hNKJUElt3ibX9xbe/yGo1p7AcWhIfNCqKxwwqD0RGY
         7Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702217952; x=1702822752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ea0v+/7dOe+rK7fNBTUS0Q19FYSn+8LMd/kdGTAt84g=;
        b=pwBJ4uQrCe3udPp8grdbGBbAJjv0Bn3VDP/T3FuP0B7DMowr+4IXaozmgKKIDiSwE+
         G9g8Cnis+DuBFqhjUC4XAceIm3W8xo1RAEaKthtm6ea5ne8gh4gAWKgaJLXgR0MEjaDo
         zH47zjqlv4mkNBB8+v0kIMrKoiIGTO/TLXpB+KHuc37ZK0yDfeW6mlAGT7K3JpWuT0fp
         s8Ka96yMpiPhneuoOgZF52QFuzoDVDvoY/MIRURRJDA+wiPL3Bg/zNOywOqgefuZetse
         H0P9xgMgrJfCl46Ob7HlHpnhZwt0Sqq0TgkvqTMFwYYttNbJmZdgGusu6uesSBgczZxv
         KcBQ==
X-Gm-Message-State: AOJu0YzPD4tom0zFyfnP4kNNi0z4eZwMF2bp0823N3DOZ0HYeT1fKRK4
	Dy9Z5pRh3xJnfCY4IwZhVKA=
X-Google-Smtp-Source: AGHT+IFYE0bB4jx5KoiwDJ3O5lzr41+l693mkpJJamV6eTf3ZW/m1v/rgMSvXlGQTTHJNmnz3wBaeQ==
X-Received: by 2002:a05:600c:501e:b0:40c:25c7:b340 with SMTP id n30-20020a05600c501e00b0040c25c7b340mr725182wmr.281.1702217952014;
        Sun, 10 Dec 2023 06:19:12 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm9644164wmq.18.2023.12.10.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:19:11 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/5] fsnotify: assert that file_start_write() is not held in permission hooks
Date: Sun, 10 Dec 2023 16:19:00 +0200
Message-Id: <20231210141901.47092-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210141901.47092-1-amir73il@gmail.com>
References: <20231210141901.47092-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

filesystem may be modified in the context of fanotify permission events
(e.g. by HSM service), so assert that sb freeze protection is not held.

If the assertion fails, then the following deadlock would be possible:

CPU0				CPU1			CPU2
-------------------------------------------------------------------------
file_start_write()#0
...
  fsnotify_perm()
    fanotify_get_response() =>	(read event and fill file)
				...
				...			freeze_super()
				...			  sb_wait_write()
				...
				vfs_write()
				  file_start_write()#1

This example demonstrates a use case of an hierarchical storage management
(HSM) service that uses fanotify permission events to fill the content of
a file before access, while a 3rd process starts fsfreeze.

This creates a circular dependeny:
  file_start_write()#0 => fanotify_get_response =>
    file_start_write()#1 =>
      sb_wait_write() =>
        file_end_write()#0

Where file_end_write()#0 can never be called and none of the threads can
make progress.

The assertion is checked for both MAY_READ and MAY_WRITE permission
hooks in preparation for a pre-modify permission event.

The assertion is not checked for an open permission event, because
do_open() takes mnt_want_write() in O_TRUNC case, meaning that it is not
safe to write to filesystem in the content of an open permission event.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 926bb4461b9e..0a9d6a8a747a 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -107,6 +107,13 @@ static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	__u32 fsnotify_mask = FS_ACCESS_PERM;
 
+	/*
+	 * filesystem may be modified in the context of permission events
+	 * (e.g. by HSM filling a file on access), so sb freeze protection
+	 * must not be held.
+	 */
+	lockdep_assert_once(file_write_not_started(file));
+
 	if (!(perm_mask & MAY_READ))
 		return 0;
 
-- 
2.34.1


