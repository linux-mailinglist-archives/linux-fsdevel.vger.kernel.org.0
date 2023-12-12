Return-Path: <linux-fsdevel+bounces-5610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF280E147
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 03:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693521F21BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A741C0F;
	Tue, 12 Dec 2023 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QKwiGgAP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jl2ExQS6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QKwiGgAP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jl2ExQS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78FB3;
	Mon, 11 Dec 2023 18:13:14 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 060592246D;
	Tue, 12 Dec 2023 02:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702347193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZqGcXQjt1NjVljjpUzX4wNLKOVR+Z2g9oE8pzeu2xc=;
	b=QKwiGgAP47wsIiyUy6taKm8KEwQgl2zywlNPSzlTU3FNec435yNGWx6fOKGWCGaWjcx5Az
	TzeRSEEgTJKVnQ1YTQPv+VrFoT+bf+zNT68QUtiT/jseVhjyiXDql5YDnHAdxr8Gv2VEZC
	Blg7VyavtnQkApasW8F/agY46VUfnGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702347193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZqGcXQjt1NjVljjpUzX4wNLKOVR+Z2g9oE8pzeu2xc=;
	b=jl2ExQS6cmR4ROMyitekEhVL1ekahSdQ1YOqZH1t0kt2jKC25mgfCWOUxQ7FugqmGQ7XkB
	3cf6WrUj8vvGaaAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702347193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZqGcXQjt1NjVljjpUzX4wNLKOVR+Z2g9oE8pzeu2xc=;
	b=QKwiGgAP47wsIiyUy6taKm8KEwQgl2zywlNPSzlTU3FNec435yNGWx6fOKGWCGaWjcx5Az
	TzeRSEEgTJKVnQ1YTQPv+VrFoT+bf+zNT68QUtiT/jseVhjyiXDql5YDnHAdxr8Gv2VEZC
	Blg7VyavtnQkApasW8F/agY46VUfnGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702347193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZqGcXQjt1NjVljjpUzX4wNLKOVR+Z2g9oE8pzeu2xc=;
	b=jl2ExQS6cmR4ROMyitekEhVL1ekahSdQ1YOqZH1t0kt2jKC25mgfCWOUxQ7FugqmGQ7XkB
	3cf6WrUj8vvGaaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB1D3136C7;
	Tue, 12 Dec 2023 02:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cz5sGrbBd2V4EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 02:13:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Donald Buczek" <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
 "Stefan Krueger" <stefan.krueger@aei.mpg.de>,
 "David Howells" <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
In-reply-to: <20231212011038.i5cinr5ok7gkotlm@moria.home.lan>
References: <20231208013739.frhvlisxut6hexnd@moria.home.lan>,
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>,
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>,
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>,
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>,
 <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>,
 <170233878712.12910.112528191448334241@noble.neil.brown.name>,
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>,
 <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <20231212011038.i5cinr5ok7gkotlm@moria.home.lan>
Date: Tue, 12 Dec 2023 13:13:07 +1100
Message-id: <170234718752.12910.7741039469009828768@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.30
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Tue, 12 Dec 2023, Kent Overstreet wrote:
> On Tue, Dec 12, 2023 at 11:59:51AM +1100, NeilBrown wrote:
> > On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > > NFSv4 specs that for the maximum size? That is pretty hefty...
> > 
> > It is - but it needs room to identify the filesystem and it needs to be
> > stable across time.  That need is more than a local filesystem needs.
> > 
> > NFSv2 allowed 32 bytes which is enough for a 16 byte filesys uuid, 8
> > byte inum and 8byte generation num.  But only just.
> > 
> > NFSv3 allowed 64 bytes which was likely plenty for (nearly?) every
> > situation.
> > 
> > NFSv4 doubled it again because .... who knows.  "why not" I guess.
> > Linux nfsd typically uses 20 or 28 bytes plus whatever the filesystem
> > wants. (28 when the export point is not the root of the filesystem).
> > I suspect this always fits within an NFSv3 handle except when
> > re-exporting an NFS filesystem.  NFS re-export is an interesting case...
> 
> Now I'm really curious - i_generation wasn't enough? Are we including
> filesystem UUIDs?

i_generation was invented so that it could be inserted into the NFS
fileshandle.

The NFS filehandle is opaque.  It likely contains an inode number, a
generation number, and a filesystem identifier.  But it is not possible
to extract those from the handle.

> 
> I suppose if we want to be able to round trip this stuff we do need to
> allocate space for it, even if a local filesystem would never include
> it.
> 
> > I suggest:
> > 
> >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> >                               same inode number
> > 
> >  
> >  __u64 stx_vol     Volume identifier.  Two files with same stx_vol and 
> >                    stx_ino MUST be the same.  Exact meaning of volumes
> >                    is filesys-specific
> 
> NFS reexport that you mentioned previously makes it seem like this
> guarantee is impossible to provide in general (so I'd leave it out
> entirely, it's just something for people to trip over).

NFS would not set stx_vol and would not return STATX_VOL in stx_mask.
So it would not attempt to provide that guarantee.

Maybe we don't need to explicitly make this guarantee.

> 
> But we definitely want stx_vol in there. Another thing that people ask
> for is a way to ask "is this a subvolume root?" - we should make sure
> that's clearly specified, or can we just include a bit for it?

The start way to test for a filesystem root - or mount point at least -
is to stat the directory in question and its parent (..) and see if the
have the same st_dev or not.
Applying the same logic to volumes means that a single stx_vol number is
sufficient.

I'm not strongly against a STATX_ATTR_VOL_ROOT flag providing everyone
agrees what it means that we cannot imagine any awkward corner-cases
(like a 'root' being different from a 'mount point').

> 
> >  STATX_VOL         Want stx_vol
> > 
> >   __u8 stx_handle_len  Length of stx_handle if present
> >   __u8 stx_handle[128] Unique stable identifier for this file.  Will
> >                        NEVER be reused for a different file.
> >                        This appears AFTER __statx_pad2, beyond
> >                        the current 'struct statx'.
> >  STATX_HANDLE      Want stx_handle_len and stx_handle. Buffer for
> >                    receiving statx info has at least
> >                    sizeof(struct statx)+128 bytes.
> > 
> > I think both the handle and the vol can be useful.
> > NFS can provide stx_handle but not stx_vol.  It is the thing
> > to use for equality testing, but it is only needed if
> > STATX_ATTR_INUM_NOT_UNIQUE is set.
> > stx_vol is useful for "du -x" or maybe "du --one-volume" or similar.
> > 
> > 
> > Note that we *could* add stx_vol to NFSv4.2.  It is designed for
> > incremental extension.  I suspect we wouldn't want to rush into this,
> > but to wait to see if different volume-capable filesystems have other
> > details of volumes that are common and can usefully be exported by statx
> 
> Sounds reasonable
> 

Thanks,
NeilBrown

