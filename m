Return-Path: <linux-fsdevel+bounces-25943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB695218B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A48D1C2121F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F101BC9F2;
	Wed, 14 Aug 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="x5F/e4c+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ExK0u0N4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B2566A
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657971; cv=none; b=MrTSCXUcodx2XXxLF42296CZOy/WdJXx2l2gPam9agDp15sXO5M4rc7Z3aXOyptoAzS3s/S/EwJ/GXn7t0bivHsNKNP8icVL34MXOBMkxVktVn6f7CyaDsOCh+6q58/9y8O6A7U82mYIEdVj3sRek8qRt+pjjqFPIERFfFW7PfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657971; c=relaxed/simple;
	bh=LNeCzdNZFDN0PobO8Wx7/mCiCN3s5C77QwHukg1+RDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vo0SPAC7Vm12/jUwqrbnIgdgwSbpyfo/9H64M7jb9t++gxw+e+KjcObPwAfMsQ9R8lzA4/MHcwqKo3rcOJIVHIuNzXMlGa+xZKCaR5YE3pfuNjTbvsrkVihZWaIzIdx4A7KI9y2HgKB99gtXQIrU758N9nDc4C9hzX0fN/a6X6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=x5F/e4c+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ExK0u0N4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5588B1148184;
	Wed, 14 Aug 2024 13:52:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 14 Aug 2024 13:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723657968;
	 x=1723744368; bh=GmTvbuXamjIPXDgNo/U2eesaPGrneTgB8BnsTdEPvTw=; b=
	x5F/e4c+HxR6TZA741Nl87oqxcRuiQoBg3NDytDLJ4ttl6nAaID6PzeqzsSkdrPZ
	2p1LpLXRrWsxyaxGWPe1dERX1vY5zl4Qtk96/7R5NUOWsBb5gGTblNfwB6J+yfB5
	Ki751zxcXgigRpI7s4m7Xcc5Ud+MLAiNSkYJBG4WWNDsytMZUpbuGT/+JlXFiSOG
	cJwGx3daKxtK7ZtKuyjngi1epv4XxCQfEcp/WlY2xHSOUn0Ct+zvleGmY1+j/wNd
	XsxbSqdAd4j6vVqSOpO8zNHsvlJlGEC5yQd0uOnaXzKToamhOulRI6TWeZUMH6Jy
	XOv6juKKI9yBw5upkCH4RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723657968; x=
	1723744368; bh=GmTvbuXamjIPXDgNo/U2eesaPGrneTgB8BnsTdEPvTw=; b=E
	xK0u0N4wRO+rI+sQrFbb8SSLCLhckr8ngJ/gJuYFN2XQ1oT1h0C2LV5FGEJYOZrS
	+q1Lz2o3UTrFeWKhSe20ebmIWrZJCZobX+m3U/ntgKLyakjdmWc1vEGoDZ3+vwC6
	l3cfpB3Go1/o6XO7D8srfLtXoc1H57K/PrhTPvk5uvZHg01+r5r/sNlaPc7X2Ps3
	l1ufpJzDc/T76ABSMzCuZTIHxFUQVYnxZ8VysMyjkJMv3xwTRidicx2uB2PaIZNx
	emUSPx2Ir0Yzz6rTwKKbGfNqvTNGFy8vRxekPjMMTTA5ZlhJoiq4GbxD+N05VN3w
	ivFy4LVwmgLMf7bBmJdpQ==
X-ME-Sender: <xms:7-68ZlcrALpBT4M_San7h1hPI81l5HHCUfSBgTR3L-ZNdYrN9fxqmw>
    <xme:7-68ZjO6LAe9fPkqxYzoXpwtyTjtkepYc7g_UHnzYpIaXXVNgUk48JmSvoGe4Ana8
    vwSl1XI3pO7sRgr>
