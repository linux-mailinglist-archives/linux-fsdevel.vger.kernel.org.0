Return-Path: <linux-fsdevel+bounces-61033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A1B549DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC211CC094C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786EA2EA73B;
	Fri, 12 Sep 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="d8Gg1SEN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MspK7O2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0A2EB852;
	Fri, 12 Sep 2025 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673094; cv=none; b=Gkk5262BBEes+tmGL92QflAZUPRy8jLyBoVzSlVm8KikjA+4IzodCFTU0WzUXDitkzfwNybGgkAglrktq7bntMVa1pQkGR08uvZ+SITDfMYmcYUTzss4U9Wvr218+hLi9cmZ6F8vN+Oalhv82utyobBUMljiuX+vtFeV78cWqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673094; c=relaxed/simple;
	bh=mi/aFgXjgNLAiM0nHg6PsOIfbdDRcx3f1vhDiQnVFEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQo/CrEM67UfBWTQnJ4uDO7OHBvm2uJNJHtO8FygZX7RcmCA/eUpIQIlsySiioJvdH32FP4egGDj5zmRBP3k0Qxb8fPnqTUsXPUzKQ/IC0bV/doju0HodRsXcCe5WJuPLcNPRkcYi+Rl3veQ+kXJB7g9jZ8uitOT2SHVyl+xklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=d8Gg1SEN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MspK7O2f; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2AAE2EC0363;
	Fri, 12 Sep 2025 06:31:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Sep 2025 06:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757673080;
	 x=1757759480; bh=5qHXIO8KHSC0qbY8cmXZJOXkjQnDFnbq/6nDZAx+8Po=; b=
	d8Gg1SENbk24imdnIbyNCyn57KksngOBv6zB2p3cfb2KAvteBsrc+BznyjNLT8P5
	uNBk+SKUv1EYaWJyHkj88rhY19BkaDQAlgq+NerB3hhQr3k9r06MSYqCdYc/N/TP
	jq2vXQXs14u60Gpw6dbNexZbN3vc5vqe88zPJkpMy4UFoR0K1+D935KTe7wSIjYf
	ORQGCIeVQMmqwbZtu0s804Rusp4DMbM571RbRy/2Xv0JEcSVzRzPfNeZ9KW28XI0
	JMhVd2JqMSV2H/U3Vs+bLBXsOwMLx4McuW0wd5MQT/USuRP98zFPyoB6WrSmaD5P
	QpaLLVIQvClCbxizbwDP+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757673080; x=
	1757759480; bh=5qHXIO8KHSC0qbY8cmXZJOXkjQnDFnbq/6nDZAx+8Po=; b=M
	spK7O2fM9CarEq8I7Bt2KdqLPd12jR1jZA0D1l7temyRJSOWEbRBmnbtmc/uIQDY
	vEHTPI+ypI0RHSt7F/CoJ5Qt7cY3kEAu7h1ri+L9TDiowxtOqrvTswbAkY3wQaTN
	RoCEDhvalOipSWUMb/VK/gjRhT9Dc32bIpsAkfjwFWtRCLOgHRlxscqaURzzY/3m
	Im5K8d2/ShZdgW9/sGt2HO21mhaOSKg0V+LYDLtNnOa6k4KNY/4BuoGkq89SNUSV
	rMfbyPMxYgdOMiT6HgXOWK4Dynk74Y9lzBdyg8Q41rlPvaNspxBjux8hifWEaNTV
	MqCnhnmi1JbjMipBMLsLw==
X-ME-Sender: <xms:d_bDaLEMQemBtCm_FS2LaD7AUI5C49Km3BM7WcIIsFJlH7SU7UYeXA>
    <xme:d_bDaIwj5wRFkcdoOzXyoEcb4OW_PAwHS6nW52rWGBL9VnL8R9yTvDjTD1cSphmLZ
    Nqk5WzHrdsEsRT5>
