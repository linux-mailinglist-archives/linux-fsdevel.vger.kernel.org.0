Return-Path: <linux-fsdevel+bounces-46944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E612A96CE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CE17A3E94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B428153A;
	Tue, 22 Apr 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y7naDXQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0327602A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328905; cv=none; b=JZ7h6PIg1OFgfclLPPbrmBt9/DwaXHlLVx98w8jyYkmKX+DZxTGvrTi1WzjFOEpJKkBKsy4J65MsW6rE64jRugwWW6mDUiSpoCQibrsdDOuorzHQ3W4853nBacZ5cF8VDnvQPbzmfIrWu+tG00VGdRrcNW/4ChDAp2Ru2X8LPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328905; c=relaxed/simple;
	bh=13PpzOYn9VmZfCu3saU93/C13hq9QrBzpKO1hrXjejM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xkmb3P9N+zrkORrcCk+fEJO5lGK0igxm5T9pVpLAoq90VqtVex5qn2m8CBX741hScW7148qIHZykGYqPmNRXz6aqaMNXx9i/yLhHfBiF/21dQKFAXGuCyQqQehhpmNG35MhD6puidhdEtD5KuXS5tqymB7C0LVsm5XFfvrVwvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y7naDXQ/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d81ea55725so17277415ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745328900; x=1745933700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ng1AJph91LR1w58lbhVEsRYbLXwmFH+WlPGVdw4yh0A=;
        b=y7naDXQ/uoszx7eAkju9qbUtDKPUY3xj+fMKQT9qZ/91bqkDKfZ+o4ywsI4rIYf/Id
         lxcrfbYkvRyMq29A23ztLAKLKuCMQTwLmE7I8ccwXumvIUrco13T6vwarefPZIhMz5W6
         kpyJiLBcNaxzt6QnF15205i7KaNsCpEWCZFlu4YVWicLt2yZ6irgi1hb3CzOyp3mpmtw
         4JZbmpu5mb8eQ/AbPtNOgq3LzXeo9DmjyWuBtg42x28wpubOU4+T02eT7ajVBDA48QtJ
         SZ3JOHP9ysrk/CQeFrL4NiItW55GzggoaMy6PUyuXYKycrMvjZers9td0zhmGGpVw+/c
         ZW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745328900; x=1745933700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ng1AJph91LR1w58lbhVEsRYbLXwmFH+WlPGVdw4yh0A=;
        b=Z74bMtn141B45SDbaU0hKZfvr73Smh1mvySuOvUnxZ3MCzd/GI0hcEFvR4tZPnurB/
         u5yaUsC1j2Yyfp3/RvjpPADvaIQRaJkd2kvLBjkixFM3pP1emjQsiIcHqyK14NtaWsbs
         QXuni61nqhVId8TIvKt3ONk6P94UhFJgB06q6EvvUZJpxWh46SHerD0zvJu6EDyD2jvK
         yOGzjXOIKWV70d5KRm02fCEGepNAkTPTgHaM6CSIK529+AWzxhFOlVaP9ATgH5kZoDLQ
         DzZr45lb7dxorCzP3XpH0MSvTkupQOtdxeouTDn/VRYTK3QDkrRdhcGI0TEy6Gr4jUdP
         xjiw==
X-Forwarded-Encrypted: i=1; AJvYcCUMyVztg7aexxv11r8AjKRoU0j5ua/EYv0oqQlrqBf06YE2R6MTltzqllVUlouQ3CdgrGrc1FRR7CPmJ1aV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uKPIDSEbdfKosbv2wFZl6iAdEyVdnIR33sbFWRWQVZXgx55T
	rEFh6KeyYWU8RnbTGS0YrQMQ3+OypMsL65EvQgewtMdGboN4EUQmQnl2mJEQITQ=
X-Gm-Gg: ASbGncukUnKezg8MPwTxxRq8+OhggPZKhIu9fAmw7VVpwGlLmWI7cp2uaLDdot/pWbb
	i24q1O6sp9pvHqzcSrqgfuR5dqQva0of/97WqriUO/BxtAaqnhBcVutpX4FfFguEg6tyOLaq1B0
	CYh+ecGruLclQIx44/if5p3d9Ur4DEMh9kbtFSnp4MVoHE1BrOc1FE5kdDs7BbnErZBnZdh7HXG
	NejSlzLBFgKPLxpJcEFSmHiCl91mZy450kIEPYo+kDt+ujukUNo2mb++lCK7UrUfd/S/nU8RPdQ
	Q6NE/ZzCJA/MoFNOmgVEXIXj52eDp7z9mZDkTfEQKeR0waF6
