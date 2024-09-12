Return-Path: <linux-fsdevel+bounces-29179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E923C976C46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 16:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3011C23519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B41B12F1;
	Thu, 12 Sep 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGpKzVxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC481AD276;
	Thu, 12 Sep 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151843; cv=none; b=u8EvSYHFbp8biMazIDFnOmcTp/MhDiAONf6A5yHcG3BXHf9wGxTkdjtTHrLWsYk7FziYWvv8+7fSHadlAU8CE0BkdYZ2pg6yBmQRocO+S0DOQvyIWoxrSMbB1hbjFZQIsS+mhfx6vYGc3A8/Pujn7gfeScTylE1QXuueaAFco18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151843; c=relaxed/simple;
	bh=GXob01pXnf8aK8r4XO0sRlGQrFeQ/G+WjHxjhlCQmjk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhWgjzHg8U0w9lC70ayNnsVCPNYVT0cWUH1LNkU97L1bs8XUEL87Sa/z9+5sKiK3JvxNeq1P60e9/VFLGR+Uoy8Xgoui2WacqJkttXLZVJfIozn4k3Pw6YCHxewv5duJj5+IzlzfPjbfETb85MhmLkZxcdbNoBUN9Mg3v26g7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGpKzVxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656C3C4CEC4;
	Thu, 12 Sep 2024 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726151843;
	bh=GXob01pXnf8aK8r4XO0sRlGQrFeQ/G+WjHxjhlCQmjk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gGpKzVxigWb8GyWDjkF7HG1BfRjuEKLDxENBpXWSy15mpWsHdH+LfN0KGawpXx41Y
	 Ds2NoaOmK+bs/90dJ6jmtKcIM5zuRyevKBzUK4pJ4fLcDnKmI+IuCSgraMDmbU1QGA
	 zLaBMuzRxn/W35ECfz9CCN8R/UyGfwrtXUXelqA8+ifKh1NVzAhhaQYCphXBPj3/OD
	 jewyFEhL+nUi3jTw2KXMb8/U6GXmuMhhm0VFTYG/xqJRaHoczWL2SvuMxZ+y2XrV4t
	 hijKQMUlIcp6jLsWtscA4DM8yWo4LyMe+ZtE772f/BgrBpdI0f/i61+ibV+EMUY7u+
	 n9WU9wks4vP4g==
Message-ID: <12577f7d9865ef8fabc7447a23cdfc1674cbe7e8.camel@kernel.org>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into
 timekeeper
From: Jeff Layton <jlayton@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>, John Stultz <jstultz@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test
 robot <oliver.sang@intel.com>
Date: Thu, 12 Sep 2024 10:37:21 -0400
In-Reply-To: <284fd6a654eaec5a45b78c9ee88cde7b543e2278.camel@kernel.org>
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
	 <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
	 <d6fe52c2-bc9e-424f-a44e-cfc3f4044443@app.fastmail.com>
	 <e4d922c8d0a06de08b91844860c76936bd5fa03a.camel@kernel.org>
	 <1484d32b-ab0f-48ff-998a-62feada58300@app.fastmail.com>
	 <c9ed7670a0b35b212991b7ce4735cb3dfaae1fda.camel@kernel.org>
	 <b71c161a-8b43-400e-8c61-caac80e685a8@app.fastmail.com>
	 <284fd6a654eaec5a45b78c9ee88cde7b543e2278.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 09:26 -0400, Jeff Layton wrote:
> On Thu, 2024-09-12 at 13:17 +0000, Arnd Bergmann wrote:
> > On Thu, Sep 12, 2024, at 11:34, Jeff Layton wrote:
> > > On Thu, 2024-09-12 at 10:01 +0000, Arnd Bergmann wrote:
> > > > On Wed, Sep 11, 2024, at 20:43, Jeff Layton wrote:
> > > >=20
> > > > That way you avoid the atomic64_try_cmpxchg()
> > > > inode_set_ctime_current(), making that case faster,
> > > > and avoid all overhead in coarse_ctime() unless you
> > > > use both types during the same tick.
> > > >=20
> > >=20
> > > With the current code we only get a fine grained timestamp iff:
> > >=20
> > > 1/ the timestamps have been queried (a'la I_CTIME_QUERIED)
> > > 2/ the current coarse-grained or floor time would not show a change i=
n
> > > the ctime
> > >=20
> > > If we do what you're suggesting above, as soon as one task sets the
> > > flag, anyone calling current_time() will end up getting a brand new
> > > fine-grained timestamp, even when the current floor time would have
> > > been fine.
> >=20
> > Right, I forgot about this part of your work, the=20
> > I_CTIME_QUERIED logic definitely has to stay.
> >=20
> > > That means a lot more calls into ktime_get_real_ts64(), at least unti=
l
> > > the timer ticks, and would probably mean a lot of extra journal
> > > transactions, since those timestamps would all be distinct from one
> > > another and would need to go to disk more often.
> >=20
> > I guess some of that overhead would go away if we just treated
> > tk_xtime() as the floor value without an additional cache,
> > and did the comparison against inode->i_ctime inside of
> > a new ktime_get_real_ts64_newer_than(), but there is still the
> > case of a single inode getting updated a lot, and it would
> > break the ordering of updates between inodes.
> >=20
>=20
> Yes, and the breaking of ordering is why we had to revert the last set,
> so that's definitely no good.
>=20
> I think your suggestion about using a tuple of the sequence and the
> delta should work. The trick is that we need to do the fetch and the
> cmpxchg of the floor tuple inside the read_seqcount loop. Zeroing it
> out can be done with write_once(). If we get a spurious update to the
> floor while zeroing then it's no big deal since everything would just
> loop and do it again.
>=20
> I'll plan to hack something together later today and see how it does.
>=20

Ok, already hit a couple of problems:

First, moving the floor word into struct timekeeper is probably not a
good idea. This is going to be updated more often than the rest of the
timekeeper, and so its cacheline will be invalidated more. I think we
need to keep the floor word on its own cacheline. It can be a static
u64 though inside timekeeper.c.

Second, the existing code basically does:

	get the floor time (tfc =3D max of coarse and ctime_floor)=20
	if ctime was queried and applying tfc would show no change:
		get fine time
		cmpxchg into place and accept the result

The key there is that if the floor time changes at any point between
when we first fetch it and the attempted cmpxchg, no update happens
(which is good).

If we move all of the floor handling into the timekeeper, then I think
we still need to have some state that we pass back when trying to get
the floor time initially, so that we keep the race window large (which
seems weird, but is good in this case).

So, I think that we actually need an API like this:

    /* returns opaque cookie value */
    u64 ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);

    /* accepts opaque cookie value from above function */=20
    void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie);

The first function fills in @ts with the max of coarse time and floor,
and returns an opaque cookie (a copy of the floor word). The second
fetches a fine-grained timestamp and uses the floor cookie as the "old"
value when doing the cmpxchg, and then fills in @ts with the result.

Does that sound reasonable? If so, then the next question is around
what the floor word should hold:

IMO, just keeping it as a monotonic time value seems simplest. I'm
struggling to understand where the "delta" portion would come from in
your earlier proposal, and the fact that that value could overflow
seems less than ideal.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>

