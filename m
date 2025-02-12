Return-Path: <linux-fsdevel+bounces-41554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006AFA31B77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 02:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479A13A8CFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 01:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E170821;
	Wed, 12 Feb 2025 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dSfYVqgh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F+LtD82t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dSfYVqgh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F+LtD82t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6969A50;
	Wed, 12 Feb 2025 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324819; cv=none; b=m3pkd6bGLWOQe9A0dolr9zsuVbEkXXcPlJHbOtRhRrFUsEGu/nxSlrRBiHC4N8uQx/40hLeVSiEhSiMawv5J1nDKm2evZio7fJ2V0MrEJf4AciV91yjUVYPYYU781EbEja6DfZhRBMTmsqdjrzm4MRnELedgOoOiUjGPrcyawz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324819; c=relaxed/simple;
	bh=Ginejh+tbEGCmtoArOZLAEg3VJDDEjauTYsDOWFIZ7o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dZJEbogjvSB3wHRt6Q2qzhloFDeOotZ6MOebIQHd5Rz1hDFZkOvEL0kPVqxg1JqgsiG8c3cl/lpZELI4lgT8azWtKpxG9Vtx87XB8P7DD9DoGCYDHP7l5bp31elWjJpXhY9yNBIcHuPOj39hfpR+05uFgiMZ8Ybj6UYpPrAHJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dSfYVqgh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F+LtD82t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dSfYVqgh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F+LtD82t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEC151FB5B;
	Wed, 12 Feb 2025 01:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739324814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80G5x7D3vfS92/rq2H76/rJdfMkIIguKeohm9qj9ym4=;
	b=dSfYVqgh+ipBmqmFS2wIjY1xgHA7E5sN4ZpAOLhmGey3Ncz/F6o8kjbJiIOnY+EqTJ73cf
	LxDfYVQvNaQdFfEpL4ylwi0hydd0cJGDiDWHnnHMFWMvqmscDcmzKx/BgkLzemVuMXsUSe
	LYrmU+gfvsL86i9WgjxCzh8imXuqlu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739324814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80G5x7D3vfS92/rq2H76/rJdfMkIIguKeohm9qj9ym4=;
	b=F+LtD82tD60yRDDO3EAOBBzi6jW6fY3TETALgs7HbPwV6UnsW80o1opiPWGDYNmHMMOH07
	+X+hvp9mru3KftCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739324814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80G5x7D3vfS92/rq2H76/rJdfMkIIguKeohm9qj9ym4=;
	b=dSfYVqgh+ipBmqmFS2wIjY1xgHA7E5sN4ZpAOLhmGey3Ncz/F6o8kjbJiIOnY+EqTJ73cf
	LxDfYVQvNaQdFfEpL4ylwi0hydd0cJGDiDWHnnHMFWMvqmscDcmzKx/BgkLzemVuMXsUSe
	LYrmU+gfvsL86i9WgjxCzh8imXuqlu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739324814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80G5x7D3vfS92/rq2H76/rJdfMkIIguKeohm9qj9ym4=;
	b=F+LtD82tD60yRDDO3EAOBBzi6jW6fY3TETALgs7HbPwV6UnsW80o1opiPWGDYNmHMMOH07
	+X+hvp9mru3KftCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E615B13782;
	Wed, 12 Feb 2025 01:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Q0IJov9q2ezPAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 01:46:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 02/19] VFS: use global wait-queue table for d_alloc_parallel()
In-reply-to: <20250212002543.GK1977892@ZenIV>
References: <>, <20250212002543.GK1977892@ZenIV>
Date: Wed, 12 Feb 2025 12:46:31 +1100
Message-id: <173932479179.22054.9609257898334521265@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 12 Feb 2025, Al Viro wrote:
> On Wed, Feb 12, 2025 at 10:35:41AM +1100, NeilBrown wrote:
>=20
> > Without lockdep making the dentry extra large, struct dentry is 192
> > bytes, exactly 3 cache lines.  There are 16 entries per 4K slab.
> > Now exactly 1/4 of possible indices are used.
> > For every group of 16 possible indices, only 0, 4, 8, 12 are used.
> > slabinfo says the object size is 256 which explains some of the spread.=20
>=20
> Interesting...
>=20
> root@cannonball:~# grep -w dentry /proc/slabinfo
> dentry            1370665 1410864    192   21    1 : tunables    0    0    =
0 : slabdata  67184  67184      0
>=20
> Where does that 256 come from?  The above is on amd64, with 6.1-based debian
> kernel and I see the same object size on other boxen (with local configs).

I found SLUB_DEBUG and redzoning does that.  Disabling the debug brings
done to 192 bytes and 21 per slab which you see.  That is still only 33%
hit rate.

>=20
> > I don't think there is a good case here for selecting bits from the
> > middle of the dentry address.
> >=20
> > If I use hash_ptr(dentry, 8) I get a more uniform distribution.  64000
> > entries would hope for 250 per bucket.  Median is 248.  Range is 186 to
> > 324 so +/- 25%.
> >=20
> > Maybe that is the better choice.
>=20
> That's really interesting, considering the implications for m_hash() and mp=
_hash()
> (see fs/namespace.c)...

Those functions add in the next set of bits as well - effectively mixing
in more bits from the page address.  If I do that the spread is better
but there are still buckets with close to twice the median, though most
are +/- 30%.

>=20
> > > > > 3) the dance with conditional __wake_up() is worth a helper, IMO.
> > >=20
> > > I mean an inlined helper function.
> >=20
> > Yes.. Of course...
> >=20
> > Maybe we should put
> >=20
> > static inline void wake_up_key(struct wait_queue_head *wq, void *key)
> > {
> > 	__wake_up(wq, TASK_NORMAL, 0, key);
> > }
> >=20
> > in include/linux/wait.h to avoid the __wake_up() "internal" name, and
> > then use
> > 	wake_up_key(d_wait, dentry);
> > in the two places in dcache.c, or did you want something
> > dcache-specific?
>=20
> More like
> 	if (wq)
> 		__wake_up(wq, TASK_NORMAL, 0, key);
> probably...
>=20

Thanks,
NeilBrown



