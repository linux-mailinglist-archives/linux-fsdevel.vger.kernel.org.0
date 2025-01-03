Return-Path: <linux-fsdevel+bounces-38370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA1DA01039
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B57A1B7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 22:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36C1C07F4;
	Fri,  3 Jan 2025 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="ZcQ8W2ui";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i88FAFXv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888611BD51B;
	Fri,  3 Jan 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735943123; cv=none; b=NZpEFExwsGrLsloVNPeeXXyHRH74WxX58PwJg8DXM5XSpcJ70EsNhhcGIjscZ5q8oR2RzqYHDa16MeJCwChK8woao2KHj5nZ37A7DgNGOKlBfnVUMrB/N2U5NtS/12ys4I5kF5Hiuv7Xijj/pKVvM6kX9r/PEGsrlJEXxyFNiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735943123; c=relaxed/simple;
	bh=+uQYrY+TUtHjqokU9nkitOIw25sm/w2lLl4H7tJbRGo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=FhhzGEgeedIHbt4B7x4ZpvH2TR05Q1OZ9+xYumcKEWKYX6si6fIdPsJgRuaMxEnmbaMqUszS72K+dvCEGk5S7/p21FSH4QTEp89l5C7NbR7OAoonxs7jLMUNP9P4XaMo1iZNfRI1zj81t6kP60sQo/bOeGSqhBAn5iup3II9ocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io; spf=pass smtp.mailfrom=devkernel.io; dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b=ZcQ8W2ui; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i88FAFXv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C4F21380217;
	Fri,  3 Jan 2025 17:25:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 17:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735943119; x=1736029519; bh=wJP1ar9X0L
	6IgFAANXqamn8drs36v0rwgpIryR2P3aw=; b=ZcQ8W2uiHrP644Bj8cc0E+t2Pv
	ZcEHKmh8lCFlvfB/+2WyT5y66Fn28n36nWkhDuzt7q9XhiEoJB5ZT1bJu9dVipxG
	Br552CbZ+qALfbv8tRVR7Hz0mPCPCgBgLv/rZDbY8/2JVGZTa8yJTl8ojVwyOZ3d
	+6NeDoHH5fETpmlDkhUVo85XCtVwNkHk7rPJbUwIFi1sOkQXq+NaUGXlcF8Lea4n
	3sUSaD8JPc5yNobUYls49Il0K4PGgwlJZsIFLuP5X5uLmQLilx3cAolOyksK88Yn
	VIRCqObiLeg1rCwtwdRq7ING0k/N+riXwwdYW2hX8VcxL3exY2tanzbogp/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735943119; x=1736029519; bh=wJP1ar9X0L6IgFAANXqamn8drs36v0rwgpI
	ryR2P3aw=; b=i88FAFXvWupBXATM2+7lRopawpdEOY6gDoDvLWH/PSquU35N13P
	a4D2fyVeDNZ9AT7KqRFyeB3gpEa/LMBKKyfHLoNfJ24G5zIfV1ELmbCmJVIcYAlv
	60qSxyEDKXLXhitUGc7oJv1Qqs0faMvI+Ae4E8yhzMC33lAq3UrCXSQOeIj4GkUM
	3f82+C+wBwepYAp6z9Gv+uRKgTpWKnhxrm8xetSGwZ0htcuKBvC/hzUZnVrMbztH
	tCLnoIfvCovcbDvCTUEs0NZupvpLmg8cxRnKBzZa6rwiNuXVxOq1wrp6hrlE3Nut
	AEEFBm6mWjE/wTIdtcgcYUns7p4hFhgMCNw==
X-ME-Sender: <xms:zmN4ZwwePaS2BN4MMOWrIPaygnlSHMK7KFcZLn2_UJvSGesD6lIpxw>
    <xme:zmN4Z0SvCjq3W99M63NbOzVuMGOPvwcmBjlz0Ec35Gbo6V0T67Y7s3ePY4GdTdD_V
    7P6f5arTMoZL3fpofs>
X-ME-Received: <xmr:zmN4ZyUQFNJjRpLZYHfaMS9ZS7hdW0G0bGe-2Jb_dqezjONXKu6h0rk-tfjGKnP9B81M0nenQGB4X56hdPNIQB2uk8mOpt_P5Yk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhf
    fvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgt
    hhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgf
    fghfehudeitdehjeevhedthfetvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvg
    hrnhgvlhdrihhopdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeiiiihq
    qhdtuddtfedrhhgvhiesghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhihsehinh
    hfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:zmN4Z-iJC7a3MplmYaKrQEIt-IXRI7-9pQy-gEKF6jfeescqCPwoEA>
    <xmx:zmN4ZyDs824ToQ6uG7QBu00xOmwcZxRSbWGajpfqNR7255MqPzxHug>
    <xmx:zmN4Z_LlZlLw0ZQ9zWiqxjDLUEmuWZqS_m27-qQ0sO-NhVW-09yLyA>
    <xmx:zmN4Z5DlHNJ91XWjQ0Um6ginDg5V-bMhwatg9-x-fWU_tDvadFtQ-Q>
    <xmx:z2N4Z00envbzZwP0FIstFvpnRQqFstSD_oBNszgsoV5ngVMhkbkPT3OQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 17:25:17 -0500 (EST)
