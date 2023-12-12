Return-Path: <linux-fsdevel+bounces-5759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED5C80FA53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800841C20D22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC4BA57;
	Tue, 12 Dec 2023 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QVCQC9U1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4a346Gj8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QVCQC9U1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4a346Gj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5A792;
	Tue, 12 Dec 2023 14:36:54 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 728BD1FCD5;
	Tue, 12 Dec 2023 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702420612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xelHuVNx0z6V1HsTh0h+nWwybAtw5umMkd+oWXzekm8=;
	b=QVCQC9U1QP/x2HwMylury5e7TzuDFL+fSllfsmq96D2xgYNfRE7fzn4/UcJn05I7KdFBMb
	4gqAI4OW1xFDtUEvF/UHI6fmwilHurRrKGYMlUHXTy6IffIYKQM+Cr84Os+6C3xr6HbOTj
	FEHpxPDemZX1z+4gs/4fv92uJAiojPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702420612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xelHuVNx0z6V1HsTh0h+nWwybAtw5umMkd+oWXzekm8=;
	b=4a346Gj8vzsYkuDiPP/C+gYBiEQXALDnFRyaMaylYz7il4A/V70esFehr4pZigWRSaYj/0
	u/NxEwuH+AnVWcBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702420612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xelHuVNx0z6V1HsTh0h+nWwybAtw5umMkd+oWXzekm8=;
	b=QVCQC9U1QP/x2HwMylury5e7TzuDFL+fSllfsmq96D2xgYNfRE7fzn4/UcJn05I7KdFBMb
	4gqAI4OW1xFDtUEvF/UHI6fmwilHurRrKGYMlUHXTy6IffIYKQM+Cr84Os+6C3xr6HbOTj
	FEHpxPDemZX1z+4gs/4fv92uJAiojPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702420612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xelHuVNx0z6V1HsTh0h+nWwybAtw5umMkd+oWXzekm8=;
	b=4a346Gj8vzsYkuDiPP/C+gYBiEQXALDnFRyaMaylYz7il4A/V70esFehr4pZigWRSaYj/0
	u/NxEwuH+AnVWcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41C2613725;
	Tue, 12 Dec 2023 22:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3JGPOIDgeGUyGwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 22:36:48 +0000
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
Cc: "Frank Filz" <ffilzlnx@mindspring.com>, "'Theodore Ts'o'" <tytso@mit.edu>,
 "'Donald Buczek'" <buczek@molgen.mpg.de>,
 "'Kent Overstreet'" <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org,
 "'Stefan Krueger'" <stefan.krueger@aei.mpg.de>,
 "'David Howells'" <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx
In-reply-to: <ZXjdVvE9W45KOrqe@dread.disaster.area>
References: <20231211233231.oiazgkqs7yahruuw@moria.home.lan>,
 <170233878712.12910.112528191448334241@noble.neil.brown.name>,
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>,
 <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>,
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>,
 <20231212152016.GB142380@mit.edu>,
 <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com>,
 <ZXjJyoJQFgma+lXF@dread.disaster.area>,
 <170241826315.12910.12856411443761882385@noble.neil.brown.name>,
 <ZXjdVvE9W45KOrqe@dread.disaster.area>
Date: Wed, 13 Dec 2023 09:36:26 +1100
Message-id: <170242058636.12910.14885419800684787314@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.30
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[mindspring.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[mindspring.com,mit.edu,molgen.mpg.de,linux.dev,vger.kernel.org,aei.mpg.de,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed, 13 Dec 2023, Dave Chinner wrote:
> On Wed, Dec 13, 2023 at 08:57:43AM +1100, NeilBrown wrote:
> > On Wed, 13 Dec 2023, Dave Chinner wrote:
> > > On Tue, Dec 12, 2023 at 09:15:29AM -0800, Frank Filz wrote:
> > > > > On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> > > > > > On 12/12/23 06:53, Dave Chinner wrote:
> > > > > >
> > > > > > > So can someone please explain to me why we need to try to re-in=
vent
> > > > > > > a generic filehandle concept in statx when we already have a ha=
ve
> > > > > > > working and widely supported user API that provides exactly this
> > > > > > > functionality?
> > > > > >
> > > > > > name_to_handle_at() is fine, but userspace could profit from being
> > > > > > able to retrieve the filehandle together with the other metadata =
in a
> > > > > > single system call.
> > > > >=20
> > > > > Can you say more?  What, specifically is the application that would=
 want
> > > > to do
> > > > > that, and is it really in such a hot path that it would be a user-v=
isible
> > > > > improveable, let aloine something that can be actually be measured?
> > > >=20
> > > > A user space NFS server like Ganesha could benefit from getting attri=
butes
> > > > and file handle in a single system call.
> > >=20
> > > At the cost of every other application that doesn't need those
> > > attributes.
> >=20
> > Why do you think there would be a cost?
>=20
> It's as much maintenance and testing cost as it is a runtime cost.

You are moving the goal posts.  Maintenance is not a cost borne by
"every other application".

But if you think it is a concern it is certainly worth mentioning.

> We have to test and check this functionality works as advertised,
> and we have to maintain that in working order forever more. That's
> not free, especially if it is decided that the implementation needs
> to be hyper-optimised in each individual filesystem because of
> performance cost reasons.
>=20
> Indeed, even the runtime "do we need to fetch this information"
> checks have a measurable cost, especially as statx() is a very hot
> kernel path. We've been optimising branches out of things like
> setting up kiocbs because when that path is taken millions of times
> every second each logic branch that decides if something needs to be
> done or not has a direct measurable cost. statx() is a hot path that
> can be called millions of times a second.....
>=20
> And then comes the cost of encoding dynamically sized information in
> struct statx - filehandles are not fixed size - and statx is most
> definitely not set up or intended for dynamically sized attribute
> data. This adds more complexity to statx because it wasn't designed
> or intended to handle dynamically sized attributes. Optional
> attributes, yes, but not attributes that might vary in size from fs
> to fs or even inode type to inode type within a fileystem (e.g. dir
> filehandles can, optionally, encode the parent inode in them).

Filehandles are fixed sized.  They are one integer in the range 0-128
plus 128 bytes.  We know/promise the when the integer is less than 128,
trailing bytes of the 128 will all be zero.

NeilBRown


>=20
> -Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20


