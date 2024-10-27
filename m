Return-Path: <linux-fsdevel+bounces-33021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84C9B1CCB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 10:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2DF1F21954
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841077F11;
	Sun, 27 Oct 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKHXsTEn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vkZMST81"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D72905;
	Sun, 27 Oct 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730021587; cv=none; b=Mq+/Bu+gfVJxzTgy1qeHzfEgTex4omtPlXO9aNfzxB7+sOgYW8qrdZX6+aIlG3e2LivpTYYi3JtGixFdPOCK3wsKUDuWQ1BFx9SXxNy4AXy5IUSw6a6cEm7A97JIKK9+LEwryhTFs83rMOFwLx4rgUMwHaSAFMOVzmyK7D9/fu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730021587; c=relaxed/simple;
	bh=WIQpZE1pVfbnVnENnTt1q/QMON2V2N60JIehc5LY4FM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TCx3f+OIrYUSSgrWGJyHssdVE7PoZJ1GbXuPTqedPPRzw9cgH0s9hbpjGOewj55sW89PXaMuqRt9QuERBZQRtcWDdc0MYpJT2iZiF0zCDibldP2cAr40RS+3+GyokxV4ta3zD4P7aEPBJ3HMtsnc4ANf+4utgTjkRitZVVhnfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKHXsTEn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vkZMST81; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730021582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h9QgVHSno0p3EwjX6gG1dRFNyeWG//lKPPzJ5XnOhkw=;
	b=ZKHXsTEn6hWOVdMTGW9ISCsGy2P0LsQfJX/12ro8HOsASBITMWRDeFa95WIkVA26DehSBe
	2rgvR+6VZFauIIFkBlSLrZgQQi8Rv6atNm0aAYYWYjmqAMPJKLKX8vw4tJ8mC70khL0M+k
	WfDjAdjcVRpV8B52j+eCSGuXF7tAlp51hKWZ7UlP97txvZQ6AX7rFTwWRW+p0h/fuiYLiH
	Nlew9yqJurW1sC7mW2V6mc82C0OU35r+4VypioDaKde/Ksco5eeO7LNIoZ99TaCWNLGL3E
	F+//K/Te1VPyDxKcZstSk6DLRspP+vrP9YvnHA1rMiK3Iy4td9oEDF+Jls0hqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730021582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h9QgVHSno0p3EwjX6gG1dRFNyeWG//lKPPzJ5XnOhkw=;
	b=vkZMST81emZjWVq3OK02/undTSUkCK8R5UJXba0oSizaF0Cnube+d8hJcq3r0NrEnxWBXH
	u4V935473lnpK8Bw==
To: syzbot <syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com>,
 brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [serial?] BUG: soft lockup in debug_check_no_obj_freed
In-Reply-To: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
References: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
Date: Sun, 27 Oct 2024 10:33:01 +0100
Message-ID: <87iktd51rm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Oct 19 2024 at 08:37, syzbot wrote:

That's not a soft lockup in debug_check_no_obj_freed().

What actually happens is:

>  serial_in drivers/tty/serial/8250/8250.h:137 [inline]
>  serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
>  wait_for_lsr+0xda/0x180 drivers/tty/serial/8250/8250_port.c:2068
>  serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3315 [inline]
>  serial8250_console_write+0xf5a/0x17c0 drivers/tty/serial/8250/8250_port.c:3393
>  console_emit_next_record kernel/printk/printk.c:3092 [inline]
>  console_flush_all+0x800/0xc60 kernel/printk/printk.c:3180
>  __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
>  console_unlock+0xd9/0x210 kernel/printk/printk.c:3279
>  vprintk_emit+0x424/0x6f0 kernel/printk/printk.c:2407
>  vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
>  _printk+0xc8/0x100 kernel/printk/printk.c:2432
>  printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
>  show_trace_log_lvl+0x1b7/0x3d0 arch/x86/kernel/dumpstack.c:285
>  sched_show_task kernel/sched/core.c:7589 [inline]
>  sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7564
>  show_state_filter+0xee/0x320 kernel/sched/core.c:7634
>  k_spec drivers/tty/vt/keyboard.c:667 [inline]
>  k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656

HID injects a sysrq-t and the task dump takes ages, which is what stalls
RCU.

There is not much what can be done about this as the dump is initiated
from soft interrupt context at interrupt return.

Thanks,

        tglx


