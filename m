Return-Path: <linux-fsdevel+bounces-45063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A2A710D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 07:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E7B7A4D7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6728F19CC28;
	Wed, 26 Mar 2025 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RfzR1uEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYnqao2r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83704A29;
	Wed, 26 Mar 2025 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972186; cv=none; b=eVgwYbyzVaKqByt6dsOo2RFAw0OJUvB1JB+rxA3CBUIllQG0PI4rBzapVkjgu6K+r5ZiXlwhWHADjvsjXw95lji4jhZCuoQo+K7gRdUbwWeCChlftQURQ+a7ync5+1bcDOTaX2ze0ZH5ZVVDPV9+kJ3du/rxGQkFPGbDbnVJTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972186; c=relaxed/simple;
	bh=ZcAFJrQbbKIem4eNtWw3oLhqPmvDEs7Nba9AnPq9pQY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gc7j2SLq44o9/Ksni6hb54uUo1It6zn1urKbIjLZrPUiIHFiueXftOmT6ABhkfO6S11XpwmTXWJhwyYk6CvyXNjajnodLISIxV0CM70aA+6/tj/xOnslhvkOttFHLIjEkE8/JxoJ6GuzUYDHcacVm/QcgXWjfd8duPWM8uOcBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RfzR1uEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYnqao2r; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 1DE6A1D414F3;
	Wed, 26 Mar 2025 02:56:21 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 02:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742972180;
	 x=1742979380; bh=ECmdnGpGt7R784A69CvkoNMp+aXiuLAMl/bxf3OLtmI=; b=
	RfzR1uEnzuIhYupQbRLI+t6oD3s5flwg37XUBK1TKTl7jUzDLK53c269/4po+kWE
	T6qwedPUcgiN2GV+jWlQJ5lajxSVtI9ACkVCTV4sHtzhp0xkVuOIxEao3qH87ENC
	kVg9hTNedZNDfzUbSAuNT7mcFz0h5QO8ykZym3mRFDAFqKLTqloW33OahrucaK+b
	P3LrHLXJKyiFe6tn7RboE7xMbRj85ez+WILF2Qs6B4i6jZFiWu9JPcZK/6gbLj03
	c4xQhgU0ZFxWSyOjDy3ba2ofduCyAHN7FWLBP2Q4XhHYaOOcRmSl1AuJhJWnxOQK
	27dpe9yy8fAecOL+iMZPcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742972180; x=
	1742979380; bh=ECmdnGpGt7R784A69CvkoNMp+aXiuLAMl/bxf3OLtmI=; b=g
	Ynqao2rMNXNJWY51guszo0nI0tNF47omPFyN1uI7U4D+iD7kLt7kFBDCjKeE55sZ
	gBca+k+hzsx1OnS77ApTw+K2kJllSfqWkSAhiRvax9sXj6q+MAkhvAkyU4zOzzmZ
	I3rtMPo41pI86aZlACoC1a0HH9j/UmCqQlcH0mo7n588xEKa13NNdqcWw5KbcBJ3
	zy0Zfiz28FcL2jNzEd5A/teVhLgIz1MX2ZIkED3an241RCIt7rtO++A2dEk/V6nh
	ijGIZ2f1Mw7v3ksd/5HFlc+qg0puMl/6G62vIZGE37II+E+lNHMtf4jwtV9XfRTA
	yczIABDyB67Rl5wWM9TXg==
X-ME-Sender: <xms:FKXjZ47JqwKD1MMrx_9I06vXKPEfU2tweDnovrjptC1d9dD1GDyAIw>
    <xme:FKXjZ56BGLV-HkBA5qzXgicwMiP5GSS5I5PXkjP5GUBpEbgIdrbpVEA0zl_Szlmde
    vYwckN0l7pLjbv5krg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegohfhorhgsihguuggvnhffohhmrghinhculdehtddtmden
    ucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrh
    hnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrght
    thgvrhhnpeffffeghffftdejvddutefhfeetiedthfegfeekheekhfejvefhleejhedvke
    ehteenucffohhmrghinhepgihrvhhmrdgtohhmnecuhfhorhgsihguuggvnhffohhmrghi
    nhepgihrvhhmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopeihohhnghiguhgrnhdrfigrnhhgsehsih
    hfihhvvgdrtghomhdprhgtphhtthhopehqihhnghhfrghnghdruggvnhhgsehsihhflhho
    figvrhdrtghomhdrtghnpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtohhmpd
    hrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohep
    sghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvhhmsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FKXjZ3d865jUDOU_P3FqbCph211xhmVC-jXyhH2KvvXElZTeQSCrgA>
    <xmx:FKXjZ9JUruLpX2ktbpsTrhMOW6uVWlJG98VBhg4xjYQ7DuQLuO7Xew>
    <xmx:FKXjZ8KNSq7i3QUHAn7c2JfEirLmIp-ywXOibEmSzqsyHEY4iBPGiA>
    <xmx:FKXjZ-xD2Zzof1B-aLRUAWZXdTsQSFSDERd7iaO-s9v57_uaLtvrLg>
    <xmx:FKXjZ1d3DtOU1G9qLwQ1zQD4PKXh2AexxJg74oQHx5WEvNy6MmnL8Dh->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DB88E2220072; Wed, 26 Mar 2025 02:56:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T218a0d8b70d1a53d
