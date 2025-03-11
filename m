Return-Path: <linux-fsdevel+bounces-43741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B169A5D23A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87877A629F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1674264FB0;
	Tue, 11 Mar 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hf8Zw2Dd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sicd/PNh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884BD199FBA;
	Tue, 11 Mar 2025 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730610; cv=none; b=G7qmJwUPQG1ediAam1MYdNg6FiTA6uBx5opc1L8zt/GZqDZCqwv5Bl7znWqaOPOJBv0sO3LhXpNZGsQsdbBqmUfLWsuMxMBz81F3p+PsO8YG598AM0AZi2qjF4VHaJYlq6SJu10gHAowxekc1nVMmJCuOzsQAL3mxwBItsA4orQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730610; c=relaxed/simple;
	bh=ngzYOMR4Yeu236yAf99OkFggrkSyXGDT7Wb8w52zW6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFWjSdrVkP3u07/UwE3pTA+f2z4SsxSglRbA394IUuzuajs9AehGPKSTEUsGmD6ByL2Pd1w+HtEeyz6MLuzSm4L4WX6SG6eo95VhNA/MNkgg223pebQ9kx+5aQz6/NnWxwHkYrmoeqKTSwVUmyDtnbpU2bxjWN3tFSX6J7PLpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hf8Zw2Dd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sicd/PNh; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id 1037B1D412D4;
	Tue, 11 Mar 2025 18:03:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 11 Mar 2025 18:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741730606;
	 x=1741734206; bh=ttQ3JYdaSOR5HSN+qJQiy55frn4OsFjKyNiYQp/8OTg=; b=
	hf8Zw2DdrOLh45Z/sdZiDBOAi2+SVIIBPAR5j2aEIXCoQeqqNWWSj2rZJCJHvah2
	SZxSymFib2FUoGASrYDZaImnvif39ZJYoZQ7clXZ5/PKqE5Ze/5c62Gnf85iTzQf
	rjYAKykSE30/9DRrn3CMsILc2HoKOBZV8akc72JskuaFOdmBiLpLIMLDZTk+9JAo
	nfXuZAHm8yc1DOpyT9SOWFGvfBlmdyjhMp1AgKKrBR4Nw+ehbEyMOXQ8K27Hz3b2
	JnNne1P7XvBlMv9kb76waWo5JA1j3EfXS7YD12b07x+4HnqksK5HPsHamLssIizr
	IhiKo2djOByJI73G+CYdbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741730606; x=
	1741734206; bh=ttQ3JYdaSOR5HSN+qJQiy55frn4OsFjKyNiYQp/8OTg=; b=S
	icd/PNhBh3P+ubP58dZ2+43YKigxjBjKOnxLjQX56HUH/+Hq0/ByYIcfGeDvqK3o
	nu2S1m3sxFU6Q73zoG2WSdfdkspd3xzQxko+PCKJ4nTdcXKcTx1Smzm+ni3X7TGk
	k1czSDjZDLYy/nQxRPsbR8T6UuTX/5jK49VQwuVmTGTe+kS/YcAJTa0TyeHt69Oz
	Kx0JdTq2Nhi2YgSQrPTH8eN8gUo/Xx0bZYOiJW4EDDKjGyQ2YCUB/80kipFYdu2p
	RJJblZmmTijOWA3BrP4OseqqW3+xPkNPtIIblo9deMnOX7AP1909mv8Xi4EsNO6Q
	E2aCVhRVaAjKigp7ecEDw==
X-ME-Sender: <xms:K7PQZxwfXrnqRJcqAf20W__-UFwOKpGzY6O0NxNxhUSsdImV0bMu1g>
    <xme:K7PQZxSDzLprUJSP3JWiD2VucfQ0s4qM3RAMnhoAPgPiSweqNol6myI7ZmFyMACnn
    fY7acBgGcqyoKWJ4Iw>
