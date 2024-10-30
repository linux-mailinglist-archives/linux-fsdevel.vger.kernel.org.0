Return-Path: <linux-fsdevel+bounces-33273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE99B6AFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B189281119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA731BD9D2;
	Wed, 30 Oct 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="cFhPKo7a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="az7yaErc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3761BD9D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309272; cv=none; b=mT/W3TjKA0dJH6ZeQMJ76SgWA0lOhHzvv7VoSG6vXjstF/RsWv6cJAJryj5a3vWJGz+fP5J15UuZsgsnZl2225/QV3TogePjt+YH7W3ASkISNu1vP5Mg+b8JZfw05exLaPu9KMgX0fP4+QjJSvqnVW5lpRG8NrLICjP+srdCMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309272; c=relaxed/simple;
	bh=AaOprhkjWi3vyu+YqS7XPt+1reACDGSEpRepdQUBtlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyGsMFFqJXnOxoqzYsc2ZpduDPwYStgso1FFE5bbqbsQbGCxMguxxHl3GiGm2vJQzS+/8n+pYUvuf3mxpctioU2EeWK9xVXUmadoRfkuSp7F1IKu+8q/FmYYoi1kiU2auk0hDPdjnliRwG+dWnDLysopkYsvoaRB69GP6fVDroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=cFhPKo7a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=az7yaErc; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BE5FC1140130;
	Wed, 30 Oct 2024 13:27:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 30 Oct 2024 13:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730309267;
	 x=1730395667; bh=HEHVsGBzrirAoADNA8r+pSWIy2xvTKgTmjRILTAQNCE=; b=
	cFhPKo7aDcTxAqsu4fw8apdPyHLlMo0fkPzqOeN1CMtBbhPHGpt61p4Zb++cM6gO
	+LBmsG24i5z+ngcOMT0OB6+583KtG+13H5yFcjN/axH//Pt3KIv7eU8NRuWs0fT/
	bnZId7CJFWVjFy/IBqOd+ibRqugBWKzFWOIUQ3XrP2hn0QxTRPGrxTCX9fPFjQRw
	mjFaEvAXYG43aGGKXbgJLwIYJ/UC2t6SExdh/SFWdvkWhQyvNMp7L82yPcTq0mIb
	bxJGv9W1PeohSBKMCzmI37mhtarIdP3BSs3rg/xUhMtCfMdVwg6y8ciHs5l2CfZS
	0LdWU9d+5wVdL28r21P2lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730309267; x=
	1730395667; bh=HEHVsGBzrirAoADNA8r+pSWIy2xvTKgTmjRILTAQNCE=; b=a
	z7yaErcupzsBl5CSthoBbxmbQM+VPq7XLa55yp4X6aKHedmVsttO2z6WOnO+P3tB
	Eh2kKciIBsTKSTgpYLMg8/EdRk1N5tB3IsPP9oICKyO/btUbwddRoPGHLSnxIJTu
	4bxLzwKlzjpTL0m0tGI4RFXY6Xyrki/pVj4RjqWdMu7pAX0/4nKYUqWWOygSoI+c
	JfGDYVvv6bXXx+wl40c6eZp+j5dMiWDKoRXMs0Cva6ouPhLpA4cRii+CZe2mtp/w
	P5RYSmqBFXkwF+IWC089X2kHJwvB5xcCb1KSCpZTpb8KJHsn7REDalLMPUGm8VW0
	lSy4rwhWzFEr3OCQrzVJg==
X-ME-Sender: <xms:kmwiZ6fU74y1b-PLXAjtTewu8t5U5A3c7MSU-6DM2s-pmjMZjPH57Q>
    <xme:kmwiZ0OxFZ8E79meScO_ulyP4IKPsU0s_d-TpWFiFAbALwCUufSlHklYbIO66W0jc
    OMWWeOJ_kU0cc49>
X-ME-Received: <xmr:kmwiZ7gDo7QCBMykBhb_EAONTHa-MLz6jBLZu_4nGTM-Eq5XGRhGUy3SXqw83qvAapYNAaLr897MyiArlI1ySdc6qCBBmaOo4oaZ8KGwE9sJQA57AmSX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtg
    hpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehshhgrkhgv
    vghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvfhesthho
    gihitghprghnuggrrdgtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrd
    horhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthht
    ohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:kmwiZ39RQ6GfOxgzuE72vBIgRXWX5SuHsvKC6FXSNagwmkuU553lEg>
    <xmx:kmwiZ2uROaTGhNV_fsTsRVkB685MNc912_bxmNeyCrI8Psrjp3qK3Q>
    <xmx:kmwiZ-Gos_5dOxu52ZYGMwL_55uyWn-Gmu-7uo2bTgl2mJg7lIkrsA>
    <xmx:kmwiZ1OfQhxHEtWQVoTMpeIiKV11V4LGKy9vxVB4xhcBLLBMZA8Ctw>
    <xmx:k2wiZwLQWyO22FoCO9-pZRKQ_c3OpBCMiyV6EZlAF66iKgFjNlNGFAvP>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 13:27:44 -0400 (EDT)
