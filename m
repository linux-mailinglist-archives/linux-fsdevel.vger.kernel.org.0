Return-Path: <linux-fsdevel+bounces-73064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 332EBD0B22B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35DC9311948C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F02798F8;
	Fri,  9 Jan 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuT8YzAv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064429DB61
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974753; cv=none; b=SN+793Fz9n9/1bpveO0Mec2VXsO4tQomQ2rM6UjXu0LSE3eCCtSPB9/+rGCdT+dQoQBoCDynZf+A00fErHe1Lpwllc1Hx2RwvX3GI/HQzPfLYR87C7W972JBlJRUBd9JoU09SsuadBZ4ZJwF7divXo6gTL5RjzXzoZS3Byj/0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974753; c=relaxed/simple;
	bh=rW/rTpihqkxbF6uD8C9NgKx2EVKr9FQbfu3UwOC5tpw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YLJE8rRSqIwt7Q6feF3NJ9L3m7OeI9mB2qU7INi9CdI7K77ZUg5I2HzAwrGJPaVeKuUARqnELxTUhrgRjMqKIf01stxKdMi/Z1xjVHJQGxiY8B70hXuVYCNYMceN0u1fYPu8m9TkiZ39XDN58jixwFQ/t5uRti8tMbHTSqiLFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuT8YzAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EC8C4AF0B;
	Fri,  9 Jan 2026 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767974753;
	bh=rW/rTpihqkxbF6uD8C9NgKx2EVKr9FQbfu3UwOC5tpw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OuT8YzAvZm2eWh8HXh6/iGpn3IdJiIMpJi5tmMR63ZBoQE0pFG3QWMa8bRMT2xTtI
	 jn9AYkAiRwAKhJtaRgh8NSd/OHHoa0LXLC/FpdxYxkgELYrMjrD+i85Ac01gFcNKwB
	 vgPPN1ZQ22A59kkmDli4cZrqtRjj37ZsxFlVsE0YripoLuKiGKP5d7p5z+BMYVGmal
	 H2j9VElZXPKx8275trmtBxhEx8xzs/eCPYxkrVouCCmXmHmQbgKfXlS/BQL9XqPNA4
	 3I+/iYP5MS22/SjeSwfCWGuFePuEgP0ELMPjWWC7VqsFMOkwymz5J59GOARn2dMKU+
	 0WDbVv99YVbqA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54107F40068;
	Fri,  9 Jan 2026 11:05:52 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 11:05:52 -0500
X-ME-Sender: <xms:YCdhaWD6X65ECJ4aIU3MZxfgPGBk3BAdlLC5ALx99PnEdQrjh2uKYA>
    <xme:YCdhabWu3mVcygelgI_bCBx6elyPhv85WKviDBLxThvrlt9dGciKF8bT7-l39jiRx
    vtLxI-Pmznhn0Z38GxdzStAM51GwBGv9D1pGzW4E6amSyVrTXX4QEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghl
    vgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YCdhaTCf8EPc07uQZ6s8jMg0-UEd9EiBq0glum7R-8DJzbZ1bfnnVQ>
    <xmx:YCdhaVjlcF04ZZSa76ZqafOWo-KmlWJ975nfGZINgg_f0DvjvSL1cg>
    <xmx:YCdhaQwHAnfPlK4YHAXUj66muVz4plhuyGjjohuIJmiRgTTqwaFFOQ>
    <xmx:YCdhaW2o9Zf-wRZrrhtUVkL0kHjB_2ql3O3iWK9OLOWNSpewFVnxjw>
    <xmx:YCdhaV95hLpieC8WUuVS6NBaSwV9U-riabqfmqNrqxFAdYeVc8uIMEHL>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3344378006C; Fri,  9 Jan 2026 11:05:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGJJpQnrpxIw
Date: Fri, 09 Jan 2026 11:04:49 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <50610e1c-7f09-4840-b2b2-f211dd6cdd5f@app.fastmail.com>
In-Reply-To: <176794792304.16766.452897252089076592@noble.neil.brown.name>
References: <20260108004016.3907158-1-cel@kernel.org>
 <20260108004016.3907158-5-cel@kernel.org>
 <176794792304.16766.452897252089076592@noble.neil.brown.name>
Subject: Re: [PATCH v2 4/6] fs: invoke group_pin_kill() during mount teardown
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 9, 2026, at 3:38 AM, NeilBrown wrote:
> On Thu, 08 Jan 2026, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> The group_pin_kill() function iterates the superblock's s_pins list
>> and invokes each pin's kill callback. Previously, this function was
>> called only during remount read-only (in reconfigure_super).
>> 
>> Add a group_pin_kill() call in cleanup_mnt() so that pins registered
>> via pin_insert_sb() receive callbacks during mount teardown as
>> well. This call runs after mnt_pin_kill() processes the per-mount
>> m_list, ensuring:
>> 
>>  - Pins registered via pin_insert() receive their callback from
>>    mnt_pin_kill() (which also removes them from s_list via
>>    pin_remove()), so group_pin_kill() skips them.
>> 
>>  - Pins registered via pin_insert_sb() are only on s_list, so
>>    mnt_pin_kill() skips them and group_pin_kill() invokes their
>>    callback.
>> 
>> This enables subsystems to use pin_insert_sb() for receiving
>> unmount notifications while avoiding any problematic locking context
>> that mnt_pin_kill() callbacks must handle.
>
> I still don't understand.
> In your code:
>>  	if (unlikely(mnt->mnt_pins.first))
>>  		mnt_pin_kill(mnt);
>> +	if (unlikely(!hlist_empty(&mnt->mnt.mnt_sb->s_pins)))
>> +		group_pin_kill(&mnt->mnt.mnt_sb->s_pins);
>
> mnt_pin_kill and group_pin_kill() are  called in exactly the same locking
> context.

The "locking context" rationale in the commit message is stale. The
actual distinction between pin_insert() and pin_insert_sb() is
semantic: per-mount versus per-superblock granularity. I've updated
the kdoc comments and commit message in my private tree.


> Inside these functions the only extra lock taken before invoking the
> callback is rcu_read_lock(), and it is the same in both cases.
>
> So if mnt_pin_kill() callbacks must handle problematic locking, then so
> must group_pin_kill() callbacks.
>
>> 
>> Because group_pin_kill() operates on the superblock's s_pins list,
>> unmounting any mount of a filesystem--including bind mounts--triggers
>> callbacks for all pins registered on that superblock. For NFSD, this
>> means unmounting an exported bind mount revokes NFSv4 state for the
>> entire filesystem, even if other mounts remain.
>
> That doesn't sound like a result that we want.

I agree that isn't the desired behavior.

Jeff mentioned to me privately that the fs_pin API may be deprecated,
with its sole current consumer (BSD process accounting) destined for
removal. I'm waiting for VFS maintainer review for confirmation on
that before deciding how to address your comment. If fs_pin is indeed
going away, building new NFSD infrastructure on top of it would be
unwise, and we'll have to consider a shift in direction.


> Can you be more explicit about the problems of the locking context that
> nfsd would need to face if it used pin_insert() ?

It's likely that is lost to the shifting sands of memory, as it was
something that came up while developing these patches and then never
documented properly.


-- 
Chuck Lever

