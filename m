Return-Path: <linux-fsdevel+bounces-22907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC0691ECAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 03:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AD01F2216E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 01:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BCFB646;
	Tue,  2 Jul 2024 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="d9QnsHRa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E549Q6QP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA8C121;
	Tue,  2 Jul 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719883801; cv=none; b=U0OxkMXA9ttMXcE4XZRQkKrruNUqwYWR9b9PfYnFy6WUXCqDFobUCIgE04ztLioLqBNrzS1DBJkq9yXKUhOHrZ3rJK66UW8MOST6R6l2UCqAqW0ZkBRUNt53vpXb9D+RhGlPGOmP5AEQbqzPVLUFKijC1dMvzHDWynSdZvRMlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719883801; c=relaxed/simple;
	bh=1+lY2UBo6IQeJ1eM8Y06KY0leWrZmPqY8xqqXGMD1mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmQ4dw/EQtcVGvaS04x67tkC9faus33n9WGrKcUM6BTFCP6FfvQZD12qGJ7hbkrLNuTgca3E35RyP0mwWdeoz7HGMmE18/jcqCJdScj9SWRJU37lQUfSf09tTE9QGLBGmgj+GFQ6Llkd255c1DsapMTIptP9bD+oUxNXudGAZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=d9QnsHRa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E549Q6QP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6A6691380491;
	Mon,  1 Jul 2024 21:29:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Jul 2024 21:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1719883798;
	 x=1719970198; bh=Vj7hXbA5EXOHGtTKBD9XCM7X1fvtRXycKWYHdAjZ5to=; b=
	d9QnsHRaFheGR91ifU0u0TqrdbUX0YRTScHkNFFEam0DRSUrYqwhpimnPQu4r6ZY
	ZFfEj/6JLZzeagSu9zxIHPiLPTitpHQW4KNkF/rOdfrjDxVj0FoSwQ+gbC9oD2/L
	fMc4Im/R/1gp957t6y6kHEUgLyGU/YLUjP4tYp9fnaO/nXoBdfDAwRQs43lJCq5O
	X/RVwn2m12rKkM4dS+KApC6IsLv+eT1vR2xC5IJuc/0bdujngUByztVD0Ov5sK0c
	4rsQwnLc17H0CWNFfK9GfpaRzZyz5mBjqf6YP/Y7K0amQbh4CALZtSupmnTnJ2KV
	G4i7vYJIin7g2yNdWlBnzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719883798; x=
	1719970198; bh=Vj7hXbA5EXOHGtTKBD9XCM7X1fvtRXycKWYHdAjZ5to=; b=E
	549Q6QP66I4AWpF3pztG+fo8Whei/aTmTecTcdSZ2ODOjNYFhMlbPy/weKDSlcca
	ke5+oFN+ApP0R2x+1dZKCH0Kurw0pG9SbWoaSwnXKgSXyazacw4RV4Lvj0gecKQQ
	c02Y/uLmu+Z5Vcd32F8iDqw6EgdLOcw+ea8CPAgrwAsxb0tLPy5skOa+f6sLcSxc
	6ZZcRAxTQVtW2i+b3UmOT2Y0kk+fScAv4f6o2H1T//cR1kPLUtQwv7LvcUKjUlkn
	GRNziB031NKnDjrAWrcrIm+xUmGvM3o82o3vHD8/uIUg9zEjrXItmgvNqDRC6t4H
	mwxcz0j8OEyH/6X6YQmGA==
X-ME-Sender: <xms:FViDZjihiMN_0KBJuIVInG8-UR7htA2NJCbAsOhOfpizp8dPtzfjeQ>
    <xme:FViDZgARm3myN2hlxhn2R6B0BUD-zO5D2OcrQVYctY90pX80tMNdmHs8nxqTn1gxk
    RLZqSPmXzQR>
