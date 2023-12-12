Return-Path: <linux-fsdevel+bounces-5602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3D80E098
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34371F21C34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8A81A;
	Tue, 12 Dec 2023 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P0oHaWL4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0iaJRxdF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P0oHaWL4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0iaJRxdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFC1B5;
	Mon, 11 Dec 2023 16:59:58 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB42D22455;
	Tue, 12 Dec 2023 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702342796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TSegy37Mywewjf7EyyG9I+arxEp5UKVg3K0h+/d2HU=;
	b=P0oHaWL4F9lmAPGHW7TKjrpyYQ7PeU0TuVk78ZO1pTDSL5xHcjMhpJEBMxoihmEUss7PEh
	zssilx9dTW/aWzja+DYmqlMBCoHOy2TWhthakEq+gkx1Af+0aP4WY4uALJirde7zUYqnWw
	jG5SUhDk43i2FU6TjmUBlG3s1oJPUkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702342796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TSegy37Mywewjf7EyyG9I+arxEp5UKVg3K0h+/d2HU=;
	b=0iaJRxdF/sy/x0fPM3PjuNWDtms6yNBsiWBRkZKKfH1vucHZnRAV0PGi/lu0aZ23av0uyl
	LRrzzzOj8Zw8o+Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702342796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TSegy37Mywewjf7EyyG9I+arxEp5UKVg3K0h+/d2HU=;
	b=P0oHaWL4F9lmAPGHW7TKjrpyYQ7PeU0TuVk78ZO1pTDSL5xHcjMhpJEBMxoihmEUss7PEh
	zssilx9dTW/aWzja+DYmqlMBCoHOy2TWhthakEq+gkx1Af+0aP4WY4uALJirde7zUYqnWw
	jG5SUhDk43i2FU6TjmUBlG3s1oJPUkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702342796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TSegy37Mywewjf7EyyG9I+arxEp5UKVg3K0h+/d2HU=;
	b=0iaJRxdF/sy/x0fPM3PjuNWDtms6yNBsiWBRkZKKfH1vucHZnRAV0PGi/lu0aZ23av0uyl
	LRrzzzOj8Zw8o+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EF7C133DE;
	Tue, 12 Dec 2023 00:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8V4DEIqwd2VzfAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 00:59:54 +0000
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
In-reply-to: <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
References: <97375d00-4bf7-4c4f-96ec-47f4078abb3d@molgen.mpg.de>,
 <170199821328.12910.289120389882559143@noble.neil.brown.name>,
 <20231208013739.frhvlisxut6hexnd@moria.home.lan>,
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>,
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>,
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>,
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>,
 <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>,
 <170233878712.12910.112528191448334241@noble.neil.brown.name>,
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
Date: Tue, 12 Dec 2023 11:59:51 +1100
Message-id: <170234279139.12910.809452786055101337@noble.neil.brown.name>
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Tue, 12 Dec 2023, Kent Overstreet wrote:
> On Tue, Dec 12, 2023 at 10:53:07AM +1100, NeilBrown wrote:
> > On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > > On Tue, Dec 12, 2023 at 09:43:27AM +1100, NeilBrown wrote:
> > > > On Sat, 09 Dec 2023, Kent Overstreet wrote:
> > > > > On Fri, Dec 08, 2023 at 12:34:28PM +0100, Donald Buczek wrote:
> > > > > > On 12/8/23 03:49, Kent Overstreet wrote:
> > > > > >=20
> > > > > > > We really only need 6 or 7 bits out of the inode number for sha=
rding;
> > > > > > > then 20-32 bits (nobody's going to have a billion snapshots; a =
million
> > > > > > > is a more reasonable upper bound) for the subvolume ID leaves 3=
0 to 40
> > > > > > > bits for actually allocating inodes out of.
> > > > > > >=20
> > > > > > > That'll be enough for the vast, vast majority of users, but exc=
eeding
> > > > > > > that limit is already something we're technically capable of: w=
e're
> > > > > > > currently seeing filesystems well over 100 TB, petabyte range e=
xpected
> > > > > > > as fsck gets more optimized and online fsck comes.
> > > > > >=20
> > > > > > 30 bits would not be enough even today:
> > > > > >=20
> > > > > > buczek@done:~$ df -i /amd/done/C/C8024
> > > > > > Filesystem         Inodes     IUsed      IFree IUse% Mounted on
> > > > > > /dev/md0       2187890304 618857441 1569032863   29% /amd/done/C/=
C8024
> > > > > >=20
> > > > > > So that's 32 bit on a random production system ( 618857441 =3D=3D=
 0x24e303e1 ).
> > > >=20
> > > > only 30 bits though.  So it is a long way before you use all 32 bits.
> > > > How many volumes do you have?
> > > >=20
> > > > > >=20
> > > > > > And if the idea to produce unique inode numbers by hashing the fi=
lehandle into 64 is followed, collisions definitely need to be addressed. Wit=
h 618857441 objects, the probability of a hash collision with 64 bit is alrea=
dy over 1% [1].
> > > > >=20
> > > > > Oof, thanks for the data point. Yeah, 64 bits is clearly not enough=
 for
