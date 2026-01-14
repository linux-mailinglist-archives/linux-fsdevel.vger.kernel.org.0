Return-Path: <linux-fsdevel+bounces-73522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0668D1BDEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 01:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4062B30119A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A0226D00;
	Wed, 14 Jan 2026 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoejNycv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9E1F03DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352040; cv=pass; b=GW/Mg4QPAQTf1Q3quHVQOLkFW/e6n7JuIvi9fFt7p/00CUsUqceXmUj1O3G85T60grgEGhzPWawRV1ZUBAmeccZUrx9ussDSh5+NHiGM7idJQTTlVGB9aFd5/UBvL0vh9FVm+uAV6EZwRhdbb2knmcMrdJJBt28sPFb+RKX/LF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352040; c=relaxed/simple;
	bh=JRwcD3fk49asyn6ngGbgkUhjPaaagx8MvdcmtHVKSAs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UqtYPdyECujdE+tq8OxvClx537zVfF7Sky7gczO1IuG5VK2PShJceAs+bVp1YXGt3Pb+y7EbM0GcGhsjVJMpFdL++fCQ6JuwSQ0sjt1dyeQ8kWNHBr98XExwqCBEwfPjT/jMv0wp6QnqONRa6Iev6vzy6+WASu3ve2PtlrdFXyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoejNycv; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014acad6f2so29011cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 16:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768352038; cv=none;
        d=google.com; s=arc-20240605;
        b=IAP1j5oB8uw/gZCvGpgEJK/K6W4TH/d5EqEwt86C8bIsIXMdomful9Rp3MFenWc6JG
         0e0dcRZo0ZIRZEmhJdKjENToSHzIWRnlPxpwmDu1GkIsZIw47cZTG5ip8GObjrHWf21j
         kidZl9VDV7YEP/t1RcxNycgEAjDpvWSpKClhR/bOlRwklr7mpdutiv2QYgm83KOZmmUh
         Z7Jmrkt/vMPTHTVoSljTv5eOIYh6+ZzFseHjtJFMyORN6X9qNs4Uvmy1l5LPIf6Fx9as
         aVLGJm2tK7L58TKNaEKceaUlAMrM4L9Jl2xek8AxkRHjR410rBJhmUZm6Nx7OuXPmvwQ
         DEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Sjvxg8rfJ4tyYbIvERML95pv2H4avy+gNarVCWV9Z+4=;
        fh=VPLYo5xqO1i3Nf9uMYoa6FxgpT4cJ0LAdhzyIKRYI9U=;
        b=bIoDnr7A5hRf2TwWUktS2zHBiXKHQ0yzDsFhgc/B1hhdlniM9T9f2DFZcevLW7kubo
         Hh24Ob2ZChG9ZKu3Etd8oKewq1gLku0GWousnlzN9J8gHsirJeGLmqFLtUXEUBSJUvMw
         bnFzDwosV6KGfBQ+5NE91suQLOKGSFInoQKBvD9J6OZIZFWHBiJc36+FKiJMF+0bhu0q
         wc/XQxFcSlKf69ia8rejs31gP7dbw432E4F/3HW/q67ymVt1AsjxqGorY4lUBOg6MVMc
         Uz8zrJqZpbdlUHPbM6bC/JybMHhIVyyuGWl92buD7ocxtWQ56TnEZfAf/jaCXI1ky3ft
         XRDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768352038; x=1768956838; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sjvxg8rfJ4tyYbIvERML95pv2H4avy+gNarVCWV9Z+4=;
        b=LoejNycvEnsttCdpXzOay8gKconLJ5/FEFm0/E7AgDEErm+uzNZ3vKQYuL3ifYAY1y
         U7inanPYtSbKYNyApBv0Xq6sHs/ku3CjGb1VuYncjZaDUjjNrIy0HJhuL7kAijAJ2Wjf
         5NI/ES3pM1+KYrt2c33uL32Af2+d/qSZ0+454VSoCCW39uKrFFS76bR2EUMx+u3zH0c2
         2HBRBQQwEErD16am0TTGbG9LtJ2OhXqLGAP7WxzUdvsgbBmL2uUysmGvtshuA/UyxzBK
         1EF8cxPIvJTFKlQ9Faj74JV5iwRVQznKtn+9d0B2VcdZTRcTifSnt25R6nKm9mup8ZaR
         e2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768352038; x=1768956838;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjvxg8rfJ4tyYbIvERML95pv2H4avy+gNarVCWV9Z+4=;
        b=wsuCyO9k+YmUe8eLHMQ1FpkmU5UQWGQAWtsU+D20CWFXWQqKOg3qrQ7vOi4qmOMvv+
         6nzFrauP8OENd23XNQTNZruCnkycG+vrXAYKKlbUuJcrQFZ600xm+Zcw2QXbyylyO+iy
         HWSb+YaC6YVxIBdaB5deYG7e/fbXnoCmPSRoVw8WQvtjjuhtX6zJJl4tfYVleDd5PAsv
         qdJr1fj836MC87ZOaMxS+9+6rviAPfp+Gpyphxv/xNnwqXWWyF6FjHk8EXP81+FJyrg8
         mD6QnBS8QksSXVCIP0D2eoXTwlCo+IRG+pkAU36bahbrEDB7Tszj6jXQW+/Cs6diyCEm
         hVYg==