X-ME-Received: <xmr:d_bDaN3mcLZZh0ZV1fp9wzk6-UT2qd0H3BmABI8dX_Lmlp2NQCCN3vBVGHsmTIxq_5R6RxBGxpa4kMSJKxJFCzmghMlP3kU5uc5KGKCNKN9FkFTv04mS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomhdprhgtphhtth
    hopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthihthhsohesmhhi
    thdrvgguuhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgthhgv
    nhesuggunhdrtghomhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:d_bDaArBBA8zFiuw1CBqtCxlj1X0iyMtB5IM0KhBtGnxctJdqODr9Q>
    <xmx:d_bDaCVmU7_92oECMDEJ0xBug98yEQNoUVMCF7_KKidaaNeetm2V1w>
    <xmx:d_bDaBq92NTf5B02NYawdyg3vPEXvKRK5tHjtFRpf6hwJfsAkQT4UQ>
    <xmx:d_bDaBC4Q5Z2Xf1zJZ9cVaaVIiuOlxfXUK5LV3RSY4jaPhlO67bbnw>
    <xmx:ePbDaOcHAu91hU1Soo7aA7Q-ChmRb93E-H4hOO33Hz1M9L3uHRNL0M4q>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 06:31:18 -0400 (EDT)
Message-ID: <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
Date: Fri, 12 Sep 2025 12:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>,
 Amir Goldstein <amir73il@gmail.com>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs> <20250731130458.GE273706@mit.edu>
 <20250731173858.GE2672029@frogsfrogsfrogs> <8734abgxfl.fsf@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <8734abgxfl.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/1/25 12:15, Luis Henriques wrote:
> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> 
>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
>>>>
>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
>>>> could restart itself.  It's unclear if doing so will actually enable us
>>>> to clear the condition that caused the failure in the first place, but I
>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>>>> aren't totally crazy.
>>>
>>> I'm trying to understand what the failure scenario is here.  Is this
>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
>>> is supposed to happen with respect to open files, metadata and data
>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
>>> e2fsck -fy, but if there are dirty inode on the system, that's going
>>> potentally to be out of sync, right?
>>>
>>> What are the recovery semantics that we hope to be able to provide?
>>
>> <echoing what we said on the ext4 call this morning>
>>
>> With iomap, most of the dirty state is in the kernel, so I think the new
>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
>> would initiate GETATTR requests on all the cached inodes to validate
>> that they still exist; and then resend all the unacknowledged requests
>> that were pending at the time.  It might be the case that you have to
>> that in the reverse order; I only know enough about the design of fuse
>> to suspect that to be true.
>>
>> Anyhow once those are complete, I think we can resume operations with
>> the surviving inodes.  The ones that fail the GETATTR revalidation are
>> fuse_make_bad'd, which effectively revokes them.
> 
> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
> but probably GETATTR is a better option.
> 
> So, are you currently working on any of this?  Are you implementing this
> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
> look at fuse2fs too.

Sorry for joining the discussion late, I was totally occupied, day and
night. Added Kevin to CC, who is going to work on recovery on our
DDN side.

Issue with GETATTR and LOOKUP is that they need a path, but on fuse
server restart we want kernel to recover inodes and their lookup count.
Now inode recovery might be hard, because we currently only have a 
64-bit node-id - which is used my most fuse application as memory
pointer.

As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
outstanding requests. And that ends up in most cases in sending requests
with invalid node-IDs, that are casted and might provoke random memory
access on restart. Kind of the same issue why fuse nfs export or
open_by_handle_at doesn't work well right now.

So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
would not return a 64-bit node ID, but a max 128 byte file handle.
And then FUSE_REVALIDATE_FH on server restart.
The file handles could be stored into the fuse inode and also used for
NFS export. 

I *think* Amir had a similar idea, but I don't find the link quickly.
Adding Amir to CC.

Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
will iterate over all superblock inodes and mark them with fuse_make_bad.
Any objections against that?


Thanks,
Bernd






