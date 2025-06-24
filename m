Return-Path: <linux-fsdevel+bounces-52793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D2AE6D73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB46176946
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901032E2F05;
	Tue, 24 Jun 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjmx-net.20230601.gappssmtp.com header.i=@jjmx-net.20230601.gappssmtp.com header.b="ooTyZZzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528C1F4199
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785942; cv=none; b=plUwpSBAqpMfbHS6KmBPBuLPCM3zpAPJhBlayWakxc2rrtjTAMTSip2wS02ZhsMkrqCvPwH7cdGUcw9c9gazVgK2B7HimbOwmsqOun9oNym86gxds8MCyGnxOpuC/MQmSBb9hljPnTiqSmvoGjsp5eBLXQuhrV1y7ZI55E/jbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785942; c=relaxed/simple;
	bh=yrYUf+T9jn1ekk5YxHOMtjBw4z5L9Hpbq5L0hufPiyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDUowuvp/u6mhplkCKcTey4n/Ni0p+t8c++EX6HmLmRDGTltAmFgVgXiGX7uJcAw3Jn64zaWee6FTpuCLQ6ajxUGT61HWETCnNfjsPxJFDbHMdIBz/psi/mSmL+DE5tDugBz97Z3NDa1wwAvdA4XaIxcwPvBVHstBoVsniuSWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net; spf=none smtp.mailfrom=jjmx.net; dkim=pass (2048-bit key) header.d=jjmx-net.20230601.gappssmtp.com header.i=@jjmx-net.20230601.gappssmtp.com header.b=ooTyZZzC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jjmx.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-237e6963f63so21790565ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jjmx-net.20230601.gappssmtp.com; s=20230601; t=1750785940; x=1751390740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J57GGm0/SdIH6DZQhDnyNsTVoEW1iv54wd0A5EiJs7A=;
        b=ooTyZZzCSgSEW/+Nrk+XjHYaq61xUD2LDvUwTgV6hhwY1td3AUrEdB49b8bftkhNyo
         yWgnqPumV4ikRLELshzK/BXC7VbQ0z5giImfieMm28RWfgK3PZsxOP82MU7TN3xP0RZA
         VZ3J+PUeXVNPtBgWg/ddNbs1U7l2JuLOoI6z6TEpVB0osw2CE2fWEMBZlFB8dI0TZLJw
         0bzC5z7MIO8ItoUEnOQTDrog/zjyOHViQSi2Z8rg9Di53Yq254NeK2Si3xiJveRV3CIi
         gc1MaS7w5AyePyIDnMHOam/9JL8pCYLNtLJqaQGTRPlxSu5PmUxWXvybf5cHi3sbv4e5
         pGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750785940; x=1751390740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J57GGm0/SdIH6DZQhDnyNsTVoEW1iv54wd0A5EiJs7A=;
        b=mdrQbPuDan1Tzl/3y3ff1ZH2FOAuNo+AkgMEPEtnn8Fs5RIrezXRNlF/WYe6OT1NQS
         WHlqXVKXbPlvmM+/S5Vyj6SP8afKpPc5l5SrkTIj3WwWvW5cNRjxQFIArhqmHGsiNuzw
         TC4jE4klfKKMaVC30mqGLsb4WNVr9pzpP+a5waezAwQbOo2gkVe0lphTUZcwvhFDo4H6
         82ujU8wTxVQBOCz5WjlS7RGJQFKg/M2HwALYR7icCnKA88FlTAC07uRtB5oVzIQFgOnr
         dUS++h24wnGP9yp+NW00a/K7k7UhQOgbE8lws9w+QUqyaaZlN76VYSgbaRrxFCsU7CM8
         G5QQ==
X-Gm-Message-State: AOJu0Yx0vWWW2PIJBaSu6lTcoHjqfUR8pQe1A3y4HmyMB9wWrUbPPseV
	qXE1dM5xPVHHY9NLmnWhXur/rRGnHarCbJanuq1o7glLnVCCUFKLRF0bMSBl2dN1bewdrVsgEF3
	ygCmC
X-Gm-Gg: ASbGncs+rtArwdJ6PKajjmTxOb3g2j+lx1cjpv36pH8CJVCgedJD1xy/OgVjbCgeLrp
	iZzZMOBv91bQZL08wleGwdcy2xCQaVRhmcK26tVDywmBguAsHoHk1QMbXSSIORfpOJJ7LSMwSSd
	bgtVjZv6eObAuxWcS3jRPbyG8h1FkkAEf4tTDahPwUOCDn1n0NaNHQljCA53nRDnKVMPQqNl367
	4UwnAyoLp/8K91P9NJan6gZxiF+4rzCXntuHm8kpRnHZkB6Vc+3al5gdv5ZHx28NSpEXoJxehZx
	7Gsxz65VCVTbfcfv2nR30kk9GZQoCx4iZm1OG6I0y3DgInM5Zb5EgSN5dGdY/GK3JAoW
X-Google-Smtp-Source: AGHT+IHGqwjj1vPA0ipDjB8+H8wvpu8EvGUzLOveaJIc7cF/8aoNMfft2/Nhp6Nnc8qe6eUyUIbesg==
X-Received: by 2002:a17:903:187:b0:234:d679:72f7 with SMTP id d9443c01a7336-23823fead84mr2329285ad.23.1750785940315;
        Tue, 24 Jun 2025 10:25:40 -0700 (PDT)
