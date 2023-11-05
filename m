Return-Path: <linux-fsdevel+bounces-1983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D27E133F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 13:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6041C2095B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA8FBA2D;
	Sun,  5 Nov 2023 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rrxdtwly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC31BA22
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 12:02:10 +0000 (UTC)
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4BCB3;
	Sun,  5 Nov 2023 04:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
	:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=HKXNPHCNFdPxUogka4hm8V+2J/QunQMFn3t+L+Ja0qo=; b=rrxdtwlydDZtpPWdp4PyeluEdR
	YCtNI9BNTwOd/NGU1Aie9jh4PYI8D7SJBc8MHKqgCKf4rU3dkxqKhdA6xAQ2TcvX1gWWM8BMFurtW
	i4+L5rJdlnuqjN+crYn074KCNu4GTaGIulqcmXkW8Kvg5Wx0cy/SRnDiG4SUuiIm83gG+Q3j5brIX
	Zp1WMwqxwZbS6KcmXhrWae0MnxClOycL5oy7s2fdECJH9MSylDW+Wif7bGJ7A0T3EoOHcGix+g7eQ
	ekhiBsXhxGWGbNo74EP6mFtnp0oszox4X6jPHSg1qbILD/tNvMoO78nM0oI6X++GHdpm2BB24lqmn
	+qqJSYGg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1qzbpN-007pAD-0H;
	Sun, 05 Nov 2023 12:02:05 +0000
Date: Sun, 5 Nov 2023 12:02:05 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: Heisenbug: I/O freeze can be resolved by cat $task/cmdline of
 unrelated process
Message-ID: <ZUeEPQy9v9BdOHar@gallifrey>
References: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 11:59:39 up 50 days, 14:58,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Donald Buczek (buczek@molgen.mpg.de) wrote:
> Hello, experts,
> 
> we have a strange new problem on a backup server (high metadata I/O 24/7, xfs -> mdraid). The system worked for years and with v5.15.86 for 8 month. Then we've updated to 6.1.52 and after a few hours it froze: No more I/O activity to one of its filesystems, processes trying to access it blocked until we reboot.
> 
> Of course, at first we blamed the kernel as this happened after an upgrade. But after several experiments with different kernel versions, we've returned to the v5.15.86 kernel we used before, but still experienced the problem. Then we suspected, that a microcode update (for AMD EPYC 7261), which happened as a side effect of the first reboot, might be the culprit and removed it. That didn't fix it either. For all I can say, all software is back to the state which worked before.

I'm not sure; but did you check /proc/cpuinfo after that revert and
check the microcode version dropped back (or physically pwoer cycle);
I'm not sure if a reboot reverts the microcode version.

> Now the strange part: What we usually do, when we have a situation like this, is that we run a script which takes several procfs and sysfs information which happened to be useful in the past. It was soon discovered, that just running this script unblocks the system. I/O continues as if nothing ever happened. Then we singled-stepped the operations of the script to find out, what action exactly gets the system to resume. It is this part:
> 
>     for task in /proc/*/task/*; do
>         echo  "# # $task: $(cat $task/comm) : $(cat $task/cmdline | xargs -0 echo)"
>         cmd cat $task/stack
>     done
> 
> which can further be reduced to
> 
>     for task in /proc/*/task/*; do echo $task $(cat $task/cmdline | xargs -0 echo); done
> 
> This is absolutely reproducible. Above line unblocks the system reliably.
> 
> Another remarkable thing: We've modified above code to do the processes slowly one by one and checking after each step if I/O resumed. And each time we've tested that, it was one of the 64 nfsd processes (but not the very first one tried). While the systems exports filesystems, we have absolutely no reason to assume, that any client actually tries to access this nfs server. Additionally, when the full script is run, the stack traces show all nfsd tasks in their normal idle state ( [<0>] svc_recv+0x7bd/0x8d0 [sunrpc] ).
> 
> Does anybody have an idea, how a `cat /proc/PID/cmdline` on a specific assumed-to-be-idle nfsd thread could have such an "healing" effect?

Not me; but had you tried something simpler like a sysrq-d or sysrq-w
for locks and blocked tasks.

> I'm well aware, that, for example, a hardware problem might result in just anything and that the question might not be answerable at all. If so: please excuse the noise.

Seems a weird hardware problem to have that specific
a way to unblock it.

Dave

> Thanks
> Donald
> -- 
> Donald Buczek
> buczek@molgen.mpg.de
> Tel: +49 30 8413 1433
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

