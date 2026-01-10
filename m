Return-Path: <linux-fsdevel+bounces-73139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 959CDD0DD5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00F89300263B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE7288510;
	Sat, 10 Jan 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="JTWFp3nG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vQRjGHLZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC702628D
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768076681; cv=none; b=pzZXf+whlexj84vbBVy3SmaMRwVxAkwe1ICOPfBWG2OpNL37h/l3WiGXIWtng3m5YocCcsGycEJvVkxecJOHm8EamcThZw0oirCcYeEjbEHx3RbMeaHM+EWH4Dda/2EqZHj5Kzl1fGeP2khu2r0UxSb4TZzXdoGbGlSp8y3RTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768076681; c=relaxed/simple;
	bh=+F5kkPrC5+KhSXUucUnT6OZwIJPshX1rEt4Zw6Y92Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmkkHCH9A6GOFwsk4ChEYD35f4bS7rbbvVc+OyNPqmuPKamrHUR+uIm8Ivu/POmQqq/OxYVQYWCUUuX+E6irXBWj88yBMhp9x4qb7t87JwgDizf4XOPK/jJ6h07rnTb5zFDirnLQnY5xPk8NirW4hxBa59cSOaqvXqhvhFEf1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=JTWFp3nG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vQRjGHLZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 898A71D000BD;
	Sat, 10 Jan 2026 15:24:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 10 Jan 2026 15:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768076678;
	 x=1768163078; bh=HIjvHAvQOdvsu9w9pgBxXhvqwLspuvmXIf95Cc7uW8Y=; b=
	JTWFp3nGZWy5GDmFO51fWjhYz6SRh8zM/GfG7HWDJXM0wEnqgaBkcdIIFQWN0LxN
	3jNw1QumloS8v7HZm1FXaWUXlf9GKYxVoKpLnR1NJYj8RhPZicPgUDmd67of5qEq
	l4/mVNbrYsHsnC0slBPC/IDL463lVK1lz6E8K0YbIa7xfbY8ypXTZGzhuassCodY
	hZsVoqu4ahDIF5NZGv+8nBxAqOimv+ozvrsfV4AyOj8kiCnChW5zANTWkKBNqAbM
	gfzLS6/efOyGvMGhM8EezbDq6Z5ZbXHNthXufAEk3ns4taZgHA02sQ6mJLu5ba/p
	utaVTU/yyCLKDaNdPYiNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768076678; x=
	1768163078; bh=HIjvHAvQOdvsu9w9pgBxXhvqwLspuvmXIf95Cc7uW8Y=; b=v
	QRjGHLZwRkcaCMToHJ6I2dr39RJct7DqjCsprZ4QEmhQWhdVSpBlyv42DhEanxjt
	jPwp5WqnEUGLJ4pDWPO40v3iMf+uB3O+fKvAgIk/FXr/LVlzcJ0iPWxsSVh5vo4k
	GUkbbIueXjsoMt0zq8gcQfAcPsh8ERg6mGZiQ5pTv0HbwLcrZFl66ePHlzR3l9P5
	TFt3b/RVEHjcbqu40o+3VRffxAUDnMK59RQtsBfKQEJox+OHQShVJKxdR5nRiTWp
	7wv72Hnv2Wi+3ahXIkAdb4Y83s9ableXM4V1O6ZLtAGzJ+PX0pg7gwwVYf9gPM8B
	3pOjVw3xRJW7UV07FN0Kw==
X-ME-Sender: <xms:hbViaTEbYUmjjCWymhchCZgqYvx0JnlOjgq_7k0sZENaBfWYlU_Wzg>
    <xme:hbViaS56pj6R9-4eOU_Jof_E87S8ZMe0EZmp-rbmaKU1tVxQ3h8gk9xKaOzIeXDUl
    JVSomcZFOwhkFoA5vLpMgEzHF6TiwWZ2UyVPK7HINO1cyKGyNg>
