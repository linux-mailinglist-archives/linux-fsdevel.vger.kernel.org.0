Return-Path: <linux-fsdevel+bounces-4015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC87FB4E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 09:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2907B1C211FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979BE2E3E5;
	Tue, 28 Nov 2023 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EBC192;
	Tue, 28 Nov 2023 00:53:56 -0800 (PST)
Received: from [192.168.1.123] (ip5b4280bd.dynamic.kabel-deutschland.de [91.66.128.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0A4D961E5FE01;
	Tue, 28 Nov 2023 09:53:41 +0100 (CET)
Message-ID: <4455a6c3-db6f-4303-940e-96a88b466c06@molgen.mpg.de>
Date: Tue, 28 Nov 2023 09:53:40 +0100
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
To: Chuck Lever III <chuck.lever@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 bagasdotme@gmail.com, neilb@suse.de,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
 <9822F555-42F5-44AD-8056-469E85A86C3D@oracle.com>
From: Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <9822F555-42F5-44AD-8056-469E85A86C3D@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just a quick followup to the problem I've reported (system freezing and could be unblocked by reading /proc/PID/cmdline of a nfsd process):

While we've rebootet the system multiple-times (through bios, not just kexec) the problem persisted. But after we've power-cycled the system once, the problem was gone. I guess, this points to a problem below ring 0 or hardware and Linux is not to blame.

Thanks everybody who answered!

Best

  Donald

On 11/6/23 14:58, Chuck Lever III wrote:
>> On Nov 5, 2023, at 4:40 AM, Donald Buczek <buczek@molgen.mpg.de> wrote:
>>
>> Hello, experts,
>>
>> we have a strange new problem on a backup server (high metadata I/O 24/7, xfs -> mdraid). The system worked for years and with v5.15.86 for 8 month. Then we've updated to 6.1.52 and after a few hours it froze: No more I/O activity to one of its filesystems, processes trying to access it blocked until we reboot.
>>
>> Of course, at first we blamed the kernel as this happened after an upgrade. But after several experiments with different kernel versions, we've returned to the v5.15.86 kernel we used before, but still experienced the problem. Then we suspected, that a microcode update (for AMD EPYC 7261), which happened as a side effect of the first reboot, might be the culprit and removed it. That didn't fix it either. For all I can say, all software is back to the state which worked before.
>>
>> Now the strange part: What we usually do, when we have a situation like this, is that we run a script which takes several procfs and sysfs information which happened to be useful in the past. It was soon discovered, that just running this script unblocks the system. I/O continues as if nothing ever happened. Then we singled-stepped the operations of the script to find out, what action exactly gets the system to resume. It is this part:
>>
>>     for task in /proc/*/task/*; do
>>         echo  "# # $task: $(cat $task/comm) : $(cat $task/cmdline | xargs -0 echo)"
>>         cmd cat $task/stack
>>     done
>>
>> which can further be reduced to
>>
>>     for task in /proc/*/task/*; do echo $task $(cat $task/cmdline | xargs -0 echo); done
>>
>> This is absolutely reproducible. Above line unblocks the system reliably.
>>
>> Another remarkable thing: We've modified above code to do the processes slowly one by one and checking after each step if I/O resumed. And each time we've tested that, it was one of the 64 nfsd processes (but not the very first one tried). While the systems exports filesystems, we have absolutely no reason to assume, that any client actually tries to access this nfs server. Additionally, when the full script is run, the stack traces show all nfsd tasks in their normal idle state ( [<0>] svc_recv+0x7bd/0x8d0 [sunrpc] ).
>>
>> Does anybody have an idea, how a `cat /proc/PID/cmdline` on a specific assumed-to-be-idle nfsd thread could have such an "healing" effect?
>>
>> I'm well aware, that, for example, a hardware problem might result in just anything and that the question might not be answerable at all. If so: please excuse the noise.
> 
> I'm with Neil on this: I believe the nfsd thread happens to be in the
> wrong place at the wrong time. When idle, an nfsd thread is nothing
> more than a plain kthread waiting in the kernel's scheduler.
> 
> If you have an opportunity, try testing without starting up the NFSD
> service. You might find that the symptoms move to another thread or
> subsystem.
> 
> 
> --
> Chuck Lever
> 
> 

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

