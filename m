Return-Path: <linux-fsdevel+bounces-33244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF89B5EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 10:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA191F2236A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FD1E1C19;
	Wed, 30 Oct 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="HixTjREt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0Rns9Bg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A21E1A2B
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280767; cv=none; b=CsJMz1V7eej31WVRMa2hKw59oxFaaFwR4Hslspo/wUeCm1fGBUeln0Uswi/LMetDGcdP/cVlc+lVw9VMAvZS3HrjVGPYPH9RyCbRx4SQ+1/UNrRduFZX/oRz6prBjWvz2ZtrEeecSHQLMknLfXXfdzzsOEFMdnp44sFf7ulv8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280767; c=relaxed/simple;
	bh=0XW8/n8mpIcw22IVfFg6EFK75cqIw4TmCNA+rf1Yj8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLk+pN0mhu7CcioLnAlGzxWY2+iyQJTdt9Qoa0Ns5wKS7yQlH+SxEXQiDEEmVpsbFVpOBtQ2hiCzel3WXrsVdJ2wq0y2hp8o31LkUjIrjqt47oiK3QzvtbgHBvxzUXO0EFU/ic8fg0+XwPQLTD/Iv2aQGI6HLd8N83cA1FI4PQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=HixTjREt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0Rns9Bg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B005711400F0;
	Wed, 30 Oct 2024 05:32:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 30 Oct 2024 05:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730280762;
	 x=1730367162; bh=vP47Fi19GSqOURIFyHr3BgCH6OFkEfDLoamJ4JOvUm4=; b=
	HixTjREtC+k1ucSRHUmEFo4cmyhIT9/dw0JpbD1qG7gZHdvirOTWTRNGN9kDJX0A
	ZT+g/n6g/pBJf49p1XrvOHgAOjBDHxKW3k8P/S31Ibq4JJVGN0KR5AIfEXhLyCDG
	cPstjK8NNtSKXU6QzkWxmIRobHEYs98NucVSFhxr3qE+dSHyethdJ6tnj1J/oNrz
	cohSPO9cGfSxj+0rPyLEX4iL9QQqxP5owagKXeW4uqbS77NKfxU7aol3Qmr500Le
	rkCdvRebPvd6g3pE5scPKGWNnSKra8jkxt83n85O9gLwiuibdm+lUPZzyg8mgj/0
	IhQnqCtcCpttJq0BDnfg9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730280762; x=
	1730367162; bh=vP47Fi19GSqOURIFyHr3BgCH6OFkEfDLoamJ4JOvUm4=; b=V
	0Rns9BgI1Q4hrq70oytQoOK8A1SGb2tSLjDeGZd5OTcr26AOrmPuJM4uEMAx1lWj
	Ni9+tBv9KANYCCzwyTIt4ikeLGwl0qW4Db7JKQGw6B3fah36lIKTxMqYbWun7bJm
	2JEw5WpWF4HIlgyPnDjaH5YsecklDz8W/0x77Y0aevzM7G6RmXcUFAwNMWTuhgtw
	3D9Q10UjVCbUKigp87BkrhgzTnZIbcBKBAVHvEXPjvgDVXrbyeGYq4625hFwY0Pi
	y0reeSshZhsrQGBksM5s5ddsIKzS+2RYRmac2Oy5q4+k/ezjJR81vUEn9cqrbGFu
	ZHc1CJDUHXsbkOB9TpZnQ==
X-ME-Sender: <xms:OP0hZ6i4wr2pU_H0LdeABsspaO4xGG0xU5_5paObq_W--A7C-XSGqg>
    <xme:OP0hZ7CrpfBuS5FJbpBiB__LdRpb0F3b8ypg3iIwDTYv0GOQcoVSrzZwCTVqjLuFF
    RuuP_dZRriQpSjH>
X-ME-Received: <xmr:OP0hZyGSaiwfF5By7zy3slCRN1McIcKH3ajgPsDP21394BK6zNDtp5bKiv2k0Z9ToJsr1fPmAFSJoCE1ZUQxb3AFJyID_uuFtLf7FrdtUpYC9XwRn9wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgtdehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:OP0hZzRK-UFLWotR_AnqbI_z05lZV2vHcyL8FAJV8YJF2F7aB-bA2A>
    <xmx:OP0hZ3wUA8xlrimZ43sL_migq40i3LVSR_VUjDvFUd5thpdIYr4H3Q>
    <xmx:OP0hZx697YzqrbLObBWk5mkQeg73zTP5x8rAqpmX4w9YIHcxQ1CpYQ>
    <xmx:OP0hZ0wLaGckwYeCnwzJqr6pjRHQ9l5EZHOID-nTZvU-ciucdcWu1g>
    <xmx:Ov0hZ_dfhe-XlDjv4t7ubqIDO0KvvvYnR_EBCE0iGQ3Bu_bq-uEnp1U0>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 05:32:39 -0400 (EDT)
