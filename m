Return-Path: <linux-fsdevel+bounces-63604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3CBC583F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 17:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA1D5350A1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1852EBBB0;
	Wed,  8 Oct 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="GgpfQHP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F15286413
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936032; cv=none; b=ih1jtIbJJ9brK7h2LzGzCBw2cV3EHjdl6s46EkqWSSJnG6jsk1puF9pZJuQTqrDTAmUpF0kgiQCtInJVDhGDOf+umDUEUOkAGPIelSIpMuyLgZKAX1Z++zB1DiW7NOD5/S3zdpEIpzBCfot3tHyyEyN6PVvpLiCDg/Q0/FcwloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936032; c=relaxed/simple;
	bh=p70jpTwbF6iD/EGs8mwK96rlc8FsCINMVTiDl7eZEJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YddLOhZnxvcbtAA2yB/PIZ1jvSJIiJyrdn4aYq9SPoqXFQefPO/7y77YkE4Nv+PoRMpBkV9bCJbKpTtLqPZG8/HJ0Kc2sxf10WfT80rSsVWg0p360m+rYsyF4GmNo9pqRSaxO5aG5Iqmqhc8GSCJvSbk0ePeSqagJdobqEiilCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=GgpfQHP9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso208835e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1759936028; x=1760540828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK7i9/AEMpPUF4a2FcEnJZGqcJ2Lpx6X/3iZkewqTsc=;
        b=GgpfQHP9S/9CC/SwDiuquxVjzu1wqUOS+IcMtXVKAQqYEzpot2Z03JA1eL7no5mclf
         6V+5F1X3ePlXGxqpmTcFqa+YPKZ+4u8DTqnSCAuma9sxV3ypSZwIBFUsP5rRFI5OZ3/y
         FlXdRiVAIAGZCYzftNpTYX2vK7naReSeoEZugKCVWUlgXcQnSqojqrzcR+KK6DruP5Mg
         nYfUXQSSGnHEqgcXuCKW2vQWQvVamDK25tvWZqVV4rXfOv3H6i9Tq9a9GU0yHpRL71uM
         3rt//moahJCuD2cudado2R/fgMopB2uNe1CexF9z10EP7Hw9UfV8aW8C764uS+KwgUsN
         3TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936028; x=1760540828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK7i9/AEMpPUF4a2FcEnJZGqcJ2Lpx6X/3iZkewqTsc=;
        b=eV1HYvuZYTFZ5kM7OkAl7NKaDnDJMNTjQ6Ax1mXSNbkiF1jf9tb9kpdiomRVRdbqDx
         ksolu0gTK3rtTFS6V9zDU41Vi/P6u4cz6mwjcXXBgVwOivrnHEnf2i/JBRglNOk/iY6a
         3/1H6d7mtdTblzW645Z5knfdNQfYpENQFMS3jx0WM+R55Kgyw8KDqTevWJr3TIXoQhGz
         x+CFJTJUYGwNrfVjQxOnRPXtnoRk0roZ4sMZq3upnn+mtdLpPmdVENBBDKr6rwuMrkF6
         Ja9EJo1wxLcgyhkf3LoLlFC4dJKvUJ2NV+x4LQZqkiyW0VabqnqQOQ1CdjfRMzCsA+Mo
         VXlg==
X-Forwarded-Encrypted: i=1; AJvYcCWwEyP0OsbJdWmtfBPJqmlBvoUAqUAsd4H5z8w+del1wPMQ6Y+TlWWdyk4kqRJuELbsdax93mCvNdemMtJe@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVelLQbQl09umMITL4PD3DvcXE1vU+zWacacD52+i0G20NZnL
	5ho2KFr/GJhabbz04XHrVCgpYYPTj0eEvwgx0BDcy4QPBYMio2tEmqGa8/4wngwKnZA=
X-Gm-Gg: ASbGncuH7DmoGHjHkIPn9fJ/hns4r8CLO9f7Ie+Lmp3Hw5BGFi8GSM4k+vNJKitVyUJ
	JXme0mQCSefKm5z7THaYFJuttD/hgjifGkfMeavMO17ybkT9fYlK5wym3zUGSCcwtG7Z+mbXK3C
	HdM/3bSeTUdg9USAcHqSXguU5npenhQ+tuZZF+GZZMNB3BSfFeLjHrPCFb/8cIpiBLcRwe4mg3D
	HjovkJGsvBmAs5oFfkk+JZLA/ikerw5UmxVSp7INosgpupWxjzlJNue+p1MkeXwaQc0uvkMy5EE
	5Q9NY+YttHWqqS7ilKCIf9US/JRDH50jquPQmDuDqyviJTcY4pxM59g41FQ7nhSJvqjyZ7XSIrj
	tbM1/RMIJpgPECcsmcaqBLaJyiONLhO3inxibV9B+C0RZyjo=