X-ME-Received: <xmr:7-68ZuhxuRXfPe7p0Z9-oJoCX55-oAF7lyY3DBIYbPlceADBTiBuT7MiG0UqBxR_uZ-SGx0lkuQ3oEP9e_7dH8JnxeVfZQG_I97d8temqlJnGXmTbwGswtZutQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepohhsrghnughovhesoh
    hsrghnughovhdrtghomhdprhgtphhtthhopehsfigvvghtthgvrgdqkhgvrhhnvghlsegu
    ohhrmhhinhihrdhmvgdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtg
    homhdprhgtphhtthhopegushhinhhghhesuggunhdrtghomh
X-ME-Proxy: <xmx:7-68Zu9bD1Mk6EEKtDtAIQon4JOzlvlSTFiavDjHVP96Qh2m4VBIbA>
    <xmx:7-68Zhujumj9lUKQW2PGhrUwhoUG36_kxjmQDtAIIdI_agxo9XR4jg>
    <xmx:7-68ZtFQzI1y7xzQzTQRTQW60w-faWELuKjRD1EaL2ZcOxcEe0onhQ>
    <xmx:7-68ZoPA4yFjp_m2deHz8rxaRsyKrfbbjGThBOKLkBbvAARUcyCQbg>
    <xmx:8O68ZnCkyMt0mos6t1j8fsffidUKVReErnTscNJyIWViON0VUkFc_NnS>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 13:52:46 -0400 (EDT)
Message-ID: <9941c561-b358-4058-8797-3e8081b019dc@fastmail.fm>
Date: Wed, 14 Aug 2024 19:52:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 osandov@osandov.com, sweettea-kernel@dorminy.me, kernel-team@meta.com,
 Dharmendra Singh <dsingh@ddn.com>
References: <20240813212149.1909627-1-joannelkoong@gmail.com>
 <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm>
 <CAJnrk1aC-qUTb1e-n7O-wqrbUKMcq18tyE7LAxattdGU22NaPA@mail.gmail.com>
 <C23FB164-EB7A-436F-8C3F-533B00F67730@fastmail.fm>
 <CAJnrk1ZZ2eEcwYeXHmJxxMywQ8=iDkffvcJK8W8exA02vjrvUg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <CAJnrk1ZZ2eEcwYeXHmJxxMywQ8=iDkffvcJK8W8exA02vjrvUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/14/24 19:18, Joanne Koong wrote:
> On Tue, Aug 13, 2024 at 3:41 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> On August 13, 2024 11:57:44 PM GMT+02:00, Joanne Koong <joannelkoong@gmail.com> wrote:
>>> On Tue, Aug 13, 2024 at 2:44 PM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> On 8/13/24 23:21, Joanne Koong wrote:
>>>>> Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
>>>>> fetched from the server after an open.
>>>>>
>>>>> For fuse servers that are backed by network filesystems, this is
>>>>> needed to ensure that file attributes are up to date between
>>>>> consecutive open calls.
>>>>>
>>>>> For example, if there is a file that is opened on two fuse mounts,
>>>>> in the following scenario:
>>>>>
>>>>> on mount A, open file.txt w/ O_APPEND, write "hi", close file
>>>>> on mount B, open file.txt w/ O_APPEND, write "world", close file
>>>>> on mount A, open file.txt w/ O_APPEND, write "123", close file
>>>>>
>>>>> when the file is reopened on mount A, the file inode contains the old
>>>>> size and the last append will overwrite the data that was written when
>>>>> the file was opened/written on mount B.
>>>>>
>>>>> (This corruption can be reproduced on the example libfuse passthrough_hp
>>>>> server with writeback caching disabled and nopassthrough)
>>>>>
>>>>> Having this flag as an option enables parity with NFS's close-to-open
>>>>> consistency.
>>>>>
>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>> ---
>>>>>  fs/fuse/file.c            | 7 ++++++-
>>>>>  include/uapi/linux/fuse.h | 7 ++++++-
>>>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>>> index f39456c65ed7..437487ce413d 100644
>>>>> --- a/fs/fuse/file.c
>>>>> +++ b/fs/fuse/file.c
>>>>> @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struct file *file)
>>>>>       err = fuse_do_open(fm, get_node_id(inode), file, false);
>>>>>       if (!err) {
>>>>>               ff = file->private_data;
>>>>> -             err = fuse_finish_open(inode, file);
>>>>> +             if (ff->open_flags & FOPEN_FETCH_ATTR) {
>>>>> +                     fuse_invalidate_attr(inode);
>>>>> +                     err = fuse_update_attributes(inode, file, STATX_BASIC_STATS);
>>>>> +             }
>>>>> +             if (!err)
>>>>> +                     err = fuse_finish_open(inode, file);
>>>>>               if (err)
>>>>>                       fuse_sync_release(fi, ff, file->f_flags);
>>>>>               else if (is_truncate)
>>>>
>>>> I didn't come to it yet, but I actually wanted to update Dharmendras/my
>>>> atomic open patches - giving up all the vfs changes (for now) and then
>>>> always use atomic open if available, for FUSE_OPEN and FUSE_CREATE. And
>>>> then update attributes through that.
>>>> Would that be an alternative for you? Would basically require to add an
>>>> atomic_open method into your file system.
>>>>
>>>> Definitely more complex than your solution, but avoids a another
>>>> kernel/userspace transition.
>>>
>>> Hi Bernd,
>>>
>>> Unfortunately I don't think this is an alternative for my use case. I
>>> haven't looked closely at the implementation details of your atomic
>>> open patchset yet but if I'm understanding the gist of it correctly,
>>> it bundles the lookup with the open into 1 request, where the
>>> attributes can be passed from server -> kernel through the reply to
>>> that request. I think in the case I'm working on, the file open call
>>> does not require a lookup so it can't take advantage of your feature.
>>> I just tested it on libfuse on the passthrough_hp server (with no
>>> writeback caching and nopassthrough) on the example in the commit
>>> message and I'm not seeing any lookup request being sent for that last
>>> open call (for writing "123").
>>>
>>
>>
>> Hi Joanne,
>>
>> gets late here and I'm typing on my phone.  I hope formatting is ok.
>>
>> what I meant is that we use the atomic open op code for both, lookup-open and plain open - i.e. we always update attributes on open. Past atomic open patches did not do that yet, but I later realized that always using atomic open op
>>
>> - avoids the data corruption you run into
>> - probably no need for atomic-revalidate-open vfs patches anymore  as we can now safely set a high attr timeout
>>
>>
>> Kind of the same as your patch, just through a new op code.
> 
> Awesome, thanks for the context Bernd. I think this works for our use
> case then. To confirm the "we will always update attributes on open"
> part, this will only send the FUSE_GETATTR request to the server if
> the server has invalidated the inode (eg through the
> fuse_lowlevel_notify_inval_inode() api), otherwise this will not send
> an extra FUSE_GETATTR request, correct? Other than the attribute

If we send FUSE_OPEN_ATOMIC (or whatever we name it) in
fuse_file_open(), it would always ask server side for attributes.
I.e. we assume that a server that has atomic open implemented can easily
provide attributes or asks for close-to-open coherency.


I'm not sure if I correctly understood your questions about
notifications and FUSE_GETATTR - from my point of view that that is
entirely independent from open. And personally I try to reduce
kernel/userspace transitions - additional notifications and FUSE_GETATTR
are not helpful here :)

> updating, would there be any other differences from using plain open
> vs the atomic open version of plain open?

Just the additional file attributes and complexity that brings.

> 
> Do you have a tentative timeline in mind for when the next iteration
> of the atomic open patchset would be out?

I wanted to have new fuse-uring patches ready by last week, but I'm
still refactoring things - changing things on top of the existing series
is easy, rebasing it is painful...  I can _try_ to make a raw new
atomic-open patch set during the next days (till Sunday), but not promised.


Thanks,
Bernd

