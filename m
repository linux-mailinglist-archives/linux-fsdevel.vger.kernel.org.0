Return-Path: <linux-fsdevel+bounces-27453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC38D96192E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69845B21A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E51D3629;
	Tue, 27 Aug 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xzPOrKMv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q3xQLIzQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xzPOrKMv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q3xQLIzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333811F943;
	Tue, 27 Aug 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794040; cv=none; b=ajvXlPcqk5oSA6ygarIhTFLnw2vPT0SLJehXcrRL+TRHnm1SVXvRhHpmzBhsnPbiE603lzAhPRDY2yAe9baCI9hqcv8mdcIj7+RLb0kIaNyDOhrLvQuj4GGeQeV58Kjybe8TK8GfwXGhWaY3o/rfj1XFBLQ/n1wXGWQ6DtBu/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794040; c=relaxed/simple;
	bh=jnGNdqFnH0BtYPZykJakqMovo0MTN6co7oc49rBUzKQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PdT8gFFKAqJ/TQH+ReJChNLiQzeiqUJ6aDPMqSfadwTuBZBJZGlpNS/5Lr8KBtoGZxa4x3KfzpQL6285NWsPWpGPkf5jJspNW2y1mP6z02FXkiDLuvaggzOqh2sxclCcBZU4YXCSszIeSolPFcWauh7L3jj6+wOhhGt7nc4hy/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xzPOrKMv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q3xQLIzQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xzPOrKMv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q3xQLIzQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54B581FB90;
	Tue, 27 Aug 2024 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724794037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RS7JPNUGITHoLswdjxpFJAQhiodt17tKjqXSLZleEyA=;
	b=xzPOrKMv6Y2fSKkuWhil8jaUPb2D8dqY9VX78O5VFRm9/x6hTx8/l+B5q7gh+5XYjS3z6q
	VaWCcrq4lONuxVTFowotAdc7o8vPogKjjLbOpLj62H1+oIXnfZuLWyAtF9EPf5h3dhUQZk
	TnYgQrGHGGbAckqhH+gYRlcrLjkbrgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724794037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RS7JPNUGITHoLswdjxpFJAQhiodt17tKjqXSLZleEyA=;
	b=Q3xQLIzQ7REWpnaiVVpTFRkXnOLVnR0Sg76X6X7BYRKQwB1itEv6Fkw95KC9enZz9Ej/xP
	V1i7/cxYFCXEdDBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724794037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RS7JPNUGITHoLswdjxpFJAQhiodt17tKjqXSLZleEyA=;
	b=xzPOrKMv6Y2fSKkuWhil8jaUPb2D8dqY9VX78O5VFRm9/x6hTx8/l+B5q7gh+5XYjS3z6q
	VaWCcrq4lONuxVTFowotAdc7o8vPogKjjLbOpLj62H1+oIXnfZuLWyAtF9EPf5h3dhUQZk
	TnYgQrGHGGbAckqhH+gYRlcrLjkbrgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724794037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RS7JPNUGITHoLswdjxpFJAQhiodt17tKjqXSLZleEyA=;
	b=Q3xQLIzQ7REWpnaiVVpTFRkXnOLVnR0Sg76X6X7BYRKQwB1itEv6Fkw95KC9enZz9Ej/xP
	V1i7/cxYFCXEdDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF26B13724;
	Tue, 27 Aug 2024 21:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iHF/JLJEzmboEgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Aug 2024 21:27:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 15/19] pnfs/flexfiles: enable localio support
In-reply-to: <Zsyhco1OrOI_uSbd@kernel.org>
References: <>, <Zsyhco1OrOI_uSbd@kernel.org>
Date: Wed, 28 Aug 2024 07:27:03 +1000
Message-id: <172479402396.11014.13472275976731435302@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 27 Aug 2024, Mike Snitzer wrote:
> On Mon, Aug 26, 2024 at 11:39:31AM +1000, NeilBrown wrote:
> > On Sat, 24 Aug 2024, Mike Snitzer wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >=20
> > > If the DS is local to this client use localio to write the data.
> > >=20
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfs/flexfilelayout/flexfilelayout.c    | 136 +++++++++++++++++++++-
> > >  fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
> > >  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
> > >  3 files changed, 140 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilela=
yout/flexfilelayout.c
> > > index 01ee52551a63..d91b640f6c05 100644
> > > --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> > > +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/nfs_mount.h>
> > >  #include <linux/nfs_page.h>
> > >  #include <linux/module.h>
> > > +#include <linux/file.h>
> > >  #include <linux/sched/mm.h>
> > > =20
> > >  #include <linux/sunrpc/metrics.h>
> > > @@ -162,6 +163,72 @@ decode_name(struct xdr_stream *xdr, u32 *id)
> > >  	return 0;
> > >  }
> > > =20
> > > +/*
> > > + * A dummy definition to make RCU (and non-LOCALIO compilation) happy.
> > > + * struct nfsd_file should never be dereferenced in this file.
> > > + */
> > > +struct nfsd_file {
> > > +       int undefined__;
> > > +};
> >=20
> > I removed this and tried building both with and without LOCALIO enabled
> > and the compiler didn't complain.
> > Could you tell me what to do to see the unhappiness you mention?
>=20
> Sorry, I can remove the dummy definition for upstream.  That was
> leftover from the backport I did to 5.15.y stable@ kernel.  Older
> kernels' RCU code dereferences what should just be an opaque pointer
> and (ab)use typeof.  So without the dummy definition compiling against
> 5.15.y fails with:
>=20
>   CC [M]  fs/nfs/flexfilelayout/flexfilelayout.o
> In file included from ./include/linux/rbtree.h:24,
>                  from ./include/linux/mm_types.h:10,
>                  from ./include/linux/mmzone.h:21,
>                  from ./include/linux/gfp.h:6,
>                  from ./include/linux/mm.h:10,
>                  from ./include/linux/nfs_fs.h:23,
>                  from fs/nfs/flexfilelayout/flexfilelayout.c:10:
> fs/nfs/flexfilelayout/flexfilelayout.c: In function `ff_local_open_fh=C2=B4:
> ./include/linux/rcupdate.h:441:9: error: dereferencing pointer to incomplet=
e type `struct nfsd_file=C2=B4
>   typeof(*p) *________p1 =3D (typeof(*p) *__force)READ_ONCE(p); \
>          ^
> ./include/linux/rcupdate.h:580:2: note: in expansion of macro `__rcu_derefe=
rence_check=C2=B4
>   __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
>   ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/rcupdate.h:648:28: note: in expansion of macro `rcu_derefer=
ence_check=C2=B4
>  #define rcu_dereference(p) rcu_dereference_check(p, 0)
>                             ^~~~~~~~~~~~~~~~~~~~~
> fs/nfs/flexfilelayout/flexfilelayout.c:193:7: note: in expansion of macro `=
rcu_dereference=C2=B4
>   nf =3D rcu_dereference(*pnf);
>        ^~~~~~~~~~~~~~~

Ahhh - good to know.  Thanks!

NeilBrown

