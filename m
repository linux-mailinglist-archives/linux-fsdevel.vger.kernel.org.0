Return-Path: <linux-fsdevel+bounces-26406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55AF958FFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 23:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF7282032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A5C1C6891;
	Tue, 20 Aug 2024 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="07dtezhV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T5AQMaWH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="07dtezhV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T5AQMaWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E814B097;
	Tue, 20 Aug 2024 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190769; cv=none; b=IwuD5qsMg4MXmqH4pEUaz82q0GPJX0dH2xdX0k2o+ufguWuo16WaZ7iLypOCxk/guFOTl+aknWvYUDPOnc57d2XIydTiP2NEtFrVbhno1rR4CT60FBUQYQzj38SNnuwgtFljs1PxgaQrK3iC+AAoDsv2nr0rWDbhnPYsCRf559g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190769; c=relaxed/simple;
	bh=l92UnS4HuKM5bmRvfmk9xH5H1aGPk1kqzSQMcMpXG4I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=R0pC2mp+j6xvBWgjEyoelPt5pW3Tv5ubtlRVtbMgxmhgm7NCNWn7+EdQxsKXN8w6BwKyX7n+6L80RnZnnHrZg5Pss1dc1+XDorNemBQ3VTTUKbRcEpJO+xE/rOOS9ExVWkiFjw9STZ1lsyujl7cjRqvZxfHciMFPYtEFIUo7An4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=07dtezhV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T5AQMaWH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=07dtezhV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T5AQMaWH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A26311FD41;
	Tue, 20 Aug 2024 21:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724190764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBSTNe05h2eWgVHdInp2HfR2w+s19RsKtJxo341VcCI=;
	b=07dtezhVavT+ZyURGqEk7Ev616wXToIqhSGwHbUYc13AKsUr8ACP259aa1n1c9gw+wk1NT
	OfuW5Ilg0u5D5GuVzQghc9hjTnjEWrO1MizRl5yDB2tvksld8aghi9IHYvMhZp1gspzNTv
	3GRViqUfjnho8rrjFIzH48PMk5IHbyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724190764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBSTNe05h2eWgVHdInp2HfR2w+s19RsKtJxo341VcCI=;
	b=T5AQMaWHBRbagzBkn8xRdCETPU7BOHMtaX6sB3x+h+Qk7nsGIjfJKXDnrOy0Tnw4KoLNUT
	ErssOuHS9xvlyHAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724190764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBSTNe05h2eWgVHdInp2HfR2w+s19RsKtJxo341VcCI=;
	b=07dtezhVavT+ZyURGqEk7Ev616wXToIqhSGwHbUYc13AKsUr8ACP259aa1n1c9gw+wk1NT
	OfuW5Ilg0u5D5GuVzQghc9hjTnjEWrO1MizRl5yDB2tvksld8aghi9IHYvMhZp1gspzNTv
	3GRViqUfjnho8rrjFIzH48PMk5IHbyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724190764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBSTNe05h2eWgVHdInp2HfR2w+s19RsKtJxo341VcCI=;
	b=T5AQMaWHBRbagzBkn8xRdCETPU7BOHMtaX6sB3x+h+Qk7nsGIjfJKXDnrOy0Tnw4KoLNUT
	ErssOuHS9xvlyHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86EED13A17;
	Tue, 20 Aug 2024 21:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BA37DioQxWZRHgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 20 Aug 2024 21:52:42 +0000
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
In-reply-to: <ZsQZHZ0y6qMJGaLQ@dread.disaster.area>
References: <>, <ZsQZHZ0y6qMJGaLQ@dread.disaster.area>
Date: Wed, 21 Aug 2024 07:52:39 +1000
Message-id: <172419075958.6062.14405334545688254538@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 20 Aug 2024, Dave Chinner wrote:
> On Mon, Aug 19, 2024 at 03:20:39PM +1000, NeilBrown wrote:
> > bd_prepare_to_claim() current uses a bit waitqueue with a matching
> > wake_up_bit() in bd_clear_claiming().  However it is really waiting on a
> > "var", not a "bit".
> >=20
> > So change to wake_up_var(), and use ___wait_var_event() for the waiting.
> > Using the triple-underscore version allows us to drop the mutex across
> > the schedule() call.
> ....
> > @@ -535,33 +535,23 @@ int bd_prepare_to_claim(struct block_device *bdev, =
void *holder,
> >  		const struct blk_holder_ops *hops)
> >  {
> >  	struct block_device *whole =3D bdev_whole(bdev);
> > +	int err =3D 0;
> > =20
> >  	if (WARN_ON_ONCE(!holder))
> >  		return -EINVAL;
> > -retry:
> > -	mutex_lock(&bdev_lock);
> > -	/* if someone else claimed, fail */
> > -	if (!bd_may_claim(bdev, holder, hops)) {
> > -		mutex_unlock(&bdev_lock);
> > -		return -EBUSY;
> > -	}
> > -
> > -	/* if claiming is already in progress, wait for it to finish */
> > -	if (whole->bd_claiming) {
> > -		wait_queue_head_t *wq =3D bit_waitqueue(&whole->bd_claiming, 0);
> > -		DEFINE_WAIT(wait);
> > =20
> > -		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
> > -		mutex_unlock(&bdev_lock);
> > -		schedule();
> > -		finish_wait(wq, &wait);
> > -		goto retry;
> > -	}
> > +	mutex_lock(&bdev_lock);
> > +	___wait_var_event(&whole->bd_claiming,
> > +			  (err =3D bd_may_claim(bdev, holder, hops)) !=3D 0 || !whole->bd_cla=
iming,
> > +			  TASK_UNINTERRUPTIBLE, 0, 0,
> > +			  mutex_unlock(&bdev_lock); schedule(); mutex_lock(&bdev_lock));
>=20
> That's not an improvement. Instead of nice, obvious, readable code,
> I now have to go look at a macro and manually substitute the
> parameters to work out what this abomination actually does.

Interesting - I thought the function as a whole was more readable this
way.
I agree that the ___wait_var_event macro isn't the best part.
Is your dislike simply that it isn't a macro that you are familar with,
or is there something specific that you don't like?

Suppose we could add a new macro so that it read:

     wait_var_event_mutex(&whole->bd_claiming,
			  (err =3D bd_may_claim(bdev, holder, hops)) !=3D 0 || !whole->bd_claiming,
			  &bdev_lock);

would that be less abominable?

Thanks,
NeilBrown

