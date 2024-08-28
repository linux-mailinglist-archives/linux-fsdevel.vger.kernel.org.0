Return-Path: <linux-fsdevel+bounces-27527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905E961E27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A03B23155
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9DD14D282;
	Wed, 28 Aug 2024 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYUMJGU8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lB93c269";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYUMJGU8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lB93c269"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DCC13D899;
	Wed, 28 Aug 2024 05:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724822425; cv=none; b=tNXgMDOprWkvUjlB72MoJNf6QFynNraOLADvEYZrV7XTm4Tj/SfVY05aVN56KD8R2jHYQQaw0IbPQg76G4dEWPJJnkgXhuWXWJhbTpY1WlTI67Am4oby9vRbM9RhjE+d6iS4RNQGubuKoBGBpNAHHb44FqouDwcfWsKFgKC8axA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724822425; c=relaxed/simple;
	bh=gXsQuZ15yToEFluBvMtYLgtaUj9rzeui8RRxrAiRzLo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PWk9a7RZ5DRZnrLTbu8OtPHNKIvd6pg/Wf+Sksx09YE3KOENpDRF92uK1EQ1zhzSBFj0wFbyOGlcZ1P2soaQnt1doLNsWnjCdEHDCwNJlu9SzgWpaSq6VNDEtbn/wiZNhAtiB30ngHWv2eivc2i53fhLcGcylZ2+iNe76wJO2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYUMJGU8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lB93c269; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYUMJGU8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lB93c269; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BAF221B3B;
	Wed, 28 Aug 2024 05:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724822421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILMhqUVFfvstQGhlSBsTjouluIsr5HE91oMzvvZOytA=;
	b=oYUMJGU8lD0GDMdbsieJw71YSIOBvSWbgTDsTX6iVv+Ng6ckMRrkVrxGaMwHPTF6z0zBsF
	oloWA8QXU5TLxTs/gtcHQ689s8cgzq2LnUxwnYsmJjJ/YErtzTZVDnyH5xAzt/d7Bsdpy2
	ZG0ItscGw5zzghHmBYX6XwrpgQAitAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724822421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILMhqUVFfvstQGhlSBsTjouluIsr5HE91oMzvvZOytA=;
	b=lB93c269AKK15rj/phtARQJr4dyLjZ5RfAvzmYt2kJAr09g9o8vtP1k/umO0IchhyKU0/F
	GWkvLLEcqeKYCbAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724822421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILMhqUVFfvstQGhlSBsTjouluIsr5HE91oMzvvZOytA=;
	b=oYUMJGU8lD0GDMdbsieJw71YSIOBvSWbgTDsTX6iVv+Ng6ckMRrkVrxGaMwHPTF6z0zBsF
	oloWA8QXU5TLxTs/gtcHQ689s8cgzq2LnUxwnYsmJjJ/YErtzTZVDnyH5xAzt/d7Bsdpy2
	ZG0ItscGw5zzghHmBYX6XwrpgQAitAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724822421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILMhqUVFfvstQGhlSBsTjouluIsr5HE91oMzvvZOytA=;
	b=lB93c269AKK15rj/phtARQJr4dyLjZ5RfAvzmYt2kJAr09g9o8vtP1k/umO0IchhyKU0/F
	GWkvLLEcqeKYCbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74C5B13724;
	Wed, 28 Aug 2024 05:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wvwAC5OzzmbEDgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Aug 2024 05:20:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 5/9] Block: switch bd_prepare_to_claim to use ___wait_var_event()
In-reply-to: <Zs575QSPazeJRzAy@dread.disaster.area>
References: <>, <Zs575QSPazeJRzAy@dread.disaster.area>
Date: Wed, 28 Aug 2024 15:20:01 +1000
Message-id: <172482240148.4433.18164936555410000141@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.906];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.28
X-Spam-Flag: NO

