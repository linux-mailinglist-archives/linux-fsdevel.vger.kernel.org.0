Return-Path: <linux-fsdevel+bounces-45010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D45A9A701EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F80617CCDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C383264A89;
	Tue, 25 Mar 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ImDeFIUl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJbcpvEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4124255E30;
	Tue, 25 Mar 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908715; cv=none; b=OV+1a+U0blzJP2PP4eTRXfJoZpEH9j6pdlAMoNuSf59C81XafWKZUS6gSVGb0xHzsGcRozZDOT/SSLS5Ggm+7YDIlTHhgyh3Rt34Rj7NsTdVPb7N9f6RKz66we2EVukSyIce+kViQhmsflfdH9H+E5fuUvACopN6rc1vvZaWlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908715; c=relaxed/simple;
	bh=C5mrfP7F3Jg/lt8fV5RKe+diz2c9+8VrzuXO+lZEKsk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ucXm544baYho5mQ9Sf7OzrqWrpDva+0+aS/QQ/vnRT+bvsQPMB4gtIhGwvq3/9ExszTdSWCScWJziH0SqAE9b/ftR1wVYgYxOH52lD7vogrD+3XZf9T51lPbqM57E6DyBZ3aW9Es7LoHpI0du1iVOXuCokmybN0yEcBoSrdkV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ImDeFIUl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJbcpvEt; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 145781D41618;
	Tue, 25 Mar 2025 09:18:31 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 25 Mar 2025 09:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742908710;
	 x=1742915910; bh=7uJCsElQFNSpp9yzC8ZbXV0umGMGK1SA9vUHShT/4EA=; b=
	ImDeFIUlaPDd5ArnPxULaKFYin+F0C7Ltwhhbiw4k7YJ41vuGpa4S0yQgq9xPsTe
	uJRvlxGtCeN8CpZuIT8pDsErIP9+bN/T8wL1tp/ARdfFsLcv8Sc8Rcm2AAGU22J+
	QDfsMB27MlJ7Fh/RgFUJCVCjIT3YZoGmX8veA4VhtWah8Pa2dOJDZNENO5efOhCF
	m3Aj/gZEic8zK7xg5Ge5VcUq9SwT677DKgbhu4s+jchHqDCVBX26EBF+Jyr1L5C7
	63jXD83O9CYKFI6eG//84unPYNTVnG6PBAwgNm0MSU3dz67bgY73jNJFOhGYl0LB
	s8TJP3x2kc2XfX0NxWNPbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908710; x=
	1742915910; bh=7uJCsElQFNSpp9yzC8ZbXV0umGMGK1SA9vUHShT/4EA=; b=A
	JbcpvEtDY5GIbS4yWE3NXqHeL6XvezyIp78DhI5UvjpRspYi/G9CdSAwYSUCtNWb
	yZCSTBsfwYT3pBmPHiX1MLdzsCwNGdqTg8pOqvQ1H2TQErjO20YnrvBIqr/9DMiS
	N/aEn/bfBhxGa3yoge377x6x7UBRw+o2D2Qg6mmJ3KKWHRDwG4n8FjXRe5ziwEm/
	wUGvAXF0t7FBZIYI28jJqmK/q7kzLry7J34szfZlVS+GOBQDtwkcol+hbMPCqvOl
	aXXG9vwK4i1gpOxa8dIUlIDZzNMjb3dauDasxJL1NU5UvnvM0wrjeuV397H1C8sF
	5R0FPcBeip3Dcp0RsoYDg==
X-ME-Sender: <xms:Jq3iZ2T8JTz-jbX0ypdu8XvymSl6Ha60DCRSyE3kfaeDEsEdhgXRHQ>
    <xme:Jq3iZ7xqFGmiYIgqeQgAYIE6NT795DUlcZ5oRdxvyZLcCtNjxwf5apWHvH69UlzU0
    90ZNR5B4xx83SxrA2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    vddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihohhnghiguhgrnhdrfigrnh
    hgsehsihhfihhvvgdrtghomhdprhgtphhtthhopehqihhnghhfrghnghdruggvnhhgsehs
    ihhflhhofigvrhdrtghomhdrtghnpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrd
    gtohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghp
    thhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvhhmse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Jq3iZz2yRnqhHEw1IF85xMNxg4AIr2suK_Z7V6TXceVVmAzSa6K9mA>
    <xmx:Jq3iZyAeXA8oa-5WGTCdkkC63QtF5vTYRHuh5qi7ccyHz9ZFy6uGWQ>
    <xmx:Jq3iZ_hXDQ-VIXP0Zn7YnVUgAq0b19IaMLt4GaWKi3jJzguZr_HdUA>
    <xmx:Jq3iZ-rgPQ_c8apCNrICWaw237kvlBRA58SynDoqVL6QMmwWVWyA2Q>
    <xmx:Jq3iZ-U7_q_MN5COfgfdsTStOp5gWRt0SJfrgmunU_hcwDOxH-bYhAym>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DF35E2220071; Tue, 25 Mar 2025 09:18:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T218a0d8b70d1a53d
