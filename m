Return-Path: <linux-fsdevel+bounces-5645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A880E807
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AE8B20DC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EFE59167;
	Tue, 12 Dec 2023 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX2FLgb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956E8D9
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-333536432e0so5071684f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374291; x=1702979091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea0v+/7dOe+rK7fNBTUS0Q19FYSn+8LMd/kdGTAt84g=;
        b=HX2FLgb6Ajn5axtM8/uDCIjAMOUVjRb0Ibq8C5xzmGG8jgjr1+ki362FBtsrBqW3Xl
         bD7adpfALwJOP0ZyC75eu2OLyDU0qn1ypVhX+QXtSFXtXN+kJ8vvykffohAyUcYAWzNm
         dChWlLIcOXyRGQP2Jtdj1gasguG9h6lk2b11FQ4v7wnUTGH9qAtPRD3OnmGOw8iemaOX
         K2VNGxlAVoTPwPgINkjJV4akA/1JVXaaP8OJw2+1IUIGttwEiJsgLM2PioSEf8/exS++
         /+Yx9v64r+Fmr83agQbQwkKbJbi3rx2sk3nqtvHmN5oVfA/uy9Kn1uL1UnrX8kKsL74x
         P41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374291; x=1702979091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ea0v+/7dOe+rK7fNBTUS0Q19FYSn+8LMd/kdGTAt84g=;
        b=m9CzZu59ymy3LvYx+Nk9XAnmHlj268F70owEbNBxVDQtT9s/0/eL72V+pgBSYUJEqg
         GCjj4bwY6VQ2mY5zKcXBTqosJDx7hm8thjdugeJ97/F0S5fQ0CPAv/lcpY5QFCh6F8os
         04LgseDz/wUAkvDazFG21kEm6eSJm9hZ39Ay2n9xaMMJ2FxwC/vIOVGQDt9g42+6El/R
         AxKrIPQbeNhMkFCBEVcyixZtCv6cIdrp7OwkGRYazOFsunYr45jLYGa9QYxHHn8Z2+V5
         qL/6NY71VkA7A4wglf8MsfhZu8M1Lom8yVL0Dfn3v6j6VfUG6rIpwLBtVqsAKfa98Sg5
         ATxQ==
X-Gm-Message-State: AOJu0YyI53b8ROUNclLg744PIqh/d6lQRU27U1HgPAwM7/vofBGPRq+x
	v5EUkqII9ksgRVdXG7Od/c0=
X-Google-Smtp-Source: AGHT+IH7wgYpabkoL1aw052x4/haGasRhvMFBZ8ZNlw+Tfp6yr+iPDkZxKAye3sZ1HCrfrm8qrxrJg==
X-Received: by 2002:a05:6000:ad1:b0:333:3c4d:7ff1 with SMTP id di17-20020a0560000ad100b003333c4d7ff1mr3059862wrb.78.1702374290983;
        Tue, 12 Dec 2023 01:44:50 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003334041c3edsm10432244wrx.41.2023.12.12.01.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:44:50 -0800 (PST)
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
Subject: [PATCH v3 4/5] fsnotify: assert that file_start_write() is not held in permission hooks
Date: Tue, 12 Dec 2023 11:44:39 +0200
Message-Id: <20231212094440.250945-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212094440.250945-1-amir73il@gmail.com>
References: <20231212094440.250945-1-amir73il@gmail.com>
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