X-ME-Received: <xmr:FViDZjGVrLvnscDPglFFf5yQ5LZVAZs95_izRijtrMNBlTsRF2cbWCqUbvvp_V81x2qEpeptUbysQ7_RvfgV0VejH2eoF7-IB-M81UyzPhs7TsJLQBWOANw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    efkefhgeeigeetleffgeelteejkeduvdfhheejhfehueeitdehuefhkeeukeffheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:FViDZgT4lEKm7WICRi0Nr71Dv_Sc8FCMEa_gpp3DPAbhBYsXfo7YQA>
    <xmx:FViDZgz2NIi5De7v7ZnWiSG4kZOjYh-shoUMBF4cHq24F-R-KdYtjg>
    <xmx:FViDZm4nkk-bp-ezlB-rfEWueK-PKvErRWpej52PNna94j-HBhoSwA>
    <xmx:FViDZlwvrWB9_Bqjv6ZTFGhfuiWur8NpIJBTolm9b2GPTX-PlGUnRg>
    <xmx:FliDZschqBClTro6TWy154EAGk7zkUAfoFgRV0jF0JuqM5YSDcVKaIpA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jul 2024 21:29:53 -0400 (EDT)
Message-ID: <312e4e43-886c-42ab-abfb-3388d9380f6e@themaw.net>
Date: Tue, 2 Jul 2024 09:29:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>, Ian Kent <ikent@redhat.com>
Cc: Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Lucas Karpinski <lkarpins@redhat.com>,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com>
 <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com>
 <20240701-zauber-holst-1ad7cadb02f9@brauner>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20240701-zauber-holst-1ad7cadb02f9@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/24 13:50, Christian Brauner wrote:
>> I always thought the rcu delay was to ensure concurrent path walks "see" the
>>
>> umount not to ensure correct operation of the following mntput()(s).
>>
>>
>> Isn't the sequence of operations roughly, resolve path, lock, deatch,
>> release
>>
>> lock, rcu wait, mntput() subordinate mounts, put path.

Sorry but I'm still having trouble understanding the role of the rcu wait.


> The crucial bit is really that synchronize_rcu_expedited() ensures that
> the final mntput() won't happen until path walk leaves RCU mode.

Sure, that's easily seen, even for me, but the rcu read lock is held for

the duration of the rcu walk and not released until leaving rcu walk more

and, on fail, switches to ref walk mode and restarts. So the mount struct

won't be freed from under the process in rcu walk mode, correct?


>
> This allows caller's like legitimize_mnt() which are called with only
> the RCU read-lock during lazy path walk to simple check for
> MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> be freed until an RCU grace period is up and so they know that they can
> simply put the reference count they took _without having to actually
> call mntput()_.
>
> Because if they did have to call mntput() they might end up shutting the
> filesystem down instead of umount() and that will cause said EBUSY
> errors I mentioned in my earlier mails.

Again, I get this too, but where is the need for the rcu wait in this?


Originally I had the notion that it was to ensure any path walkers had seen

the mount become invalid before tearing down things that enable the 
detection

but suddenly I don't get that any more ...


Please help me out here, I just don't get the need (and I'm sure there is

one) for the rcu wait.


Ian

>
>>
>> So the mount gets detached in the critical section, then we wait followed by
>>
>> the mntput()(s). The catch is that not waiting might increase the likelyhood
>>
>> that concurrent path walks don't see the umount (so that possibly the umount
>>
>> goes away before the walks see the umount) but I'm not certain. What looks
>> to
>>
>> be as much of a problem is mntput() racing with a concurrent mount beacase
>> while
>>
>> the detach is done in the critical section the super block instance list
>> deletion
>>
>> is not and the wait will make the race possibility more likely. What's more
> Concurrent mounters of the same filesystem will wait for each other via
> grab_super(). That has it's own logic based on sb->s_active which goes
> to zero when all mounts are gone.
>
>> mntput() delegates the mount cleanup (which deletes the list instance) to a
>>
>> workqueue job so this can also occur serially in a following mount command.
> No, that only happens when it's a kthread. Regular umount() call goes
> via task work which finishes before the caller returns to userspace
> (same as closing files work).
>
>>
>> In fact I might have seen exactly this behavior in a recent xfs-tests run
>> where I
>>
>> was puzzled to see occasional EBUSY return on mounting of mounts that should
>> not
>>
>> have been in use following their umount.
> That's usually very much other bugs. See commit 2ae4db5647d8 ("fs: don't
> misleadingly warn during thaw operations") in vfs.fixes for example.
>
>>
>> So I think there are problems here but I don't think the removal of the wait
>> for
>>
>> lazy umount is the worst of it.
>>
>>
>> The question then becomes, to start with, how do we resolve this unjustified
>> EBUSY
>>
>> return. Perhaps a completion (used between the umount and mount system
>> calls) would
>>
>> work well here?
> Again, this already exists deeper down the stack...