X-Forwarded-Encrypted: i=1; AJvYcCWczaVbHFG7+I/f4R4mySVqnWzXSW8WRP5dz6lpUXnTmsp+ayqnlzNLJFpxV10OZJjVkd1+4kl4b1nWnBov@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVw460ZV0T/5RdJmxUayy22++mtqcpMUKSh2mRfbXmFgON+D6
	q3mg/eOF8tvnH10oJk4yPabN1rPzqpSbCIfxYLVwi/XifUn4D+esrwpfKDY8EQ/21CVvhM58i2x
	4xVWOc/uiO01wXVz7YiofR1wE9pQ1hUIcaHJZ/0r/
X-Gm-Gg: AY/fxX4jI1EyAaJZGvHabz8kFW7hFnAPJojYIpYcgAOoFXzMdCagMjgP39HFxf7MHhc
	jZnv+pFNRhyX90pXmFcCzIYvm/KDt6Y4ymXXOdKzO9v/QAPeZ1wkA1VhYoceXagSCo76OJlrrc5
	Tn2EVr/LHHwuUaEGoSfia9Jb/cWJOk+ZQYFH+C71CaPEZV1jg39tq4O1JNzG1nLmyIs9OEUyPjq
	aqe0nztKdnULCWzBfTzngvS/73uASr589ZgDYrmNAPZHs6AVFaJVg5efrZt3LswNR7/KMAQCYbG
	S/6m2w==
X-Received: by 2002:a05:622a:190b:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-50148257b6fmr5472821cf.12.1768352038005; Tue, 13 Jan 2026
 16:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenglong Tang <chenglongtang@google.com>
Date: Tue, 13 Jan 2026 16:53:47 -0800
X-Gm-Features: AZwV_QhrCp2EjVpNxdoB6X5frwJ2nGOcpg_dBtQQxSup5r0OlCW4AghAPeQvEhc
Message-ID: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
Subject: [Regression 6.12] NULL pointer dereference in submit_bio_noacct via backing_file_read_iter
To: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amir73il@gmail.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"

Hi OverlayFS Maintainers,

This is from Container Optimized OS in Google Cloud.

We are reporting a reproducible kernel panic on Kernel 6.12 involving
a NULL pointer dereference in submit_bio_noacct.

The Issue: The panic occurs intermittently (approx. 5 failures in 1000
runs) during a specific PostgreSQL client test
(postgres_client_test_postgres15_ctrdncsa) on Google
Container-Optimized OS. The stack trace shows the crash happens when
IMA (ima_calc_file_hash) attempts to read a file from OverlayFS via
the new-in-6.12 backing_file_read_iter helper.

