Return-Path: <linux-fsdevel+bounces-36324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392359E1A32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 12:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE68D285446
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146011E3769;
	Tue,  3 Dec 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gje1Wes/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32861E32C8
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223715; cv=none; b=Wj/KuQwUI1Wsoun0DLWy1IAo8JJx+CS6WTEkeEfP58pKJW5qBs5vHpNMCYpLnBVpZVhv+LV/JyhqSE/bzkt4rpz6sKQQYogkT2s25d6pt85l4+lQD080upp5iCmXc6zoXb6lnH3ksSoTL2EXMJ7lTAJLYcX2zPvZxnAzJV9Qrj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223715; c=relaxed/simple;
	bh=Ri3F2lqYqFmVChwzqTNrMDbi1gcnXfl4eYPHbc4AN20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXb7RlutASAHeMlOCNzU26y9wdkW8T0V83oKUY2at/6bYMCmVpbeIcd1qveJES+KlgRI7PbffkUJpD/Lg+5TON5uUajAM/HcwYxIXGW56qJSb7vBI+CrBhtkwLB7AJIbv1cYSEhePGl/V1ZdpfLpELCYqjHzlIw0x9LskbEUeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gje1Wes/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7256dc42176so2202442b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 03:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733223713; x=1733828513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YOJmyn78rzkgES+8M6yXGVtihB1o6gQ+kzJyZUe6FU=;
        b=gje1Wes/mkxg9rfPxeECi3T88XBW+qBikQHA4o+gRmA6VHY0ete6Qufb18pu3f7MJc
         3vv92+rASMOv8kNIiw7au2vwYAoFSUTDOaa/UtTJYFtDpCb0TE2O8h9NcoNX/oc9TKT0
         j3Bzszif3/5maBMRyiXAP+JGrPJTIHRkhlqhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223713; x=1733828513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YOJmyn78rzkgES+8M6yXGVtihB1o6gQ+kzJyZUe6FU=;
        b=BYfjDpHWZJbFRWMxbUf7SufhTaNEsX0C9M3ZEx1k9yMcyQeTm3KbhyRYeyt/jGIkxP
         2OzFrcScjQEoIPRrI8Ngj30NPylo/xor9GRPrd/5guoYWKE5VumKDQnxoR16Z7shuQW1
         beFkO3LNZin15aeeCZmYKwao7Hrin7IlTmVuZhPrfy860zI85xccaqT/qHH3djmb9zk0
         2SVe2keBik2J4yaJyiNOdQEPd0xBmXWAIXI+DBW52Z+ctNi6yXf0mW0PQi5KhjLyjyNp
         4OQyl8/2VDMItv/opiyhAiLFBTXYHt3cuOoL2/23/eq7Nj3qqTxi2hcFzUZCAlS/lQgY
         bShw==
X-Forwarded-Encrypted: i=1; AJvYcCU1EyY6pxxIMLCIkSU1rgXDrx82fTD0GOj1w+KRbxAZCtWbHPyknvMaoZXQwm0tZIXZ8sMiHgG1EXVKt3HK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2avjC9pu/xhIiLANpuZHwJIJhGABzuea4w2AoJbhRpXPLDD93
	7xgtyGhva8ErRgmntAJPO929Mf1BBgDrhptTeFmdf+dkxZkEldJgg/jESgcfbw==
X-Gm-Gg: ASbGncuR+bQ0Sxtd5aKh37WvuyxANWoybGwWcM6ypnaSnhFkM9mjvTw9c+68g/KL0C7
	OJKa8M31sQVetD2URo0LSUOKrRw6AaD84ukYUUAQ7HFlMKsqSHAecvDepl6bcC0wvq3mZA4q+q/
	drIrfvoRFGYRvOkcWPqrO+eAB/3RBu2tbh/d4ljSxf23HGRmZKsPpvRo+dW5DHsXPednLaeCFwY
	TBVZNtsHcraM9sHZOV1fkDuaMBYY58H9stPAyUtQiDeNIQfLA==
X-Google-Smtp-Source: AGHT+IG90FbTz4KpcISO4CZABfe3ApkK6JUWFFx8QJei5AFDPmaxF7HkMtKQVWmT9LBAoXCp9rqKrQ==
X-Received: by 2002:a17:90b:2786:b0:2ee:7870:8835 with SMTP id 98e67ed59e1d1-2ef012673a1mr2823722a91.33.1733223713238;
        Tue, 03 Dec 2024 03:01:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f520:3e:d9a1:1de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee61638836sm7534259a91.48.2024.12.03.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:01:52 -0800 (PST)
Date: Tue, 3 Dec 2024 20:01:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>,
	Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241203110147.GD886051@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114191332.669127-3-joannelkoong@gmail.com>

