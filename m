Return-Path: <linux-fsdevel+bounces-9575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24530842EFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E1B1C20BF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62797AE63;
	Tue, 30 Jan 2024 21:49:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452478667;
	Tue, 30 Jan 2024 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651385; cv=none; b=gBwCcbp4nVcrXYaRlTPQUv6qZo2p8sC/VA2Wew6KtLv/kW1fYpypZJHQG77MHymipQaoN+u/IIvym8NFS0o9SOGJ8Ms8HXEN5DcRT/s6Z8crLsutAFCq2dtRSV6wVmXH+VbDXk+qpS0BcXoVbTs5a6eZdtIbWvFoGBIchMs5Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651385; c=relaxed/simple;
	bh=Qwx0IqNMZgC+QUJgYyMtM+q120xKqoyQylNr7GT7SyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O87xhfyNEDALmNTW/FCbdkspOokUzrPaQotQRJTx0aFc/oUAq03oHaP3sGd/OeYWGrzs5UeMy8Diaiz8FTZuzFloSxwKYHaak5jc2rrbp8/oMReevAh/nxAJX11QCBwx5XyBDXnj5rZOrMgR5zO6Dqzxl+UhcWCnpApveMirQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddc2a78829so2005441b3a.3;
        Tue, 30 Jan 2024 13:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651383; x=1707256183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4UrNeChDqVOfEzO8p6dQhx5OKsmU+cgYZn1LaX3tGQ=;
        b=eKTVMEY2SPNzWpwFdRmCxbGr8ouAm9Fc3yEVohk/L/noUzyZqAqNrRwIXUrw2tO3Hx
         uGnN1ZV4vNqLD/ou9CcoCUEAYLQbulc51s4ZBsmeFyw7mfnNz6DYoXMsdWcsFlcv8zyE
         Uv81qoOpVtlzjg0OpyK6zwOAV6oFm4+P8TAoqSAsgJhndgEXRnVXfvPurV+ZMqrKm32b
         R3Qvp/AvKOUJ8OsOSjna6mVU6PHZH0aUnWjZABlLYX5lpF1Eer7C9eXRxQMQufliec/E
         gKm8Zc+vzxqSeYP7y0O/mYpDzcV2HZX4EIYwIRJpLx5m6GGc1bv6WBwx3gywRwzqElUf
         FRtA==
X-Gm-Message-State: AOJu0Yy04tT1qQw7XYhWQ93J8UTPj7jfQFK+HR9WAHOtpVJNMxrnNpiZ
	GBauYeND7aaFe6ZGp/mNu7/4X+7w3L0Q+BaWY4xoSL8nZL8k54Gj
X-Google-Smtp-Source: AGHT+IEQaJm+yOeazxODneOpRgQXgAc69JoTWWrXlGC6huZCv9tCMR5fd0WNRrcQcKGGRqdsaFlX2g==
X-Received: by 2002:a05:6a20:7923:b0:19c:7e70:d32d with SMTP id b35-20020a056a20792300b0019c7e70d32dmr5401445pzg.0.1706651383455;
        Tue, 30 Jan 2024 13:49:43 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:43 -0800 (PST)
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
Subject: [PATCH v9 08/19] fs/f2fs: Restore support for tracing data lifetimes
Date: Tue, 30 Jan 2024 13:48:34 -0800
Message-ID: <20240130214911.1863909-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130214911.1863909-1-bvanassche@acm.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
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
index 7ed0fc430dc6..db3596478748 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1032,6 +1032,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__field(ino_t,	ino)
 		__field(loff_t,	ki_pos)
 		__field(int,	ki_flags)
+		__field(u16,	ki_hint)
 		__field(u16,	ki_ioprio)
 		__field(unsigned long,	len)
 		__field(int,	rw)
@@ -1042,16 +1043,19 @@ TRACE_EVENT(f2fs_direct_IO_enter,
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

