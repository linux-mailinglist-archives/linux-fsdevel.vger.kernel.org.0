Return-Path: <linux-fsdevel+bounces-29145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA08976642
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE581C23294
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937C19F10B;
	Thu, 12 Sep 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIbtk/mH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA167136328
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135362; cv=none; b=JEoFUe08zttWCBvW5c2GAidjMdEyNYe2z34oZQ03pX4iNIgZ3K/DTzcMe/umdWLuAgLf750AW15GPIVTDeLZQWFG9MhuV5Q0Jwqj2LcJJmbGbOgiYr0AFCjxQOWSV2QY81Lb0yA3qCrUSVfWhw14ESahYHLwSwTpeBPDS1OLJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135362; c=relaxed/simple;
	bh=a5vCrkBl64E/DxQ9VPHN+y7+aJZs9Z1Kpz+98ZbYe4Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KvhLfUyJJLTmIgVPYFrL3mKLe5hQosdCJeyy3A+2vaH1LaMGEPOjSuggsAMiQUJetyb5RU6oo9Fx4QClhFOzt8IPw6CcLUUI8rvbh+qhCvn5uBynOtpvRQddXg0qW5kHUYF84emTHXSIQzUaMOcvhtcBbzbve77e05iYVMT1kV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIbtk/mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5968AC4CEC5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726135362;
	bh=a5vCrkBl64E/DxQ9VPHN+y7+aJZs9Z1Kpz+98ZbYe4Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cIbtk/mHKhxFttFlEB0tywkl4cFj4dA5RxxCfdbjlgnyzU9QdOmH1GXUBilh5AL0b
	 /Y46yLkHoH/kR7rBbCBxls1xeQczIY4fOsWl5duUg+8BL+gxI2+23UYq+byI3iV3nH
	 uD2f3RIJo9ao8RtHJU6OpK3LEq3LAf+VDO5gTpn7TBD9HsVEKmPf8iO+ZF3YXPLyt1
	 EqxJeW0FLfVtiz7XOM94YwpdkOj3SEitjugOjdDPu8JYAFXrwIuJT+stUaD0CXnF66
	 gfEAbVRq58mZUbOaDdlU32inlOH4Zuovj0BevrNlC0JgfCOWkKUeS4c9EwP3EwpTwc
	 QqvHS/Xy9OWiQ==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6A79A120006A;
	Thu, 12 Sep 2024 06:02:41 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 12 Sep 2024 06:02:41 -0400
X-ME-Sender: <xms:QbziZi_gNVisByn4l1i4Jr1FxIpR1uEynX6RTtRl6lwZgvi0arq4DQ>
    <xme:QbziZivKpKvdGbfZALX8t5O3HRRfeaP7YRr8JjUXbqlUw6TI5u2kkxDG6_NcoPjnq
    vdUsaLuuSz6LYwxhY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgvdefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:QbziZoAO0cMepT2rctHgh4AK_aIj1zUgE-oPT73DVPFEYcKEGh3o3A>
    <xmx:QbziZqeY7dWFUrxbUYyHhomeiYueageZRAjvsScfYDDA_N7r7rHVQA>
    <xmx:QbziZnPNh1U4f9K4f27u9ap8v_5BwY8LIM8k1Q74e0KJyTc9db57OA>
    <xmx:QbziZkloUg5oE-03ViTeXr3hyD-Xb9mgbnJqgLiatGNMfOWRilD8HA>
    <xmx:QbziZpuOsQYn9n6tSYBsKJjXdwC4cydU0IBT6VNu9ATP_r8kmr0LSFu->
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 39243222006F; Thu, 12 Sep 2024 06:02:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Sep 2024 10:01:59 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, "John Stultz" <jstultz@google.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Stephen Boyd" <sboyd@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "kernel test robot" <oliver.sang@intel.com>
Message-Id: <1484d32b-ab0f-48ff-998a-62feada58300@app.fastmail.com>
In-Reply-To: <e4d922c8d0a06de08b91844860c76936bd5fa03a.camel@kernel.org>
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
 <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
 <d6fe52c2-bc9e-424f-a44e-cfc3f4044443@app.fastmail.com>
 <e4d922c8d0a06de08b91844860c76936bd5fa03a.camel@kernel.org>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into timekeeper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 11, 2024, at 20:43, Jeff Layton wrote:
>
> I think we'd have to track this delta as an atomic value and cmpxchg
> new values into place. The zeroing seems quite tricky to make race-
> free.
>
> Currently, we fetch the floor value early in the process and if it
> changes before we can swap a new one into place, we just take whatever
> the new value is (since it's just as good). Since these are monotonic
> values, any new value is still newer than the original one, so its
> fine. I'm not sure that still works if we're dealing with a delta that
> is siding upward and downward.
>
> Maybe it does though. I'll take a stab at this tomorrow and see how it
> looks.

Right, the only idea I had for this would be to atomically
update a 64-bit tuple of the 32-bit sequence count and the
32-bit delta value in the timerkeeper. That way I think the
"coarse" reader would still get a correct value when running
concurrently with both a fine-grained reader updating the count
and the timer tick setting a new count.

There are still a couple of problems:

- this extends the timekeeper logic beyond what the seqlock
  semantics normally allow, and I can't prove that this actually
  works in all corner cases.

- if the delta doesn't fit in a 32-bit value, there has to 
  be another fallback mechanism.

- This still requires an atomic64_cmpxchg() in the
  fine-grained ktime_get_real_ts64() replacement, which
  I think is what inode_set_ctime_current() needs today
  as well to ensure that the next coarse value is the
  highest one that has been read so far.

There is another idea that would completely replace
your design with something /much/ simpler:

 - add a variant of ktime_get_real_ts64() that just
   sets a flag in the timekeeper to signify that a
   fine-grained time has been read since the last
   timer tick
 - add a variant of ktime_get_coarse_real_ts64()
   that returns either tk_xtime() if the flag is
   clear or calls ktime_get_real_ts64() if it's set
 - reset the flag in timekeeping_advance() and any other
   place that updates tk_xtime

That way you avoid the atomic64_try_cmpxchg()
inode_set_ctime_current(), making that case faster,
and avoid all overhead in coarse_ctime() unless you
use both types during the same tick.

      Arnd