Received: from [192.168.192.84] ([50.47.147.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d8729de6sm111543865ad.238.2025.06.24.10.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 10:25:39 -0700 (PDT)
Message-ID: <d6d091fa-1e6f-40ea-983a-59ac2d8a38d2@jjmx.net>
Date: Tue, 24 Jun 2025 10:25:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][BUG] ns_mkdir_op() locking is FUBAR
To: Al Viro <viro@zeniv.linux.org.uk>, John Johansen <john@apparmor.net>
Cc: linux-fsdevel@vger.kernel.org, apparmor <apparmor@lists.ubuntu.com>
References: <20250623213747.GJ1880847@ZenIV> <20250623222316.GK1880847@ZenIV>
Content-Language: en-US
From: John Johansen <john@jjmx.net>
In-Reply-To: <20250623222316.GK1880847@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/25 15:23, Al Viro wrote:
> On Mon, Jun 23, 2025 at 10:37:47PM +0100, Al Viro wrote:
>
>> Could you explain what exclusion are you trying to get there?
>> The mechanism is currently broken, but what is it trying to achieve?
> While we are at it:
>
> root@kvm1:~# cd /sys/kernel/security/apparmor/policy
> root@kvm1:/sys/kernel/security/apparmor/policy# (for i in `seq 270`; do mkdir namespaces/$i; cd namespaces/$i; done)
> root@kvm1:/sys/kernel/security/apparmor/policy# rmdir namespaces/1
> [   40.980453] Oops: stack guard page: 0000 [#1] PREEMPT SMP NOPTI
> [   40.980457] CPU: 3 UID: 0 PID: 2223 Comm: rmdir Not tainted 6.12.27-amd64 #11
> [   40.980459] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.164
> [   40.980460] RIP: 0010:inode_set_ctime_current+0x2c/0x100
> [   40.980490] Code: 1e fa 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 53 31 db 48 8f
> [   40.980491] RSP: 0018:ffffc1cbc2cfbff8 EFLAGS: 00010292
> [   40.980493] RAX: 0000000000400000 RBX: 0000000000000000 RCX: ffff9dbcc358ac70
> [   40.980494] RDX: 0000000000000001 RSI: ffff9dbcc48c0300 RDI: ffffc1cbc2cfbff8
> [   40.980495] RBP: ffffc1cbc2cfc028 R08: 0000000000000000 R09: ffffffffa484c6c0
> [   40.980495] R10: ffff9dbcc0729cc0 R11: 0000000000000002 R12: ffff9dbcc4a75b28
> [   40.980496] R13: ffff9dbcc4a75b28 R14: ffff9dbcc01fe600 R15: ffff9dbcc51a9e00
> [   40.980498] FS:  00007ffb70ea4740(0000) GS:ffff9dbfefd80000(0000) knlGS:00000
> [   40.980499] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   40.980499] CR2: ffffc1cbc2cfbfe8 CR3: 000000010619a000 CR4: 00000000000006f0
> [   40.980501] Call Trace:
> [   40.980510]  <TASK>
> [   40.980513]  simple_unlink+0x24/0x50
> [   40.980526]  aafs_remove+0x9a/0xb0
> [   40.980543]  __aafs_ns_rmdir+0x2ec/0x3b0
> [   40.980548]  destroy_ns.part.0+0x9f/0xc0
> [   40.980558]  __aa_remove_ns+0x44/0x90
> [   40.980560]  destroy_ns.part.0+0x40/0xc0
> [   40.980562]  __aa_remove_ns+0x44/0x90
> [   40.980563]  destroy_ns.part.0+0x40/0xc0
> .....
> [   40.981324]  ns_rmdir_op+0x189/0x300
> [   40.981327]  vfs_rmdir+0x9b/0x200
> [   40.981335]  do_rmdir+0x1ac/0x1c0
> [   40.981340]  __x64_sys_rmdir+0x3f/0x70
> [   40.981342]  do_syscall_64+0x82/0x190
> [   40.981360]  ? do_fault+0x31a/0x550
> [   40.981372]  ? __handle_mm_fault+0x7c2/0xf70
> [   40.981373]  ? syscall_exit_to_user_mode_prepare+0x149/0x170
> [   40.981388]  ? __count_memcg_events+0x53/0xf0
> [   40.981392]  ? count_memcg_events.constprop.0+0x1a/0x30
> [   40.981394]  ? handle_mm_fault+0x1bb/0x2c0
> [   40.981396]  ? do_user_addr_fault+0x36c/0x620
> [   40.981408]  ? exc_page_fault+0x7e/0x180
> [   40.981412]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> .....
> [   40.981486] Kernel panic - not syncing: Fatal exception in interrupt
>
> I realize that anyone who can play with apparmor config can screw the
> box into the ground in a lot of ways, but... when you have a recursion
> kernel-side, it would be nice to have its depth bounded.  Not even root
> should be able to panic the box with a single call of rmdir(2)...

Indeed, we can cap this something about ~3x what realistically we would see with

nesting of user namespaces. Some where between between 8-16 deep should be enough.

Something like

diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
index d646070fd966..081a0d5988d4 100644
--- a/security/apparmor/include/policy_ns.h
+++ b/security/apparmor/include/policy_ns.h
@@ -19,6 +19,9 @@
  #include "policy.h"


+/* maximum nesting of policy namespaces */
+#define MAX_NS_DEPTH 8
+
  /* struct aa_ns_acct - accounting of profiles in namespace
   * @max_size: maximum space allowed for all profiles in namespace
   * @max_count: maximum number of profiles that can be in this namespace
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 64783ca3b0f2..89a6fecfd39a 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -223,6 +223,9 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
      AA_BUG(!name);
      AA_BUG(!mutex_is_locked(&parent->lock));

+    if (ns->level >= MAX_NS_LEVEL)
+        return ERR_PTR(-EPERM);
+
      ns = alloc_ns(parent->base.hname, name);
      if (!ns)
          return ERR_PTR(-ENOMEM);

would do for the creation side, which should be enough. But We could also

throw in a bug check and bail against the the ns->level on the rmdir as well.





