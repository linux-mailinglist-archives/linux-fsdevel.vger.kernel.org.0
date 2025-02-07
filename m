Return-Path: <linux-fsdevel+bounces-41140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB559A2B71E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 01:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B791664BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 00:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E0DDC5;
	Fri,  7 Feb 2025 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cWls+fXb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hRtvrFc3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cWls+fXb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hRtvrFc3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A31B661;
	Fri,  7 Feb 2025 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887874; cv=none; b=BI/lwofvd90U8Pm56D5NyRKAT7MmYWt6TkwvrXAp9IkDu15/LMVVW3SR8qi1HcsIjLbTVxiannWxCyFe7PR68K9GLKTLwdW4b6vyQ11q2kxGEPKWvrYZde+L0kIdw7/eeDxPbWh14VJr7hoe8wKIKSbjaBI7jCLgPtl+dInEgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887874; c=relaxed/simple;
	bh=TroOzWND330GgK3MxRPY5u6oKXdAle+e3IIl25gKAc0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NpSBX+pwVXNuHsn1gn8HX4G1/O6ov0KbsykToumzh8jooxrcC0s6HXQoVr3DM94jZeZ53sCUb982HkZqRmTMpyb4BtHES8wTkdw1H6VjwDDWcXT/DjcvDTEZUK215KCM7rvtFaWkRFDY/LTkIrnxgr6znrC3g983cvEVANVfUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cWls+fXb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hRtvrFc3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cWls+fXb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hRtvrFc3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D2B521133;
	Fri,  7 Feb 2025 00:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738887869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFm6NKSTC19zpEUQhxoyoN7NmED4mjR9ddmWCiw0B5M=;
	b=cWls+fXbg5fHVbrDLjTs5zEYw7+4MbBJl9khOoJ0NYMRooqBd5pZfxDO5JCcQqen0Y2YTQ
	h/lPiYssH4F5Gn389gnVQYIalyKR1JUXFlm1JotcUbXAxw7ETpLnBcNmPqXOlMVxqBgBXw
	7kgpRbrAACkiaYoZH8QG5Rd0NRugEEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738887869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFm6NKSTC19zpEUQhxoyoN7NmED4mjR9ddmWCiw0B5M=;
	b=hRtvrFc3Gyvu13wJfkTRlyU9AKg24h2JAa4pPvcSfmCqJ8ZjB06Pr5U0nlyJoSsVUwggt2
	kQ92gsTWUho2ztCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738887869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFm6NKSTC19zpEUQhxoyoN7NmED4mjR9ddmWCiw0B5M=;
	b=cWls+fXbg5fHVbrDLjTs5zEYw7+4MbBJl9khOoJ0NYMRooqBd5pZfxDO5JCcQqen0Y2YTQ
	h/lPiYssH4F5Gn389gnVQYIalyKR1JUXFlm1JotcUbXAxw7ETpLnBcNmPqXOlMVxqBgBXw
	7kgpRbrAACkiaYoZH8QG5Rd0NRugEEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738887869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFm6NKSTC19zpEUQhxoyoN7NmED4mjR9ddmWCiw0B5M=;
	b=hRtvrFc3Gyvu13wJfkTRlyU9AKg24h2JAa4pPvcSfmCqJ8ZjB06Pr5U0nlyJoSsVUwggt2
	kQ92gsTWUho2ztCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF0D213796;
	Fri,  7 Feb 2025 00:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vh79G7pSpWcLTgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 00:24:26 +0000
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
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/19] VFS: repack LOOKUP_ bit flags.
In-reply-to: <20250206-wirren-ausfiel-99acf5b0ace8@brauner>
References: <>, <20250206-wirren-ausfiel-99acf5b0ace8@brauner>
Date: Fri, 07 Feb 2025 11:24:23 +1100
Message-id: <173888786333.22054.10384828439744337327@noble.neil.brown.name>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 06 Feb 2025, Christian Brauner wrote:
> On Thu, Feb 06, 2025 at 04:42:44PM +1100, NeilBrown wrote:
> > The LOOKUP_ bits are not in order, which can make it awkward when adding
> > new bits.  Two bits have recently been added to the end which makes them
> > look like "scoping flags", but in fact they aren't.
> >=20
> > Also LOOKUP_PARENT is described as "internal use only" but is used in
> > fs/nfs/
> >=20
> > This patch:
> >  - Moves these three flags into the "pathwalk mode" section
> >  - changes all bits to use the BIT(n) macro
> >  - Allocates bits in order leaving gaps between the sections,
> >    and documents those gaps.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
>=20
> This is also a worthwhile cleanup independent of the rest of the series.
> But you've added LOOKUP_INTENT_FLAGS prior to packing the flags. Imho,
> this patch should've gone before the addition of LOOKUP_INTENT_FLAGS.

