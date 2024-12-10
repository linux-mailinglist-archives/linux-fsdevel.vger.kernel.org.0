Return-Path: <linux-fsdevel+bounces-36989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B99EBB83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 22:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927451886ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA8230268;
	Tue, 10 Dec 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="GROLPSc8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hwd8Cny9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBB23025D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864839; cv=none; b=gWE8KDY4Hl0ifc9ZfAvFqlFyWk/sIDa5AgfKiZSDVpu9PvFphtWquNDysyXpb3+FzE1aTwOHjCyAehMQVydJHE6ezb3tkE0Fv+siQQHuxHeGZWKoHjuSmg7CTeqZMn5JIXEoZ3CWiYeIV3IYyW0K+DQbkPHRxyT03CzZCtX1m0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864839; c=relaxed/simple;
	bh=j7rSrmHi6FegCueQJjZ5w0gsyiAtIHR7CGuUgS9rnq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8tDWx7jm9KXyZ6YRADcfyK0vHDBweOvwuSBaJQPj84sTsKI5SGchKGF8cSPE6gyvaEFR4mkPToIqv+SAH/9Q975v9A/nh7ZRM+5JIJDCajLhJLTCtUhKpkV/iQKmtTvTOMZIH71DXzuEP0DSMMrXu2AV9nQeN4Ksu6nbQjyMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=GROLPSc8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hwd8Cny9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B0701384162;
	Tue, 10 Dec 2024 16:07:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Dec 2024 16:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733864836;
	 x=1733951236; bh=maM8VcKcBcgyaEBNSUKqG+1xCg8Ks7oTDeKmI5zAa+Q=; b=
	GROLPSc8vTQlCTKXyB9RM999pAFo4W5uPCowrOuZGGXEaO4QMfbq6188p+ffN4kK
	Glkefx+9fUShnAg7UqpW4fC2BzGqyICHcYo3mRjbd4V7URodN1xYVHcMWg76GJFn
	JLZIdJsiuewLqJOr20NvAUpaHJha+88fY/+tfvGEihYduGXFe15YYnzjsfTTZLAO
	vgQbXU9XLKhANTwYJH8K75H4Gw6S6e9JFU+38FCwxcJhdNqAgnvyy3RFPEtz0c6u
	PU9qYImVm3DdGg66T6HiRZk4LOnYoHhv2VPffA/x+WGS+h0W8ByqnXT6+5RanJL4
	IYxb29hjagL0A7JdPUtVlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733864836; x=
	1733951236; bh=maM8VcKcBcgyaEBNSUKqG+1xCg8Ks7oTDeKmI5zAa+Q=; b=h
	wd8Cny9pvfaDkKi2yEU/ofqnMAfhBbYDForHPZOvVslSj8ql4ZsSLHCBzo3brf/e
	vbMDVSp48N5b9sbWme2Uj8XR1UMjmIZCtXUCJJJxpb0moXh4wfM4NT0KJRJbpp1T
	gP4/AwkEGq1Vah59SlNdAyAvfHjsfXm5kGpmfYBPZqJ9Nbq87216LTy1viXl93Pl
	4lQ1duEO1DZd4fD2n1/n8kzhZC2z21JRSKe0kWzS7LBEDVOEKFMBOiiNhaevwi4+
	3nPddjFW3CYECbFoyKZ7hChBTbA5YkkVP2yBbFktpOnchRE9Oz5rHVUKg/3qujeM
	GEPmH15mmMaDcyUug7uxA==
X-ME-Sender: <xms:gq1YZ4F9DmtG99PYH7vNWz3SrC9wPuh875xMQCthzUaNAazbOJiHyw>
    <xme:gq1YZxVyz3KKhpHy9JVgP2hcBOMQ3gXUQS5g1ZUiuD14FaejKAtxaYsCABGNCMFWC
    aHRediLlZraZq9g>
X-ME-Received: <xmr:gq1YZyLJjptiMNT9ACNZWAMErUoYfdpYpmLr_jXatAoF1Ew2prPRy6H2a9pIZ03TLM_Ch2s-v25WE8SehyU9NnkeOK_KOmS0Wam9sxb3Gff5NEL_SCEv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfg
    fuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggv
    rhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtf
    frrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveejieefveeiteeggffg
    gfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghtmhgrrhhtihhnge
    efudefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvg
    guihdrhhhupdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpd
    hrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohep
    lhgrohgrrhdrshhhrghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghtmhgrrhhtih
    hnsegtihhstghordgtohhm
