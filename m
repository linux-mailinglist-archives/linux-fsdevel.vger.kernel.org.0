Return-Path: <linux-fsdevel+bounces-6402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A4817A46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D12A2858D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD6B73472;
	Mon, 18 Dec 2023 18:57:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BC1EB3F;
	Mon, 18 Dec 2023 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso1744344b3a.2;
        Mon, 18 Dec 2023 10:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925860; x=1703530660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXA7k6a8U08Bb8Ki+Hye/mJLhOdW4scyh8EQNqbrNXo=;
        b=m13+RzEwopsPD2fTqxmyXOkgmp50/u4s1Mca0aj5WzvL1JiGK+A6Xw2iM4xxAXh18c
         3qby2ipb1/fFFaAL8O5PyfeueMgsN+/8ti4wK+Rjs6SSP7z8CP2zas87HUXM06+MhfL4
         F9pBW0MwkkIkqXEEKOU4SHBC/qKVLovLiVSF2TerwODpJZOQfBTlAukvwCYjMN94PgVK
         j/R8UsF1qJqZQ9lJvyT4fabJMwH71TBj1gAP5C/drbFc2IB4Dt0X12v7/O8s86m71sfY
         ue0qxbeR2QQ/dYb0Gzs+R/z9NDVHBz958Zz5fvhMhEO//jiStlxfJ5Kg5MFoX4hAwahA
         XJXA==
X-Gm-Message-State: AOJu0YxFiLd8Ebm1zr3hb1gw5mrvQW2hd3P4WRCfF8HFJ+uQUyMtT4lP
	hbHdpx5qO6XUlYv+WqgZGY4AuUTRzLg=
X-Google-Smtp-Source: AGHT+IHvJcMyLPaXUjXJ8PF48U6h5bodI2ekKJfFzhrhGTuDn5Z6l6uxKRqiCmAhj8L+3NpfLrh0pg==
X-Received: by 2002:a05:6a00:8007:b0:6d4:5efe:75be with SMTP id eg7-20020a056a00800700b006d45efe75bemr1713408pfb.33.1702925860239;
        Mon, 18 Dec 2023 10:57:40 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n20-20020a056a0007d400b006d45707d8edsm3918397pfu.7.2023.12.18.10.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:57:39 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v7 08/19] fs/f2fs: Restore support for tracing data lifetimes
Date: Mon, 18 Dec 2023 10:56:31 -0800
Message-ID: <20231218185705.2002516-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218185705.2002516-1-bvanassche@acm.org>
References: <20231218185705.2002516-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch restores code that was removed by commit 41d36a9f3e53 ("fs:
remove kiocb.ki_hint").

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/trace/events/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 793f82cc1515..d5a771a869b2 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -946,6 +946,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__field(ino_t,	ino)
 		__field(loff_t,	ki_pos)
 		__field(int,	ki_flags)
+		__field(u16,	ki_hint)
 		__field(u16,	ki_ioprio)
 		__field(unsigned long,	len)
 		__field(int,	rw)
@@ -956,16 +957,19 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__entry->ino		= inode->i_ino;
 		__entry->ki_pos		= iocb->ki_pos;
 		__entry->ki_flags	= iocb->ki_flags;
+		__entry->ki_hint	=
+			file_inode(iocb->ki_filp)->i_write_hint;
 		__entry->ki_ioprio	= iocb->ki_ioprio;
 		__entry->len		= len;
 		__entry->rw		= rw;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
+	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_hint = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
 		__entry->ki_pos,
 		__entry->len,
 		__entry->ki_flags,
+		__entry->ki_hint,
 		__entry->ki_ioprio,
 		__entry->rw)
 );