X-Google-Smtp-Source: AGHT+IHHHiu00/+y+Qzr9ip7z9MvgYCkQKUorD8RSuE1gz8NEXqljs9qDzEiFA1EgVMqP9sQ/ONd7Q==
X-Received: by 2002:a05:600c:458b:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-46fa9e9a2e5mr27125865e9.8.1759936028143;
        Wed, 08 Oct 2025 08:07:08 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf16abf6sm3383135e9.12.2025.10.08.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:07:07 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Matt Fleming <matt@readmodwrite.com>
Cc: adilger.kernel@dilger.ca,
	kernel-team@cloudflare.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: ext4 writeback performance issue in 6.12
Date: Wed,  8 Oct 2025 16:07:05 +0100
Message-Id: <20251008150705.4090434-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006115615.2289526-1-matt@readmodwrite.com>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Adding Baokun and Jan in case they have any ideas)

On Mon, Oct 06, 2025 at 12:56:15 +0100, Matt Fleming wrote:
> Hi,
> 
> We're seeing writeback take a long time and triggering blocked task
> warnings on some of our database nodes, e.g.
> 
>   INFO: task kworker/34:2:243325 blocked for more than 225 seconds.
>         Tainted: G           O       6.12.41-cloudflare-2025.8.2 #1
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:kworker/34:2    state:D stack:0     pid:243325 tgid:243325 ppid:2      task_flags:0x4208060 flags:0x00004000
>   Workqueue: cgroup_destroy css_free_rwork_fn
>   Call Trace:
>    <TASK>
>    __schedule+0x4fb/0xbf0
>    schedule+0x27/0xf0
>    wb_wait_for_completion+0x5d/0x90
>    ? __pfx_autoremove_wake_function+0x10/0x10
>    mem_cgroup_css_free+0x19/0xb0
>    css_free_rwork_fn+0x4e/0x430
>    process_one_work+0x17e/0x330
>    worker_thread+0x2ce/0x3f0
>    ? __pfx_worker_thread+0x10/0x10
>    kthread+0xd2/0x100
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x34/0x50
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> A large chunk of system time (4.43%) is being spent in the following
> code path:
> 
>    ext4_get_group_info+9
>    ext4_mb_good_group+41
>    ext4_mb_find_good_group_avg_frag_lists+136
>    ext4_mb_regular_allocator+2748
>    ext4_mb_new_blocks+2373
>    ext4_ext_map_blocks+2149
>    ext4_map_blocks+294
>    ext4_do_writepages+2031
>    ext4_writepages+173
>    do_writepages+229
>    __writeback_single_inode+65
>    writeback_sb_inodes+544
>    __writeback_inodes_wb+76
>    wb_writeback+413
>    wb_workfn+196
>    process_one_work+382
>    worker_thread+718
>    kthread+210
>    ret_from_fork+52
>    ret_from_fork_asm+26
> 
> That's the path through the CR_GOAL_LEN_FAST allocator.
> 
> The primary reason for all these cycles looks to be that we're spending
> a lot of time in ext4_mb_find_good_group_avg_frag_lists(). The fragment
> lists seem quite big and the function fails to find a suitable group
> pretty much every time it's called either because the frag list is empty
> (orders 10-13) or the average size is < 1280 (order 9). I'm assuming it
> falls back to a linear scan at that point.
> 
>   https://gist.github.com/mfleming/5b16ee4cf598e361faf54f795a98c0a8
> 
> $ sudo cat /proc/fs/ext4/md127/mb_structs_summary
> optimize_scan: 1
> max_free_order_lists:
> 	list_order_0_groups: 0
> 	list_order_1_groups: 1
> 	list_order_2_groups: 6
> 	list_order_3_groups: 42
> 	list_order_4_groups: 513
> 	list_order_5_groups: 62
> 	list_order_6_groups: 434
> 	list_order_7_groups: 2602
> 	list_order_8_groups: 10951
> 	list_order_9_groups: 44883
> 	list_order_10_groups: 152357
> 	list_order_11_groups: 24899
> 	list_order_12_groups: 30461
> 	list_order_13_groups: 18756
> avg_fragment_size_lists:
> 	list_order_0_groups: 108
> 	list_order_1_groups: 411
> 	list_order_2_groups: 1640
> 	list_order_3_groups: 5809
> 	list_order_4_groups: 14909
> 	list_order_5_groups: 31345
> 	list_order_6_groups: 54132
> 	list_order_7_groups: 90294
> 	list_order_8_groups: 77322
> 	list_order_9_groups: 10096
> 	list_order_10_groups: 0
> 	list_order_11_groups: 0
> 	list_order_12_groups: 0
> 	list_order_13_groups: 0
> 
> These machines are striped and are using noatime:
> 
> $ grep ext4 /proc/mounts
> /dev/md127 /state ext4 rw,noatime,stripe=1280 0 0
> 
> Is there some tunable or configuration option that I'm missing that
> could help here to avoid wasting time in
> ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
> fail an order 9 allocation anyway?
> 
> I'm happy to provide any more details that might help.
> 
> Thanks,
> Matt