Message-ID: <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm>
Date: Wed, 30 Oct 2024 10:32:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
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
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/24 22:58, Joanne Koong wrote:
> On Fri, Oct 25, 2024 at 3:40 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>>> Same here, I need to look some more into the compaction / page
>>> migration paths. I'm planning to do this early next week and will
>>> report back with what I find.
>>>
>>
>> These are my notes so far:
>>
>> * We hit the folio_wait_writeback() path when callers call
>> migrate_pages() with mode MIGRATE_SYNC
>>    ... -> migrate_pages() -> migrate_pages_sync() ->
>> migrate_pages_batch() -> migrate_folio_unmap() ->
>> folio_wait_writeback()
>>
>> * These are the places where we call migrate_pages():
>> 1) demote_folio_list()
>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>
>> 2) __damon_pa_migrate_folio_list()
>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>
>> 3) migrate_misplaced_folio()
>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
>>
>> 4) do_move_pages_to_node()
>> Can ignore this. This calls migrate_pages() in MIGRATE_SYNC mode but
>> this path is only invoked by the move_pages() syscall. It's fine to
>> wait on writeback for the move_pages() syscall since the user would
>> have to deliberately invoke this on the fuse server for this to apply
>> to the server's fuse folios
>>
>> 5)  migrate_to_node()
>> Can ignore this for the same reason as in 4. This path is only invoked
>> by the migrate_pages() syscall.
>>
>> 6) do_mbind()
>> Can ignore this for the same reason as 4 and 5. This path is only
>> invoked by the mbind() syscall.
>>
>> 7) soft_offline_in_use_page()
>> Can skip soft offlining fuse folios (eg folios with the
>> AS_NO_WRITEBACK_WAIT mapping flag set).
>> The path for this is soft_offline_page() -> soft_offline_in_use_page()
>> -> migrate_pages(). soft_offline_page() only invokes this for in-use
>> pages in a well-defined state (see ret value of get_hwpoison_page()).
>> My understanding of soft offlining pages is that it's a mitigation
>> strategy for handling pages that are experiencing errors but are not
>> yet completely unusable, and its main purpose is to prevent future
>> issues. It seems fine to skip this for fuse folios.
>>
>> 8) do_migrate_range()
>> 9) compact_zone()
>> 10) migrate_longterm_unpinnable_folios()
>> 11) __alloc_contig_migrate_range()
>>
>> 8 to 11 needs more investigation / thinking about. I don't see a good
>> way around these tbh. I think we have to operate under the assumption
>> that the fuse server running is malicious or benevolently but
>> incorrectly written and could possibly never complete writeback. So we
>> definitely can't wait on these but it also doesn't seem like we can
>> skip waiting on these, especially for the case where the server uses
>> spliced pages, nor does it seem like we can just fail these with
>> -EBUSY or something.

I see some code paths with -EAGAIN in migration. Could you explain why
we can't just fail migration for fuse write-back pages?

>>
> 
> I'm still not seeing a good way around this.
> 
> What about this then? We add a new fuse sysctl called something like
> "/proc/sys/fs/fuse/writeback_optimization_timeout" where if the sys
> admin sets this, then it opts into optimizing writeback to be as fast
> as possible (eg skipping the page copies) and if the server doesn't
> fulfill the writeback by the set timeout value, then the connection is
> aborted.
> 
> Alternatively, we could also repurpose
> /proc/sys/fs/fuse/max_request_timeout from the request timeout
> patchset [1] but I like the additional flexibility and explicitness
> having the "writeback_optimization_timeout" sysctl gives.
> 
> Any thoughts on this?


I'm a bit worried that we might lock up the system until time out is
reached - not ideal. Especially as timeouts are in minutes now. But
even a slightly stuttering video system not be great. I think we
should give users/admin the choice then, if they prefer slow page
copies or fast, but possibly shortly unresponsive system.


Thank,
Bernd

