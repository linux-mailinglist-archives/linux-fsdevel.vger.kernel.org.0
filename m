Return-Path: <linux-fsdevel+bounces-39191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C2DA11338
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916C6188691C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069A20B1F5;
	Tue, 14 Jan 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="sIGjZFgn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w8Co961e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D8209F4C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890816; cv=none; b=HOkNlhrE9gbOz+UVWuLBBK/SK05ipmM9T0tSQ0wsitLeJxttWGsF9jNkdWBrutXyfpPgUIIGY2hTpakAYuk5vHJ4+c1EHkcRLAbAp649xGI+NDCfsHQp7vmhVbzzkLqQj0KbsNqZQEPCxxdU2mSbFK2+Jb5HABhvb3yXk4nID4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890816; c=relaxed/simple;
	bh=0mGa3nKZa2DRI066l2vWdCl4d5575tAWJ3U4FdqdJBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPSnpxrmPajl8LwBjKo1tfa2oWJ+bMPvaS4O/XuKOZkUHhPndsWTGebGHxwof5peNcY8N6eBF7pLyfJDHt6loAXYim1VetdmnwbnxnP9aeFnf1y6i7YYBWnOGY8iPzI6zORitYn0ij6unPSA7d9vy0sSN9VJBOQQx8994bQleXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=sIGjZFgn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w8Co961e; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E2A8138025D;
	Tue, 14 Jan 2025 16:40:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 16:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736890813;
	 x=1736977213; bh=7SnkAapVOWOoQzhpCp9f1lx43PiwZJ468hSDGpsT83E=; b=
	sIGjZFgnPlbWPVIYQM4v9OpVA3MPqqTkbsuLQL7BiNLEk9v80DTBpT7unrsbGcDs
	uoys8thnagm+NQlm19aaSii75U1jZTOPtKbLwTtmHlMQ9IneZVFdwIaAdqTD4vvG
	H1SaheEp2sP/OqBdJL8zlP51EQikHeGWjzpIRx04XF4qBs2O1UvdG/HnyHZzLkZW
	xPc4qXiyl4gZtrHJEefYfy2KnuT8YBJZr5XxCUbmOtMnvA1GVlAiTimsDU0rQces
	kZkHkt0DosiMw7X19+pgNmdFmECwi076gS4VoygZPNz45w6xzbf3CPaJEU3xP11y
	E5mTuy8XUM55FkzPQbZXww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736890813; x=
	1736977213; bh=7SnkAapVOWOoQzhpCp9f1lx43PiwZJ468hSDGpsT83E=; b=w
	8Co961eEsl+3e08D50sQEQci5sLOC7pW59FVCXV0rXs/lTT7Es7NDAFW2KYttCle
	WPp8VpwNeIrlQIqpoBwVq7WPbnae7A6mYCZsXXAgaz+SSis2pIQOBQqSrCJiq6lG
	XB9qgV10VpLAndY7Q4/HgxP266Zmto0C9dmOu8Lj9/UGeGce4W4p3LL9GvS0pKjW
	lqFhWSpk/MHj2RDJaYdFrlkEV98oBxni4GWi+lhRUgpmqw85XTwstfRbjgV2FMHC
	Bu22mAenjbY6+CstuCVVt4otN8WXP44Es270Wv+r0uuzFvF0pEY256KV/swP5k1c
	HdcIyoeYP9B1y3EhwY2QQ==
X-ME-Sender: <xms:u9mGZ8LCSPbz1Ggrd1kLKB1iBeIeaa_3N7TZ4kTNj4qVw-5gYR-_3w>
    <xme:u9mGZ8JUw0pAYv7X3Kg6dmU3jh65XE4GTZtxCV8uCaxqPryWpA-bxLmeKM8ulbc1Q
    Hwi6JA9TU0tZTRP>
X-ME-Received: <xmr:u9mGZ8u6iakDvVTYwfQ_i5iAF0914_6_8lxS5-Xa_Khy-R7Dk9KrZRBdnX6NiDn80YwRE4eTYOBFwXfLG8b5XRq2faufIY96cmKISp-UOZTniYLhabDi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevgfeukedtfeeu
    gfekueeikeeileejheffjeehleduieefteeufefhteeuhefhfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlrgih
    thhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdp
    rhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehshhgrkh
    gvvghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtthhopeiiihihsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggr
    sggrrdgtohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhm
X-ME-Proxy: <xmx:u9mGZ5ZWfm-zOLme0D3wKOmDRLRBCy0yJvybZB2cLSkj0PHOxrtXhQ>
    <xmx:u9mGZzZmIR30ZWlqwQ0hH0EkaZhYeEgTmCAbYsj9f8LKljokUzw69w>
    <xmx:u9mGZ1Clu_fSRc1pMgV8PxFCccPlucoCKvJz7uUd5gslZSbunFfZZA>
    <xmx:u9mGZ5bUyEkX5dlMksw4646bjDkuUDRqY0HhzVSh2s8fMg5dctWXaA>
    <xmx:vdmGZwSgjVbQXQkgTEMMBdCYQpKvz6zP5MgLFI0hG8PxKb5E-gwvbsHU>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 16:40:09 -0500 (EST)
Message-ID: <630dd043-6094-482a-9544-f4eb4202d1c2@fastmail.fm>
Date: Tue, 14 Jan 2025 22:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: David Hildenbrand <david@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>, David Wei <dw@davidwei.uk>,
 Ming Lei <tom.leiming@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
 <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com>
 <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm>
 <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
 <CAJnrk1ZP4yZZDR0fZghBmuN-N=JfrbJZALBH0pdaC5_gGWFwEw@mail.gmail.com>
 <CAJfpegvqZnMmgYcy28iDD_T=bFgeXgWD7ZZkpuJfXdBmjCK9hA@mail.gmail.com>
 <CAJnrk1Y14Xn8y2GLhGeVaistpX3ncTpkzSNBhDvN37v7YGSo4g@mail.gmail.com>
 <d5ffad60606fbf467af6c3b1aee3e5a59bd6c5a8.camel@kernel.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <d5ffad60606fbf467af6c3b1aee3e5a59bd6c5a8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/14/25 21:29, Jeff Layton wrote:
> On Tue, 2025-01-14 at 11:12 -0800, Joanne Koong wrote:
>> On Tue, Jan 14, 2025 at 10:58 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>
>>> On Tue, 14 Jan 2025 at 19:08, Joanne Koong <joannelkoong@gmail.com> wrote:
>>>
>>>> - my understanding is that the majority of use cases do use splice (eg
>>>> iirc, libfuse does as well), in which case there's no point to this
>>>> patchset then
>>>
>>> If it turns out that non-splice writes are more performant, then
>>> libfuse can be fixed to use non-splice by default.   It's not as clear
>>> cut though, since write through (which is also the default in libfuse,
>>> AFAIK) should not be affected by all this, since that never used tmp
>>> pages.
>>
>> My thinking was that spliced writes without tmp pages would be
>> fastest, then non-splice writes w/out tmp pages and spliced writes w/
>> would be roughly the same. But i'd need to benchmark and verify this
>> assumption.
>>
> 
> A somewhat related question: is Bernd's io_uring patchset susceptible
> to the same problem as splice() in this situation? IOW, does the kernel
> inline pagecache pages into the io_uring buffers?

Right now it does a full copy, similar as non-splice /dev/fuse
read/write. I.e. it doesn't have zero copy either yet.

> 
> If it doesn't have the same issue, then maybe we should think about
> using that to make a clean behavior break. Gate large folios and not
> using bounce pages behind io_uring.
> 
> That would mean dealing with multiple IO paths, but that might still be
> simpler than trying to deal with multiple folio sizes in the writeback
> rbtree tracking.


My personal thinking regarding ZC was to hook into Mings work, I
didn't into deep details but from interface point of view it sounded
nice, like

- Application write
- fuse-client/kernel request/CQEs with write attempts
- fuse server prepares group SQE, group leader prepares
  the write buffer, other group members are consumers
  using their buffer part for the final destination
- release of leader buffer when other group members
  are done


Though, Pavel and Jens have concerns and have a different suggestion
and at least the example Pavel gave looks like splice

https://lore.kernel.org/all/f3a83b6a-c4b9-4933-998d-ebd1d09e3405@gmail.com/


I think David is looking into a different ZC solution, but I
don't have details on that.
Maybe fuse-io-uring and ublk splice approach should be another LSFMM
topic.


Thanks,
Bernd




