Return-Path: <linux-fsdevel+bounces-50223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4345AC8CE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F8D4A7B26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69B224B0C;
	Fri, 30 May 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HfA8/NB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55D1C84A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604341; cv=none; b=ZcVg2giOkhR8kn7QbmD7rR0e/oTHkiJeuRKGuDA7U6WbfqMv7OhwFr4nqiKf45NuRUnUEllQ6QZXA5mi43EGclmeTYZUACIWCduk2Gr7X+9B4J3eIVi8gOHyHdT3HxGAYpdtlZxyXPjOyHSerztvQ2cJ/9UjPhnothccqvTa6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604341; c=relaxed/simple;
	bh=pSGOGcpSRJixFKus1P0k4Lq94Pk6AcLRBRh77gAk7WE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=h9/S/CKZLKBT9PUUG7emxJMi7saQug+5cu23+GHygI8L2eIWCKKv13Hqu8bE1525L576HoWXYC4LOgACXZQaJ0y4OJYxSrJT1qHyO7Iw1ElkCycnpDdKD3NosOVmJTvOSahXYxVK+mwqq0FZz3W1AaicfecnWlkLhWbivr71YVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HfA8/NB9; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3dd83950ec6so6679855ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748604337; x=1749209137; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me0qwVBXzS2O+r3Qynqre69B8HlCXA0G9rg1yp3M4ro=;
        b=HfA8/NB9jZI1ndW5zTMp97qTbABViiW99CMgekQ13SU6LEMO7UHnLD0vCOinjwbWab
         seilkzxg/vO7WwyT38gzrJ3loLf6RLCX9CcHrD+mhyRw3jLnxLRO0dnbvCTYDWShUX8v
         kr9TewUUJdxkC4XDpGCmwkyOYNNuU1S9UfSGSk2b/uZauq+4vN2z4J5ND9c+SYub6L9I
         JfMIplVMjr84v5fFrcrLkuB0IwjxnHX+FgMOrp+YX/owWxQUMpNsjlgfUAL7UAKEI0Yt
         M0QHOnzkPks1zYzTxvP3gzQCfFVeK5KNvt58yY2Z3On5xU2j8ugYZ6VJzcF7TkHyAKrk
         MirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748604337; x=1749209137;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=me0qwVBXzS2O+r3Qynqre69B8HlCXA0G9rg1yp3M4ro=;
        b=whgifvQxzB85tiVYnLZH9m1dy1AjlCdY/h/7kPJqrYXtKmWHTpBFowd1nZtBr94Xxd
         1d+nAIgYLPLzPmJsJ4NUqAOVcBADbmAzKG6p0s9vH5JBQSkruF+zv1VibfCwGihguaBI
         VXzS+B0lhdwa1j4lvTusWvx94VG3EovRRSD+g+lcywxB6lzGBYO49y5NOLcNCpyDoRus
         BjJ1JvoOtUEQ+t925Lkzbhtm23PmcdnXdLhzv7VEY8/u5jkPOgIDoaGL3ytxl0xDW/y7
         u0OKcFRcWk2q3Hk8rijt1e8nArnzLs9LWXKvxz4zb4mRv9W2JhSmaoyJQjD+dOXNcWMy
         9ABg==
X-Gm-Message-State: AOJu0Yw+alGb1/2esD+MokfSMvy4g4nsRituNk/u6z0SGbAbxiL20JXv
	4CwLehPSePXSIMFI5cmbSDyn9Da2u50TKk7AtP03kwcBwAbmT20Q8QVCSFWgni8TjiSFCFEXapy
	xHtRI
X-Gm-Gg: ASbGncs0vj/WXfBPotnp7Ht995VRAKsAjcsJT66mLCS5MPujA3jYFK4h5LKkBnp+g6S
	jHSaS8O1ac+P8+8PykWG0H4uU+nXR++PQv4aXOrAQwgJvDEd+m6C6gG1ViFJSGEEOTohaPc8diN
	E2bsSFAi+6ER0aiKkjBRyvaBAMQeMN2yjWG0m3GgwKfMMUpDPBUlyxeY546TMU0KaMIVYMpYUKe
	TwYDb0R+hag08sxq6UzKYEWbAKPWsBS43K6z9MBoI5rmKrJtUl5NTIyNmk+fZ49hj/2SXGfW+y2
	ZFjd6ioQw1vRd5tPEJiZUrGSHviEnLkAlujTkaaz4tmwtKSEhEAmQ+YwNk4=
X-Google-Smtp-Source: AGHT+IEftL2YaeYK7K7EchCOXhDI/0q23ODJx/AVnsMDUZnBGQB7dz5OembVedNdqUCX9Bv66HgruQ==
X-Received: by 2002:a05:6e02:378b:b0:3dc:8682:39ca with SMTP id e9e14a558f8ab-3dd90b97d98mr86038965ab.0.1748604337283;
        Fri, 30 May 2025 04:25:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd93534293sm7381485ab.13.2025.05.30.04.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 04:25:36 -0700 (PDT)
Message-ID: <1f0473f8-69f3-4eb1-aa77-3334c6a71d24@kernel.dk>
Date: Fri, 30 May 2025 05:25:35 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs/pipe: set FMODE_NOWAIT in create_pipe_files()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Rather than have the caller set the FMODE_NOWAIT flags for both output
files, move it to create_pipe_files() where other f_mode flags are set
anyway with stream_open(). With that, both __do_pipe_flags() and
io_pipe() can remove the manual setting of the NOWAIT flags.

No intended functional changes, just a code cleanup.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/pipe.c b/fs/pipe.c
index da45edd68c41..27580a5f7ae7 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -964,6 +964,11 @@ int create_pipe_files(struct file **res, int flags)
 	res[1] = f;
 	stream_open(inode, res[0]);
 	stream_open(inode, res[1]);
+
+	/* pipe groks IOCB_NOWAIT */
+	res[0]->f_mode |= FMODE_NOWAIT;
+	res[1]->f_mode |= FMODE_NOWAIT;
+
 	/*
 	 * Disable permission and pre-content events, but enable legacy
 	 * inotify events for legacy users.
@@ -998,9 +1003,6 @@ static int __do_pipe_flags(int *fd, struct file **files, int flags)
 	audit_fd_pair(fdr, fdw);
 	fd[0] = fdr;
 	fd[1] = fdw;
-	/* pipe groks IOCB_NOWAIT */
-	files[0]->f_mode |= FMODE_NOWAIT;
-	files[1]->f_mode |= FMODE_NOWAIT;
 	return 0;
 
  err_fdr:
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index 83e36ad4e31b..d70700e5cef8 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -416,8 +416,6 @@ int io_pipe(struct io_kiocb *req, unsigned int issue_flags)
 	ret = create_pipe_files(files, p->flags);
 	if (ret)
 		return ret;
-	files[0]->f_mode |= FMODE_NOWAIT;
-	files[1]->f_mode |= FMODE_NOWAIT;
 
 	if (!!p->file_slot)
 		ret = io_pipe_fixed(req, files, issue_flags);

-- 
Jens Axboe


