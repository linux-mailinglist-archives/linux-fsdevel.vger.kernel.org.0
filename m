Return-Path: <linux-fsdevel+bounces-26560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B4895A7A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D978281BB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 22:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A2179957;
	Wed, 21 Aug 2024 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DjVAg43R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EFXO8qdZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yeO9k9TX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wmUMUnCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E579D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278350; cv=none; b=ZikDN6i/18r9KvZGBTIDxZ4ABF0tuyEGPiAPoUD+uFLOnK6GkMBOIaCKipLC+iZtT4+0TU8JX2VHj62I9rmaab8joYi0y/dG4eFuCjqcgWHgZguwP8q23d9nHk/3xrwEa0qlf+1C8j4ujvhnJLZgXtxra+LhYIdjTnPjk6upQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278350; c=relaxed/simple;
	bh=fT2wdMwIfuE8OQj2dmC233A3/f+UA9R7/xGCVeey+zg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CavN/gqGu9eK4rrNfCXwn+u7KHy2vQ0nnsLvq3NCeMipY0njKpi/P07zsxPj670bUerkbkyTaeYVzafsm35WqzSPK+RQG+PTs6Q1Gdppf4YKY4sYbUkS/ci3VD0Lm0+kRthCVVAAIiRz4BCPkg6U3xuXd6xiafugQ6i2d6nntbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DjVAg43R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EFXO8qdZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yeO9k9TX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wmUMUnCj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8EE2200EF;
	Wed, 21 Aug 2024 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724278347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwqTQCGXKgJDDCRPvINDgTyuNdPyB9d8mNoBSsfkGDo=;
	b=DjVAg43RFFxrsjUxQqymGPVhJjzGo1mOTub/GALXS0DwSXDJPxzRCZdDbpC7ACdLNY1scs
	m9eL+pjrMW7B/OcVNC0xtvVUm5FxrEJSKdT42Hum+9SXKW0LSfTculN761j/eZFmSh8TIB
	Irh11lhII6eIsviq7/SHuUxb8M1rM8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724278347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwqTQCGXKgJDDCRPvINDgTyuNdPyB9d8mNoBSsfkGDo=;
	b=EFXO8qdZZ2SpHvc1ONjR7nS04Xv3Tw5jwa+j2bPMtIqe0+Pl/TmKcIYq0frNzRwh3dAGKB
	q9f3SXhuD9BLVaBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yeO9k9TX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wmUMUnCj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724278346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwqTQCGXKgJDDCRPvINDgTyuNdPyB9d8mNoBSsfkGDo=;
	b=yeO9k9TXRcXtn+6y39kjvjiMGuJxL7Ti3buKFT6HNIJ65JvqYOP2Q2CU9jEnXM7woLvI2l
	gF934KgWxYCueEoI9Q73Mf9ndMaEyeD3O2ImJK8mL/RGd1RFy+B+p59URKXiiOV+d6ORRO
	aOXJf5Ql0EnRp2FYG0deBBFuc83UmgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724278346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwqTQCGXKgJDDCRPvINDgTyuNdPyB9d8mNoBSsfkGDo=;
	b=wmUMUnCjhW5402+J93opP13VauRIkGaPad7xGtUdwWs+FtCWvzSXuqOkqXEmnFRWdUEwcI
	YjsLCwriTfD2ocBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 870F2139C2;
	Wed, 21 Aug 2024 22:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YsJVD0hmxmY6PgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 21 Aug 2024 22:12:24 +0000
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
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
In-reply-to: <20240821-work-i_state-v2-1-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>,
 <20240821-work-i_state-v2-1-67244769f102@kernel.org>
Date: Thu, 22 Aug 2024 08:12:15 +1000
Message-id: <172427833589.6062.8614016543522604940@noble.neil.brown.name>
X-Rspamd-Queue-Id: E8EE2200EF
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Thu, 22 Aug 2024, Christian Brauner wrote:
> The i_state member is an unsigned long so that it can be used with the
> wait bit infrastructure which expects unsigned long. This wastes 4 bytes
> which we're unlikely to ever use. Switch to using the var event wait
> mechanism using the address of the bit. Thanks to Linus for the address
> idea.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/inode.c         | 10 ++++++++++
>  include/linux/fs.h | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index 154f8689457f..f2a2f6351ec3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -472,6 +472,16 @@ static void __inode_add_lru(struct inode *inode, bool =
rotate)
>  		inode->i_state |=3D I_REFERENCED;
>  }
> =20
> +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *w=
qe,
> +					    struct inode *inode, u32 bit)
> +{
> +        void *bit_address;
> +
> +        bit_address =3D inode_state_wait_address(inode, bit);
> +        init_wait_var_entry(wqe, bit_address, 0);
> +        return __var_waitqueue(bit_address);
> +}
> +
>  /*
>   * Add inode to LRU if needed (inode is unused and clean).
>   *
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 23e7d46b818a..a5b036714d74 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -744,6 +744,22 @@ struct inode {
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
> =20
> +/*
> + * Get bit address from inode->i_state to use with wait_var_event()
> + * infrastructre.
> + */
> +#define inode_state_wait_address(inode, bit) ((char *)&(inode)->i_state + =
(bit))
> +
> +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *w=
qe,
> +					    struct inode *inode, u32 bit);
> +
> +static inline void inode_wake_up_bit(struct inode *inode, u32 bit)
> +{
> +	/* Ensure @bit will be seen cleared/set when caller is woken up. */

The above comment is wrong.  I think I once thought it was correct too
but now I know better (I hope).
A better comment might be
       /* Insert memory barrier as recommended by wake_up_var() */
but even that is unnecessary as we don't need the memory barrier.

A careful reading of memory-barriers.rst shows that *when the process is
actually woken* there are sufficient barriers in wake_up_process() and
prepare_wait_event() and the scheduler and (particularly)
set_current_state() so that a value set before the wake_up is seen after
the schedule().

So this barrier isn't about the bit.  This barrier is about the
wait_queue.  In particular it is about waitqueue_active() call at the
start of wake_up_var().  If that test wasn't there and if instead
wake_up_var() conditionally called __wake_up(), then there would be no
need for any barrier.  A comment near wake_up_bit() makes it clear that
the barrier is only needed when the spinlock is avoided.

On a weakly ordered arch, this test can be effected *before* the write
of the bit.  If the waiter adds itself to the wait queue and then tests
the bit before the bit is set, but after the waitqueue_active() test is
put in effect, then the wake_up will never be sent.

But ....  this is all academic of this code because you don't need a
barrier at all.  The wake_up happens in a spin_locked region, and the
wait is entirely inside the same spin_lock, except for the schedule.  A
later patch has:
     spin_unlock(); schedule(); spin_lock();

So there is no room for a race.  If the bit is cleared before the
wait_var_event() equivalent, then no wakeup is needed.  When the lock is
dropped after the bit is cleared the unlock will have all the barriers
needed for the bit to be visible.

The only other place that the bit can be cleared is concurrent with the
above schedule() while the spinlock isn't held by the waiter.  In that
case it is again clear that no barrier is needed - or that the
spin_unlock/lock provide all the needed barriers.

So a better comment would be

   /* no barrier needs as both waker and waiter are in spin-locked regions */

Thanks,
NeilBrown


> +	smp_mb();
> +	wake_up_var(inode_state_wait_address(inode, bit));
> +}
> +
>  struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *in=
ode);
> =20
>  static inline unsigned int i_blocksize(const struct inode *node)
>=20
> --=20
> 2.43.0
>=20
>=20


