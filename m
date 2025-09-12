Return-Path: <linux-fsdevel+bounces-61081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCBEB54E0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7433BAC038D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB430C614;
	Fri, 12 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Bb61dM/e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmApKfXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC13064AE;
	Fri, 12 Sep 2025 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680149; cv=none; b=jPKmb9TQT0/vA9ykbbq4zbJAjZUr4kjbKkjKjk+Uk1uEqE3F6hiAUIi+bUciHC4zrO26ouxxp9oR+pWyG4opz7RZhzzkZ9fHMvcbBLYzkVrG/1a0yRx0T5w7YUSA5JI50W3ZcNwpYH47HRnAdP9u+jvPmLdQIoJ0nWEMqTtTQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680149; c=relaxed/simple;
	bh=0KY4CmUCaxpsALU8LxCLml3ocb24U73WUWj+gvADy3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mafZmJ4emG6BnZNl/NeKVm87CNXqB2sonhgTTMHhFj8TGmlEA3NCMRP8MdvWMe4L55C4umj7NbZdYlHQgvzxvGCEndYny3ziEYSt5r8CtXyijHnnSLcOMy8Pak8uLciDpIObJ9jpOm+MCojH0/w14eBtIUz0oM0gH801IJsULI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Bb61dM/e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmApKfXi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 132EF14003CF;
	Fri, 12 Sep 2025 08:29:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Sep 2025 08:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757680146;
	 x=1757766546; bh=+EuBTtxheLs6YMQiQHMhbhJYRJOzaO/5/ZkBd7bqUGw=; b=
	Bb61dM/e7R9qEoerttMFDeG7k1uNgJt8LLJ8DCguRpIDwBTMWEEjg0BCEK1DXOoE
	Ee5Sbyp+tOf/IvPTNKt0lhwe68rlL9tvV7Hv8wrNvA/3w3p4Rb8Dl5OdDzEElJKY
	B6oZXBnTB834Ev7JKnMOwJutbi/2yL5gomdN2aicv49T/RxCZKWY6LiuBdwLi6n6
	oCZ+fFG1u7gvlAVcFc0QZ2BujgFJs13oQJ0hOO3Rn7SX3RiP2zd6YrdnNrKafJ0z
	opUOc3QrmjRNPjOvnQ+GoygpujQgpjMGvGA/DrMWtQ6Uhv+LZFDnyK8hweCs5oZb
	6rjcc3U9/9ab2y6v1XcxTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757680146; x=
	1757766546; bh=+EuBTtxheLs6YMQiQHMhbhJYRJOzaO/5/ZkBd7bqUGw=; b=W
	mApKfXiQgeL3XmYmDdMdOylBHWvk/UnHbqlXY9QwE8gercTylVV1/Axgz7ne4iBq
	ByemZ82QafevwmA79UFjv/WBAfsTo5D5Sn3Z8R5EcIWtERseR98+ZsmPcJHrksq7
	5XxqeFwRjCxxeDqnuTx6iaqEaylVkHnvSKth2NSHKILaLsgH18rnR7vVfjGG3lOr
	8vNkYyacHXupYYifsrcpelcOJoh/OKqGT7u2ivxq0n3aMkgd3xuCFklLJy6sS47t
	6Y+gKs0TTGdapt7Mas2eRy1yNfJboUxYlpcR+focFrk4FivMvQaLtNZI86EEVTy0
	uLPrWrovlm86p0AuSRIOg==
X-ME-Sender: <xms:ERLEaCusQqJZezTbNG5Z9cweOnqPzHLvPXeKnDiq8WW3QAmFhgUnAQ>
    <xme:ERLEaCEgNoCkdoJ1oq2nvbEytNzPnOMBDQgLwzoTWTRuDdWC3P_xjatpsU_xRzSVP
    s28N5KMAIvd-Xiv>
X-ME-Received: <xmr:ERLEaDwK94VCz12iBj50xIvmtTZW3Q2462KS-xwxCTjxDqx1JT9nzYDnfQugQ8y8_LQrFLm9SGENZjdwtPi_R52nccEJ67jIzlGtfdOCtYlE3SQLX_0F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvledthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeuvdeuudeltddukefhueeludduieejvdevveevteduvdefuedvkeffjeel
    ueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmh
    hirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehluhhishesihhgrghlihgr
    rdgtohhmpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehthihtshhosehmihhtrdgvughupdhrtghpthhtohepmhhikhhlohhssehsiigvrhgv
    ughirdhhuhdprhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehktghhvghnseguughnrdgtohhm
X-ME-Proxy: <xmx:ERLEaM0_uD09J-uTkc-FuwabqZ2xhoN69wBi67DZ9AM0fmg9a-_rgw>
    <xmx:ERLEaDo_jd-wvWAJztm8gjNE82oG2W4oCieKTVBXPAx4kPwEcDEz6g>
    <xmx:ERLEaJVAEB8K7Z2jDTEA2sAgCE-D0GRRizg4IeV1ApSF2zSQcy0nzA>
    <xmx:ERLEaMpewsONL1PLZo4N2stxKAIX8kEmCRaPp07pvfAwYAwph48vjQ>
    <xmx:EhLEaDclqWDd0bsKhD65CGS4JgX4PEHJiTwsgHOJtsqF5qJafqmKyTXc>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 08:29:04 -0400 (EDT)
Message-ID: <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
Date: Fri, 12 Sep 2025 14:29:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs> <20250731130458.GE273706@mit.edu>
 <20250731173858.GE2672029@frogsfrogsfrogs> <8734abgxfl.fsf@igalia.com>
 <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/12/25 13:41, Amir Goldstein wrote:
> On Fri, Sep 12, 2025 at 12:31 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 8/1/25 12:15, Luis Henriques wrote:
>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
>>>
>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
>>>>>>
>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
>>>>>> could restart itself.  It's unclear if doing so will actually enable us
>>>>>> to clear the condition that caused the failure in the first place, but I
>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>>>>>> aren't totally crazy.
>>>>>
>>>>> I'm trying to understand what the failure scenario is here.  Is this
>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
>>>>> is supposed to happen with respect to open files, metadata and data
>>>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
>>>>> e2fsck -fy, but if there are dirty inode on the system, that's going
>>>>> potentally to be out of sync, right?
>>>>>
>>>>> What are the recovery semantics that we hope to be able to provide?
>>>>
>>>> <echoing what we said on the ext4 call this morning>
>>>>
>>>> With iomap, most of the dirty state is in the kernel, so I think the new
>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
>>>> would initiate GETATTR requests on all the cached inodes to validate
>>>> that they still exist; and then resend all the unacknowledged requests
>>>> that were pending at the time.  It might be the case that you have to
>>>> that in the reverse order; I only know enough about the design of fuse
>>>> to suspect that to be true.
>>>>
>>>> Anyhow once those are complete, I think we can resume operations with
>>>> the surviving inodes.  The ones that fail the GETATTR revalidation are
>>>> fuse_make_bad'd, which effectively revokes them.
>>>
>>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
>>> but probably GETATTR is a better option.
>>>
>>> So, are you currently working on any of this?  Are you implementing this
>>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
>>> look at fuse2fs too.
>>
>> Sorry for joining the discussion late, I was totally occupied, day and
>> night. Added Kevin to CC, who is going to work on recovery on our
>> DDN side.
>>
>> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
>> server restart we want kernel to recover inodes and their lookup count.
>> Now inode recovery might be hard, because we currently only have a
>> 64-bit node-id - which is used my most fuse application as memory
>> pointer.
>>
>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
>> outstanding requests. And that ends up in most cases in sending requests
>> with invalid node-IDs, that are casted and might provoke random memory
>> access on restart. Kind of the same issue why fuse nfs export or
>> open_by_handle_at doesn't work well right now.
>>
>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
>> would not return a 64-bit node ID, but a max 128 byte file handle.
>> And then FUSE_REVALIDATE_FH on server restart.
>> The file handles could be stored into the fuse inode and also used for
>> NFS export.
>>
>> I *think* Amir had a similar idea, but I don't find the link quickly.
>> Adding Amir to CC.
> 
> Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/

Thanks for the reference Amir! I even had been in that thread.

> 
>>
>> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
>> will iterate over all superblock inodes and mark them with fuse_make_bad.
>> Any objections against that?
> 
> IDK, it seems much more ugly than implementing LOOKUP_HANDLE
> and I am not sure that LOOKUP_HANDLE is that hard to implement, when
> comparing to this alternative.
> 
> I mean a restartable server is going to be a new implementation anyway, right?
> So it makes sense to start with a cleaner and more adequate protocol,
> does it not?

Definitely, if we agree on the approach on LOOKUP_HANDLE and using it
for recovery, adding that op seems simple. And reading through the
thread you had posted above, just the implementation was missing.
So let's go ahead to do this approach.


Thanks,
Bernd