Date: Tue, 25 Mar 2025 14:17:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Zijlstra" <peterz@infradead.org>, guoren <guoren@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Anup Patel" <anup@brainfault.org>,
 "Atish Patra" <atishp@atishpatra.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Kees Cook" <kees@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Eric Dumazet" <edumazet@google.com>,
 "Chen Wang" <unicorn_wang@outlook.com>,
 "Inochi Amaoto" <inochiama@outlook.com>, gaohan@iscas.ac.cn,
 shihua@iscas.ac.cn, jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn,
 "Drew Fustini" <drew@pdp7.com>, "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 ctsai390@andestech.com, wefu@redhat.com,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Josef Bacik" <josef@toxicpanda.com>, "David Sterba" <dsterba@suse.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>, qingfang.deng@siflower.com.cn,
 "Leonardo Bras" <leobras@redhat.com>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "Conor.Dooley" <conor.dooley@microchip.com>,
 "Samuel Holland" <samuel.holland@sifive.com>, yongxuan.wang@sifive.com,
 "Xu Lu" <luxu.kernel@bytedance.com>,
 "David Hildenbrand" <david@redhat.com>,
 "Ruan Jinjie" <ruanjinjie@huawei.com>,
 "Yunhui Cui" <cuiyunhui@bytedance.com>,
 "Kefeng Wang" <wangkefeng.wang@huawei.com>, qiaozhe@iscas.ac.cn,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, maple-tree@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Message-Id: <db3c9923-8800-4ed3-a352-4ee9ef79c0b7@app.fastmail.com>
In-Reply-To: <20250325122640.GK36322@noisy.programming.kicks-ass.net>
References: <20250325121624.523258-1-guoren@kernel.org>
 <20250325122640.GK36322@noisy.programming.kicks-ass.net>
Subject: Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT kernel-self with
 ILP32 ABI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 25, 2025, at 13:26, Peter Zijlstra wrote:
> On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
>> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>> 
>> Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
>> but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
>
> Please, don't do this. This adds a significant maintenance burden on all
> of us.

It would be easier to this with CONFIG_64BIT disabled and continue
treating CONFIG_64BIT to be the same as BITS_PER_LONG=64, but I still
think it's fundamentally a bad idea to support this in mainline
kernels in any variation, other than supporting regular 32-bit
compat mode tasks on a regular 64-bit kernel.

>> The patchset targets RISC-V and is built on the RV64ILP32 ABI, which
>> was introduced into RISC-V's psABI in January 2025 [1]. This patchset
>> equips an rv64ilp32-abi kernel with all the functionalities of a
>> traditional lp64-abi kernel, yet restricts the address space to 2GiB.
>> Hence, the rv64ilp32-abi kernel simultaneously supports lp64-abi
>> userspace and ilp32-abi (compat) userspace, the same as the
>> traditional lp64-abi kernel.

You declare the syscall ABI to be the native 64-bit ABI, but this
is fundamentally not true because a many uapi structures are
defined in terms of 'long' or pointer values, in particular in
the ioctl call. This might work for an rv64ilp32 userspace that
uses the same headers and the same types, but you explicitly
say that the goal is to run native rv64 or compat rv32 tasks,
not rv64ilp32 (thanks!).

As far as I can tell, there is no way to rectify this design flaw
other than to drop support for 64-bit userspace and only support
regular rv32 userspace. I'm also skeptical that supporting rv64
userspace helps in practice other than for testing, since
generally most memory overhead is in userspace rather than the
kernel, and there is much more to gain from shrinking the larger
userspace by running rv32 compat mode binaries on a 64-bit kernel
than the other way round.

If you remove the CONFIG_64BIT changes that Peter mentioned and
the support for ilp64 userland from your series, you end up
with a kernel that is very similar to a native rv32 kernel
but executes as rv64ilp32 and runs rv32 userspace. I don't have
any objections to that approach, and the same thing has come
up on arm64 as a possible idea as well, but I don't know if
that actually brings any notable advantage over an rv32 kernel.

Are there CPUs that can run rv64 kernels and rv32 userspace
but not rv32 kernels, similar to what we have on Arm Cortex-A76
and Cortex-A510?

       Arnd

