Return-Path: <linux-fsdevel+bounces-29129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3FF975BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 22:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6092E1C226F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 20:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3D1BC089;
	Wed, 11 Sep 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8OYb6Et"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424431BB69F;
	Wed, 11 Sep 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085980; cv=none; b=eauZ8890TUBucKO8Cbf/tYI7EiFQT1wkcUqubJjlJoBdaHyy/BMGrCplW/cAb2tK1Dam6UlPkEs6nRbJdpNxI3AILoqVMAXlHcYZ1WuIcST7j9f+g5PB3pzUSOdM+ef3NwWLa1JH/n62EMJO7M8eamEDMkpnOpb7iB3oSfYQO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085980; c=relaxed/simple;
	bh=fTzUIQ6MBGlxxuKGdlLuP5iQaJj0ok5XOKBcZat6TP0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hItV6PAWA1T3VmKU/4htbpyP4YklqEUQFJTu8lLNLldD0/pnffBC/Q7UR/L3FCb5QCFZZgoNs8upNPDcdhCobjWKE2wDNyaFpLTOA2VW8YD3C8ae4Qp7iH5qyw1yzZGJQ5m0Xmfm1gguVAfQWIK2+pRfyEyTZcsdiNOOppf/ly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8OYb6Et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985FCC4CECD;
	Wed, 11 Sep 2024 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085980;
	bh=fTzUIQ6MBGlxxuKGdlLuP5iQaJj0ok5XOKBcZat6TP0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=E8OYb6EtwLyzWLtv2fMTz+S1tamIFbGWe5zuIWp6/reTp0t5PlWSrPZF84k1lYtBE
	 +rjCJWbG4TqV6MPWTrjTnulEah/lb/ZxpVWcEjYWW8jQgmfRxOdzff1IXhsn9QYpG8
	 PwnTGHgHTALSm/VDTHMGk9nDLP/7I93434Z41JVsPVG8mtusYR763G3wRFSCY+CP7t
	 aTRVH+l24Sn19cNTlCn8VUWsk9H37BVSNJwrFoCGawkzOJyQzpQUokYc/T2uZtgXb0
	 0QL5NGtYR79U508GkqIvEz6qm584uZjCcJ9L8Rrb0wg6R7XhhT2Ky+9bZbgvraJq1s
	 2RtHVQm+DFIKA==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A80121200084;
	Wed, 11 Sep 2024 16:19:38 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 11 Sep 2024 16:19:38 -0400
X-ME-Sender: <xms:WvvhZpxqQ9mTTXdYMelY883s5sTrSj150INZPpZeNCO6UGYVaCBUHg>
    <xme:WvvhZpSoQuuY1F8qJ_0oKmF7OkUFzVysjYhXcRwTVXG7Okv6hhU-PEeE8WRttntDN
    HWQc2B67gCcnbMD2-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgudegiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:WvvhZjUXp8YNXIIzAf_LXfdbX4iXcAIJMsgGOnRqyofoNb1H4xQuIg>
    <xmx:WvvhZrjrvVMHGm-ru2GfV0fxgu8hb2fZFaUjfGV4gmxuQAtc3MTq3Q>
    <xmx:WvvhZrBxiGO6U75XKzP1b_dfP1bBO3rjQo_OWIAR1Edx2Ay_b6ZMgg>
    <xmx:WvvhZkIkY-Zdy6ek3fjdHnWRxncemWtvc9Bby00cSDFykeat66KISA>
    <xmx:WvvhZqBNP0ZkHqaaao5BHeDE3ZyyKYN676sziQkPohMe_BlmomGGLaAi>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 74F1E222006F; Wed, 11 Sep 2024 16:19:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 20:19:17 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "John Stultz" <jstultz@google.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Stephen Boyd" <sboyd@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "kernel test robot" <oliver.sang@intel.com>
Message-Id: <d6fe52c2-bc9e-424f-a44e-cfc3f4044443@app.fastmail.com>
In-Reply-To: 
 <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
 <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into timekeeper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 11, 2024, at 19:55, John Stultz wrote:
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index 5391e4167d60..56b979471c6a 100644

> My confusion comes from the fact it seems like that would mean you
> have to do all your timestamping with CLOCK_MONOTONIC (so you have a
> useful floor value that you're keeping), so I'm not sure I understand
> the utility of returning CLOCK_REALTIME values. I guess I don't quite
> see the logic where the floor value is updated here, so I'm guessing.

I think we could take this further and store the floor value
in the timekeeper itself rather than in a global variable
next to the caller.

And instead of storing the absolute floor value, it would
be enough to store the delta since the previous
update_wall_time(), which in turn can get updated by a
variant of ktime_get_real_ts64() and reset to zero during
update_wall_time().

That way the coarse function only gains a call to
timespec64_add_ns() over the traditional version, and the
fine-grained version needs to atomically update that value.
If the delta value has to be a 64-bit integer, there also
needs to be some serialization of the reader side, but I
think that can be done with read_seqcount_begin() .

      Arnd

