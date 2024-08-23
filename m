Return-Path: <linux-fsdevel+bounces-26853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB395C224
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 02:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F91B218FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B64A08;
	Fri, 23 Aug 2024 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l9zJPEYH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3ObTnrAE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l9zJPEYH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3ObTnrAE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660B259C
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372099; cv=none; b=YLcY3Y5pDOY2vTT0loaWUMSK2D9YYVTXjvwSGZgC5ehOvjzR5WNAxKM1z8dZXMTOAHlfmzr5zavCsT23iS5stuKk1vPPFoIB7B/s6oPDBpPfPP/L2Z0gKqBmqANtdeUTh5WSrZ83sbLdDbMtC2Pt23GXB1Mgi4iTcfnne0vUm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372099; c=relaxed/simple;
	bh=LpoHU29Y0xZuh4xZsWYE2fDIgWhmHjPwTgj0ugMj8+0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WLOuQNbNQ1Q5xe2sVL028IsVNAl2bW99bpAEjwykMN6d6FWmVN2GbidD3ChxcfMhISiXgoICcqUngEYajL+UtEJm6y3Xfn7spAIIK4lW1Si9tUDqUsZsSsKAqPHu7HUJ+12G9ursdHFK8UFYieoieWpikmNDP01Q1KISFGyV2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l9zJPEYH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3ObTnrAE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l9zJPEYH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3ObTnrAE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B9DA20270;
	Fri, 23 Aug 2024 00:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724372095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KApcC+pGbjnlwt6jAHOK83krJ883/sJzJ0HOwwv2S+g=;
	b=l9zJPEYHmxc3A3l6QaD+WQSyK5UnaYhr/k+cbLNOLCtSHOmg8C1mrViZ5qf5ldkdqP/Q1o
	y+Qo6QR1P1xGkJeMU9QblnpdnCV1nq7+99Bx4yvs+F5BDZW2/ss3tYrP6MdcgKECUk9Hin
	Ma1Pal9IuvIr+GCF1qSivjAfRoJhGak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724372095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KApcC+pGbjnlwt6jAHOK83krJ883/sJzJ0HOwwv2S+g=;
	b=3ObTnrAEVqbYtFaXygSsAEhoBZyQregU+G2GtGLakhinEN4EyqOPkrOvw+lsIy8Oni4T9m
	QNbAZppZOJTRB2DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724372095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KApcC+pGbjnlwt6jAHOK83krJ883/sJzJ0HOwwv2S+g=;
	b=l9zJPEYHmxc3A3l6QaD+WQSyK5UnaYhr/k+cbLNOLCtSHOmg8C1mrViZ5qf5ldkdqP/Q1o
	y+Qo6QR1P1xGkJeMU9QblnpdnCV1nq7+99Bx4yvs+F5BDZW2/ss3tYrP6MdcgKECUk9Hin
	Ma1Pal9IuvIr+GCF1qSivjAfRoJhGak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724372095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KApcC+pGbjnlwt6jAHOK83krJ883/sJzJ0HOwwv2S+g=;
	b=3ObTnrAEVqbYtFaXygSsAEhoBZyQregU+G2GtGLakhinEN4EyqOPkrOvw+lsIy8Oni4T9m
	QNbAZppZOJTRB2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0A07139D2;
	Fri, 23 Aug 2024 00:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IFojKXzUx2bRBQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 23 Aug 2024 00:14:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
In-reply-to: <20240822-knipsen-bebildert-b6f94efcb429@brauner>
References: <>, <20240822-knipsen-bebildert-b6f94efcb429@brauner>
Date: Fri, 23 Aug 2024 10:14:50 +1000
Message-id: <172437209004.6062.17184722714391055041@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 22 Aug 2024, Christian Brauner wrote:
> >=20
> > So this barrier isn't about the bit.  This barrier is about the
> > wait_queue.  In particular it is about waitqueue_active() call at the
> > start of wake_up_var().  If that test wasn't there and if instead
> > wake_up_var() conditionally called __wake_up(), then there would be no
>=20
> Did you mean "unconditionally called"?

Yes :-)


>=20
> > need for any barrier.  A comment near wake_up_bit() makes it clear that
> > the barrier is only needed when the spinlock is avoided.
> >=20
> > On a weakly ordered arch, this test can be effected *before* the write
> > of the bit.  If the waiter adds itself to the wait queue and then tests
> > the bit before the bit is set, but after the waitqueue_active() test is
> > put in effect, then the wake_up will never be sent.
> >=20
> > But ....  this is all academic of this code because you don't need a
> > barrier at all.  The wake_up happens in a spin_locked region, and the
> > wait is entirely inside the same spin_lock, except for the schedule.  A
> > later patch has:
> >      spin_unlock(); schedule(); spin_lock();
> >=20
> > So there is no room for a race.  If the bit is cleared before the
> > wait_var_event() equivalent, then no wakeup is needed.  When the lock is
> > dropped after the bit is cleared the unlock will have all the barriers
> > needed for the bit to be visible.
> >=20
> > The only other place that the bit can be cleared is concurrent with the
> > above schedule() while the spinlock isn't held by the waiter.  In that
> > case it is again clear that no barrier is needed - or that the
> > spin_unlock/lock provide all the needed barriers.
> >=20
> > So a better comment would be
> >=20
> >    /* no barrier needs as both waker and waiter are in spin-locked region=
s */
>=20
> Thanks for the analysis. I was under the impression that wait_on_inode()
> was called in contexts where no barrier is guaranteed and the bit isn't
> checked with spin_lock() held.
>=20

Yes it is.  I was looking at the I_SYNC waiter and mistakenly thought it
was a model for the others.
A wake_up for I_SYNC being cleared doesn't need the barrier.

Maybe inode_wake_up_bit() should not have a barrier and the various
callers should add whichever barrier is appropriate.  That is the model
that Linus prefers for wake_up_bit() and for consistency it should apply
to inode_wake_up_bit() too.

Thanks,
NeilBrown