X-ME-Received: <xmr:K7PQZ7UfqGzvHOTGH0NvvvbqFMAAY4MTTFm8oiAOXz6y3osn35STAc5NvR2D9Vf4YwZH34v_gpIhNzsbw1lwWoW2KovXPB0kLFuibKbd_H-pjjBcl8GqsYuC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeffeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepudekvefhgeevvdevieehvddvgefhgeelgfdugeeftedv
    keeigfeltdehgeeghffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeduledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepsghrrghunhgv
    rheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthi
    dqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgvphhn
    ohhpsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:K7PQZziK0cX1YaC9SYzQ9lLXUQWwg4_KGx1l0P171rI_beugbVs8JQ>
    <xmx:K7PQZzDuSbRL3ADZPuTnrWWtEQugcibJleUw8oIgdRGORc8y4wH6XQ>
    <xmx:K7PQZ8ImoOQSLUlFKM6Im9KP4wAh3jx8TWiyoAdKUoM2qXdvsf1Qeg>
    <xmx:K7PQZyBeeKQ94xgyIicEVCglGZoh4yO0ZK41UPpumaDjsMH0gztuNQ>
    <xmx:LrPQZ1xc9JtxfufnOibbY1NjKRAg1w-zK8g2VFQnMueDbJXVTk7ZGGy->
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 18:03:21 -0400 (EDT)
Message-ID: <c6e67ee5-9f85-44f4-a27c-97e10942ff57@maowtm.org>
Date: Tue, 11 Mar 2025 22:03:19 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Song Liu <song@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Jan Kara <jack@suse.cz>,
 linux-security-module@vger.kernel.org, Matthew Bobrowski
 <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 Tycho Andersen <tycho@tycho.pizza>, Kees Cook <kees@kernel.org>,
 Jeff Xu <jeffxu@google.com>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Francis Laniel <flaniel@linux.microsoft.com>,
 Matthieu Buffet <matthieu@buffet.re>, Paul Moore <paul@paul-moore.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 John Johansen <john.johansen@canonical.com>
References: <cover.1741047969.git.m@maowtm.org>
 <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
 <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
 <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
 <20250311.Ti7bi9ahshuu@digikod.net>
 <CAPhsuW4YXGFY___8x7my4tUbgyp5N4FHSQpJpKgEDK6r0vphAA@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAPhsuW4YXGFY___8x7my4tUbgyp5N4FHSQpJpKgEDK6r0vphAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 20:58, Song Liu wrote:
> On Tue, Mar 11, 2025 at 12:28 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> On Tue, Mar 11, 2025 at 12:42:05AM +0000, Tingmao Wang wrote:
>>> On 3/6/25 17:07, Amir Goldstein wrote:
>>> [...]
>>>>
>>>> w.r.t sharing infrastructure with fanotify, I only looked briefly at
>>>> your patches
>>>> and I have only a vague familiarity with landlock, so I cannot yet form an
>>>> opinion whether this is a good idea, but I wanted to give you a few more
>>>> data points about fanotify that seem relevant.
>>>>
>>>> 1. There is already some intersection of fanotify and audit lsm via the
>>>> fanotify_response_info_audit_rule extension for permission
>>>> events, so it's kind of a precedent of using fanotify to aid an lsm
>>>>
>>>> 2. See this fan_pre_modify-wip branch [1] and specifically commit
>>>>     "fanotify: introduce directory entry pre-modify permission events"
>>>> I do have an intention to add create/delete/rename permission events.
>>>> Note that the new fsnotify hooks are added in to do_ vfs helpers, not very
>>>> far from the security_path_ lsm hooks, but not exactly in the same place
>>>> because we want to fsnotify hooks to be before taking vfs locks, to allow
>>>> listener to write to filesystem from event context.
>>>> There are different semantics than just ALLOW/DENY that you need,
>>>> therefore, only if we move the security_path_ hooks outside the
>>>> vfs locks, our use cases could use the same hooks
>>>
>>> Hi Amir,
>>>
>>> (this is a slightly long message - feel free to respond at your convenience,
>>> thank you in advance!)
>>>
>>> Thanks a lot for mentioning this branch, and for the explanation! I've had a
>>> look and realized that the changes you have there will be very useful for
>>> this patch, and in fact, I've already tried a worse attempt of this (not
>>> included in this patch series yet) to create some security_pathname_ hooks
>>> that takes the parent struct path + last name as char*, that will be called
>>> before locking the parent.  (We can't have an unprivileged supervisor cause
>>> a directory to be locked indefinitely, which will also block users outside
>>> of the landlock domain)
>>>
>>> I'm not sure if we can move security_path tho, because it takes the dentry
>>> of the child as an argument, and (I think at least for create / mknod /
>>> link) that dentry is only created after locking.  Hence the proposal for
>>> separate security_pathname_ hooks.  A search shows that currently AppArmor
>>> and TOMOYO (plus Landlock) uses the security_path_ hooks that would need
>>> changing, if we move it (and we will have to understand if the move is ok to
>>> do for the other two LSMs...)
>>>
>>> However, I think it would still make a lot of sense to align with fsnotify
>>> here, as you have already made the changes that I would need to do anyway
>>> should I implement the proposed new hooks.  I think a sensible thing might
>>> be to have the extra LSM hooks be called alongside fsnotify_(re)name_perm -
>>> following the pattern of what currently happens with fsnotify_open_perm
>>> (i.e. security_file_open called first, then fsnotify_open_perm right after).
> 
> I think there is a fundamental difference between LSM hooks and fsnotify,
> so putting fsnotify behind some LSM hooks might be weird. Specifically,
> LSM hooks are always global. If a LSM attaches to a hook, say
> security_file_open, it will see all the file open calls in the system. On the
> other hand, each fsnotify rule only applies to a group, so that one fanotify
> handler doesn't touch files watched by another fanotify handler. Given this
> difference, I am not sure how fsnotify LSM hooks should look like.
> 
> Does this make sense?

