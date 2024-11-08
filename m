Return-Path: <linux-fsdevel+bounces-34074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B09C244D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1112285E01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FDD21F4A9;
	Fri,  8 Nov 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OnJ2iGzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E121E13E
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087926; cv=none; b=fzXnZ9nHzNCHQrCvF+FjqizunUoOOYzAGWuZTHYIEww2Ey1b8sWTHByRiwEnrxW61VlYOVk/l6Dw409xO3Ugig9ut3xXvV637E0gy8qtFiabV7i3S8W9VzEA+7PVkak6o22gzdfFRYA3JUmZWp2Ylw2hUov1UsNGvbgY6nVFJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087926; c=relaxed/simple;
	bh=DyjqDUCBJSj/CnUsQELSU5shQKyR4sQgd2xgO6LEYiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uawr7+YyXZk4XHDmaUzMZLx363GSOR3nhCQwY6t2VrUo8N8T+WZCrTjkZPAHVH5yQRcJAurKirzQ0rgm2NSCB6eLecwzHP+h6QCRExULFpxNcVAg4AAN9nP2TO0ZWvlEFqNulAjAh3o7peWi7f6bdWLTBVmbeDVnkA2zsX6aN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OnJ2iGzW; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e6104701ffso1630437b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087923; x=1731692723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWDNTRuAGEC8P1PkMAQXcWfNP3UvXVPT3pXPdqP7CT4=;
        b=OnJ2iGzWog30ADCSfPtO7riVPGsZU0byapv29srIuAWjnUpLjOlWxa8LC//Zm/7mkq
         MbrmoMuBKhH7AuvxUJr4pVyggg4d024lbbipXJW259Y708NzyTFL0jNTk8DeRp3x2DUy
         yhkP/rhG9eE1IR4uO+REPsLPNvKhtVHlfEs5VyaXRgbjoNs7UVtahBzKfNgzcCM8J1cm
         bbrN2XkomvS/zAUCUh8WAMvnQSu5P6HZhnsApD/MbZCk8EuxnpUkcbMup/PGESlb9dgu
         qO5X7Da9W0lVRl88/J3RiLtlLmIQgZPDXGnoMW6YBPfNJ9jqKMl30gUJ9qy9HqUztVGg
         8Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087923; x=1731692723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWDNTRuAGEC8P1PkMAQXcWfNP3UvXVPT3pXPdqP7CT4=;
        b=lKdsrbJLlJI9bziBUBKvuA6OdFOxr1XzrwdmtU8oe4QP29lAO3RQNliuoXVYYBmAO+
         9ploMVkW85SFPjAiDzdlrWKAwB4Fy8UEnTTbEEDNgJDN6ERrFIrOXe7dl/BWuMGqUsDk
         t5ersEzjW3qsUavxCXZl18QRcpCLCsbpNQvVl9ejFsmRV2ts3jv8RDNqrDQypkQwDVku
         X6BziQ6imJy01b78ZXaoiWfsIc7KyM00IHSaOlVFezTu02EP2W/tJleJ+XuX3rr/RRqx
         Ce2/lAiCGXa0FUStAvf0KIViPSeh5EK2jjLcGQVS1bHUDkt6Ogpmorm/CkvW58/KjhK1
         +G2A==
X-Forwarded-Encrypted: i=1; AJvYcCVJtvITd2fMpr8NklXl8NHho13cqddvNETRZPzt54HxkvJHx7mb2k70a0HvFm+iW1I4ZI4v9H2uWP3YqTPP@vger.kernel.org
X-Gm-Message-State: AOJu0YzHf50oU2ENBdKBDPLeFt1hGtZiujWkWDHld6zrTwTpDAnMEMbu
	erPzC5hHccOs2qj5ugpA8UOqTX8qanLAzKZJgRhuL6lQWh705JBkMKp3yXX5FYwN+5uI7y+DWbh
	lN4s=
X-Google-Smtp-Source: AGHT+IEpy29b6bGe+h/CboagPQRbeA16vn/em+bpmlLLfLOrXhNW+1oHUaJS7mfyo/74o97NJpvLFQ==
X-Received: by 2002:a05:6808:1525:b0:3e5:f141:1331 with SMTP id 5614622812f47-3e794733f1fmr4465090b6e.37.1731087923389;
        Fri, 08 Nov 2024 09:45:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/13] fs: add FOP_UNCACHED flag
Date: Fri,  8 Nov 2024 10:43:30 -0700
Message-ID: <20241108174505.1214230-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a file system supports uncached buffered IO, it may set FOP_UNCACHED
and enable RWF_UNCACHED. If RWF_UNCACHED is attempted without the file
system supporting it, it'll get errored with -EOPNOTSUPP.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..491eeb73e725 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2116,6 +2116,8 @@ struct file_operations {
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
 /* Treat loff_t as unsigned (e.g., /dev/mem) */
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
+/* File system supports uncached read/write buffered IO */
+#define FOP_UNCACHED		((__force fop_flags_t)(1 << 6))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
@@ -3532,6 +3534,10 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_UNCACHED) {
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
-- 
2.45.2