Date: Wed, 26 Mar 2025 07:55:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: guoren <guoren@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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
Message-Id: <a9dddc3d-d03d-4614-9d55-1ce48c6ad5ef@app.fastmail.com>
In-Reply-To: 
 <CAJF2gTSHpZMyUk+8HL0=bevCd4XZYRAkrPM600qLPCKxG+bfrg@mail.gmail.com>
References: <20250325121624.523258-1-guoren@kernel.org>
 <20250325122640.GK36322@noisy.programming.kicks-ass.net>
 <db3c9923-8800-4ed3-a352-4ee9ef79c0b7@app.fastmail.com>
 <CAJF2gTSHpZMyUk+8HL0=bevCd4XZYRAkrPM600qLPCKxG+bfrg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT kernel-self with
 ILP32 ABI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025, at 07:07, Guo Ren wrote:
> On Tue, Mar 25, 2025 at 9:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Tue, Mar 25, 2025, at 13:26, Peter Zijlstra wrote:
>> > On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
>>
>> You declare the syscall ABI to be the native 64-bit ABI, but this
>> is fundamentally not true because a many uapi structures are
>> defined in terms of 'long' or pointer values, in particular in
>> the ioctl call.
>
> I modified uapi with
> void __user *msg_name;
> ->
> union {void __user *msg_name; u64 __msg_name;};
> to make native 64-bit ABI.
>
> I would look at compat stuff instead of using __riscv_xlen macro.

The problem I see here is that there are many more drivers
that you did not modify than drivers that you did change this
way.  The union is particularly ugly, but even if you find
a nicer method of doing this, you now also put the burden
on future driver writers to do this right for your platform.

>> As far as I can tell, there is no way to rectify this design flaw
>> other than to drop support for 64-bit userspace and only support
>> regular rv32 userspace. I'm also skeptical that supporting rv64
>> userspace helps in practice other than for testing, since
>> generally most memory overhead is in userspace rather than the
>> kernel, and there is much more to gain from shrinking the larger
>> userspace by running rv32 compat mode binaries on a 64-bit kernel
>> than the other way round.
>
> The lp64-abi userspace rootfs works fine in this patch set, which
> proves the technique is valid. But the modification on uapi is raw,
> and I'm looking at compat stuff.

There is a big difference between making it work for a particular
set of userspace binaries and making it correct for the entire
kernel ABI.

I agree that limiting the hacks to the compat side while keeping
the native ABI as ilp32 as in your previous versions is better,
but I also don't think this can be easily done without major
changes to how compat mode works in general, and that still
seems like a show-stopper for two reasons:

- it still puts the burden on driver writers to get it right
  for your platform. The scope is a bit smaller than in the
  current version because that would be limited to the compat
  handlers and not change the native codepath, but that's
  still a lot of drivers.

- the way that I would imagine this to be implemented in
  practice would require changing the compat code in a way that
  allows multiple compat ABIs, so drivers can separate the
  normal 32-on-64 handling from the 64-on-32 version you need.
  We have discussed something like this in the past, but Linus
  has already made it very clear that he doesn't want it done
  that way. Whichever way you do it, this is unlikely to
  find consensus. =20

> Supporting lp64-abi userspace is essential because riscv lp64-abi and
> ilp32-abi userspace are hybrid deployments when the target is
> ilp32-abi userspace. The lp64-abi provides a good supplement to
> ilp32-abi which eases the development.

I'm not following here, please clarify. I do understand that
having a mixed 32/64 userspace can help for development, but
that can already be done on a 64-bit kernel and it doesn't
seem to be useful for deployment because having two sets of
support libraries makes this counterproductive for the goal
of saving RAM.

>> If you remove the CONFIG_64BIT changes that Peter mentioned and
>> the support for ilp64 userland from your series, you end up
>> with a kernel that is very similar to a native rv32 kernel
>> but executes as rv64ilp32 and runs rv32 userspace. I don't have
>> any objections to that approach, and the same thing has come
>> up on arm64 as a possible idea as well, but I don't know if
>> that actually brings any notable advantage over an rv32 kernel.
>>
>> Are there CPUs that can run rv64 kernels and rv32 userspace
>> but not rv32 kernels, similar to what we have on Arm Cortex-A76
>> and Cortex-A510?
>
> Yes, there is, and it only supports rv32 userspace, not rv32 kernel.
> https://www.xrvm.com/product/xuantie/C908

Ok, thanks for the link.

       Arnd