It appears to be a race condition where the underlying block device is
detached (becoming NULL) while the backing_file wrapper is still
attempting to submit a read bio during container teardown.

Stack Trace:
[  OK  ] Started    75.793015] BUG: kernel NULL pointer dereference,
address: 0000000000000156
[   75.822539] #PF: supervisor read access in kernel mode
[   75.849332] #PF: error_code(0x0000) - not-present page
[   75.862775] PGD 7d012067 P4D 7d012067 PUD 7d013067 PMD 0
[   75.884283] Oops: Oops: 0000 [#1] SMP NOPTI
[   75.902274] CPU: 1 UID: 0 PID: 6476 Comm: helmd Tainted: G
 O       6.12.55+ #1
[   75.928903] Tainted: [O]=OOT_MODULE
[   75.942484] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[   75.965868] RIP: 0010:submit_bio_noacct+0x21d/0x470
[   75.978340] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 b6 ad 89 01 49
83 fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 09 c9 7d 01
00 7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 4c
a0 02
[   76.035847] RSP: 0018:ffffa41183463880 EFLAGS: 00010202
[   76.050141] RAX: ffff9d4ec1a81a78 RBX: ffff9d4f3811e6c0 RCX: 00000000009410a0
[   76.065176] RDX: 0000000010300001 RSI: ffff9d4ec1a81a78 RDI: ffff9d4f3811e6c0
[   76.089292] RBP: ffffa411834638b0 R08: 0000000000001000 R09: ffff9d4f3811e6c0
[   76.110878] R10: 2000000000000000 R11: ffffffff8a33e700 R12: 0000000000000000
[   76.139068] R13: ffff9d4ec1422bc0 R14: ffff9d4ec2507000 R15: 0000000000000000
[   76.168391] FS:  0000000008df7f40(0000) GS:ffff9d4f3dd00000(0000)
knlGS:0000000000000000
[   76.179024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   76.184951] CR2: 0000000000000156 CR3: 000000007d01c006 CR4: 0000000000370ef0
[   76.192352] Call Trace:
[   76.194981]  <TASK>
[   76.197257]  ext4_mpage_readpages+0x75c/0x790
[   76.201794]  read_pages+0xa0/0x250
[   76.205373]  page_cache_ra_unbounded+0xa2/0x1c0
[   76.232608]  filemap_get_pages+0x16b/0x7a0
[   76.254151]  ? srso_alias_return_thunk+0x5/0xfbef5
[   76.260523]  filemap_read+0xf6/0x440
[   76.264540]  do_iter_readv_writev+0x17e/0x1c0
[   76.275427]  vfs_iter_read+0x8a/0x140
[   76.279272]  backing_file_read_iter+0x155/0x250
[   76.284425]  ovl_read_iter+0xd7/0x120
[   76.288270]  ? __pfx_ovl_file_accessed+0x10/0x10
[   76.293069]  vfs_read+0x2b1/0x300
[   76.296835]  ksys_read+0x75/0xe0
[   76.300246]  do_syscall_64+0x61/0x130
[   76.304173]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Our Findings:

Not an Ext4 regression: We verified that reverting "ext4: reduce stack
usage in ext4_mpage_readpages()" does not resolve the panic.

Suspected Fix: We suspect upstream commit 18e48d0e2c7b ("ovl: store
upper real file in ovl_file struct") is the correct fix. It seems to
address this exact lifetime race by persistently pinning the
underlying file.

The Problem: We cannot apply 18e48d0e2c7b to 6.12 stable because it
depends on the extensive ovl_real_file refactoring series (removing
ovl_real_fdget family functions) that landed in 6.13.

Is there a recommended way to backport the "persistent real file"
logic to 6.12 without pulling in the entire refactor chain?

Best,

Chenglong

