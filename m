Return-Path: <linux-fsdevel+bounces-33259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3BD9B690E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CACD1C21DCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0521443B;
	Wed, 30 Oct 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="nuJmOD1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZqKaKmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183E214420
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305279; cv=none; b=WTJMDsw15oqI2rQrIsfzDtYfdJGSWmcqAbFmr46QXRGeSH7CVdXlfOTR2i5FNAXVlGmUGmvanmLn/2wEmOqS7ag4MYSf1FcGuSsgXu40nHc1ofHPc2CNbCp07Xn8LnWqBs8I9KMevOcu4Hx99Np2/CM4s/VZKlCvB+21AHwELKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305279; c=relaxed/simple;
	bh=us0rhoMWN1X+q4cMAgXEWlm8y37l3JAfdiccwYtlko8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmSNmB24zpXHIzNtjo9pp7tB5C1VkeR9pVpzP5tczXY3ID73XeU2UprisDlKnINL/2e4eYxGR9VKhB9JTY5PnzYM48Ppsg87C/iOq0fIaA8xt3Li3t/r7fDF9awVjaBO+JZaj73ZXmQU+uTp5pe0azDIxEye9sX+fYZPUR/9f9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=nuJmOD1y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZqKaKmk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67379254008B;
	Wed, 30 Oct 2024 12:21:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 30 Oct 2024 12:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730305275;
	 x=1730391675; bh=FAXRooxK7+YfyaclUhlqNapuimFMYjPHr3wsSd0GJiA=; b=
	nuJmOD1yjBzUygKkNGKabp6gFbJk2OHLn0dXmAmO1RCbxC3iBTMGl2cGu0qprV0K
	FW+Lw2MZraV7hbQfiJhF8Hc4fOq81po6yVysTASJCzTgaeYkRtXouOgGVyDnJprE
	A65N17tdeHC+tCQqs34shQgFW4PMGp19p3Q5/ZyleRkSghAcXhKlXDrlwrfCymMb
	ecSLWbh4L+46z7fB+ZMtgd8T2R4rpFjuC0ov1rNmv4Jzuo2tdLBFTT3HGxwi3Y6p
	ASMrbCLvDeJk5B8YVfvm/2Q2FSTEyueAOt1OiorAkqK8rXUhQdR1JEZSeRbMRu2h
	C+JfKg1YDXZGxHOCvbZkNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730305275; x=
	1730391675; bh=FAXRooxK7+YfyaclUhlqNapuimFMYjPHr3wsSd0GJiA=; b=I
	ZqKaKmk1rsq2bvUBDdlHhqGJNgubeGdujzK3mCQaFhdBpwFVLUgyldVTy7WyiluM
	je8buVLDqdwEq63/b6o/6FiB/jYyrBfDyWKRJ2FHiJFHtL2O9t9Pyr4XhWEKOyN9
	nN5TE0beQy6cmhsEcRmgOsTljT4z6S0+6Jbn3LDm0lgfZYJba6CNJo8DzQw8lGBA
	lDkIuVGxlPFHQcPbT2fmZgwjj9o7ZH/NIQyJ8eaaw92wH6VpVQV6jg+C2fU5VVck
	vf9dO1Otx2pY88tvXzVeINexp5anpaElonZW4g2uUT3amSyJHTPX872GcJvKDz9h
	FOFVVS+lE4pXRcP1agCag==
X-ME-Sender: <xms:-VwiZ--yC1qeKfJVMUZG3OQNgwsTItKIZloLq8ze0Mb6VpQJQilPQA>
    <xme:-VwiZ-sFCFgMaizNHPpa2IsulEacnpllQPtpYL9X_8cDQ-lUjYSV6i_vwATczI_5n
    twGbzS5WhjFIixo>
X-ME-Received: <xmr:-VwiZ0D_v-bCCibBBgffuWRNIq5pM79I7I4Hg6BsXIRcIG1dDYlKh8FAkyDAkL_fEYMYJTsAGqiGPZ1r3p_2rDYUskooqYcCAy6BXkegaiNPrt5JBIj5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudev
    leegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtph
    htthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepshhhrghkvggv
    lhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfsehtohig
    ihgtphgrnhgurgdrtghomhdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthho
    pehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:-VwiZ2ea9tJNx1y534xpCx5f9zF_GszhNqfpKuDduXx8fp9fPJBXEw>
    <xmx:-lwiZzMM8EZIe02glmmHl8ak-POYvNWCcjf7Dep11BXYWU2S2yShaA>
    <xmx:-lwiZwmgFdnrDUnGfoV7q4VwPA3pHvObrqBC6kTE19wOJdoNEpRl4w>
    <xmx:-lwiZ1vL5qSfpTEYm_UTCZiUnfMGY5cVONnYB_2V7hLR2NOcELfSeA>
    <xmx:-1wiZ-oikzFdhbPRz9h6l3bVEVVG4aoRARraXHQyUtufKFc02YWONXed>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 12:21:12 -0400 (EDT)
Message-ID: <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm>
Date: Wed, 30 Oct 2024 17:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
 <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
 <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJnrk1ZNqLXAM=QZO+rCqarY1ZP=9_naU7WNyrmPAY=Q2Htu_Q@mail.gmail.com>
 <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
 <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm>
 <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/24 17:04, Joanne Koong wrote:
> On Wed, Oct 30, 2024 at 2:32 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> On 10/28/24 22:58, Joanne Koong wrote:
>>> On Fri, Oct 25, 2024 at 3:40 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>
>>>>> Same here, I need to look some more into the compaction / page
>>>>> migration paths. I'm planning to do this early next week and will
>>>>> report back with what I find.
>>>>>
>>>>
>>>> These are my notes so far:
>>>>
>>>> * We hit the folio_wait_writeback() path when callers call
>>>> migrate_pages() with mode MIGRATE_SYNC
>>>>    ... -> migrate_pages() -> migrate_pages_sync() ->
>>>> migrate_pages_batch() -> migrate_folio_unmap() ->
>>>> folio_wait_writeback()
>>>>
>>>> * These are the places where we call migrate_pages():
>>>> 1) demote_folio_list()
>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>>>
>>>> 2) __damon_pa_migrate_folio_list()
>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>>>
>>>> 3) migrate_misplaced_folio()
>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>>>
>>>> 4) do_move_pages_to_node()
>>>> Can ignore this. This calls migrate_pages() in MIGRATE_SYNC mode but
>>>> this path is only invoked by the move_pages() syscall. It's fine to
>>>> wait on writeback for the move_pages() syscall since the user would
>>>> have to deliberately invoke this on the fuse server for this to apply
>>>> to the server's fuse folios
>>>>
>>>> 5)  migrate_to_node()
>>>> Can ignore this for the same reason as in 4. This path is only invoked
>>>> by the migrate_pages() syscall.
>>>>
>>>> 6) do_mbind()
>>>> Can ignore this for the same reason as 4 and 5. This path is only
>>>> invoked by the mbind() syscall.
>>>>
>>>> 7) soft_offline_in_use_page()
>>>> Can skip soft offlining fuse folios (eg folios with the
>>>> AS_NO_WRITEBACK_WAIT mapping flag set).
>>>> The path for this is soft_offline_page() -> soft_offline_in_use_page()
>>>> -> migrate_pages(). soft_offline_page() only invokes this for in-use
>>>> pages in a well-defined state (see ret value of get_hwpoison_page()).
>>>> My understanding of soft offlining pages is that it's a mitigation
>>>> strategy for handling pages that are experiencing errors but are not
>>>> yet completely unusable, and its main purpose is to prevent future
>>>> issues. It seems fine to skip this for fuse folios.
>>>>
>>>> 8) do_migrate_range()
>>>> 9) compact_zone()
>>>> 10) migrate_longterm_unpinnable_folios()
>>>> 11) __alloc_contig_migrate_range()
>>>>
>>>> 8 to 11 needs more investigation / thinking about. I don't see a good
>>>> way around these tbh. I think we have to operate under the assumption
>>>> that the fuse server running is malicious or benevolently but
>>>> incorrectly written and could possibly never complete writeback. So we
>>>> definitely can't wait on these but it also doesn't seem like we can
>>>> skip waiting on these, especially for the case where the server uses
>>>> spliced pages, nor does it seem like we can just fail these with
>>>> -EBUSY or something.
>>
>> I see some code paths with -EAGAIN in migration. Could you explain why
>> we can't just fail migration for fuse write-back pages?
>>

Hi Joanne,

thanks a lot for your quick reply (especially as my reviews come in very 
late).

> 
> My understanding (and please correct me here Shakeel if I'm wrong) is
> that this could block system optimizations, especially since if an
> unprivileged malicious fuse server never replies to the writeback
> request, then this completely stalls progress. In the best case
> scenario, -EAGAIN could be used because the server might just be slow
> in serving the writeback, but I think we need to also account for
> servers that never complete the writeback. For
> __alloc_contig_migrate_range() for example, my understanding is that
> this is used to migrate pages so that there are more physically
> contiguous ranges of memory freed up. If fuse writeback blocks that,
> then that hurts system health overall.

Hmm, I wonder what is worse - tmp page copies or missing compaction.
Especially if we expect a low range of in-writeback pages/folios. 
One could argue that an evil user might spawn many fuse server
processes to work around the default low fuse write-back limits, but
does that make any difference with tmp pages? And these cannot be
compacted either?

And with timeouts that would be so far totally uncritical, I
think.


You also mentioned 

> especially for the case where the server uses spliced pages

could you provide more details for that? 



> 
>>>>
>>>
>>> I'm still not seeing a good way around this.
>>>
>>> What about this then? We add a new fuse sysctl called something like
>>> "/proc/sys/fs/fuse/writeback_optimization_timeout" where if the sys
>>> admin sets this, then it opts into optimizing writeback to be as fast
>>> as possible (eg skipping the page copies) and if the server doesn't
>>> fulfill the writeback by the set timeout value, then the connection is
>>> aborted.
>>>
>>> Alternatively, we could also repurpose
>>> /proc/sys/fs/fuse/max_request_timeout from the request timeout
>>> patchset [1] but I like the additional flexibility and explicitness
>>> having the "writeback_optimization_timeout" sysctl gives.
>>>
>>> Any thoughts on this?
>>
>>
>> I'm a bit worried that we might lock up the system until time out is
>> reached - not ideal. Especially as timeouts are in minutes now. But
>> even a slightly stuttering video system not be great. I think we
>> should give users/admin the choice then, if they prefer slow page
>> copies or fast, but possibly shortly unresponsive system.
>>
> I was thinking the /proc/sys/fs/fuse/writeback_optimization_timeout
> would be in seconds, where the sys admin would probably set something
> more reasonable like 5 seconds or so.
> If this syctl value is set, then servers who want writebacks to be
> fast can opt into it at mount time (and by doing so agree that they
> will service writeback requests by the timeout or their connection
> will be aborted).


I think your current patch set has it in minutes? (Should be easy
enough to change that.) Though I'm more worried about the impact
of _frequent_ timeout scanning through the different fuse lists 
on performance, than about missing compaction for folios that are
currently in write-back.


Thanks,
Bernd