X-ME-Proxy: <xmx:gq1YZ6Gbu7DuDbZyJCrLlYP6fA1-nYcSU92cD2Sy37yuud2hVIOb9g>
    <xmx:gq1YZ-WtYyCKJa-ELnx-32_o_RiY8e_ZcLe6OF5sdHKBknxnm16Gkg>
    <xmx:gq1YZ9Nkr752-2pkGLYjuFx7xngsQuKM8YaE_-D5TOzwC-oBbuAtzQ>
    <xmx:gq1YZ10RZSQWMTzqLeZ7tLer6kXw89axK6CUxfmwUdMmCMUYdiakVA>
    <xmx:hK1YZyo-6rdtkDdgcu4_sJoFHWVOAj79sSuS8j0Xvse0isRw5-FXhTQa>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 16:07:13 -0500 (EST)
Message-ID: <4f524025-e64e-4d67-a0f3-20f0fa21ca1a@fastmail.fm>
Date: Tue, 10 Dec 2024 22:07:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Abort connection if FUSE server get stuck
To: etmartin4313@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 laoar.shao@gmail.com, etmartin@cisco.com
References: <20241210171621.64645-1-etmartin4313@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241210171621.64645-1-etmartin4313@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/10/24 18:16, etmartin4313@gmail.com wrote:
> From: Etienne Martineau <etmartin4313@gmail.com>
> 
> This patch abort connection if HUNG_TASK_PANIC is set and a FUSE server
> is getting stuck for too long.
> 
> Without this patch, an unresponsive / buggy / malicious FUSE server can
> leave the clients in D state for a long period of time and on system where
> HUNG_TASK_PANIC is set, trigger a catastrophic reload.
> 
> So, if HUNG_TASK_PANIC checking is enabled, we should wake up periodically
> to abort connections that exceed the timeout value which is define to be
> half the HUNG_TASK_TIMEOUT period, which keeps overhead low.
> 
> This patch introduce a list of request waiting for answer that is time
> sorted to minimize the overhead.
> 
> When HUNG_TASK_PANIC is enable there is a timeout check per connection
> that is running at low frequency only if there are active FUSE request
> pending.
> 
> A FUSE client can get into D state as such ( see below Scenario #1 / #2 )
>  1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
>     OR
>  2) request_wait_answer() -> wait_event_(interruptible / killable) is head
>     of line blocking for subsequent clients accessing the same file


I don't think that will help you for fuse background requests.

[422820.431981] INFO: task dd:1590644 blocked for more than 120 seconds.
[422820.436556]       Not tainted 6.13.0-rc1+ #92
[422820.439189] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[422820.446822] task:dd              state:D stack:27440 pid:1590644 tgid:1590644 ppid:1590478 flags:0x00000002
[422820.456782] Call Trace:
[422820.459467]  <TASK>
[422820.461667]  __schedule+0x1b42/0x25b0
[422820.465312]  schedule+0xb5/0x260
[422820.468568]  schedule_preempt_disabled+0x19/0x30
[422820.473033]  rwsem_down_write_slowpath+0x8a6/0x12b0
[422820.477644]  ? generic_file_write_iter+0x82/0x240
[422820.481774]  down_write+0x16f/0x1a0
[422820.486756]  generic_file_write_iter+0x82/0x240
[422820.490412]  ? fuse_file_read_iter+0x490/0x490 [fuse]
[422820.493021]  vfs_write+0x7c8/0xb70
[422820.494389]  ? fuse_file_read_iter+0x490/0x490 [fuse]
[422820.497003]  ksys_write+0xce/0x170
[422820.500110]  do_syscall_64+0x81/0x120
[422820.502941]  ? irqentry_exit_to_user_mode+0x133/0x180
[422820.505504]  entry_SYSCALL_64_after_hwframe+0x4b/0x53


Joannes timeout patches are more generic and handle these as well.


Thanks,
Bernd

