Return-Path: <linux-fsdevel+bounces-74295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7415D3902C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABBE301FB46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10F29ACDB;
	Sat, 17 Jan 2026 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfCrhRCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE3279DC0
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672329; cv=none; b=XPqIfld8vrSOyt09mfYWT4LMOGtIG8IwI+dXoVym4jmKedlmf0jsQxCDliJe1yQBVv10VSacymFZDALTAiAvM1RfO8dymdeykSY5u9wuP17MrpSgljMVP6cbqMMVb7kza9ODUW83YUeSaldPoXu2qTSmyEt/Xap4THTuAQwmryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672329; c=relaxed/simple;
	bh=LdL2NP/9zkYJ9uZeCyKaPM2nU0McevIKKU5RbNyx4gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvdGEFMA1FR7kUYIzFmG5P5osLS9Chfsnuz9n+Ic8jICipMKXrES/TG1pSq4AS7IGp+MzxNk1wGUtll03X65QK+leG7f+WKsGCZtIRnQEukJkAAirfBV1Ibv0RBzWDBq7sqxfG2CpeIBz5A/YBFsQR6GWnxhdFdvjQaZLexAdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfCrhRCb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47edb585dffso2044475e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768672326; x=1769277126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBbmI5LQhg1F/iwNCBH8tSn2MKg4q8ChUorIYQ0V3rI=;
        b=BfCrhRCbfz/LP/9LzD7HJgN3QpNvZgbJVawoJF5kzOJcaNbkmwe40uwAXBwZG47xEM
         nNo2dVgioXlPUPrkunObh7IEOby7QQwrvZfSDuiy63QM6UU9qVtnOeLiheTIj44x4ddl
         X80IMLYbm5V2NJ3k/+02Dfs62VFFZuUg1v8ItDrBfaHHcObZBnyKNZd53uTQd8dRGXzb
         dpoFbGBSYkzwEAGdQ+teJz70G3rw0h3fLDCb58zyo+qZD2EofKRfPUb7UP4G3BPioO4k
         DYw00azWc7H/g+ba0OiqnNdFtHUud4zkZJbx5DmAzWHEJ5x5CimcyajYMh0XrGpbmaxB
         C3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768672326; x=1769277126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBbmI5LQhg1F/iwNCBH8tSn2MKg4q8ChUorIYQ0V3rI=;
        b=WCv30QXt8+jzIM3nYk4rYiLyarDKEFENmn6C5AdFdRUu8+1qxGnanHt8hevp/WUs7S
         2q9tTJJvNbRpWGr7sG+Xm0imiskwA48Ro/TYQB+9KL2mXcxo/D74F1YRnO6huHiXL8KE
         g0+Z3mUrFcTlb94fFhuu3fd0okR/bzO0qGpHkQCNsDgX+skKzRDx77XwfdXme/zO5cDR
         lZAvL7X1L4+grCW4nl4PmCaQm5PKCl7wnyO6bMYysGlNbI2xttQKJI6yxsCiKCVvFtgx
         sfBrkCP6rDC5tiBovWoeag8gqi91ASDG5d9TWhtjnbgjC6+9EB8sdNy7hmofZ4Y0/rHq
         TSEA==
X-Forwarded-Encrypted: i=1; AJvYcCU0JEQtC8Zz4T+4w31pfGcum80aR1GcQLR2WzzSRoPpWbkm/X6B9IEED73+XAGZeSY/JB3jaiI7m8PvLX4y@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaymA5/iNBRz8qE8mRKApZ4RU4BZOLbFQ9/vikc//TkwImzy8
	scLgrms88DaVAFWNfzpOdMHChqBBbfWJ0DVFtFTahwHYjxy10bzWxtPt
X-Gm-Gg: AY/fxX4l4AD77EhJtKHfoM1CE/UWB1xljeN0nL5jmtmGwq40ReLvbdZepn43UzHGJv8
	c8ziCQokmSrzZWgr6rYs2yAeCOb9GqUJn/HtQiz3a4KIH2E03A37AtMh+JFaHCbJwtTPSPdP0hR
	A/i0uKmMKuxCMRrSVW8HF+HF8HRFQnTrqGnDbFTaPNKzbNmGMy45pqx1yZkJ2LdIjEBJ/rf1610
	DIzR5ql0vESt01FsFU98Tm7khpOLK2EFfoSi/eqAOuyRshuL32sMu7FsfnQ29eeoBQJvUGaWvUl
	K3MllQtDLgHlcJYSF/M4imbQitA7Es5/SpdGu7YoNHdZi36UFjU8XRL/z4m16Q85+ispbzILq9S
	4buofJgEay7EcEls3ZQbWDOeRYrO6ix9jjj3T+6Vc+7fUDglVzl+WnMckb+4Tpd+G6rnEiWZkvJ
	99jcLTZL3dbpgHPKpvGljlfO63DYiBwg==
