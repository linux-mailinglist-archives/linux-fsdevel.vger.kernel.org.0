Return-Path: <linux-fsdevel+bounces-6148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8507813BC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5EFB21841
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37636E585;
	Thu, 14 Dec 2023 20:42:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E126E2BD;
	Thu, 14 Dec 2023 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so7394696a12.3;
        Thu, 14 Dec 2023 12:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586541; x=1703191341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLoFyvSeWEJ6wnKJhrzn9rCRQDYM25hI2bk+w92kUts=;
        b=fs81yFOVisLAEl1Hkr+e8WxEnbKd0Bk7+vd8csStT1kIITI+xc27FeUZsuq80Fxbn5
         4QEUYdXSSRqJTIf8Rr8I5VH3IHISe5d5/2PUGuP51lslTuVG7i2OuP469DV0t9vr6xy1
         +qCw0J9iuYa/ZhV2g90qalwd4rRm5FXOwf/JjoyPFXpmU3bPELS0tCVoGC5dboTMfpSI
         3inSYYOG3KKn/LwtwTOnTj/iSaYK+C8uqiQ4L16gQXLn+PRl1sUoWPDC4gvOiKUjIpIG
         UBnkfjpippIqSJi7h752f8UD3jXtc8ZF5xbbXA8NR1DRJN+OH7HPoPpN647du8NpIS2I
         FIoQ==
X-Gm-Message-State: AOJu0YwsqEwXT9zWFLn1aP9kLFghaZUS3aS4Aii2/JXmyVjU6dsQbAlv
	8T3lWpcVc6PzDyDPz4Emypc=
X-Google-Smtp-Source: AGHT+IG6YxepFBkv0zd1UTXNY6p4Y5eR+Opix737rodSGpto+DHq8VF9sbUqkXlK+OM5HeLVh4L+Qw==
X-Received: by 2002:a17:903:22d0:b0:1d0:7535:8b94 with SMTP id y16-20020a17090322d000b001d075358b94mr13104659plg.97.1702586541371;
        Thu, 14 Dec 2023 12:42:21 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:20 -0800 (PST)
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
Subject: [PATCH v6 09/20] fs/f2fs: Restore support for tracing data lifetimes
Date: Thu, 14 Dec 2023 12:40:42 -0800
Message-ID: <20231214204119.3670625-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214204119.3670625-1-bvanassche@acm.org>
References: <20231214204119.3670625-1-bvanassche@acm.org>
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
 include/trace/events/f2fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 793f82cc1515..1041a12364f2 100644
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
@@ -956,16 +957,18 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__entry->ino		= inode->i_ino;
 		__entry->ki_pos		= iocb->ki_pos;
 		__entry->ki_flags	= iocb->ki_flags;
+		__entry->ki_hint	= file_write_hint(iocb->ki_filp);
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