X-Google-Smtp-Source: AGHT+IHIKm2ycnI/f/1vykV7XxOgEYKLsp1CQzjQB79xzDp79m4CqVmAxO17uvtvLxPVOJiUh4ZBpg==
X-Received: by 2002:a05:6e02:214f:b0:3d3:dcc4:a58e with SMTP id e9e14a558f8ab-3d88ed7c050mr142584975ab.8.1745328900022;
        Tue, 22 Apr 2025 06:35:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3958e2esm2316031173.122.2025.04.22.06.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 06:34:59 -0700 (PDT)
Message-ID: <bc68ea08-4add-4304-b66b-376ec488da63@kernel.dk>
Date: Tue, 22 Apr 2025 07:34:57 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix 100% CPU usage issue in IOU worker threads
To: Zhiwei Jiang <qq282012236@gmail.com>, viro@zeniv.linux.org.uk
Cc: brauner@kernel.org, jack@suse.cz, akpm@linux-foundation.org,
 peterx@redhat.com, asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20250422104545.1199433-1-qq282012236@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250422104545.1199433-1-qq282012236@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 4:45 AM, Zhiwei Jiang wrote:
> In the Firecracker VM scenario, sporadically encountered threads with
> the UN state in the following call stack:
> [<0>] io_wq_put_and_exit+0xa1/0x210
> [<0>] io_uring_clean_tctx+0x8e/0xd0
> [<0>] io_uring_cancel_generic+0x19f/0x370
> [<0>] __io_uring_cancel+0x14/0x20
> [<0>] do_exit+0x17f/0x510
> [<0>] do_group_exit+0x35/0x90
> [<0>] get_signal+0x963/0x970
> [<0>] arch_do_signal_or_restart+0x39/0x120
> [<0>] syscall_exit_to_user_mode+0x206/0x260
> [<0>] do_syscall_64+0x8d/0x170
> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0x80
> The cause is a large number of IOU kernel threads saturating the CPU
> and not exiting. When the issue occurs, CPU usage 100% and can only
> be resolved by rebooting. Each thread's appears as follows:
> iou-wrk-44588  [kernel.kallsyms]  [k] ret_from_fork_asm
> iou-wrk-44588  [kernel.kallsyms]  [k] ret_from_fork
> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker
> iou-wrk-44588  [kernel.kallsyms]  [k] io_worker_handle_work
> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_submit_work
> iou-wrk-44588  [kernel.kallsyms]  [k] io_issue_sqe
> iou-wrk-44588  [kernel.kallsyms]  [k] io_write
> iou-wrk-44588  [kernel.kallsyms]  [k] blkdev_write_iter
> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_file_buffered_write
> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_write_iter
> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_iov_iter_readable
> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_readable
> iou-wrk-44588  [kernel.kallsyms]  [k] asm_exc_page_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] exc_page_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] do_user_addr_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] handle_mm_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_no_page
> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_handle_userfault
> iou-wrk-44588  [kernel.kallsyms]  [k] handle_userfault
> iou-wrk-44588  [kernel.kallsyms]  [k] schedule
> iou-wrk-44588  [kernel.kallsyms]  [k] __schedule
> iou-wrk-44588  [kernel.kallsyms]  [k] __raw_spin_unlock_irq
> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker_sleeping
> 
> I tracked the address that triggered the fault and the related function
> graph, as well as the wake-up side of the user fault, and discovered this
> : In the IOU worker, when fault in a user space page, this space is
> associated with a userfault but does not sleep. This is because during
> scheduling, the judgment in the IOU worker context leads to early return.
> Meanwhile, the listener on the userfaultfd user side never performs a COPY
> to respond, causing the page table entry to remain empty. However, due to
> the early return, it does not sleep and wait to be awakened as in a normal
> user fault, thus continuously faulting at the same address,so CPU loop.
> Therefore, I believe it is necessary to specifically handle user faults by
> setting a new flag to allow schedule function to continue in such cases,
> make sure the thread to sleep.
> 
> Patch 1  io_uring: Add new functions to handle user fault scenarios
> Patch 2  userfaultfd: Set the corresponding flag in IOU worker context
> 
>  fs/userfaultfd.c |  7 ++++++
>  io_uring/io-wq.c | 57 +++++++++++++++---------------------------------
>  io_uring/io-wq.h | 45 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 68 insertions(+), 41 deletions(-)

Do you have a test case for this? I don't think the proposed solution is
very elegant, userfaultfd should not need to know about thread workers.
I'll ponder this a bit...

-- 
Jens Axboe

