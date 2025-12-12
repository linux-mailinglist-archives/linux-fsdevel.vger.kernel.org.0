Return-Path: <linux-fsdevel+bounces-71178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D3CB7CE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 04:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FCA303C811
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 03:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C362DECBF;
	Fri, 12 Dec 2025 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmupvHaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA728224AE8
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765511814; cv=none; b=eIC60cgHjdBBxluH2LoRTP19/NZrfZI94IHtPyHgWBhrPU/otHFvhU3DxXqyMbsBET2D75+mlg2X4QbzFXLwR/OkuGH3olD6PXH9C4BjtVp39CwkZopNf/CTrgkqMXMkQdGOqZz1iYtEQQzDjE4XdBjMyfS6d4F2+SnVlBhIU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765511814; c=relaxed/simple;
	bh=BSPNDIjYRwX+rmmxc1Nm+icFpMP5Heegcj4kj1lgue8=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=A0xQhf1wb+KqyFX44WXQU4adc3j5gF2dBlqqqu7nzf0S/LKY81P/rV6bRw69ESA3oIdtN+dBAcLVjlUT9yW4cgyaFT0lAwX8I6V/6T8ISh1SpMHfYWIeOPEtN/PSm/Zqk53W6ceBSuj/rNGuFvEHAautvxYKwGQd/9nmGHLyPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmupvHaf; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-786a822e73aso8168387b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 19:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765511811; x=1766116611; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xeFWRCGQLVfdTlq5pXNNJICaPMuBvs9CA3bbYx0xV40=;
        b=qmupvHafjNH7ZsoO9FlLpz4uGHWPDTY4wsU8H0Xost5mCBsY1K1T7fkHd8EXowkfE7
         Qj0j8csjq3KTcvD63W9SMWl8nYVEnifa8r4Z2IsifieeFUInuR/oiMR/3WqhsHR9UC3F
         Ft4MwXCCXgI81yasq53ad+a70cBIVugDILkt0mU+M2SVWk9zkctSFjXsMbstZLAY6XpI
         Nl0aPTAi6YE1eJRwLOSoLvW4BpbjZTU3o34PHWFT4gg6EPTMfACLA79AeYu3yOK63y6x
         eOkVqKxUw6kfqpuFYLfKsILKrGWC1Lj8HAPrRqbZd/+Kctm+1e9cfFUqSVn4ZSXYkAUL
         oRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765511811; x=1766116611;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeFWRCGQLVfdTlq5pXNNJICaPMuBvs9CA3bbYx0xV40=;
        b=xLgAkuOwfxD+Mvj4Z0Nc39mDNcA/Zz2PF2uOyM5xPc17JdhlGbnmlodsiJCv28tuFY
         RGj082821SBV+hjaLvQk0Uw2bSNSvIuzqeuTl7fZhUtsp9zRYZ0iOweMN9g++Bj7hvZD
         3SQV9rck6b9WgNJQVv14ZMm7yl6hrLcrH5YYhRTuCOVRHjhyo/iVsGr3E0YEDHTJGnBR
         kPLi/lgbnR51t8/T5neT6c/H/+t+e6DgJguz2u3rbjRauFn+S+6puXJqzWhGlIcmpZMc
         bI9jEJvfYfVz8JUzW6djfWS+xZtyIyJ+Av4H/+QAIqvqQJtaNil305TpqZf6mT8YssIY
         V/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVvVg47qWu2xAOe7Nyrzu5VjYTCdKdsmWjvpLlQFfVLS9V7NN4q1cQz5uEnNjAVd3kzSByEFfmlF9MHfRAR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/u68YOTYZ8vQ6dGtJnJUPWyhuXc2bk/TsN69mD5wSgzqEpbG
	E3EZSqSoBt0FE44ekp3HJhQ83wka6bs6EqcoWpODQPEA5haZsdBYjEy0iPNYu/kMJA==
