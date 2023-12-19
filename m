Return-Path: <linux-fsdevel+bounces-6445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4274817E80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69ED81F23B75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792F5CB9;
	Tue, 19 Dec 2023 00:08:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323D4C63;
	Tue, 19 Dec 2023 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28bb6f1b30fso242621a91.2;
        Mon, 18 Dec 2023 16:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944525; x=1703549325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXA7k6a8U08Bb8Ki+Hye/mJLhOdW4scyh8EQNqbrNXo=;
        b=EZbjaNBO9ErSuliPc9cdHvqNZIBdDn2C55LQ1++Zkz6NbKALq45cyWNUM6hifMSrG0
         rFtBRksiZ8U7U0rrM7u6fLGTB3OzbIret2UqcWbJEH8RsME7VlR8V+heeP56H6p1GGNS
         1ChlQ7XlopgBz3BA7XyDa7uUJiSTsyitBsp5l3hiCHPXWMp3urY1f2y9exo7cAMPbDf5
         Ur0G3Tn/T5Mq/iAsWV2Fv+gqgvO5hRisOo4j6uPCLv89GK7WCUM1QLrqQDdsYakAqNFH
         OT/1hxKu3HCbXHPgRjWiHQrM06PIKSJzEXXEve7cKQbn/rd/dNwYDffLqE4Ir2SzbtWk
         9MfA==
X-Gm-Message-State: AOJu0Yyvy7pBvJRpEPgLBFY4YLXo9LPCr7M+inQdI0EtjOA1qMjOZDMF
	Zy60Ebs08L+XpQ93RP7znyw=
X-Google-Smtp-Source: AGHT+IE7D1LFkLB7o7AM3EHjH1LxmSr8LgDDQN614ITw/TJ2DxAlGu/n28W0eonUL2e6wyLt1jRY/Q==
X-Received: by 2002:a17:90b:83:b0:28b:906f:1227 with SMTP id bb3-20020a17090b008300b0028b906f1227mr1515733pjb.34.1702944525411;
        Mon, 18 Dec 2023 16:08:45 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:45 -0800 (PST)
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
Subject: [PATCH v8 08/19] fs/f2fs: Restore support for tracing data lifetimes
Date: Mon, 18 Dec 2023 16:07:41 -0800
Message-ID: <20231219000815.2739120-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
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