I'll fix that and submit separately - thanks.

>=20
> And btw, what does this series apply to?

It was based on
Commit 92514ef226f5 ("Merge tag 'for-6.14-rc1-tag' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/kdave/linux")

which was the current upstream at the time.

> Doesn't apply to next-20250206 nor to current mainline.
> I get the usual
>=20
> Patch failed at 0012 VFS: enhance d_splice_alias to accommodate shared-lock=
 updates
> error: sha1 information is lacking or useless (fs/dcache.c).
> error: could not build fake ancestor
>=20
> when trying to look at this locally.

Probably your tree was missing
Commit 902e09c8acde ("fix braino in "9p: fix ->rename_sem exclusion"")

Thanks,
NeilBrown


>=20
> >  include/linux/namei.h | 46 +++++++++++++++++++++----------------------
> >  1 file changed, 23 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 839a64d07f8c..0d81e571a159 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -18,38 +18,38 @@ enum { MAX_NESTED_LINKS =3D 8 };
> >  enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> > =20
> >  /* pathwalk mode */
> > -#define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
> > -#define LOOKUP_DIRECTORY	0x0002	/* require a directory */
> > -#define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
> > -#define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
> > -#define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
> > -#define LOOKUP_MOUNTPOINT	0x0080	/* follow mounts in the end */
> > -
> > -#define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache =
*/
> > -#define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */
> > +#define LOOKUP_FOLLOW		BIT(0)	/* follow links at the end */
> > +#define LOOKUP_DIRECTORY	BIT(1)	/* require a directory */
> > +#define LOOKUP_AUTOMOUNT	BIT(2)  /* force terminal automount */
> > +#define LOOKUP_EMPTY		BIT(3)	/* accept empty path [user_... only] */
> > +#define LOOKUP_LINKAT_EMPTY	BIT(4) /* Linkat request with empty path. */
> > +#define LOOKUP_DOWN		BIT(5)	/* follow mounts in the starting point */
> > +#define LOOKUP_MOUNTPOINT	BIT(6)	/* follow mounts in the end */
> > +#define LOOKUP_REVAL		BIT(7)	/* tell ->d_revalidate() to trust no cache =
*/
> > +#define LOOKUP_RCU		BIT(8)	/* RCU pathwalk mode; semi-internal */
> > +#define LOOKUP_CACHED		BIT(9) /* Only do cached lookup */
> > +#define LOOKUP_PARENT		BIT(10)	/* Looking up final parent in path */
> > +/* 5 spare bits for pathwalk */
> > =20
> >  /* These tell filesystem methods that we are dealing with the final comp=
onent... */
> > -#define LOOKUP_OPEN		0x0100	/* ... in open */
> > -#define LOOKUP_CREATE		0x0200	/* ... in object creation */
> > -#define LOOKUP_EXCL		0x0400	/* ... in target must not exist */
> > -#define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
> > +#define LOOKUP_OPEN		BIT(16)	/* ... in open */
> > +#define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
> > +#define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
> > +#define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
> > =20
> >  #define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |=
	\
> >  				 LOOKUP_RENAME_TARGET)
> > -
> > -/* internal use only */
> > -#define LOOKUP_PARENT		0x0010
> > +/* 4 spare bits for intent */
> > =20
> >  /* Scoping flags for lookup. */
> > -#define LOOKUP_NO_SYMLINKS	0x010000 /* No symlink crossing. */
> > -#define LOOKUP_NO_MAGICLINKS	0x020000 /* No nd_jump_link() crossing. */
> > -#define LOOKUP_NO_XDEV		0x040000 /* No mountpoint crossing. */
> > -#define LOOKUP_BENEATH		0x080000 /* No escaping from starting point. */
> > -#define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
> > -#define LOOKUP_CACHED		0x200000 /* Only do cached lookup */
> > -#define LOOKUP_LINKAT_EMPTY	0x400000 /* Linkat request with empty path. =
*/
> > +#define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
> > +#define LOOKUP_NO_MAGICLINKS	BIT(25) /* No nd_jump_link() crossing. */
> > +#define LOOKUP_NO_XDEV		BIT(26) /* No mountpoint crossing. */
> > +#define LOOKUP_BENEATH		BIT(27) /* No escaping from starting point. */
> > +#define LOOKUP_IN_ROOT		BIT(28) /* Treat dirfd as fs root. */
> >  /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
> >  #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
> > +/* 3 spare bits for scoping */
> > =20
> >  extern int path_pts(struct path *path);
> > =20
> > --=20
> > 2.47.1
> >=20
>=20


