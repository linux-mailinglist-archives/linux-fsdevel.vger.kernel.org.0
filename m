Return-Path: <linux-fsdevel+bounces-29193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A6976F27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 18:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF091C23D38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAB1BE84B;
	Thu, 12 Sep 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGN5fpwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45F1AD256
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160000; cv=none; b=k9N9MdhDZcbf58ZiZ1rvqAhOQgswMp1SypJuVshrpX6apBMmtwVcxfkFjtpKb9zWhQt4vdysw+SE9T/xkWNvb1zAqa7KSubGEHESrhbDsaaxc88FENbU1O7J1kPvEwtv9gUIN8nswJQVuHSMH3LAB+5Bz7k3J8Vq+7lLCFREE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160000; c=relaxed/simple;
	bh=NS0psCyXMoQOWIi5/SsS35KhFzxrGs+XZODMnDu4vlE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TmVKMvj2OmTedvL/4xkQ3l2eh1o4mmnegAwnrMfM8Sm+lwoDr8O5U1+A/T/1halPbNe4AiqKG7jRbQb8T98uqwaztlIeiNzVhjMJAId7rEqZfA9UA6NHgYNlYvPyNGM9a4ACZwKx8/xYF+kSi44H7J7etL1o6GTvLxIOCmwcQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGN5fpwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57703C4AF09;
	Thu, 12 Sep 2024 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726159999;
	bh=NS0psCyXMoQOWIi5/SsS35KhFzxrGs+XZODMnDu4vlE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EGN5fpwXN8eF/DXVbaIirE/I7O2FWMzGft3z3+ITQqplQIVMDNiC/7TGD7+8K5qvW
	 iLDaW0onkKiTiLtYgzhySnFK7QiOs69Yb5StpexuUIEmiU7YRk8LGdK4HxvrUe8hn/
	 i+sEbDymRFZBKtCU2GTJsa++E3+qvgu/YZ3gJqbWjXTyKG8SvZV+nGCVPFVVEzsA9k
	 Cb5oLRsd1NzXl9VeuJGS5qJOleV32h8dqYQilvs92DtWKkrr8fKaWoDXSn+7OS0OUZ
	 Y34ckBQQn/kGf8w8kXDwYh/zO45YRJ7oLEUpn5Yjtd5jNcIUiJ7ii+xQyTpSoznT8f
	 tHOs/Cq6jbuYg==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5EB461200043;
	Thu, 12 Sep 2024 12:53:18 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 12 Sep 2024 12:53:18 -0400
X-ME-Sender: <xms:fhzjZtxr5FxgfOcgpu4W7reiYXKtUmuzhnldk7xndz3itREvy59Amw>
    <xme:fhzjZtSw70R-Ydy5CzcZi0lQI8GuzSiBmSwkEOtRwkfam0YQ6omtwjRId4hcyeqwe
    vd_qIcLUkbKvQrAXSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvg
    hlrdhorhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeef
    iedtudeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlh
    drohhrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepohhlihhvvghrrdhsrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhgr
    uhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehjrggtkhessh
    hushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fhzjZnUavYW64BMj7P5WbzfaZF4yPTdPBSSgy40KL9YRMBbnFxbgmQ>
    <xmx:fhzjZvjNCPZ5thJHvEB-6Ng-fmoF93_CqFemTWgOg5kpRuNpRYyPxw>
    <xmx:fhzjZvBGsNeGGJ_1Z9c-JYXTxRKBZwr--FJ2X6FnabblmxnbtgmRVg>
    <xmx:fhzjZoJw8DvV39S4Eyole57cZwWd9JUpokSRrG4r0jV49EZp9NqpVQ>
    <xmx:fhzjZuBE6nCXh-vzj419XjjjxIJnBVT9ZQZ4ix1sJEFGhxAbwOJrogLU>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 31D48222006F; Thu, 12 Sep 2024 12:53:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Sep 2024 16:51:11 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, "John Stultz" <jstultz@google.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Stephen Boyd" <sboyd@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "kernel test robot" <oliver.sang@intel.com>
Message-Id: <7586990d-ca2b-4ff3-9231-928f1f3be4ea@app.fastmail.com>
In-Reply-To: <12577f7d9865ef8fabc7447a23cdfc1674cbe7e8.camel@kernel.org>
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
 <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
 <d6fe52c2-bc9e-424f-a44e-cfc3f4044443@app.fastmail.com>
 <e4d922c8d0a06de08b91844860c76936bd5fa03a.camel@kernel.org>
 <1484d32b-ab0f-48ff-998a-62feada58300@app.fastmail.com>
 <c9ed7670a0b35b212991b7ce4735cb3dfaae1fda.camel@kernel.org>
 <b71c161a-8b43-400e-8c61-caac80e685a8@app.fastmail.com>
 <284fd6a654eaec5a45b78c9ee88cde7b543e2278.camel@kernel.org>
 <12577f7d9865ef8fabc7447a23cdfc1674cbe7e8.camel@kernel.org>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into timekeeper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 12, 2024, at 14:37, Jeff Layton wrote:
> On Thu, 2024-09-12 at 09:26 -0400, Jeff Layton wrote:
>> On Thu, 2024-09-12 at 13:17 +0000, Arnd Bergmann wrote:
>> > On Thu, Sep 12, 2024, at 11:34, Jeff Layton wrote:
>> 
>> I'll plan to hack something together later today and see how it does.
>> 
>
> Ok, already hit a couple of problems:
>
> First, moving the floor word into struct timekeeper is probably not a
> good idea. This is going to be updated more often than the rest of the
> timekeeper, and so its cacheline will be invalidated more. I think we
> need to keep the floor word on its own cacheline. It can be a static
> u64 though inside timekeeper.c.

Right.

> So, I think that we actually need an API like this:
>
>     /* returns opaque cookie value */
>     u64 ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
>
>     /* accepts opaque cookie value from above function */ 
>     void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie);
>
> The first function fills in @ts with the max of coarse time and floor,
> and returns an opaque cookie (a copy of the floor word). The second
> fetches a fine-grained timestamp and uses the floor cookie as the "old"
> value when doing the cmpxchg, and then fills in @ts with the result.

I think you lost me here, I'd need to look at the code in
more detail to understand it.

> Does that sound reasonable? If so, then the next question is around
> what the floor word should hold:
>
> IMO, just keeping it as a monotonic time value seems simplest. I'm
> struggling to understand where the "delta" portion would come from in
> your earlier proposal, and the fact that that value could overflow
> seems less than ideal.

I was thinking of the diffence between tk->xtime_nsec and the
computed nsecs in ktime_get_real_ts64().

The calculation is what is in timekeeping_cycles_to_ns(),
with the  "+ tkr->xtime_nsec" left out, roughly

   ((tk_clock_read(tkr) - tkr->cycle_last) & tkr->mask) * \
         tkr->mult >> tkr->shift

There are a few subtleties here, including the possible
1-bit rounding error from the shift. 

     Arnd