To clarify, I wasn't suggesting that we put one hook _behind_ another 
("behind" in the sense of one calling the other), just that the place 
that calls the new fsnotify_name_perm/fsnotify_rename_perm hook (in 
Amir's WIP branch) could also be made to call some new LSM hooks in 
addition to fsnotify (i.e. security_pathname_create/delete/rename).

My understanding of the current code is that VFS calls security_... and 
fsnotify_... unconditionally, and the fsnotify_... functions figure out 
who needs to be notified.

> 
>> Yes, I think it would make sense to use the same hooks for fanotify and
>> other security subsystems, or at least to share them.  It would improve
>> consistency across different Linux subsystems and simplify changes and
>> maintenance where these hooks are called.

Mickaël - I'm not sure what you mean by "the same hook" - do you mean 
the relevant VFS functions could call both fsnotify and LSM hooks?

> 
> [...]
> 
>>> --
>>>
>>> For Mickaël,
>>>
>>> Would you be on board with changing Landlock to use the new hooks as
>>> mentioned above?  My thinking is that it shouldn't make any difference in
>>> terms of security - Landlock permissions for e.g. creating/deleting files
>>> are based on the parent, and in fact except for link and rename, the
>>> hook_path_ functions in Landlock don't even use the dentry argument.  If
>>> you're happy with the general direction of this, I can investigate further
>>> and test it out etc.  This change might also reduce the impact of Landlock
>>> on non-landlocked processes, if we avoid holding exclusive inode lock while
>>> evaluating rules / traversing paths...? (Just a thought, not measured)
> 
> I think the filter for process/thread is usually faster than the filter for
> file/path/subtree? Therefore, it is better for landlock to check the filter for
> process/thread first. Did I miss/misunderstand something?
>

Sorry, I should have clarified that the "impact" I'm talking about here 
isn't referring to directly the time it takes for landlock to decide if 
an access is allowed or not - in a non-landlocked process, the landlock 
hooks already returns really early and fast.  However, I'm thinking of a 
situation where a landlocked process makes lots of create/delete etc 
requests on a directory, and landlock does need to do some work (e.g. 
path traversal) to decide those access.  Because the 
security_path_mknod/unlink/... hooks are called in the VFS from a place 
where it is holding an exclusive lock on the directory (for O_CREAT'ing 
a child or other directory modification cases), when landlock is working 
out an access by the landlocked process, no other tasks will be able to 
read/write the directory (they will be blocked on the lock), even if 
their access have nothing to do with landlock.

I should add that this is probably just a very minor impact: the user 
space can't cause the dir to be blocked for arbitrary amount of time, at 
worst slowing everyone else down by a bit if it deliberately creates 
lots of layers (max 16) each with lots of rules (the ruleset evaluation 
is O(log(#rules) * dir_depth)). I didn't measure it, it's just something 
that occurred to me that could be improved by using new hooks that 
aren't called with inode locks held.

Kind regards,
Tingmao

> Thanks,
> Song
> 
> 
> 
> 
>> This looks reasonable.  As long as the semantic does not change it
>> should be good and Landlock tests should pass.  That would also require
>> other users of this hook to make sure it works for them too.  If it is
>> not the case, I guess we could add an alternative hooks with different
>> properties.  However, see the issue and the alternative approach below.
>>