On Wed, 28 Aug 2024, Dave Chinner wrote:
> On Wed, Aug 21, 2024 at 07:52:39AM +1000, NeilBrown wrote:
> > On Tue, 20 Aug 2024, Dave Chinner wrote:
> > > On Mon, Aug 19, 2024 at 03:20:39PM +1000, NeilBrown wrote:
> > > > bd_prepare_to_claim() current uses a bit waitqueue with a matching
> > > > wake_up_bit() in bd_clear_claiming().  However it is really waiting o=
n a
> > > > "var", not a "bit".
> > > >=20
> > > > So change to wake_up_var(), and use ___wait_var_event() for the waiti=
ng.
> > > > Using the triple-underscore version allows us to drop the mutex across
> > > > the schedule() call.
> > > ....
> > > > @@ -535,33 +535,23 @@ int bd_prepare_to_claim(struct block_device *bd=
ev, void *holder,
> > > >  		const struct blk_holder_ops *hops)
> > > >  {
> > > >  	struct block_device *whole =3D bdev_whole(bdev);
> > > > +	int err =3D 0;
> > > > =20
> > > >  	if (WARN_ON_ONCE(!holder))
> > > >  		return -EINVAL;
> > > > -retry:
> > > > -	mutex_lock(&bdev_lock);
> > > > -	/* if someone else claimed, fail */
> > > > -	if (!bd_may_claim(bdev, holder, hops)) {
> > > > -		mutex_unlock(&bdev_lock);
> > > > -		return -EBUSY;
> > > > -	}
> > > > -
> > > > -	/* if claiming is already in progress, wait for it to finish */
> > > > -	if (whole->bd_claiming) {
> > > > -		wait_queue_head_t *wq =3D bit_waitqueue(&whole->bd_claiming, 0);
> > > > -		DEFINE_WAIT(wait);
> > > > =20
> > > > -		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
> > > > -		mutex_unlock(&bdev_lock);
> > > > -		schedule();
> > > > -		finish_wait(wq, &wait);
> > > > -		goto retry;
> > > > -	}
> > > > +	mutex_lock(&bdev_lock);
> > > > +	___wait_var_event(&whole->bd_claiming,
> > > > +			  (err =3D bd_may_claim(bdev, holder, hops)) !=3D 0 || !whole->bd=
_claiming,
> > > > +			  TASK_UNINTERRUPTIBLE, 0, 0,
> > > > +			  mutex_unlock(&bdev_lock); schedule(); mutex_lock(&bdev_lock));
> > >=20
> > > That's not an improvement. Instead of nice, obvious, readable code,
> > > I now have to go look at a macro and manually substitute the
> > > parameters to work out what this abomination actually does.
> >=20
> > Interesting - I thought the function as a whole was more readable this
> > way.
> > I agree that the ___wait_var_event macro isn't the best part.
> > Is your dislike simply that it isn't a macro that you are familar with,
> > or is there something specific that you don't like?
>=20
> It's the encoding of non-trivial logic and code into the macro
> parameters that is the problem....

It would probably make sense to move all the logic into bd_may_claim()
so that it returns:
  -EBUSY if claim cannot succeed
  -EAGAIN if claim might succeed soon, or
  0 if it can be claimed now.
Then the wait becomes:

   wait_var_event_mutex(&whole->bd_claiming,
			bd_may_claim(bdev, holder, hops) !=3D -EAGAIN,
			&bdev_lock);

>=20
> > Suppose we could add a new macro so that it read:
> >=20
> >      wait_var_event_mutex(&whole->bd_claiming,
> > 			  (err =3D bd_may_claim(bdev, holder, hops)) !=3D 0 || !whole->bd_clai=
ming,
> > 			  &bdev_lock);
>=20
> .... and this still does it.=20
>=20
> In fact, it's worse, because now I have -zero idea- of what locking
> is being performed in this case, and so now I definitely have to go
> pull that macro apart to understand what this is actually doing.
>=20
> Complex macros don't make understanding the code easier - they may
> make writing the code faster, but that comes at the expense of
> clarity and obviousness of the logic flow of the code...

I think that SIMPLE macros rarely make the code easier to understand -
for precisely the reason that you have to go and find out what the macro
actually does.
Complex macros obviously suffer the same problem but I believe they
bring tangible benefits by making review easier for those who understand
the macros, and consequently reducing bugs.

I'm currently particularly sensitive to this since finding that the
open-coded wait loop in pkt_make_request_write() - which I wrote - is
missing a finish_wait() call.  Ouch.  If there had been a
wait_var_event_spinlock() when I wrote that code, the mistake would not
have happened.

The argument about locking being non-obvious is, I think, doubly true
for wait_on_bit_lock().  But that is still a useful interface.

Thanks,
NeilBrown