X-Received: by 2002:a05:6000:3112:b0:42b:3e20:f1b1 with SMTP id ffacd0b85a97d-4356997c382mr4931671f8f.2.1768672325505;
        Sat, 17 Jan 2026 09:52:05 -0800 (PST)
Received: from [192.168.1.105] ([165.50.15.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dedsm12338569f8f.9.2026.01.17.09.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 09:52:04 -0800 (PST)
Message-ID: <7d38a29d-9d81-42e0-99c1-b6a09afe61fd@gmail.com>
Date: Sat, 17 Jan 2026 19:51:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "brauner@kernel.org" <brauner@kernel.org>
Cc: "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
 <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
 <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
 <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 8:24 PM, Viacheslav Dubeyko wrote:
> On Sat, 2025-11-29 at 13:48 +0100, Mehdi Ben Hadj Khelifa wrote:
>> On 11/27/25 9:19 PM, Viacheslav Dubeyko wrote:
>>>
> 
> <skipped>
> 
>>>
>>> As far as I can see, the situation is improving with the patches. I can say that
>>> patches have been tested and I am ready to pick up the patches into HFS/HFS+
>>> tree.
>>>
>>> Mehdi, should I expect the formal patches from you? Or should I take the patches
>>> as it is?
>>>
>>
>> I can send them from my part. Should I add signed-off-by tag at the end
>> appended to them?
>>
> 
> If you are OK with the current commit message, then I can simply add your
> signed-off-by tag on my side. If you would like to polish the commit message
> somehow, then I can wait the patches from you. So, what is your decision?
> 
>>
>> Also, I want to give an apologies for the delayed/none reply about the
>> crash of xfstests on my part. I went back testing them 3 days earlier
>> and they started showing different results again and then I have broken
>> my finger....Which caused me to have much slower progress.I'm still
>> working on getting the same crashes as I did before where I get them
>> when running any test.Because I ran quick tests and they didn't crash.
>> only with auto around the 631 test for desktop and around 642 on my
>> laptop for both not patched and patched kernels.I'm going to update you
>> on that matter when I can have predictable behavior and cause of the
>> crash/call stack.But expect slow progress from my part here for the
>> reason I mentionned before.
>>
> 
> No problem. Take your time.
> 
Continuing on this. I have run xfstests today on the base 6.18-rc7 
unmodified kernel ( I will do it again for latest release) and captured 
the crash.
The following is the decoded crash report:
[ 1572.093549] [T1127273] Oops: general protection fault, maybe for 
address 0xffffcaa2c1da364c: 0000 [#1] SMP NOPTI
[ 1572.093555] [T1127273] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE, 
[E]=UNSIGNED_MODULE
[ 1572.093556] [T1127273] Hardware name: Gigabyte Technology Co., Ltd. 
B760 DS3H/B760 DS3H, BIOS F12 02/25/2025
[ 1572.093557] [T1127273] RIP: 0010:memcpy (arch/x86/lib/memcpy_64.S:38)
[ 1572.093560] [T1127273] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 
00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 
89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 90 66 66 2e 0f 1f 84 00 00 00 
00 00 90 90
All code
========
    0:	2e 0f 1f 84 00 00 00 	cs nopl 0x0(%rax,%rax,1)
    7:	00 00
    9:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    e:	90                   	nop
    f:	90                   	nop
   10:	90                   	nop
   11:	90                   	nop
   12:	90                   	nop
   13:	90                   	nop
   14:	90                   	nop
   15:	90                   	nop
   16:	90                   	nop
   17:	90                   	nop
   18:	90                   	nop
   19:	90                   	nop
   1a:	90                   	nop
   1b:	90                   	nop
   1c:	90                   	nop
   1d:	90                   	nop
   1e:	f3 0f 1e fa          	endbr64
   22:	66 90                	xchg   %ax,%ax
   24:	48 89 f8             	mov    %rdi,%rax
   27:	48 89 d1             	mov    %rdx,%rcx
   2a:*	f3 a4                	rep movsb (%rsi),(%rdi)		<-- trapping 
instruction
   2c:	c3                   	ret
   2d:	cc                   	int3
   2e:	cc                   	int3
   2f:	cc                   	int3
   30:	cc                   	int3
   31:	66 90                	xchg   %ax,%ax
   33:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   3a:	00 00 00 00
   3e:	90                   	nop
   3f:	90                   	nop

Code starting with the faulting instruction
===========================================
    0:	f3 a4                	rep movsb (%rsi),(%rdi)
    2:	c3                   	ret
    3:	cc                   	int3
    4:	cc                   	int3
    5:	cc                   	int3
    6:	cc                   	int3
    7:	66 90                	xchg   %ax,%ax
    9:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   10:	00 00 00 00
   14:	90                   	nop
   15:	90                   	nop
[ 1572.093561] [T1127273] RSP: 0018:ffffcaa2c1da3610 EFLAGS: 00010206
[ 1572.093563] [T1127273] RAX: ffffcaa2c1da364c RBX: 0000000000000004 
RCX: 0000000000000004
[ 1572.093564] [T1127273] RDX: 0000000000000004 RSI: 0ddc8fa7cb9c9ff6 
RDI: ffffcaa2c1da364c
[ 1572.093565] [T1127273] RBP: 0000000000000004 R08: 0000000000002000 
R09: ffff89e0966c8118
[ 1572.093566] [T1127273] R10: 0000000000000009 R11: 000000000000000a 
R12: ffffcaa2c1da364c
[ 1572.093566] [T1127273] R13: ffff89e085beee98 R14: 0000000000000004 
R15: ffff89e085beee40
[ 1572.093567] [T1127273] FS:  00007f9b755ddc40(0000) 
GS:ffff89e8af90e000(0000) knlGS:0000000000000000
[ 1572.093568] [T1127273] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1572.093569] [T1127273] CR2: 00007f0cc5b95a10 CR3: 00000003448b9001 
CR4: 0000000000f72ef0
[ 1572.093570] [T1127273] PKRU: 55555554
[ 1572.093570] [T1127273] Call Trace:
[ 1572.093572] [T1127273]  <TASK>
Server query failed: No such file or directory
[ 1572.093574] [T1127273] hfsplus_bnode_read (fs/hfsplus/bnode.c:49 
fs/hfsplus/bnode.c:23) hfsplus
[ 1572.093580] [T1127273]  ? __pfx_hfs_find_rec_by_key 
(fs/hfsplus/bfind.c:86) hfsplus
[ 1572.093584] [T1127273] hfsplus_brec_lenoff (fs/hfsplus/brec.c:27) hfsplus
[ 1572.093588] [T1127273] __hfsplus_brec_find (fs/hfsplus/bfind.c:118) 
hfsplus
[ 1572.093592] [T1127273] hfsplus_brec_find (fs/hfsplus/bfind.c:191) hfsplus
[ 1572.093596] [T1127273]  ? __pfx_hfs_find_rec_by_key 
(fs/hfsplus/bfind.c:86) hfsplus
[ 1572.093599] [T1127273] hfsplus_attr_exists 
(fs/hfsplus/attributes.c:190) hfsplus
[ 1572.093603] [T1127273] __hfsplus_setxattr (fs/hfsplus/xattr.c:340 
(discriminator 1)) hfsplus
[ 1572.093610] [T1127273] hfsplus_setxattr (fs/hfsplus/xattr.c:437) hfsplus
[ 1572.093613] [T1127273]  __vfs_setxattr (fs/xattr.c:200)
[ 1572.093616] [T1127273]  __vfs_setxattr_noperm (fs/xattr.c:236)
[ 1572.093619] [T1127273]  vfs_setxattr (./include/linux/fs.h:990 
fs/xattr.c:323)
[ 1572.093621] [T1127273]  filename_setxattr (fs/xattr.c:666)
[ 1572.093623] [T1127273]  path_setxattrat (fs/xattr.c:715)
[ 1572.093626] [T1127273]  __x64_sys_lsetxattr (fs/xattr.c:750 
(discriminator 2))
[ 1572.093628] [T1127273]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 
(discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[ 1572.093630] [T1127273]  ? do_syscall_64 
(arch/x86/entry/syscall_64.c:63 (discriminator 1) 
arch/x86/entry/syscall_64.c:94 (discriminator 1))
[ 1572.093631] [T1127273]  ? __x64_sys_lsetxattr (fs/xattr.c:750 
(discriminator 2))
[ 1572.093633] [T1127273]  ? do_syscall_64 
(arch/x86/entry/syscall_64.c:63 (discriminator 1) 
arch/x86/entry/syscall_64.c:94 (discriminator 1))
[ 1572.093633] [T1127273]  ? __irq_exit_rcu (kernel/softirq.c:688 
(discriminator 1) kernel/softirq.c:729 (discriminator 1))
[ 1572.093636] [T1127273]  entry_SYSCALL_64_after_hwframe 
(arch/x86/entry/entry_64.S:130)
[ 1572.093637] [T1127273] RIP: 0033:0x7f9b7531697e
[ 1572.093654] [T1127273] Code: 83 c4 18 48 89 d8 5b 41 5c 41 5d 41 5e 
41 5f 5d c3 0f 1f 00 31 db eb e7 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 bd 
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 62 13 0f 00 f7 d8 
64 89 01 48
All code
========
    0:	83 c4 18             	add    $0x18,%esp
    3:	48 89 d8             	mov    %rbx,%rax
    6:	5b                   	pop    %rbx
    7:	41 5c                	pop    %r12
    9:	41 5d                	pop    %r13
    b:	41 5e                	pop    %r14
    d:	41 5f                	pop    %r15
    f:	5d                   	pop    %rbp
   10:	c3                   	ret
   11:	0f 1f 00             	nopl   (%rax)
   14:	31 db                	xor    %ebx,%ebx
   16:	eb e7                	jmp    0xffffffffffffffff
   18:	0f 1f 40 00          	nopl   0x0(%rax)
   1c:	f3 0f 1e fa          	endbr64
   20:	49 89 ca             	mov    %rcx,%r10
   23:	b8 bd 00 00 00       	mov    $0xbd,%eax
   28:	0f 05                	syscall
   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- 
trapping instruction
   30:	73 01                	jae    0x33
   32:	c3                   	ret
   33:	48 8b 0d 62 13 0f 00 	mov    0xf1362(%rip),%rcx        # 0xf139c
   3a:	f7 d8                	neg    %eax
   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
   3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
    6:	73 01                	jae    0x9
    8:	c3                   	ret
    9:	48 8b 0d 62 13 0f 00 	mov    0xf1362(%rip),%rcx        # 0xf1372
   10:	f7 d8                	neg    %eax
   12:	64 89 01             	mov    %eax,%fs:(%rcx)
   15:	48                   	rex.W
[ 1572.093655] [T1127273] RSP: 002b:00007ffc251dfbd8 EFLAGS: 00000246 
ORIG_RAX: 00000000000000bd
[ 1572.093656] [T1127273] RAX: ffffffffffffffda RBX: 0000000000000000 
RCX: 00007f9b7531697e
[ 1572.093657] [T1127273] RDX: 00005617e5af5990 RSI: 00007ffc251dfd70 
RDI: 00005617e5af9190
[ 1572.093657] [T1127273] RBP: 00007ffc251dfd60 R08: 0000000000000000 
R09: 0000000000000000
[ 1572.093658] [T1127273] R10: 00000000000002a1 R11: 0000000000000246 
R12: 00007ffc251dfd70
[ 1572.093658] [T1127273] R13: 00005617e5af5990 R14: 00000000000002a1 
R15: 0000000000001ae7
[ 1572.093660] [T1127273]  </TASK>


Should be noted that before the crash, dmesg shows that the generic test 
642 is stuck repeatedly trying to "replace xattr" which is triggered in 
the __hfsplus_setxattr() function under fs/hfsplus/xattr line 354. 
relevant dmesg output:
[ 1571.407168] [   T4294] run fstests generic/642 at 2026-01-17 14:49:36
[ 1571.892677] [T1127270] hfsplus: cannot replace xattr
.
.
.
[ 1572.092869] [T1127271] hfsplus: cannot replace xattr
[ 1572.093234] [T1127270] hfsplus: cannot replace xattr


If more information relevant to the crash or more testing is needed I 
would do my best to help.I will also provide more crash info for the 
6.18-rc7 patched kernel and 6.19-rc4 base and patched kernel soon.

> Thanks,
> Slava.
> 
Also I wanted to check on the v3 patches current status. Do they need 
more revision or they were missed to be merged in?
Best Regards,
Mehdi Ben Hadj Khelifa

>>