References: <CAKHoSAsMYWOYfqw6h74cEzucg1vGZaY4ShT3e35NnX2v_Ro04w@mail.gmail.com>
 <Z3fq3VLthzzmsYd9@casper.infradead.org>
User-agent: mu4e 1.10.3; emacs 29.4
From: Stefan Roesch <shr@devkernel.io>
To: Matthew Wilcox <willy@infradead.org>
Cc: cheung wall <zzqq0103.hey@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: "divide error in bdi_set_min_bytes" in Linux kernel version
 6.13.0-rc2
Date: Fri, 03 Jan 2025 14:24:07 -0800
In-reply-to: <Z3fq3VLthzzmsYd9@casper.infradead.org>
Message-ID: <87pll35yd0.fsf@devkernel.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jan 03, 2025 at 03:25:01PM +0800, cheung wall wrote:
>> I am writing to report a potential vulnerability identified in the
>> Linux Kernel version 6.13.0-rc2. This issue was discovered using our
>> custom vulnerability discovery tool.
>
> Your tool would be more useful if you told us what it was doing.
> I suspect it's writing a very small value into the min_bytes pseudo-file.
> Since that's something only root can do, this isn't a vulnerability.
> This is a very annoying conversation to keep having with people who
> write their own custom "vulnerability discovery tools".
>
> That said, we could do better here.  Stefan, you wrote this code.
>

Thanks for the analysis Matthew. I'll have a look.
Is there a testcase?

>> RIP: 0010:div64_u64 include/linux/math64.h:69 [inline]
>> RIP: 0010:bdi_ratio_from_pages mm/page-writeback.c:695 [inline]
>> RIP: 0010:bdi_set_min_bytes+0x9f/0x1d0 mm/page-writeback.c:799
>> Code: ff 48 39 d8 0f 82 3b 01 00 00 e8 ac fd e7 ff 48 69 db 40 42 0f
>> 00 48 8d 74 24 40 48 8d 7c 24 20 e8 c6 f1 ff ff 31 d2 48 89 d8 <48> f7
>> 74 24 40 48 89 c3 3d 40 42 0f 00 0f 87 08 01 00 00 e8 79 fd
>> RSP: 0018:ffff88810a5f7b60 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff9c9ef057
>> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88810a5f7ab8
>> RBP: 1ffff110214bef6c R08: 0000000000000000 R09: fffffbfff4081c7b
>> R10: ffffffffa040e3df R11: 0000000000032001 R12: ffff888105c65000
>> R13: dffffc0000000000 R14: ffff888105c65000 R15: ffff888105c65800
>> FS: 00007fdfc7c37580(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055adcdc786c8 CR3: 0000000104128000 CR4: 0000000000350ef0
>> Call Trace:
>> <TASK>
>> min_bytes_store+0xba/0x120 mm/backing-dev.c:385
>> dev_attr_store+0x58/0x80 drivers/base/core.c:2439
>> sysfs_kf_write+0x136/0x1a0 fs/sysfs/file.c:139
>> kernfs_fop_write_iter+0x323/0x530 fs/kernfs/file.c:334
>> new_sync_write fs/read_write.c:586 [inline]
>> vfs_write+0x51e/0xc80 fs/read_write.c:679
>> ksys_write+0x110/0x200 fs/read_write.c:731
>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fdfc7b4d513
>> Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
>> 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
>> 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
>> RSP: 002b:00007ffe7796ae28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 000055adcdc766c0 RCX: 00007fdfc7b4d513
>> RDX: 0000000000000002 RSI: 000055adcdc766c0 RDI: 0000000000000001
>> RBP: 0000000000000002 R08: 000055adcdc766c0 R09: 00007fdfc7c30be0
>> R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000000001
>> R13: 0000000000000002 R14: 7fffffffffffffff R15: 0000000000000000
>>
>> ------------[ cut here end]------------
>>
>> Root Cause:
>>
>> The crash is caused by a division by zero error within the Linux
>> kernel's page-writeback subsystem. Specifically, the bdi_set_min_bytes
>> function attempts to calculate a ratio using bdi_ratio_from_pages,
>> which internally calls div64_u64. During this calculation, a
>> denominator value unexpectedly becomes zero, likely due to improper
>> handling or validation of input data provided through the sysfs
>> interface during the min_bytes_store operation. This erroneous zero
>> value leads to a divide error exception when the kernel tries to
>> perform the division. The issue occurs while processing a sysfs write
>> operation (min_bytes_store), suggesting that invalid or uninitialized
>> data supplied through sysfs triggers the faulty calculation,
>> ultimately causing the kernel to crash.
>>
>> Thank you for your time and attention.
>>
>> Best regards
>>
>> Wall