Message-ID: <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
Date: Wed, 30 Oct 2024 18:27:42 +0100
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
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm>
 <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/24 18:02, Joanne Koong wrote:
> On Wed, Oct 30, 2024 at 9:21 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> On 10/30/24 17:04, Joanne Koong wrote:
>>> On Wed, Oct 30, 2024 at 2:32 AM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> On 10/28/24 22:58, Joanne Koong wrote:
>>>>> On Fri, Oct 25, 2024 at 3:40 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>>>
>>>>>>> Same here, I need to look some more into the compaction / page
>>>>>>> migration paths. I'm planning to do this early next week and will
>>>>>>> report back with what I find.
>>>>>>>
>>>>>>
>>>>>> These are my notes so far:
>>>>>>
>>>>>> * We hit the folio_wait_writeback() path when callers call
>>>>>> migrate_pages() with mode MIGRATE_SYNC
>>>>>>    ... -> migrate_pages() -> migrate_pages_sync() ->
>>>>>> migrate_pages_batch() -> migrate_folio_unmap() ->
>>>>>> folio_wait_writeback()
>>>>>>
>>>>>> * These are the places where we call migrate_pages():
>>>>>> 1) demote_folio_list()
>>>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>>>>>
>>>>>> 2) __damon_pa_migrate_folio_list()
>>>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>>>>>
>>>>>> 3) migrate_misplaced_folio()
>>>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>>>>>
>>>>>> 4) do_move_pages_to_node()
>>>>>> Can ignore this. This calls migrate_pages() in MIGRATE_SYNC mode but
>>>>>> this path is only invoked by the move_pages() syscall. It's fine to
>>>>>> wait on writeback for the move_pages() syscall since the user would
>>>>>> have to deliberately invoke this on the fuse server for this to apply
>>>>>> to the server's fuse folios
>>>>>>
>>>>>> 5)  migrate_to_node()
>>>>>> Can ignore this for the same reason as in 4. This path is only invoked
>>>>>> by the migrate_pages() syscall.
>>>>>>
>>>>>> 6) do_mbind()
>>>>>> Can ignore this for the same reason as 4 and 5. This path is only
>>>>>> invoked by the mbind() syscall.
>>>>>>
>>>>>> 7) soft_offline_in_use_page()
>>>>>> Can skip soft offlining fuse folios (eg folios with the
>>>>>> AS_NO_WRITEBACK_WAIT mapping flag set).
>>>>>> The path for this is soft_offline_page() -> soft_offline_in_use_page()
>>>>>> -> migrate_pages(). soft_offline_page() only invokes this for in-use
>>>>>> pages in a well-defined state (see ret value of get_hwpoison_page()).
>>>>>> My understanding of soft offlining pages is that it's a mitigation
>>>>>> strategy for handling pages that are experiencing errors but are not
>>>>>> yet completely unusable, and its main purpose is to prevent future
>>>>>> issues. It seems fine to skip this for fuse folios.
>>>>>>
>>>>>> 8) do_migrate_range()
>>>>>> 9) compact_zone()
>>>>>> 10) migrate_longterm_unpinnable_folios()
>>>>>> 11) __alloc_contig_migrate_range()
>>>>>>
>>>>>> 8 to 11 needs more investigation / thinking about. I don't see a good
>>>>>> way around these tbh. I think we have to operate under the assumption
>>>>>> that the fuse server running is malicious or benevolently but
>>>>>> incorrectly written and could possibly never complete writeback. So we
>>>>>> definitely can't wait on these but it also doesn't seem like we can
>>>>>> skip waiting on these, especially for the case where the server uses
>>>>>> spliced pages, nor does it seem like we can just fail these with
>>>>>> -EBUSY or something.
>>>>
>>>> I see some code paths with -EAGAIN in migration. Could you explain why
>>>> we can't just fail migration for fuse write-back pages?
>>>>
>>
>> Hi Joanne,
>>
>> thanks a lot for your quick reply (especially as my reviews come in very
>> late).
>>
> 
> Thanks for your comments/reviews, Bernd! I always appreciate them.
> 
>>>
>>> My understanding (and please correct me here Shakeel if I'm wrong) is
>>> that this could block system optimizations, especially since if an
>>> unprivileged malicious fuse server never replies to the writeback
>>> request, then this completely stalls progress. In the best case
>>> scenario, -EAGAIN could be used because the server might just be slow
>>> in serving the writeback, but I think we need to also account for
>>> servers that never complete the writeback. For
>>> __alloc_contig_migrate_range() for example, my understanding is that
>>> this is used to migrate pages so that there are more physically
>>> contiguous ranges of memory freed up. If fuse writeback blocks that,
>>> then that hurts system health overall.
>>
>> Hmm, I wonder what is worse - tmp page copies or missing compaction.
>> Especially if we expect a low range of in-writeback pages/folios.
>> One could argue that an evil user might spawn many fuse server
>> processes to work around the default low fuse write-back limits, but
>> does that make any difference with tmp pages? And these cannot be
>> compacted either?
> 
> My understanding (and Shakeel please jump in here if this isn't right)
> is that tmp pages can be migrated/compacted. I think it's only pages
> marked as under writeback that are considered to be non-movable.
> 
>>
>> And with timeouts that would be so far totally uncritical, I
>> think.
>>
>>
>> You also mentioned
>>
>>> especially for the case where the server uses spliced pages
>>
>> could you provide more details for that?
>>
7> 
> For the page migration / compaction paths, I don't think we can do the
> workaround we could do for sync where we skip waiting on writeback for
> fuse folios and continue on with the operation, because the migration
> / compaction paths operate on the pages. For the splice case, we
> assign the page to the pipebuffer (fuse_ref_page()), so if the
> migration/compaction happens on the page before the server has read
> this page from the pipebuffer, it'll be incorrect data or maybe crash
> the kernel.
> 
>>
>>
>>>
>>>>>>
>>>>>
>>>>> I'm still not seeing a good way around this.
>>>>>
>>>>> What about this then? We add a new fuse sysctl called something like
>>>>> "/proc/sys/fs/fuse/writeback_optimization_timeout" where if the sys
>>>>> admin sets this, then it opts into optimizing writeback to be as fast
>>>>> as possible (eg skipping the page copies) and if the server doesn't
>>>>> fulfill the writeback by the set timeout value, then the connection is
>>>>> aborted.
>>>>>
>>>>> Alternatively, we could also repurpose
>>>>> /proc/sys/fs/fuse/max_request_timeout from the request timeout
>>>>> patchset [1] but I like the additional flexibility and explicitness
>>>>> having the "writeback_optimization_timeout" sysctl gives.
>>>>>
>>>>> Any thoughts on this?
>>>>
>>>>
>>>> I'm a bit worried that we might lock up the system until time out is
>>>> reached - not ideal. Especially as timeouts are in minutes now. But
>>>> even a slightly stuttering video system not be great. I think we
>>>> should give users/admin the choice then, if they prefer slow page
>>>> copies or fast, but possibly shortly unresponsive system.
>>>>
>>> I was thinking the /proc/sys/fs/fuse/writeback_optimization_timeout
>>> would be in seconds, where the sys admin would probably set something
>>> more reasonable like 5 seconds or so.
>>> If this syctl value is set, then servers who want writebacks to be
>>> fast can opt into it at mount time (and by doing so agree that they
>>> will service writeback requests by the timeout or their connection
>>> will be aborted).
>>
>>
>> I think your current patch set has it in minutes? (Should be easy
>> enough to change that.) Though I'm more worried about the impact
>> of _frequent_ timeout scanning through the different fuse lists
>> on performance, than about missing compaction for folios that are
>> currently in write-back.

Hmm, if tmp pages can be compacted, isn't that a problem for splice?
I.e. I don't understand what the difference between tmp page and
write-back page for migration.


>>
> 
> Ah, for this the " /proc/sys/fs/fuse/writeback_optimization_timeout"
> would be a separate thing from the
> "/proc/sys/fs/fuse/max_request_timeout". The
> "/proc/sys/fs/fuse/writeback_optimization_timeout" would only apply
> for writeback requests. I was thinking implementation-wise, for
> writebacks we could just have a timer associated with each request
> (instead of having to grab locks with the fuse lists), since they
> won't be super common.

Ah, thank you! I had missed that this is another variable. Issue
with too short timeouts would probably be network hick-up that
would immediately kill fuse-server. I.e. if it just the missing
page compaction/migration, maybe larger time outs would be
acceptable.


Thanks,
Bernd

