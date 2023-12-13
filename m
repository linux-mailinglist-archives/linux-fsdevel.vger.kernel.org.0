Return-Path: <linux-fsdevel+bounces-5767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B180FBB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05251F219CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94BE33CA;
	Wed, 13 Dec 2023 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0rYjgScs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TwRmT26R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0rYjgScs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TwRmT26R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D009BE;
	Tue, 12 Dec 2023 16:02:36 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A18B3224E5;
	Wed, 13 Dec 2023 00:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702425754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uP5dCxevZYjeO16uJvrHP4UdWkyIyrzHoRTGNnEMXg=;
	b=0rYjgScs0hgB21SzkcjjDeGLEqA694anm2XKZ9aRU57dqdwbUIVkTSXbYqmBc7F45Ds/Da
	45RWXZoyc5ZsBl5WTEWxTLs3iKm82m3IjL6ZSBBbc/09gxgxi/F2LLX3HodTXr/0HesipM
	ipZCUV5H6eq1LtBU//t8sjmqVgDQL+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702425754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uP5dCxevZYjeO16uJvrHP4UdWkyIyrzHoRTGNnEMXg=;
	b=TwRmT26RXdInNB5Rm1qXwR8DF2mY0WqrJwFVICC7RpCM77ej7VNO96c301/5FGgZXgvwA5
	M26F9/y0pMDgZgCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702425754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uP5dCxevZYjeO16uJvrHP4UdWkyIyrzHoRTGNnEMXg=;
	b=0rYjgScs0hgB21SzkcjjDeGLEqA694anm2XKZ9aRU57dqdwbUIVkTSXbYqmBc7F45Ds/Da
	45RWXZoyc5ZsBl5WTEWxTLs3iKm82m3IjL6ZSBBbc/09gxgxi/F2LLX3HodTXr/0HesipM
	ipZCUV5H6eq1LtBU//t8sjmqVgDQL+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702425754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uP5dCxevZYjeO16uJvrHP4UdWkyIyrzHoRTGNnEMXg=;
	b=TwRmT26RXdInNB5Rm1qXwR8DF2mY0WqrJwFVICC7RpCM77ej7VNO96c301/5FGgZXgvwA5
	M26F9/y0pMDgZgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 621A9137E8;
	Wed, 13 Dec 2023 00:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q0pzBJj0eGX8NgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Dec 2023 00:02:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "David Howells" <dhowells@redhat.com>,
 "Donald Buczek" <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
 "Stefan Krueger" <stefan.krueger@aei.mpg.de>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
In-reply-to: <20231212234348.ojllavmflwipxo2j@moria.home.lan>
References: <170199821328.12910.289120389882559143@noble.neil.brown.name>,
 <20231208013739.frhvlisxut6hexnd@moria.home.lan>,
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>,
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>,
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>,
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>,
 <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <2799307.1702338016@warthog.procyon.org.uk>,
 <20231212205929.op6tq3pqobwmix5a@moria.home.lan>,
 <170242184299.12910.16703366490924138473@noble.neil.brown.name>,
 <20231212234348.ojllavmflwipxo2j@moria.home.lan>
Date: Wed, 13 Dec 2023 11:02:29 +1100
Message-id: <170242574922.12910.6678164161619832398@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.10
X-Spam-Level: 
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.10

On Wed, 13 Dec 2023, Kent Overstreet wrote:
> On Wed, Dec 13, 2023 at 09:57:22AM +1100, NeilBrown wrote:
> > On Wed, 13 Dec 2023, Kent Overstreet wrote:
> > > On Mon, Dec 11, 2023 at 11:40:16PM +0000, David Howells wrote:
> > > > Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > >=20
> > > > > I was chatting a bit with David Howells on IRC about this, and floa=
ted
> > > > > adding the file handle to statx. It looks like there's enough space
> > > > > reserved to make this feasible - probably going with a fixed maximum
> > > > > size of 128-256 bits.
> > > >=20
> > > > We can always save the last bit to indicate extension space/extension=
 record,
> > > > so we're not that strapped for space.
> > >=20
> > > So we'll need that if we want to round trip NFSv4 filehandles, they
> > > won't fit in existing struct statx (nfsv4 specs 128 bytes, statx has 96
> > > bytes reserved).
> > >=20
> > > Obvious question (Neal): do/will real world implementations ever come
> > > close to making use of this, or was this a "future proofing gone wild"
> > > thing?
> >=20
> > I have no useful data.  I have seen lots of filehandles but I don't pay
> > much attention to their length.  Certainly some are longer than 32 bytes.
> >=20
> > >=20
> > > Say we do decide we want to spec it that large: _can_ we extend struct
> > > statx? I'm wondering if the userspace side was thought through, I'm
> > > sure glibc people will have something to say.
> >=20
> > The man page says:
> >=20
> >      Therefore, do not simply set mask to UINT_MAX (all bits set), as
> >      one or more bits may, in the future, be used to specify an
> >      extension to the buffer.
> >=20
> > I suspect the glibc people read that.
>=20
> The trouble is that C has no notion of which types are safe to pass
> across a dynamic library boundary, so if we increase the size of struct
> statx and someone's doing that things will break in nasty ways.
>=20

Maybe we don't increase the size of struct statx.
Maybe we declare

   struct statx2 {
     struct statx base;
     __u8 stx_handle[128];
   }

and pass then when we request STX_HANDLE.

Or maybe there is a better way.  I'm sure the glibc developers have face
this sort of problem before.

NeilBrown


