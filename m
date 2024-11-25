Return-Path: <linux-fsdevel+bounces-35853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983C9D8E46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54032162E67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342151CDA04;
	Mon, 25 Nov 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WayxfO+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA9190059
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572365; cv=none; b=PSpEshnlkX2ARKf3994d3avn+np1JdCe4iqlVQff85c8PhJ4s0ahr4ttvkqzZLsR5+3gIALIC7igOBnkL4mURAIfzt3irQMLzRBKmPcoYW2m/XlvpmdHSjGpymNtS/k18EzlBa+8YcWNHESJF46qA+26Orl4VIunlhVQUt4Abqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572365; c=relaxed/simple;
	bh=TlWx8pPe3VMieBiipZvUswFTK+zsLNBNts60fUq8aBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsNxfuq76HnPrtB2hbCQUrcx+h0WfFv5BTSR4QcYYOUIIX7piOOp2DeWAoZquOX9YCsbzgRvdzmP7tVQhqv2xKuwwUl3v244SFv5L8XAeMUFXNXbu+nI/y8xT2zeHMdG/I7PJH526uF9Hs52Etes4G+SePJt5MyozpUiHiSE6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WayxfO+E; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eeafd42dd8so51759887b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572363; x=1733177163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk6k1EjolX1nbz1/ZuRAGyGHURCB48ZYiPJbglQ4bAo=;
        b=WayxfO+EV7WuqCI43paeG1lx02ifSd58PiMNYfdhuvHOjBjrfa4Jf/QwzcnalmGE2E
         afR2jfdsBArr8hcMb+NI3QpmFedZ17XtgQOUYwgNv4eBAWvTSI7ftGUphXoGw0asgbYs
         jFnsQ1BKUndXGHuBb71+dspTi5jvRDzUreh4QMk+DUFby/RX3MjmEVwJgfAdsDvpbt9+
         NtP22HzD8O/2Ah5gK4caj/+TJ3RZj9LgotVZktz3quIxXhd2gQPeKBlbOflGzDJsSb+v
         SGOhXw1WbQQbRfQ/TPwCfi0NZBnqf/IPfL8o7K8q0JNLh3JEofR3zrXXGBSfKDQs/0HQ
         FBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572363; x=1733177163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk6k1EjolX1nbz1/ZuRAGyGHURCB48ZYiPJbglQ4bAo=;
        b=PGNiuNhdKibBDRZ9/DMR/T4bxgvo9ArQe1YI7Z8ESrgQWus0n20yEbJCRNnMsXEjF5
         OLChwh3XBaCUqYaEjcnxsuTaSRn1MB6Xi1CSPs7I2r0sHWP98W9aElwzAV+mUVVCULNt
         TGcxpQ9kFez4QNQi0UklReA9n19rnPW9HJ8KiRoWUqWpkZbYBSXXK5e5QfSOlfTNrWoE
         Lc0OX+gFxSzZLwQyXFqui7FHTGDsuMBePwszc2J1FzyW24D5DKJc2MWWgWBGgkYAK5ZC
         uTYvbPwfBNNProxXUHdqnOiR8x6H+KxtsY5aVDj30ooQVv0EpAFWV8coss1ObppM6Unx
         X/UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh2PFIDdpEK08uuW6glgCFjooiuAjoSTCVAPtPg9e6wccNQuqhYog78e/EsfSpU8wHr1jBqfqc06Z7AOHf@vger.kernel.org
X-Gm-Message-State: AOJu0YxO27Y1O9HslKSZYRzYYFCkGJ1CoJk9OHu+7BjBlhBacG2UHwEt
	5XvTQ/nS1NkhBoYrqNx/3qCJfL7UHHRbpj9Gm7ZKUWkVzXG5Nd1l4cVB6A==
X-Gm-Gg: ASbGncvZ7ELbSsLWUGqkhsgQuvSVeIi7OmlvfblNxIbFVH1FUKpz0V0S9tzMKXWTgf/
	RmszjosSX4u/wIJ89A+kXmRmtxhikmO1Cbzc8RegVxDQ1FLoDSAnqllabA41VUOLtEdhcovTb9W
	G/JOGLIiUlQPUcDa8XvL2MTn9MUMczg++6Dfb8GaWQU2w8OobSyODMqTCUSP1zBxAZkK7lHZWcU
	tiXv7+t1rl+PMA+N037kqk37lw4w4NR4H80x295Tvmq8vV83NDt6TzRub2aery3oshOqJ8XToWO
	tW+lvfzk
X-Google-Smtp-Source: AGHT+IH2Vs5RxaOnGcYlODJfn7hsxU4DOG0twCtFjOFjnuBSu2ZCXQxZSbhayJORyLuEjWhDa5c/aw==
X-Received: by 2002:a05:690c:6d0e:b0:6e3:29ae:a3a5 with SMTP id 00721157ae682-6eee0a491d9mr160329197b3.34.1732572363048;
        Mon, 25 Nov 2024 14:06:03 -0800 (PST)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee008042dsm20000207b3.80.2024.11.25.14.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:02 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 05/12] fuse: support large folios for folio reads
Date: Mon, 25 Nov 2024 14:05:30 -0800
Message-ID: <20241125220537.3663725-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for folio reads into
the page cache.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fab7cfa8700b..b12b3cb96450 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -797,7 +797,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	loff_t pos = folio_pos(folio);
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = folio_size(folio) };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-- 
2.43.5


