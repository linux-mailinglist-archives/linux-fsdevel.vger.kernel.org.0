Return-Path: <linux-fsdevel+bounces-5753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF9A80F9DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B5AB20F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277BF64CD7;
	Tue, 12 Dec 2023 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KYFmvhp9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AsWdKKWV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KYFmvhp9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AsWdKKWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DBBB3;
	Tue, 12 Dec 2023 14:00:57 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A9381FC11;
	Tue, 12 Dec 2023 22:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702418456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ivYwgdqs0q7RxHtaoRaa/Ww+pOgF1a5Sj6U6sMAObU=;
	b=KYFmvhp9o7KIVLePnRZND+guag4iZEzj62wRCe05QbnZrL1AldZ1ZdqbmbCoFbVU9VjyuX
	Sna5+9a8ERvzmkZ45X2G/fPNzQlaKlq8edPUVg6igwFyK6/mkW085fNYwufPLPoRovsltN
	mMOJt0V6J8InsoNnt/6C+y4bzRno8B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702418456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ivYwgdqs0q7RxHtaoRaa/Ww+pOgF1a5Sj6U6sMAObU=;
	b=AsWdKKWV5mepHoc99NZqpt9gh02qe/k8e4UjY2o4HWBTQNcynuYfWJvOEpcOxaPmo7bwey
	itvCA5yZ6gbSYhDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702418456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ivYwgdqs0q7RxHtaoRaa/Ww+pOgF1a5Sj6U6sMAObU=;
	b=KYFmvhp9o7KIVLePnRZND+guag4iZEzj62wRCe05QbnZrL1AldZ1ZdqbmbCoFbVU9VjyuX
	Sna5+9a8ERvzmkZ45X2G/fPNzQlaKlq8edPUVg6igwFyK6/mkW085fNYwufPLPoRovsltN
	mMOJt0V6J8InsoNnt/6C+y4bzRno8B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702418456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ivYwgdqs0q7RxHtaoRaa/Ww+pOgF1a5Sj6U6sMAObU=;
	b=AsWdKKWV5mepHoc99NZqpt9gh02qe/k8e4UjY2o4HWBTQNcynuYfWJvOEpcOxaPmo7bwey
	itvCA5yZ6gbSYhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2272136C7;
	Tue, 12 Dec 2023 22:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8uTxIxXYeGXdEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 22:00:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Donald Buczek" <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
 "Stefan Krueger" <stefan.krueger@aei.mpg.de>,
 "David Howells" <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
In-reply-to: <ZXjHEPn3DfgQNoms@dread.disaster.area>
References: <20231208024919.yjmyasgc76gxjnda@moria.home.lan>,
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>,
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>,
 <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>,
 <170233878712.12910.112528191448334241@noble.neil.brown.name>,
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>,
 <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>,
 <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>,
 <ZXjHEPn3DfgQNoms@dread.disaster.area>
Date: Wed, 13 Dec 2023 09:00:50 +1100
Message-id: <170241845067.12910.13041782380548675911@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.10
X-Spam-Level: 
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -4.10

On Wed, 13 Dec 2023, Dave Chinner wrote:
> On Tue, Dec 12, 2023 at 10:21:53AM -0500, Kent Overstreet wrote:
> > On Tue, Dec 12, 2023 at 04:53:28PM +1100, Dave Chinner wrote:
> > > Doesn't anyone else see or hear the elephant trumpeting loudly in
> > > the middle of the room?
> > > 
> > > I mean, we already have name_to_handle_at() for userspace to get a
> > > unique, opaque, filesystem defined file handle for any given file.
> > > It's the same filehandle that filesystems hand to the nfsd so nfs
> > > clients can uniquely identify the file they are asking the nfsd to
> > > operate on.
> > > 
> > > The contents of these filehandles is entirely defined by the file
> > > system and completely opaque to the user. The only thing that
> > > parses the internal contents of the handle is the filesystem itself.
> > > Therefore, as long as the fs encodes the information it needs into the
> > > handle to determine what subvol/snapshot the inode belongs to when
> > > the handle is passed back to it (e.g. from open_by_handle_at()) then
> > > nothing else needs to care how it is encoded.
> > > 
> > > So can someone please explain to me why we need to try to re-invent
> > > a generic filehandle concept in statx when we already have a
> > > have working and widely supported user API that provides exactly
> > > this functionality?
> > 
> > Definitely should be part of the discussion :)
> > 
> > But I think it _does_ need to be in statx; because:
> >  - we've determined that 64 bit ino_t just isn't a future proof
> >    interface, we're having real problems with it today
> >  - statx is _the_ standard, future proofed interface for getting inode
> >    attributes
> 
> No, it most definitely isn't, and statx was never intended as a
> dumping ground for anything and everything inode related. e.g. Any
> inode attribute that can be modified needs to use a different
> interface - one that has a corresponding "set" operation.

stx_size, stx_mtime, stx_atime, stx_mode, stx_owner, stx_group,
stx_nlink, ....

These can all be modified but don't have matched get and set operations.

stx_handle, of course, cannot be modified.

I think I must be completely misunderstanding you, because the way I
read your words, they don't make any sense at all.  Help!

NeilBrown

