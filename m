Return-Path: <linux-fsdevel+bounces-9074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A083DE18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396B32845AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CC31D546;
	Fri, 26 Jan 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0utNwNd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125AA1D524
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284648; cv=none; b=r0PWxXlosmpy9RiJ1NBjp7QvhsioEWpufFQa04+RXy6W/MdCjj9xYwd276d+Rqj6HNTSnlCal9firelF5BYijLeu7mnoPXuTggNZ8bbVt3tynV8csyvGHuEE8Qu+GJVu5qRwcT4i1cL2wZgWFkdInlJpcY4p/1VnF14ixOjzapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284648; c=relaxed/simple;
	bh=pTKkt4HDy5cHafjWqvRLIghyQiaeiOTEEWK32KvorGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KK6DVa6aAlsy8zj37eTvfcXgVBMxXTZpwxwIE8kJIFkP7ZtVsh5w9jvQi3Wi/jXYIWdkv/YbdeJrMIyBvjZgcY2QAgrvu0w58RyNE6E4O4yK7wvmw5Nueuf3LN1Cbc2RXastMqYUmXts824u5kyWQo0i3NuWSOjSfPW6pvBkitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0utNwNd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51021b25396so628548e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 07:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706284645; x=1706889445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdeDSOAKJ5pfj4o7Pq9ratOpidbjA9SWUn8FNbD+huE=;
        b=U0utNwNdTyZjNMC6Ich6YVwo/dOBNHJh6z1yRLXQH8PABu79/s0jEmPocO+Lzrdb2I
         hkQa+YiuBSXVc5eqduZA/1R+fiJl9hSvZJl219GRgHAXGeawhzAs5TpbpuqTSrgJjhzR
         xHeQ4ZzV9Q9fC/byxlX+tXxKoXQdrrPr3QRgqQdVILN57txXvHyp9/CJzUf3eRmn6bgz
         EA+aNj8xx1gUI64e4Ozt12Kfy3q1xNcwcxjeHMYq1otG88xISyyxqBndYOY4XKSbBrod
         a78MLiHV8mDc+rnhqdSjEjwMOJWuS4vvwhs0m/VTA4nCmyXo7TbL/eEG4Ilw3hMtJ/mp
         HHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706284645; x=1706889445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdeDSOAKJ5pfj4o7Pq9ratOpidbjA9SWUn8FNbD+huE=;
        b=Hl5CAxwjv745+NXcQxsSMLXNUfW2Z8zmB5MHQMSW3Is/0h677eU6RcNp8ZYBgcXPsA
         j3hPmwNmvy1cqh8exUwYDZsnBsLsM5jvcDUJjTXEPG2DHapzmX8urnIjggs9g4naVqm+
         f47AI8u3wPBjgFiUjRwljbu2l9icY0/W6ZFbk2eVTA7Uv5rHJLdy9Fjtx9ZZ4iJM4w8W
         gDkyB9PoOxlekzAtfP84XeAM2gpknITcDKHPAaTP53JGHoPvNE3j9YzWA/xJJhlmyHJF
         qOPKeiq6JH+4qj/jPIoJM+Wg9FIgdLsYiPG8M+kiHgwM87YtcGskNN4jQEFeVSVuNh5W
         MzXg==
X-Gm-Message-State: AOJu0Yx3/mPVxyoZYAGR16Yx8HrK2ZSPrPM/8tIe/79clCMhgQPpnugW
	IfCW2icQoC0tjY0ahNOAH8qp8DMuiC7jexLExxexYP/ndE1uVdkp
X-Google-Smtp-Source: AGHT+IE3NqgDddSoCNKo7gASir4kevimLzi1aiqSaIWORrva2gYfeiNfnl/4QMyyU4jErPVyF4Xauw==
X-Received: by 2002:a2e:2e1a:0:b0:2cf:33b9:81e with SMTP id u26-20020a2e2e1a000000b002cf33b9081emr728753lju.38.1706284644649;
        Fri, 26 Jan 2024 07:57:24 -0800 (PST)
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id f8-20020a2e6a08000000b002ccdb771df0sm188598ljc.108.2024.01.26.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:57:24 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v7 0/2] io_uring: add support for ftruncate
Date: Fri, 26 Jan 2024 17:57:18 +0200
Message-Id: <20240126155720.20385-1-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124083301.8661-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for doing truncate through io_uring, eliminating
the need for applications to roll their own thread pool or offload
mechanism to be able to do non-blocking truncates.

Tony Solomonik (2):
  Add do_ftruncate that truncates a struct file
  io_uring: add support for ftruncate

 fs/internal.h                 |  1 +
 fs/open.c                     | 53 ++++++++++++++++++-----------------
 include/uapi/linux/io_uring.h |  1 +
 io_uring/Makefile             |  2 +-
 io_uring/opdef.c              | 10 +++++++
 io_uring/truncate.c           | 48 +++++++++++++++++++++++++++++++
 io_uring/truncate.h           |  4 +++
 7 files changed, 93 insertions(+), 26 deletions(-)
 create mode 100644 io_uring/truncate.c
 create mode 100644 io_uring/truncate.h


base-commit: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
-- 
2.34.1