On (24/11/14 11:13), Joanne Koong wrote:
[..]
> +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
> +{
> +	if (ctx->req_timeout) {
> +		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_timeout))
> +			fc->timeout.req_timeout = ULONG_MAX;
> +		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> +		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);

So I think this will require much bigger changes in the code.
fuse_check_timeout() is executed from IRQ context and it takes
the same locks that are acquired by preemptive task contexts.
So all of those now need to disable local IRQs before they
acquire: fc->bg_lock, fig->lock, fc->lock.  Otherwise we are
in a deadlock scenario (in many places, unfortunately).

A simple example:

[   91.466408]   _raw_spin_lock+0x39/0x70
[   91.466420]   fuse_simple_background+0x902/0x1130 [fuse]
[   91.466453]   fuse_send_init+0x337/0x680 [fuse]
[   91.466485]   fuse_fill_super+0x1c8/0x200 [fuse]
[   91.466516]   get_tree_nodev+0xaf/0x140
[   91.466527]   fuse_get_tree+0x27e/0x450 [fuse]
[   91.466559]   vfs_get_tree+0x88/0x240
[   91.466569]   path_mount+0xf26/0x1ed0
[   91.466579]   __se_sys_mount+0x1c9/0x240
[   91.466588]   do_syscall_64+0x6f/0xa0
[   91.466598]   entry_SYSCALL_64_after_hwframe+0x73/0xdd
[   91.466666] 
               other info that might help us debug this:
[   91.466672]  Possible unsafe locking scenario:

[   91.466679]        CPU0
[   91.466684]        ----
[   91.466689]   lock(&fiq->lock);
[   91.466701]   <Interrupt>
[   91.466707]     lock(&fiq->lock);
[   91.466718] 
                *** DEADLOCK ***

[   91.466724] 4 locks held by runtime_probe/5043:
[   91.466732]  #0: ffff888005812448 (sb_writers#3){.+.+}-{0:0}, at: filename_create+0xb2/0x320
[   91.466762]  #1: ffff8881499ea3f0 (&type->i_mutex_dir_key#5/1){+.+.}-{3:3}, at: filename_create+0x14c/0x320
[   91.466791]  #2: ffffffff9d864ce0 (rcu_read_lock){....}-{1:2}, at: security_sid_to_context_core+0xa4/0x4f0
[   91.466817]  #3: ffff88815c009ec0 ((&fc->timeout.timer)){+.-.}-{0:0}, at: run_timer_softirq+0x702/0x1700
[   91.466841] 
               stack backtrace:
[   91.466850] CPU: 2 PID: 5043 Comm: runtime_probe Tainted: G     U             6.6.63-lockdep #1 f2b045305e587e03c4766ca818bb77742f953c87
[   91.466864] Hardware name: HP Lantis/Lantis, BIOS Google_Lantis.13606.437.0 01/21/2022
[   91.466872] Call Trace:
[   91.466881]  <IRQ>
[   91.466889]  dump_stack_lvl+0x6d/0xb0
[   91.466904]  print_usage_bug+0x8a4/0xbb0
[   91.466917]  mark_lock+0x13ca/0x1940
[   91.466930]  __lock_acquire+0xc10/0x2670
[   91.466944]  lock_acquire+0x119/0x3a0
[   91.466955]  ? fuse_check_timeout+0x32/0x630 [fuse c290dfa1c114772028056af34b9662cba2d155b5]
[   91.466992]  ? fuse_check_timeout+0x32/0x630 [fuse c290dfa1c114772028056af34b9662cba2d155b5]
[   91.467025]  _raw_spin_lock+0x39/0x70
[   91.467036]  ? fuse_check_timeout+0x32/0x630 [fuse c290dfa1c114772028056af34b9662cba2d155b5]
[   91.467070]  fuse_check_timeout+0x32/0x630 [fuse c290dfa1c114772028056af34b9662cba2d155b5]
[   91.467104]  ? run_timer_softirq+0x702/0x1700
[   91.467114]  ? run_timer_softirq+0x702/0x1700
[   91.467123]  ? __pfx_fuse_check_timeout+0x10/0x10 [fuse c290dfa1c114772028056af34b9662cba2d155b5]
[   91.467156]  run_timer_softirq+0x763/0x1700
[   91.467172]  irq_exit_rcu+0x300/0x7d0
[   91.467183]  ? sysvec_apic_timer_interrupt+0x56/0x90
[   91.467195]  sysvec_apic_timer_interrupt+0x56/0x90
[   91.467205]  </IRQ>

Do we want to run fuse-watchdog as a preemptive task instead of
IRQ context?  Simlar to the way the hung-task watchdog runs, for
example.  Yes, it now may starve and not get scheduled in corner
cases (under some crazy pressure), but at least we don't need to
patch the entire fuse code to use irq_safe/irq_restore locking
variants.