> > > > > a unique identifier; time to start looking at how to extend statx.
> > > > >=20
> > > >=20
> > > > 64 should be plenty...
> > > >=20
> > > > If you have 32 bits for free allocation, and 7 bits for sharding acro=
ss
> > > > 128 CPUs, then you can allocate many more than 4 billion inodes.  May=
be
> > > > not the full 500 billion for 39 bits, but if you actually spread the
> > > > load over all the shards, then certainly tens of billions.
> > > >=20
> > > > If you use 22 bits for volume number and 42 bits for inodes in a volu=
me,
> > > > then you can spend 7 on sharding and still have room for 55 of Donald=
's
> > > > filesystems to be allocated by each CPU.
> > > >=20
> > > > And if Donald only needs thousands of volumes, not millions, then he
> > > > could configure for a whole lot more headroom.
> > > >=20
> > > > In fact, if you use the 64 bits of vfs_inode number by filling in bit=
s from
> > > > the fs-inode number from one end, and bits from the volume number from
> > > > the other end, then you don't need to pre-configure how the 64 bits a=
re
> > > > shared.
> > > > You record inum-bits and volnum bits in the filesystem metadata, and
> > > > increase either as needed.  Once the sum hits 64, you start returning
> > > > ENOSPC for new files or new volumes.
> > > >=20
> > > > There will come a day when 64 bits is not enough for inodes in a sing=
le
> > > > filesystem.  Today is not that day.
> > >=20
> > > Except filesystems are growing all the time: that leaves almost no room
> > > for growth and then we're back in the world where users had to guess how
> > > many inodes they were going to need in their filesystem; and if we put
> > > this off now we're just kicking the can down the road until when it
> > > becomes really pressing and urgent to solve.
> > >=20
> > > No, we need to come up with something better.
> > >=20
> > > I was chatting a bit with David Howells on IRC about this, and floated
> > > adding the file handle to statx. It looks like there's enough space
> > > reserved to make this feasible - probably going with a fixed maximum
> > > size of 128-256 bits.
> >=20
> > Unless there is room for 128 bytes (1024bits), it cannot be used for
> > NFSv4.  That would be ... sad.
>=20
> NFSv4 specs that for the maximum size? That is pretty hefty...

It is - but it needs room to identify the filesystem and it needs to be
stable across time.  That need is more than a local filesystem needs.

NFSv2 allowed 32 bytes which is enough for a 16 byte filesys uuid, 8
byte inum and 8byte generation num.  But only just.

NFSv3 allowed 64 bytes which was likely plenty for (nearly?) every
situation.

NFSv4 doubled it again because .... who knows.  "why not" I guess.
Linux nfsd typically uses 20 or 28 bytes plus whatever the filesystem
wants. (28 when the export point is not the root of the filesystem).
I suspect this always fits within an NFSv3 handle except when
re-exporting an NFS filesystem.  NFS re-export is an interesting case...


>=20
> > > Thoughts?
> > >=20
> >=20
> > I'm completely in favour of exporting the (full) filehandle through
> > statx. (If the application asked for the filehandle, it will expect a
> > larger structure to be returned.  We don't need to use the currently
> > reserved space).
> >=20
> > I'm completely in favour of updating user-space tools to use the
> > filehandle to check if two handles are for the same file.
> >=20
> > I'm not in favour of any filesystem depending on this for correct
> > functionality today.  As long as the filesystem isn't so large that
> > inum+volnum simply cannot fit in 64 bits, we should make a reasonable
> > effort to present them both in 64 bits.  Depending on the filehandle is a
> > good plan for long term growth, not for basic functionality today.
>=20
> My standing policy in these situations is that I'll do the stopgap/hacky
> measure... but not before doing actual, real work on the longterm
> solution :)

Eminently sensible.

>=20
> So if we're all in favor of statx as the real long term solution, how
> about we see how far we get with that?
>=20

I suggest:

 STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
                              same inode number

=20
 __u64 stx_vol     Volume identifier.  Two files with same stx_vol and=20
                   stx_ino MUST be the same.  Exact meaning of volumes
                   is filesys-specific
=20
 STATX_VOL         Want stx_vol

  __u8 stx_handle_len  Length of stx_handle if present
  __u8 stx_handle[128] Unique stable identifier for this file.  Will
                       NEVER be reused for a different file.
                       This appears AFTER __statx_pad2, beyond
                       the current 'struct statx'.
 STATX_HANDLE      Want stx_handle_len and stx_handle. Buffer for
                   receiving statx info has at least
                   sizeof(struct statx)+128 bytes.

I think both the handle and the vol can be useful.
NFS can provide stx_handle but not stx_vol.  It is the thing
to use for equality testing, but it is only needed if
STATX_ATTR_INUM_NOT_UNIQUE is set.
stx_vol is useful for "du -x" or maybe "du --one-volume" or similar.


Note that we *could* add stx_vol to NFSv4.2.  It is designed for
incremental extension.  I suspect we wouldn't want to rush into this,
but to wait to see if different volume-capable filesystems have other
details of volumes that are common and can usefully be exported by statx
- or NFS.

NeilBrown

