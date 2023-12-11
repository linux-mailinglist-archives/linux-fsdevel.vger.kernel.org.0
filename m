Return-Path: <linux-fsdevel+bounces-5596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC480DFBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAA8282301
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA1F5677F;
	Mon, 11 Dec 2023 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kb+L5QSd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CTvGuy9D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kb+L5QSd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CTvGuy9D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161609B;
	Mon, 11 Dec 2023 15:53:14 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D0FB22458;
	Mon, 11 Dec 2023 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702338792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gofbj9vDdSgV2Ql1I9R397h0kPZepN567eMxEXSjMbA=;
	b=kb+L5QSdmiNO8Bn0RU+oukADhokIW8btbU2slYimpT0fpse41EqAEkBcHRFgQp/vgU+BGC
	f5lAEwPGS0DMYG3bh9knLFfprEEMjNThcV3jdtmN4V0850bZrw1Jw2BtRfn1J/8Qa5QNja
	I+AD5vr6xXLo15K4hftw6TVwWNMQuTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702338792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gofbj9vDdSgV2Ql1I9R397h0kPZepN567eMxEXSjMbA=;
	b=CTvGuy9DDtg1KmLZtE3yJBUd9qTG3CccvdB2s7UurmaJLmn2ZbkdYOjxb57Wgbt2RnzpuP
	WLlz0/vlCb7uTIBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702338792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gofbj9vDdSgV2Ql1I9R397h0kPZepN567eMxEXSjMbA=;
	b=kb+L5QSdmiNO8Bn0RU+oukADhokIW8btbU2slYimpT0fpse41EqAEkBcHRFgQp/vgU+BGC
	f5lAEwPGS0DMYG3bh9knLFfprEEMjNThcV3jdtmN4V0850bZrw1Jw2BtRfn1J/8Qa5QNja
	I+AD5vr6xXLo15K4hftw6TVwWNMQuTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702338792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gofbj9vDdSgV2Ql1I9R397h0kPZepN567eMxEXSjMbA=;
	b=CTvGuy9DDtg1KmLZtE3yJBUd9qTG3CccvdB2s7UurmaJLmn2ZbkdYOjxb57Wgbt2RnzpuP
	WLlz0/vlCb7uTIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CAC5132DA;
	Mon, 11 Dec 2023 23:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VtT7OuWgd2WRVAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Dec 2023 23:53:09 +0000
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
Cc: "Donald Buczek" <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
 "Stefan Krueger" <stefan.krueger@aei.mpg.de>,
 "David Howells" <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
In-reply-to: <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
References: <12f711f9-70a2-408e-8588-2839e599b668@molgen.mpg.de>,
 <170181366042.7109.5045075782421670339@noble.neil.brown.name>,
 <97375d00-4bf7-4c4f-96ec-47f4078abb3d@molgen.mpg.de>,
 <170199821328.12910.289120389882559143@noble.neil.brown.name>,
 <20231208013739.frhvlisxut6hexnd@moria.home.lan>,
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>,
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>,
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>,
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>,
 <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
Date: Tue, 12 Dec 2023 10:53:07 +1100
Message-id: <170233878712.12910.112528191448334241@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.30
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.19)[-0.958];
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Tue, 12 Dec 2023, Kent Overstreet wrote:
> On Tue, Dec 12, 2023 at 09:43:27AM +1100, NeilBrown wrote:
> > On Sat, 09 Dec 2023, Kent Overstreet wrote:
> > > On Fri, Dec 08, 2023 at 12:34:28PM +0100, Donald Buczek wrote:
> > > > On 12/8/23 03:49, Kent Overstreet wrote:
> > > >=20
> > > > > We really only need 6 or 7 bits out of the inode number for shardin=
g;
> > > > > then 20-32 bits (nobody's going to have a billion snapshots; a mill=
ion
> > > > > is a more reasonable upper bound) for the subvolume ID leaves 30 to=
 40
> > > > > bits for actually allocating inodes out of.
> > > > >=20
> > > > > That'll be enough for the vast, vast majority of users, but exceedi=
ng
> > > > > that limit is already something we're technically capable of: we're
> > > > > currently seeing filesystems well over 100 TB, petabyte range expec=
ted
> > > > > as fsck gets more optimized and online fsck comes.
> > > >=20
> > > > 30 bits would not be enough even today:
> > > >=20
> > > > buczek@done:~$ df -i /amd/done/C/C8024
> > > > Filesystem         Inodes     IUsed      IFree IUse% Mounted on
> > > > /dev/md0       2187890304 618857441 1569032863   29% /amd/done/C/C8024
> > > >=20
> > > > So that's 32 bit on a random production system ( 618857441 =3D=3D 0x2=
4e303e1 ).
> >=20
> > only 30 bits though.  So it is a long way before you use all 32 bits.
> > How many volumes do you have?
> >=20
> > > >=20
> > > > And if the idea to produce unique inode numbers by hashing the fileha=
ndle into 64 is followed, collisions definitely need to be addressed. With 61=
8857441 objects, the probability of a hash collision with 64 bit is already o=
ver 1% [1].
> > >=20
> > > Oof, thanks for the data point. Yeah, 64 bits is clearly not enough for
> > > a unique identifier; time to start looking at how to extend statx.
> > >=20
> >=20
> > 64 should be plenty...
> >=20
> > If you have 32 bits for free allocation, and 7 bits for sharding across
> > 128 CPUs, then you can allocate many more than 4 billion inodes.  Maybe
> > not the full 500 billion for 39 bits, but if you actually spread the
> > load over all the shards, then certainly tens of billions.
> >=20
> > If you use 22 bits for volume number and 42 bits for inodes in a volume,
> > then you can spend 7 on sharding and still have room for 55 of Donald's
> > filesystems to be allocated by each CPU.
> >=20
> > And if Donald only needs thousands of volumes, not millions, then he
> > could configure for a whole lot more headroom.
> >=20
> > In fact, if you use the 64 bits of vfs_inode number by filling in bits fr=
om
> > the fs-inode number from one end, and bits from the volume number from
> > the other end, then you don't need to pre-configure how the 64 bits are
> > shared.
> > You record inum-bits and volnum bits in the filesystem metadata, and
> > increase either as needed.  Once the sum hits 64, you start returning
> > ENOSPC for new files or new volumes.
> >=20
> > There will come a day when 64 bits is not enough for inodes in a single
> > filesystem.  Today is not that day.
>=20
> Except filesystems are growing all the time: that leaves almost no room
> for growth and then we're back in the world where users had to guess how
> many inodes they were going to need in their filesystem; and if we put
> this off now we're just kicking the can down the road until when it
> becomes really pressing and urgent to solve.
>=20
> No, we need to come up with something better.
>=20
> I was chatting a bit with David Howells on IRC about this, and floated
> adding the file handle to statx. It looks like there's enough space
> reserved to make this feasible - probably going with a fixed maximum
> size of 128-256 bits.

Unless there is room for 128 bytes (1024bits), it cannot be used for
NFSv4.  That would be ... sad.

>=20
> Thoughts?
>=20

I'm completely in favour of exporting the (full) filehandle through
statx. (If the application asked for the filehandle, it will expect a
larger structure to be returned.  We don't need to use the currently
reserved space).

I'm completely in favour of updating user-space tools to use the
filehandle to check if two handles are for the same file.

I'm not in favour of any filesystem depending on this for correct
functionality today.  As long as the filesystem isn't so large that
inum+volnum simply cannot fit in 64 bits, we should make a reasonable
effort to present them both in 64 bits.  Depending on the filehandle is a
good plan for long term growth, not for basic functionality today.

Thanks,
NeilBrown

