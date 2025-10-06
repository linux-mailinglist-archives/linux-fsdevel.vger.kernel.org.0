Return-Path: <linux-fsdevel+bounces-63486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8CBBBDEF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D221896DEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D1276024;
	Mon,  6 Oct 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="uGBW4ypu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237C275865
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751782; cv=none; b=rx72cuDsB/De5Pirf44VN11X9/v9emDJ45nlVq+Mwyvs0H31bz35L3R2FeNZAodGCJOWIJ1CxCAOZLAQroThu+sd2M/3UJMBh7Bdie7OYa8l6qO6TWo3Gq7Mgk5KOHTo4V8welrQ3ev7k4E6L5Fcron/e8o4eCSejn7JdzljP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751782; c=relaxed/simple;
	bh=wrbHTVgjTq2O8XParlMCWpyu37Ui/UVjk417+ozSffY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxEM0nbz1EC3Y5lT+DvapkST/zrF8hPjIR35PS5AInSCoRdgpXuvW4J/GvuLuqy1zW/AZraE06T7+6DE+MUvHuEVc2Ld1t3y1ALNpZI/m/MgEm0zdXAEwclP0qVkLLNLPVmvAmzvrM0sKIvnelTmSOgJBWCRlxA90M5LdRqN3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=uGBW4ypu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so55101525e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1759751778; x=1760356578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nbV5f3XstJLy0t8dFU+ULrkXIa5z+4WHcRiH+hJ6r0=;
        b=uGBW4ypu9qZztNYMii3UQuwE6a8QChNiNYr86UHjoMvm9hoC0pgON4tfxCntCnF4PF
         HV7gVw6Up3Nlg/4L0svu3+ze8WuDMrNaeXq57U43WEQ22fwYs891nXmSHDulDo42mL2P
         umOGqqolU17vBjRjUAv0qdh9toWXT1zEndmpqgJvq9PJEiq6MrCLLadxa1ZVCkj5WLB2
         S62MLKel7VtDYwaCpT36f63D1pOSM+eow4ov0ZMjIBvPJxwX5H+04LH7/2Gd2ieUzmGD
         5RUSKsSuM/61y3hzqAR8wfOvjh+s8opK80s1OtD73Kg8Fp+DYSuxTVviOvHlQnSJUOlr
         8HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751778; x=1760356578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nbV5f3XstJLy0t8dFU+ULrkXIa5z+4WHcRiH+hJ6r0=;
        b=RqT1MJSh6EQjOSkDPBkuk4QuOlOsu61Tdr+jwdTPSqjbdrQPvdPaDcDHLh2BgQatf2
         ckjBe9FxgcbzDzEUzK+MZDMsTBG9QLxjg1SWzpIXelbIcVfIicSl5yZ9nOXRdb82BXs6
         JFTb/rKh4SWFZnUxeEmZwa2Nkh6qezMQugePb5568K7CGncGOFhJYOZweaokPzKwbguu
         VB3wkzEcpnXjkUUivAvCCNHHFgfpDu/xWhPwx/q2HsohZVsKxJ30aKYYxJYROZNRNT4k
         BRjyOu7cm74eI7IvZiNyb8KZgMqEq9msrs0ATSMm1ZQ7VMTpQAhZj6N0je/XnsbObcgp
         JIGA==
X-Forwarded-Encrypted: i=1; AJvYcCVryPvbR9be7BZGZKc/TYralxzAVhJ+STynGc2cApuvj7WZOPVvhPqbZOO0Y5EoZHugEg11Rw1P3xE3WIAq@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuhdkMD6RC8ShR9fQ38vduDJfGTb9p+eeWFOQhJlRYp7Yenu7
	06PSWvaMSkqWvncsSJYylTGguyL+Ep+hcrJfog1D1H2QPeJ1WKxSxfugd9FE0qH+mQSSlV4e60O
	Z8OhT
X-Gm-Gg: ASbGncu+jrEBX8yiTcR05lC0pYqyqY8wDXBz4PH5FAPR4hVNhTX5LCl0lxgy3H/K8R/
	BbVGXEDq3SKmrC1tCQECqSobIUYCmTFjEU648op0hw9TL3PjaEcRzgOFDSO987vWZJZc0crB+/J
	+/peCuavoiyX447c8/R42sLIkdecKc2y4l4XrC5zJjWEdB43arj1JnzwUC9O36a0rIp8nkdc0MD
	HIIHwFdRU4EqrRWvsuEWGDF9JABTrdf7Txr1OT4A7XW/oSKKce23RpDgj5Bf0sj3vSqNfwcqWXI
	yMvTSrgaPdPyKR51MwyuntU7gIvsF8xEgkT4I7rkwT6ZS3r7+6MzCRFjffGhXiOTShnrM3qbC5k
	c/FllGFKLS7E9yhAtlPoPDJpaSuO6MOgYnl+8DvBg6qsnwiMS2C6hGrJrkg==