X-Gm-Gg: AY/fxX4+IHZh54tAShS7wyB8iCY9IV+cHsZTHWSVqmp6AV+Q2av0y/wHQwsKvj+pVPe
	lCmPma7VFlCSjyZzKyNI25jBz25BpQJW3O/n4Lcbk9xAp7HFWVdUT6s8ljtl/ZrTf9H4yLbqj3z
	fPDtQigO5cOcrgz5HPGYMdUv7ZlUaodeK1jsvzbv0JE3Ra9t6W0bOARiiJFiH7xbVu0/WuD2L6e
	kw7ouNwMYeroWHWVDbWl97GmjqUI+SupTgI27WQq5nbmNN1ZaLBG3dd7VzgkTO6XEF2deze32hT
	kBheTupzVLwSEZJxeMCFu0+xWnlHd1m8UExVdRjUiGEwHCZVRvoPsGxAMXijm06Cjj+vb0+FrVO
	NoSA4FnNGlO9646M2JsKYyybdLXO75cNHTSJIO0B2K8UBIpSdnpWCiyjXk6uKpuhnwl/b47RKjj
	o24CQPY68/+yWdIBuWLiAOwwLMdzpu67KDv2ecqZNgZpDeK3lkzf+IPeSIqrn8PoWEYqOgULY=
X-Google-Smtp-Source: AGHT+IE/UYWvWx/nJFV7pIAxmMrHkR+lE0t2mrgPpTbjSQpL/ST9/mf7gIbX2nmyWaYnzBbvDqZ7/g==
X-Received: by 2002:a05:690c:61ca:b0:789:4f19:7fb3 with SMTP id 00721157ae682-78e66ea6d0bmr7619027b3.68.1765511811239;
        Thu, 11 Dec 2025 19:56:51 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e6a40fc41sm864367b3.29.2025.12.11.19.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 19:56:49 -0800 (PST)
Date: Thu, 11 Dec 2025 19:56:38 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 6.19 tmpfs __d_lookup() lockup
Message-ID: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Al,

Though good for ordinary usage, your persistency mods for 6.19 cause
tmpfs to lockup in __d_lookup() during several fsstressing xfstests:
fairly reliably in generic/269, generic/476, generic/650, generic/750,
less reliably in generic/013, generic/585.  Typical dmesg below.
I have not spotted what's wrong: better hand over to you.

Of course, 2313598222f9 ("convert ramfs and tmpfs") (of Feb 26 2024!)
comes out as the first failing commit, no surprise there.

I did try inserting a BUG_ON(node == node->next) on line 2438 of
fs/dcache.c, just after __d_lookup's hlist_bl_for_each_entry_rcu(),
and that BUG was immediately hit (but, for all I know, perhaps that's
an unreliable asserition, perhaps it's acceptable for a race to result
in a momentary node == node->next there).

I did try hacking on xfstests common/rc, to allow ramfs where tmpfs
is enabled (and _df_device() then needs $DF_PROG -a to show ramfs).
I did not get a lockup or crash from any of them on ramfs (and 476 and
750 actually passed).  I don't draw any conclusion from that, maybe
ramfs just does not support some of the options which help fsstress
to generate the issue; but it might be useful background info.

Hoping you can soon guess what's gone wrong,
or ask for more info, thanks,
Hugh

[   54.354788] run fstests generic/269 at 2025-12-10 19:40:16
[  114.660512] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  114.670705] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-7): P3185
[  114.681006] rcu: 	(detected by 6, t=15007 jiffies, g=3377, q=6940 ncpus=8)
[  114.691346] task:fsstress        state:R  running task     stack:0     pid:3185  tgid:3185  ppid:3059   task_flags:0x400140 flags:0x00080003
[  114.702226] Call Trace:
[  114.712908]  <TASK>
[  114.723528]  __schedule+0x67c/0x6c5
[  114.734245]  ? __d_lookup_rcu+0x7a/0x9c
[  114.744921]  ? irqentry_exit+0x27/0x35
[  114.755547]  ? sysvec_apic_timer_interrupt+0xa8/0xae
[  114.766300]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  114.776953]  ? __d_lookup+0x37/0xad
[  114.787357]  ? __d_lookup+0x2f/0xad
[  114.797700]  ? d_lookup+0x2b/0x42
[  114.807970]  ? lookup_dcache+0x1f/0x60
[  114.818265]  ? lookup_one_qstr_excl+0x1a/0xbe
[  114.828525]  ? do_renameat2+0x1d1/0x3e4
[  114.838808]  ? getname_flags+0x4b/0x17a
[  114.849093]  ? __do_sys_rename+0x36/0x3e
[  114.859363]  ? __x64_sys_rename+0x11/0x13
[  114.869634]  ? x64_sys_call+0x34d/0xe2c
[  114.879797]  ? do_syscall_64+0x53/0x123
[  114.889820]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  114.899748]  </TASK>

