Return-Path: <linux-fsdevel+bounces-29175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0237976A5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D63DB21683
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B461AE87C;
	Thu, 12 Sep 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQe0580N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FB1A3020;
	Thu, 12 Sep 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147096; cv=none; b=A3peHm7Vc5bNKkXy/21yLinPGh8LiZxV/pwH8UZIU65HdUlZeNPpMCOSzOuRD6oISSaz6wIcUw0RmKbr8hOHAsiNJhmajjbRH1OmIxos6W41etCBX7R8TxOZpmGd6+/ojIcuCQFwDAAnLnjPfEU7gRlV7NN+THxxri5QzHGeFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147096; c=relaxed/simple;
	bh=Cu1pQUxXwIUIzVF52yjB13vZeQmqXJGkdAlblCJUTp0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TbqJfqqq6Osj2ir7ruKeQicGK4z07vPhRby1oYcv7Qvb3I9AtBoutaaxz05b97FvNjB/E55h3p4GRBZUu+s2mYKS8cQk+3LPY1nqTL9yTsUV8JZ66SpcCcrp5iuSgY7B0KgYybzi3e/2sdH1GgMNeshGy7p17VKg2qXkLXqUGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQe0580N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23648C4CEC4;
	Thu, 12 Sep 2024 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726147095;
	bh=Cu1pQUxXwIUIzVF52yjB13vZeQmqXJGkdAlblCJUTp0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sQe0580NCUZn1g0KpfJ9YcJSZlzlafKzaYcYoepTSaANDhw5sql8hjJPJZWeCcvQW
	 532ddoOUtyaD/hXAiRpbYgY4z0KzcVviMaCG/89wt7FXW6SY72BumaGP2BdxTq/0fC
	 nefz4NGTdl8rCRyr2QLNAXVS4wR8wudIGzZFnQlDGRuIWRKcGXzTZCceP14MzF9sYP
	 WjcSWdOeD2xcpSmg0CnmKzzZ4jsp3lp4yRWcGyUqxkRDlKeYOSPJnh3Sgo+mMk6II0
	 C86WH4iupSNCEXUp2zgtXVj0op5sYoC9gAilN0FB4x9hjgShJCsRIxuOzBLKQe40En
	 ywT43Z4G/1t3Q==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3AF091200068;
	Thu, 12 Sep 2024 09:18:14 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 12 Sep 2024 09:18:14 -0400
X-ME-Sender: <xms:FuriZiuNwwOSO2OuEt8UpaIuQuLG3PLBudTHzIspBX1Uk2vIa_EcbQ>
    <xme:FuriZnfZsQAbDmTMZ9d9JuIiKCOMNBxgd83Ygxuy4mSbIavBVUfQRiUyEG-IewIm9
    kiSS0CPKJJeY5z9nXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfeffeei
    tdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehjshhtuhhlthiisehgohhoghhlvgdrtghomhdprhgtphhtth
    hopeholhhivhgvrhdrshgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghrrghu
    nhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepjhgrtghksehsuh
    hsvgdrtgiipdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FuriZtzZLrjk7OCjccfy4Z4N11F3ZL9v4a_ww_o-jHGMxOfcCL-M1A>
    <xmx:FuriZtPWYWevc9p0o8rCxf6CWye1zRZBvvcOuF-h0DKa_E2xey-AzA>
    <xmx:FuriZi_OcSyCPAyBhyOgsrjsYNNQmlnkG3m46aWrWIvVmUvpR7kbVQ>
    <xmx:FuriZlWg7YEAm3Gq8iVb6QNw7VCZT8HBPjedf6WsGbflD9OIYdLfRA>
    <xmx:FuriZrczM8dluR8_KpuRXmVcKlBX8GjhoZaQsOGLM1n_PQ81s2yjsFzv>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D8C52220071; Thu, 12 Sep 2024 09:18:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Sep 2024 13:17:16 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, "John Stultz" <jstultz@google.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Stephen Boyd" <sboyd@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "kernel test robot" <oliver.sang@intel.com>
Message-Id: <b71c161a-8b43-400e-8c61-caac80e685a8@app.fastmail.com>
In-Reply-To: <c9ed7670a0b35b212991b7ce4735cb3dfaae1fda.camel@kernel.org>
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
 <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
 <d6fe52c2-bc9e-424f-a44e-cfc3f4044443@app.fastmail.com>
 <e4d922c8d0a06de08b91844860c76936bd5fa03a.camel@kernel.org>
 <1484d32b-ab0f-48ff-998a-62feada58300@app.fastmail.com>
 <c9ed7670a0b35b212991b7ce4735cb3dfaae1fda.camel@kernel.org>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into timekeeper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 12, 2024, at 11:34, Jeff Layton wrote:
> On Thu, 2024-09-12 at 10:01 +0000, Arnd Bergmann wrote:
>> On Wed, Sep 11, 2024, at 20:43, Jeff Layton wrote:
>>
>> That way you avoid the atomic64_try_cmpxchg()
>> inode_set_ctime_current(), making that case faster,
>> and avoid all overhead in coarse_ctime() unless you
>> use both types during the same tick.
>> 
>
> With the current code we only get a fine grained timestamp iff:
>
> 1/ the timestamps have been queried (a'la I_CTIME_QUERIED)
> 2/ the current coarse-grained or floor time would not show a change in
> the ctime
>
> If we do what you're suggesting above, as soon as one task sets the
> flag, anyone calling current_time() will end up getting a brand new
> fine-grained timestamp, even when the current floor time would have
> been fine.

Right, I forgot about this part of your work, the 
I_CTIME_QUERIED logic definitely has to stay.

> That means a lot more calls into ktime_get_real_ts64(), at least until
> the timer ticks, and would probably mean a lot of extra journal
> transactions, since those timestamps would all be distinct from one
> another and would need to go to disk more often.

I guess some of that overhead would go away if we just treated
tk_xtime() as the floor value without an additional cache,
and did the comparison against inode->i_ctime inside of
a new ktime_get_real_ts64_newer_than(), but there is still the
case of a single inode getting updated a lot, and it would
break the ordering of updates between inodes.

       Arnd

