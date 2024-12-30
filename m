Return-Path: <linux-fsdevel+bounces-38282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA19FEB02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 22:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA02A161444
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F064E198A3F;
	Mon, 30 Dec 2024 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g5eIXY1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9862188CB1
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735593562; cv=none; b=MUZFM8VneLkeN8ax2R0co+7Q7XTaKPnUIZ49XDCxc/iFfLsU2a6BFXTYhTeQo4Vt322QYmO9aj811KfCcM7oawbSDjLpPiE5P+xYAEGtBEUkc4iz8EpHk7UT/m9Qo8diZQ4oKH62PQATvb55+2gTbLB0ZIqrVMm2S0djOmAjCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735593562; c=relaxed/simple;
	bh=0Ng/m/PsD2jQKEe2mMkN2J8F/tJmhS/LSZ9hggw1DNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VxsnUH94GKobhbO9OewN7KzEWna+hcJuspgk3zIVlca4bZIPggd77nFxfISuIfQCJGvGbiixsHY22qmnHSQdl6rPwcKD+AsTwytHdfCuwWHUItRXaYVmlBjAGtzKRvijOFIXyhVYGpaI8NVbuYgdeAuM8W6dUEc5aAL/yPUcIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g5eIXY1x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2167141dfa1so122121855ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735593559; x=1736198359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kY/jKKALg+6LJ3R04QO+vMeDW2e1LZ4lo7EHj/mvQ0=;
        b=g5eIXY1xfFZO0igV2H9qaywERWRIY7ekYm0TzDHeQ829aiD5CyW7eT5hpYG4ajSelK
         gW4II9hp13ZRR2HmY66HWAJMUd36CgXlJC+munWJ7QVwqTb/HitqDPXGUP6+kEeDlex3
         jr5ksQizdT2ZyftsZdZeRYirvl6Kg7zFSwY3tKDOF7mQDTpJ619nFCBVg0yHg22wHLLj
         qcADsEO5dl+r/5m9HYcXu5L4E9K99vsXmcmnjS5HJEUS0d+oR2Yj1YR0P3WfmHbmob6+
         svebG3w9QJx1pS7wxGi6qspci+rLte1K0+B5sJoBWIfddONP5E25mz02MiDDGTfWj2Y1
         STxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735593559; x=1736198359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kY/jKKALg+6LJ3R04QO+vMeDW2e1LZ4lo7EHj/mvQ0=;
        b=JU4NtBk5TLNiXpC+WIVxddKQ7zHUM2QFYpAK6Pb5t8tdMxYTo9FvbIg3qh6dc1jLhX
         QoTzqtyFuaaDyKZMN6cHICZ1meu37/LC0gMDPrhvPnxCFiKbGjlHoJ6r7fc1UN/cVIN6
         1ZXknQsGcMli6uER0gbaX98Oh6rHMX0+OZodHVxc2SjIcKNn9R7HPuTrpSWVzMNlI8x2
         xpRD+6bsGCCjKqp6x3tqyd5nz/R9l4DL6R61ix08YInG4bRHbGfkfqUBJL5/U9j8BXFY
         gbsik97jC8u+n991jdKMyoDr+BY3NX0WG/MXwb0JVfACkLzq/daipmni0+jApDN/UXhR
         WGBg==
X-Forwarded-Encrypted: i=1; AJvYcCUNaEA9VsLufKCCYOOR1cTD0ocdpRnQSYJK1PKBOIYcUSPWz4vLGZEUx/MpFgamFCQrlLReu2drjZyPUNo4@vger.kernel.org
X-Gm-Message-State: AOJu0Yygg364ZAEFCPspDaagxNyLef++U8edRO9dml4K4vMmsfchA9Iu
	NuJjEdHZ848iyZ6XbCaEg/fU2Sf//tF+51HS/Wt9aIIcjwXjwgs9a5cBGquMbak=
X-Gm-Gg: ASbGnctbiGMj2GFYO1X/htvOvUbmyDVFHA17J8R4Gx93pYaep1/oRuGS0XyibON4Fg8
	2YtpEhBHA/lQQrrXFmZ2Ucla1z3Ci7wLzMBK1s5H2K5cx+LiwxkRo7FCXxkORXDp5CPjWnLHHxV
	3sCb5+pylPQqTJfO0exwSx7HV/vpiRXSeLl/rOroibaGdjr9Z6srxCNtv1jNtcHzOqjYJMy9ggC
	+khyeA+jdfCAXeJfTRv5T0P2G2yN/HA8v7ohxk9hu/QD6zfSeuiOw==
X-Google-Smtp-Source: AGHT+IEEW/98DMG+Ccn7tYKKNnYJKgJFri/6T1fdrEwHE8RgV3wfw0kXF1DnoCWXyGK9Cmsi+zGEAQ==
X-Received: by 2002:a17:903:32c1:b0:215:7287:67bb with SMTP id d9443c01a7336-219e6bf8c37mr495064155ad.0.1735593558999;
        Mon, 30 Dec 2024 13:19:18 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962c1bsm183090255ad.3.2024.12.30.13.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 13:19:18 -0800 (PST)
Message-ID: <616118a2-e440-45c6-a548-a1cdb1b586f2@kernel.dk>
Date: Mon, 30 Dec 2024 14:19:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] [io-uring?] WARNING: locking bug in
 eventfd_signal_mask
To: syzbot <syzbot+b1fc199a40b65d601b65@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, bigeasy@linutronix.de, brauner@kernel.org,
 clrkwllms@kernel.org, io-uring@vger.kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rostedt@goodmis.org,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <67710fe0.050a0220.226966.00bd.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67710fe0.050a0220.226966.00bd.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/24 2:01 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=128f74c4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d269ef41b9262400
> dashboard link: https://syzkaller.appspot.com/bug?extid=b1fc199a40b65d601b65
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1469890f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154b22f8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9015cc2b19ac/disk-9b2ffa61.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3ddeabd5e7eb/vmlinux-9b2ffa61.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/36e13b0305d0/bzImage-9b2ffa61.xz
> 
> The issue was bisected to:
> 
> commit 020b40f3562495f3c703a283ece145ffec19e82d
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Dec 17 15:21:46 2024 +0000
> 
>     io_uring: make ctx->timeout_lock a raw spinlock

#syz test: git://git.kernel.dk/linux io_uring-6.13

-- 
Jens Axboe


