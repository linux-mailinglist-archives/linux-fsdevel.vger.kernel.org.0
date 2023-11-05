Return-Path: <linux-fsdevel+bounces-1985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783E7E134C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 13:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81639B20E29
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE0FBA40;
	Sun,  5 Nov 2023 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7717BA29
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 12:09:09 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF972BF;
	Sun,  5 Nov 2023 04:09:06 -0800 (PST)
Received: from [192.168.1.123] (ip5b4280bd.dynamic.kabel-deutschland.de [91.66.128.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9489C61E5FE03;
	Sun,  5 Nov 2023 13:09:01 +0100 (CET)
Message-ID: <57de3b6c-480d-487b-9e75-0566ffe6eb62@molgen.mpg.de>
Date: Sun, 5 Nov 2023 13:09:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Heisenbug: I/O freeze can be resolved by cat $task/cmdline of
 unrelated process
Content-Language: en-US
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org
References: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
 <ZUeEPQy9v9BdOHar@gallifrey>
From: Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <ZUeEPQy9v9BdOHar@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/23 13:02, Dr. David Alan Gilbert wrote:
> * Donald Buczek (buczek@molgen.mpg.de) wrote:
>> Hello, experts,
>>
>> we have a strange new problem on a backup server (high metadata I/O 24/7, xfs -> mdraid). The system worked for years and with v5.15.86 for 8 month. Then we've updated to 6.1.52 and after a few hours it froze: No more I/O activity to one of its filesystems, processes trying to access it blocked until we reboot.
>>
>> Of course, at first we blamed the kernel as this happened after an upgrade. But after several experiments with different kernel versions, we've returned to the v5.15.86 kernel we used before, but still experienced the problem. Then we suspected, that a microcode update (for AMD EPYC 7261), which happened as a side effect of the first reboot, might be the culprit and removed it. That didn't fix it either. For all I can say, all software is back to the state which worked before.
> 
> I'm not sure; but did you check /proc/cpuinfo after that revert and
> check the microcode version dropped back (or physically pwoer cycle);
> I'm not sure if a reboot reverts the microcode version.

Yes, when not updated via init.d amd-ucode.img, /proc/cpuinfo and dmesg show the old microcode after reboot (through bios, not just kexec). We've power-cycled nonetheless once

>> Now the strange part: What we usually do, when we have a situation like this, is that we run a script which takes several procfs and sysfs information which happened to be useful in the past. It was soon discovered, that just running this script unblocks the system. I/O continues as if nothing ever happened. Then we singled-stepped the operations of the script to find out, what action exactly gets the system to resume. It is this part:
>>
>>      for task in /proc/*/task/*; do
>>          echo  "# # $task: $(cat $task/comm) : $(cat $task/cmdline | xargs -0 echo)"
>>          cmd cat $task/stack
>>      done
>>
>> which can further be reduced to
>>
>>      for task in /proc/*/task/*; do echo $task $(cat $task/cmdline | xargs -0 echo); done
>>
>> This is absolutely reproducible. Above line unblocks the system reliably.
>>
>> Another remarkable thing: We've modified above code to do the processes slowly one by one and checking after each step if I/O resumed. And each time we've tested that, it was one of the 64 nfsd processes (but not the very first one tried). While the systems exports filesystems, we have absolutely no reason to assume, that any client actually tries to access this nfs server. Additionally, when the full script is run, the stack traces show all nfsd tasks in their normal idle state ( [<0>] svc_recv+0x7bd/0x8d0 [sunrpc] ).
>>
>> Does anybody have an idea, how a `cat /proc/PID/cmdline` on a specific assumed-to-be-idle nfsd thread could have such an "healing" effect?
> 
> Not me; but had you tried something simpler like a sysrq-d or sysrq-w
> for locks and blocked tasks.

No, will do.

Thanks!

   Donald

>> I'm well aware, that, for example, a hardware problem might result in just anything and that the question might not be answerable at all. If so: please excuse the noise.
> 
> Seems a weird hardware problem to have that specific
> a way to unblock it.
> 
> Dave
> 
>> Thanks
>> Donald
>> -- 
>> Donald Buczek
>> buczek@molgen.mpg.de
>> Tel: +49 30 8413 1433

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