X-Google-Smtp-Source: AGHT+IHcu55JZb+QMGkTtdqsOpdfQTS9H0v4wFjgnm088OjhN8myHoA2yHtMbs7aZj1YDYIl3fN4uQ==
X-Received: by 2002:a05:6000:604:b0:424:211a:4141 with SMTP id ffacd0b85a97d-42567165eabmr8187487f8f.27.1759751777806;
        Mon, 06 Oct 2025 04:56:17 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72343260sm154020345e9.4.2025.10.06.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 04:56:17 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: ext4 writeback performance issue in 6.12
Date: Mon,  6 Oct 2025 12:56:15 +0100
Message-Id: <20251006115615.2289526-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We're seeing writeback take a long time and triggering blocked task
warnings on some of our database nodes, e.g.

  INFO: task kworker/34:2:243325 blocked for more than 225 seconds.
        Tainted: G           O       6.12.41-cloudflare-2025.8.2 #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/34:2    state:D stack:0     pid:243325 tgid:243325 ppid:2      task_flags:0x4208060 flags:0x00004000
  Workqueue: cgroup_destroy css_free_rwork_fn
  Call Trace:
   <TASK>
   __schedule+0x4fb/0xbf0
   schedule+0x27/0xf0
   wb_wait_for_completion+0x5d/0x90
   ? __pfx_autoremove_wake_function+0x10/0x10
   mem_cgroup_css_free+0x19/0xb0
   css_free_rwork_fn+0x4e/0x430
   process_one_work+0x17e/0x330
   worker_thread+0x2ce/0x3f0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xd2/0x100
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x34/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

A large chunk of system time (4.43%) is being spent in the following
code path:

   ext4_get_group_info+9
   ext4_mb_good_group+41
   ext4_mb_find_good_group_avg_frag_lists+136
   ext4_mb_regular_allocator+2748
   ext4_mb_new_blocks+2373
   ext4_ext_map_blocks+2149
   ext4_map_blocks+294
   ext4_do_writepages+2031
   ext4_writepages+173
   do_writepages+229
   __writeback_single_inode+65
   writeback_sb_inodes+544
   __writeback_inodes_wb+76
   wb_writeback+413
   wb_workfn+196
   process_one_work+382
   worker_thread+718
   kthread+210
   ret_from_fork+52
   ret_from_fork_asm+26

That's the path through the CR_GOAL_LEN_FAST allocator.

The primary reason for all these cycles looks to be that we're spending
a lot of time in ext4_mb_find_good_group_avg_frag_lists(). The fragment
lists seem quite big and the function fails to find a suitable group
pretty much every time it's called either because the frag list is empty
(orders 10-13) or the average size is < 1280 (order 9). I'm assuming it
falls back to a linear scan at that point.

  https://gist.github.com/mfleming/5b16ee4cf598e361faf54f795a98c0a8

$ sudo cat /proc/fs/ext4/md127/mb_structs_summary
optimize_scan: 1
max_free_order_lists:
	list_order_0_groups: 0
	list_order_1_groups: 1
	list_order_2_groups: 6
	list_order_3_groups: 42
	list_order_4_groups: 513
	list_order_5_groups: 62
	list_order_6_groups: 434
	list_order_7_groups: 2602
	list_order_8_groups: 10951
	list_order_9_groups: 44883
	list_order_10_groups: 152357
	list_order_11_groups: 24899
	list_order_12_groups: 30461
	list_order_13_groups: 18756
avg_fragment_size_lists:
	list_order_0_groups: 108
	list_order_1_groups: 411
	list_order_2_groups: 1640
	list_order_3_groups: 5809
	list_order_4_groups: 14909
	list_order_5_groups: 31345
	list_order_6_groups: 54132
	list_order_7_groups: 90294
	list_order_8_groups: 77322
	list_order_9_groups: 10096
	list_order_10_groups: 0
	list_order_11_groups: 0
	list_order_12_groups: 0
	list_order_13_groups: 0

These machines are striped and are using noatime:

$ grep ext4 /proc/mounts
/dev/md127 /state ext4 rw,noatime,stripe=1280 0 0

Is there some tunable or configuration option that I'm missing that
could help here to avoid wasting time in
ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
fail an order 9 allocation anyway?

I'm happy to provide any more details that might help.

Thanks,
Matt

