Return-Path: <linux-fsdevel+bounces-26320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A399575E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 22:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772BE1C21F7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3C158DD8;
	Mon, 19 Aug 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qnx1iWRD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ntzf2Tlx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qnx1iWRD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ntzf2Tlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97015E96;
	Mon, 19 Aug 2024 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724100760; cv=none; b=CtqK5gFOs36tG6h4/7qhPJYoRsE/UYelazo7cvqUS1l1gRLq5zkbzrH9MUpB4klzUW/RPoHUQ7ajwxqJ4P2HW2AOe14FqunoRf6iqlzDkrsVqNQaDYVssILu5/JGxrtYDxnJSKhGYlsw81YtwcFs6xd6xDvJrpIoZLKl35onwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724100760; c=relaxed/simple;
	bh=VHsbWr9rZjDMgU2XJZu3a86HtX+f/X636MoPUwVQe/w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=r3U5Y4zFoR24hQKILAAo8RtgfVMPYfY9hn4d9NJ2bYwPAiS1lBYfX1P+QnO8DGt4o8OCCBQtY/tAWjsqMzUFvi0ERPw0F9Whwg3ahkV15DlfWYtki7nL6t578Nnz+c98ap5fY1sTawnTSGZideZ0etrPATQx8pqquen1qS+Bnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qnx1iWRD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ntzf2Tlx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qnx1iWRD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ntzf2Tlx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2DBE22784;
	Mon, 19 Aug 2024 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724100757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvWtThllQ7ghmiGYjwKH0w44hAeQ77b5rmz8qdXu2yY=;
	b=qnx1iWRDu1F+1bGqzo5ONjaJclIKI5dfGZWrSqVZ1/cC3Pz48HGekIHqHWG/07lNCchgNQ
	EjPpk3fgBt+T38HVExoVqSbXKVw/ZJ7Sn5ivQ2maFzLqct9RQKy5sqGreKB4MWQq44brEd
	fLi5HfFRkhivokIyRlzVoAbrIoNvN/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724100757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvWtThllQ7ghmiGYjwKH0w44hAeQ77b5rmz8qdXu2yY=;
	b=Ntzf2Tlx/vg7h2mcCUzvOGLcMGSbu3kcM8XweiGh+QoZrbIFRkvDFTKSzhzppNLwy1RcyR
	a1SqndmpuZ2fssBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724100757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvWtThllQ7ghmiGYjwKH0w44hAeQ77b5rmz8qdXu2yY=;
	b=qnx1iWRDu1F+1bGqzo5ONjaJclIKI5dfGZWrSqVZ1/cC3Pz48HGekIHqHWG/07lNCchgNQ
	EjPpk3fgBt+T38HVExoVqSbXKVw/ZJ7Sn5ivQ2maFzLqct9RQKy5sqGreKB4MWQq44brEd
	fLi5HfFRkhivokIyRlzVoAbrIoNvN/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724100757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvWtThllQ7ghmiGYjwKH0w44hAeQ77b5rmz8qdXu2yY=;
	b=Ntzf2Tlx/vg7h2mcCUzvOGLcMGSbu3kcM8XweiGh+QoZrbIFRkvDFTKSzhzppNLwy1RcyR
	a1SqndmpuZ2fssBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C92481397F;
	Mon, 19 Aug 2024 20:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IffpHpKww2b/cwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 20:52:34 +0000
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
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
In-reply-to: <20240819-bestbezahlt-galaabend-36a83208e172@brauner>
References: <20240819053605.11706-1-neilb@suse.de>,
 <20240819-bestbezahlt-galaabend-36a83208e172@brauner>
Date: Tue, 20 Aug 2024 06:52:30 +1000
Message-id: <172410075061.6062.16885080304623041632@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 19 Aug 2024, Christian Brauner wrote:
> On Mon, Aug 19, 2024 at 03:20:34PM GMT, NeilBrown wrote:
> > I wasn't really sure who to send this too, and get_maintainer.pl
> > suggested 132 addresses which seemed excessive.  So I've focussed on
> > 'sched' maintainers.  I'll probably submit individual patches to
> > relevant maintainers/lists if I get positive feedback at this level.
> >=20
> > This series was motivated by=20
> >=20
> >    Commit ed0172af5d6f ("SUNRPC: Fix a race to wake a sync task")
> >=20
> > which adds smp_mb__after_atomic().  I thought "any API that requires that
> > sort of thing needs to be fixed".
> >=20
> > The main patches here are 7 and 8 which revise wake_up_bit and
> > wake_up_var respectively.  They result in 3 interfaces:
> >   wake_up_{bit,var}           includes smp_mb__after_atomic()
> >   wake_up_{bit,var}_relaxed() doesn't have a barrier
> >   wake_up_{bit,var}_mb()      includes smb_mb().
>=20
> It's great that this api is brought up because it gives me a reason to
> ask a stupid question I've had for a while.
>=20
> I want to change the i_state member in struct inode from an unsigned
> long to a u32 because really we're wasting 4 bytes on 64 bit that we're
> never going to use given how little I_* flags we actually have and I
> dislike that we use that vacuous type in a bunch of our structures for
> that reason.
>=20
> (Together with another 4 byte shrinkage we would get a whopping 8 bytes
> back.)
>=20
> The problem is that we currently use wait_on_bit() and wake_up_bit() in
> various places on i_state and all of these functions require an unsigned
> long (probably because some architectures only handle atomic ops on
> unsigned long).

i_state contains two bits that are used for wake_up - I_NEW and I_SYNC,
one virtual bit that is used for wake_up - I_DIO_WAKEUP - and 15 others.
You could fit those in a short and two bools which gives you three
different addresses to pass to wake_up_var().
Doing that would make it a little difficult to test for=20
   I_NEW | I_FREEING | I_WILL_FREE
but you could probably make an inline that the compile with optimise
effectively.

Alternately you could union the "u32" with an array for 4 char to give
you 4 addresses for wakeup.

Both of these would be effective, but a bit hackish.  If you want
something clean we would need a new interface.  Maybe
wake_var_bit()/wait_var_bit_event().
It could store the bit in wait_bit_key.bit_nr as "-2-n" or similar.  Or
better still, add another field: enum { WAIT_BIT, WAIT_VAR, WAIT_VAR_BIT } wa=
it_type
to wait_bit_key.

I would probably go with the union approach and re-order the bits so that
the ones you want to use for wake_up are less than sizeof(u32).

NeilBrown

