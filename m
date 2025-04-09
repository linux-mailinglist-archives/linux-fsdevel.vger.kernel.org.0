Return-Path: <linux-fsdevel+bounces-46087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE68A8266F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5157B2C5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1772F2641FF;
	Wed,  9 Apr 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RenqEk3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF92620D1
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206067; cv=none; b=hwWRtREa7yMJMpk3jO8Bfr5iXe4yQqs5Xdx/QJuKe0A+suwEvj0dCVEOQKzXVkdN3LpUQiAGQv6Fue4qNv1o5ilPw96crIs5NEycHWEwPJoJiENFjnRgp0rddV54BW5Q71VU1aoye6orbkadWtvAlV4C8VXDytHi83t69OkW5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206067; c=relaxed/simple;
	bh=3scP3JHTuKX1LZ4+gl8oT4+aiKvSKIdIVZ57eA9iTDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzYt9cUUNqrnqSU18AzAH4GEFZ5MAlWHgnAhk7uTaJkQNw7B3VtUqynDwAWP0jf1hU5EH6zVBYgEGH1Kwiln0aA3fFe06bBIDP1PBq/1vlgrw7tsXODd2X6in/RXemlhOBias4SIWpBFcbywoZ0kngYbz6TTUBg9It7KB8bKMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RenqEk3j; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso170042739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744206064; x=1744810864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7pPynJaQneGDwKYEd+0PbGH80xVi4jqqdOU/lGU1TE=;
        b=RenqEk3j0y5ZB3ukjFNp7ZntxRdplKt0NDMahUueFfhMOhQm0nUgL41gzz8J41KJDp
         qH4vYRnpNh9nybaxnmCQd9TzdmoZNRHJslFVfna/Wk5vhQW6aEwAEpthDttEucT0njlC
         mdH7P0IX+PSZHo7az94zDQx4q+w9dyO99jy9D468fvOjH6XhJFesC6Krg3anEy2PfrYh
         gG0WHoQ070bof3d3jTRULwsusG9QVJ8PjgL+8627c7lWwvuZXbsJ5sXg3p6OMVUThVaV
         Q5oDDYUBpyxJI6xps5OKTADPn+wDwv+BYn8CwhidmJ2r9Xkbrdt1sSTyFRDoODlsIyWw
         VCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206064; x=1744810864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7pPynJaQneGDwKYEd+0PbGH80xVi4jqqdOU/lGU1TE=;
        b=J6xlycF3UxQJi0o9pSo03NZI8Cn2LrBBPFVAci8sRlx+bYVOpKguftwy20Ru8N4IBF
         7k8SCwU8/5PcY8Zc8DZw/7+I90AcqtjAG8s7/x9kXHDPlDfMyIK+FaTX8MJry69a8wVU
         Jm6FLSkRYqXdTI/zhVeLQLigTAY1kX3hGRaq6WnamtEfinLUEUytHY3Xv5UNOKXUpeCn
         v2moKnvQWVl8vw4XV0TB0I3dQ2ARgsdgy+KZYBWQBSpuRMafslBbKtDzWSWRy7E5eDoj
         GdCbd5+qmYaCe/e8PDx91Xtnt6rN7Th2mV//Hrmr3YXT8iHtq8O2DGGXaS/IK+ZAuo4y
         Fbqw==
X-Forwarded-Encrypted: i=1; AJvYcCW/ryPTowodR8tZxiw5x/WquFl92tXVI36/6JxlK/IYq2sTW2KUCk04VkgzHDOwWpRDVQcBCxUrax4sSBWD@vger.kernel.org
X-Gm-Message-State: AOJu0YxHHvSypFdpFvCo1tHrkFpzl8cOsxLTjLcW/GXsmdel6CKruixw
	mZYciOI9VvIVA6I4CtoPFYPmiSrPcG94HTj60FtJc5GBQJJDqKlQ/CcqJv+Qdt8=
X-Gm-Gg: ASbGncsU1xYc+qZNLNFv265XycQgMm/MEHM+KxZF/BM2+m4cx/7EhsJyflcCvORsgGV
	LSOOs+5+ZnHD8OaHE550RdfEODIMqvnSajAr+d2ojCZR1NS964UEVRJkrUiRf+ezQmBEBMG5lQM
	XyLn4nQIcYu35IuF38tTXYNStTA6d2YQT5+iS3hGsKWDT+w6we4A9A4UOOnJOoTjZazrO7jEari
	Zi5wvAZkCnDSvjzMlv5b5zqOofX641KmxxXg71ZaeY+V1sAfSo9FBX4cCZf8y0O62LTloVfeBwQ
	4rjSafiZ8wU6SD0GwwIdNzCkERy6iLh14ejKMNgDad8c
X-Google-Smtp-Source: AGHT+IGc8av/+BjU0ISRwrY4urN6ol/l4Tr3rEkGJdZOwGQ9e/may1bZRc7w9EEl9F0YL9kZtdqp7g==
X-Received: by 2002:a05:6602:b97:b0:861:1ba3:cba4 with SMTP id ca18e2360f4ac-86160f544bamr272566239f.0.1744206064440;
        Wed, 09 Apr 2025 06:41:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2eaeesm242546173.126.2025.04.09.06.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:41:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] io_uring: consider ring dead once the ref is marked dying
Date: Wed,  9 Apr 2025 07:35:21 -0600
Message-ID: <20250409134057.198671-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409134057.198671-1-axboe@kernel.dk>
References: <20250409134057.198671-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For queueing work to io-wq or adding normal task_work, io_uring will
cancel the work items if the task is going away. If the ring is starting
to go through teardown, the ref is marked as dying. Use that as well for
the fallback/cancel mechanism.

For deferred task_work, this is done out-of-line as part of the exit
work handling. Hence it doesn't need any extra checks in the hot path.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index bff99e185217..ce00b616e138 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -555,7 +555,8 @@ static void io_queue_iowq(struct io_kiocb *req)
 	 * procedure rather than attempt to run this request (or create a new
 	 * worker for it).
 	 */
-	if (WARN_ON_ONCE(!same_thread_group(tctx->task, current)))
+	if (WARN_ON_ONCE(!same_thread_group(tctx->task, current) ||
+			 percpu_ref_is_dying(&req->ctx->refs)))
 		atomic_or(IO_WQ_WORK_CANCEL, &req->work.flags);
 
 	trace_io_uring_queue_async_work(req, io_wq_is_hashed(&req->work));
@@ -1246,7 +1247,8 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 		return;
 	}
 
-	if (likely(!task_work_add(tctx->task, &tctx->task_work, ctx->notify_method)))
+	if (!percpu_ref_is_dying(&ctx->refs) &&
+	    !task_work_add(tctx->task, &tctx->task_work, ctx->notify_method))
 		return;
 
 	io_fallback_tw(tctx, false);
-- 
2.49.0


