Return-Path: <linux-fsdevel+bounces-66820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F438C2CC96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAAA134B2AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AF3313E38;
	Mon,  3 Nov 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DqhkjNNA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94430103F
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183906; cv=none; b=lZo3/TuUiWBqQ4Ya7kFaIxSK8Rp3du+7VeMC42VKX2sQtlxbMj51Hwzk5wbQp4Qjk8dXpXfhsqwmPCp190wiQEFcP8pQ6zURtOhZLmnGOLhdAejrNVURi2Syok22ptie2SIr/SFvEVQ2t+jr5k+o3ZxoWKe7QlceFGCJ9rc6d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183906; c=relaxed/simple;
	bh=wXqRBILaE55JdL+E9B9wbUTmWAfxB6SrR/EgtwrIOKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SbXWXAMUmSzUeTtR9TbM+oe8L57XTU06hgy0nVsGahfDl+MtfP1/Ya67CYEgS6TEHmYIsPBfJZHKBYOW+bG/6baTPRnlHudpdqC6iK6F/7OUh4yIUGg5ZAGa5qG69/bZUxomZ3yCMmxZP85sV2kPQjkjO1D5SZWeIKqv2wewnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DqhkjNNA; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-93e8834d80aso190769739f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762183903; x=1762788703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=;
        b=DqhkjNNARmUumWmAELJ8kG6aFkYpyL/osO+/82gX7guXvoQcO3WYgmnk0LRFkp+G1V
         CtkXa974DGFYOe/ezzuhTCW6iAJwZWTsanKUwVfoFS59vuiRDWIQDY10V6l7ZQux9wHh
         T8qeG2ikGlRb4C8bY23BPled/bsUr2+ZA5kK81m42ZkGrZE/dmbAht7VsbdLJkMIfULU
         dUFftII2zAGIBfkcb+R2MlRwe6+R8mSFgzCDULDdLOIszUwyF38q749EsAIM9vTW2nPL
         Uj9tH21ZIMuXrJTCqSKmPgrmYF7cJf8ZmJz0FzcKrMrRnxCASka4eQNhOo4SdFQYHUtq
         i62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183903; x=1762788703;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=;
        b=VWSTqa6Xb42aqAtPqNR7rQb7wg1UMVH4mNDFapU6Fd470MPMPTRoHTPVVD2IUg6QP0
         HxjlXp/jveYsCZ/kxm810B3w4Mz6wllYJ0YS1+/vXamqBRKkVkjAAPRwu+LY4VgFtKjL
         B74JOUB/YCg6eIjS3oUCY6+Wt976yVrm4pKGP3aQSGtYJ1IKNuFNthgLhmrYB+QbdAut
         p5smWf9OwmDwAjHjXL8t11+SouMCx1dMl900JugjZlW27drZTKigQmTxBQze+1V3nsGX
         4Figwa3Ij11t4X794G0ntAM5ZOSA1t2iVXygrrG9x1shnG5XZq3e5O08tWmjHlXUyL54
         eAlg==
X-Forwarded-Encrypted: i=1; AJvYcCUKtSr0Y5km717jh0tBbTZ0P2gQCuC3zB54+xrL5fIr0fQgBQOHttfubBe6e6U+aWiuZ9V+sBs1kj9reeOr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g/7fnqaagSRRtRWQFKcAUZfXYDqZEY/0Tmai3koJ6GD96kX9
	YwnIqz6JG/Bbgd6jZV2RxYN9E9WaDknjdqq5qmZJDcUAkHIj59cUTAzNqoTqSqXj5NI=
X-Gm-Gg: ASbGnctr5qLtIc4xRU5z4Y+zUP6W2+evFhhD5mVthRgbIpIOnht8fdytW9nL3q6JfzM
	JVgi6zMJuf1w4cxim69mGMOMo79pZrYivZddKU0kIBbhEUUKHMmRalKkTwU++VtX2hKRj7MmtH8
	Rocs8Uv10RiSA5n6z0XdoXlI2cdjVzfZ7edSd+THQ8eh5vmdPRBfLEMfwriDvOuP3T9AVIQxvWY
	6oYQB4JtWiFpmLpI+v8FbyzJmDw9Oe28rxDs74jO1v2uSVizvW0GW1Tm4mqwTtDitjFuUkglroj
	XOqbtGEVHzOIRTBYEDJr5zfox6pisR0M34xzr6XY9s9yeeO4W19y4u9TGztE1e5K9aOGb63aggd
	Wh5FAr+VxvjDnZ7qLA1lCzihkVwfssqdLPjvsYWBpqg6AG4Lyg+mRorP0Kr2dKmp7Xf1mu1iPF8
	RDWw==
X-Google-Smtp-Source: AGHT+IFTIBxUfn46sYZ6hbUJrbv86bqFQPF02qtQJk8t7o8hAHovGW6C2GZKwz2eeRA4AwfjgvTr9g==
X-Received: by 2002:a05:6e02:3110:b0:431:d093:758d with SMTP id e9e14a558f8ab-4330d1f5a08mr177643355ab.22.1762183903343;
        Mon, 03 Nov 2025 07:31:43 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b5a92dsm2754945ab.28.2025.11.03.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:31:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
Subject: Re: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call
 in task work dispatch
Message-Id: <176218390170.6648.16490159252453601596.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:31:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 14:34:27 -0600, Caleb Sander Mateos wrote:
> Define uring_cmd implementation callback functions to have the
> io_req_tw_func_t signature to avoid the additional indirect call and
> save 8 bytes in struct io_uring_cmd.
> 
> v4:
> - Rebase on "io_uring: unify task_work cancelation checks"
> - Small cleanup in io_fallback_req_func()
> - Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
>   is only used once (Christoph)
> 
> [...]

Applied, thanks!

[1/3] io_uring: only call io_should_terminate_tw() once for ctx
      commit: 4531d165ee39edb315b42a4a43e29339fa068e51
[2/3] io_uring: add wrapper type for io_req_tw_func_t arg
      commit: c33e779aba6804778c1440192a8033a145ba588d
[3/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
      commit: 20fb3d05a34b55c8ec28ec3d3555e70c5bc0c72d

Best regards,
-- 
Jens Axboe