X-ME-Received: <xmr:hbViaYwuLUxBo4AvCYL0TGUJkgD4cGtPAkhrjdbkQokTsysr6qBMmf_FgpVjw8VKU4bnMoPiNvqNSOb8pOpGkAk2SxlsPm98qOPhJ1W6U949PG8MQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhorghnnhgvlhhk
    ohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvug
    hirdhhuhdprhgtphhtthhopehhsghirhhthhgvlhhmvghrseguughnrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepuggrvhhiug
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hbViaRNPq2Vk62v1j6bXlJKpoGqk-CiiC47EcYcyzT0WJmWMhVJgDA>
    <xmx:hbViaens_xNAqGpELOKVSFY_b2LL95XOv2Sn45w86HqqhONha0OpDQ>
    <xmx:hbViaWTrPvkN0e7Lj6MFrgZE_MT8P0g0JxwSzKASaIdXn33bowWGCA>
    <xmx:hbViadUNfSjQUYtw__vwRCj0yfTBBSgAGrjotByGUr9wodAmBiEUQQ>
    <xmx:hrViaZ3AzD9P9cEwQOl2g23Ar1HZWqdIBycHay5HHU5Mwct-hUzJ_gIq>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 15:24:36 -0500 (EST)
Message-ID: <60036371-1321-4e3c-a870-5b51f3d867d9@bsbernd.com>
Date: Sat, 10 Jan 2026 21:24:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: __folio_end_writeback() lockdep issue
To: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
References: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
 <b7b72183-f9e1-4e58-b40f-45a267cc6831@bsbernd.com>
 <aWJ-pHIY8Y8sjLeC@casper.infradead.org>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <aWJ-pHIY8Y8sjLeC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/26 17:30, Matthew Wilcox wrote:
> On Sat, Jan 10, 2026 at 04:31:28PM +0100, Bernd Schubert wrote:
>> [  872.499480]  Possible interrupt unsafe locking scenario:
>> [  872.499480] 
>> [  872.500326]        CPU0                    CPU1
>> [  872.500906]        ----                    ----
>> [  872.501464]   lock(&p->sequence);
>> [  872.501923]                                local_irq_disable();
>> [  872.502615]                                lock(&xa->xa_lock#4);
>> [  872.503327]                                lock(&p->sequence);
>> [  872.504116]   <Interrupt>
>> [  872.504513]     lock(&xa->xa_lock#4);
>>
>>
>> Which is introduced by commit 2841808f35ee for all file systems. 
>> The should be rather generic - I shouldn't be the only one seeing
>> it?
> 
> Oh wow, 2841808f35ee has a very confusing commit message.  It implies
> that _no_ filesystem uses BDI_CAP_WRITEBACK_ACCT, but what it really
> means is that no filesystem now _clears_ BDI_CAP_WRITEBACK_ACCT, so
> all filesystems do use this code path and therefore the flag can be
> removed.  And that matches the code change.

Ah right, I had mixed it up, fuse was actually clearing
BDI_CAP_WRITEBACK_ACCT in the past.

> 
> So you should be able to reproduce this problem with commit 494d2f508883
> as well?

Yep, reproducible.

> 
> That tells me that this is something fuse-specific.  Other filesystems
> aren't seeing this.  Wonder why ...
> 
> __wb_writeout_add() or its predecessor __wb_writeout_inc() have been in
> that spot since 2015 or earlier.  
> 
> The sequence lock itself is taken inside fprop_new_period() called from
> writeout_period() which has been there since 2012, so that's not it.
> 
> Looking at fprop_new_period() is more interesting.  Commit a91befde3503
> removed an earlier call to local_irq_save().  It was then replaced with
> preempt_disable() in 9458e0a78c45 but maybe removing it was just
> erroneous?
> 
> Anyway, that was 2022, so it doesn't answer "why is this only showing up
> now and only for fuse?"  But maybe replacing the preempt-disable with
> irq-disable in fprop_new_period() is the right solution, regardless.

With fuse tmp pages mapping was NULL in past? I.e. I *guess* the trigger
is 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb
tree"), although I'm confused why I didn't run into this earlier.


Bernd


