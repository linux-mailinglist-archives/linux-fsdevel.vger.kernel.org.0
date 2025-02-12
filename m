Return-Path: <linux-fsdevel+bounces-41563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998AEA31DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 06:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E7165AE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 05:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0091F12E4;
	Wed, 12 Feb 2025 05:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e1pSSxNt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KRkXJYZR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e1pSSxNt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KRkXJYZR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AF1DB12C;
	Wed, 12 Feb 2025 05:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739337761; cv=none; b=PCITLdJtrQCpi3JcTKSILsT0n6tpVjR2FIqq1jrZXwvZlZzMC78Um3grbtpTmquN5P8tm3+hov4XpMrrvA8/CgG0/zZ06OdaNFmQZqZjhih3EJCsH/VRCyItKqugK2A5rV1W+pAPridfyXSCJ/wOajxBYQcYr8AYzi3UQxhMWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739337761; c=relaxed/simple;
	bh=foq2SrGu35ckWh0uM/JlM2by4URihd4ahZVdTGyxbKA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PpodzZIGNm6NjkuJ7wJVoJ/SujX+cTL58EqNrkPxNyqHf09V1RdQRcUbgp0GqENTn7RJdatg26UAlzEGf6yKwr+uLuNLQcO9PtMY7nRUbaz9X7iy4G4ovvr230DKVu5qLM/lUZitbgZeFRaO7OcqCzWHB/8aiNufVR1OIG0nzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e1pSSxNt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KRkXJYZR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e1pSSxNt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KRkXJYZR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2E681FB8D;
	Wed, 12 Feb 2025 05:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739337757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pMrhd8rIAPk1/Wb1h7GOo77FVMJ/Y+bI9/i18p9Eng=;
	b=e1pSSxNt2lqENrRhC2t6NYbqcQkrLBfBUmyx+7RHHa4ZOfgv+hCUzakL3bRVTUkBVgMJKF
	reWPLkF17hs86zjr6Uy1E5ErAw0c9dAiFmfaiGNdSJFSthI05U+YS1yl+LZ2fET4I+zO08
	jeaDGxAzMb9Hew7iwOiqpya/kxEUZi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739337757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pMrhd8rIAPk1/Wb1h7GOo77FVMJ/Y+bI9/i18p9Eng=;
	b=KRkXJYZRP76cSPk+Z+xxOohOydAuF5he0FOxhjPTMlJK4xBz+Z3LDD2iL+8sQhovdz6hLH
	Yla/1hLEDLA25MCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739337757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pMrhd8rIAPk1/Wb1h7GOo77FVMJ/Y+bI9/i18p9Eng=;
	b=e1pSSxNt2lqENrRhC2t6NYbqcQkrLBfBUmyx+7RHHa4ZOfgv+hCUzakL3bRVTUkBVgMJKF
	reWPLkF17hs86zjr6Uy1E5ErAw0c9dAiFmfaiGNdSJFSthI05U+YS1yl+LZ2fET4I+zO08
	jeaDGxAzMb9Hew7iwOiqpya/kxEUZi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739337757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pMrhd8rIAPk1/Wb1h7GOo77FVMJ/Y+bI9/i18p9Eng=;
	b=KRkXJYZRP76cSPk+Z+xxOohOydAuF5he0FOxhjPTMlJK4xBz+Z3LDD2iL+8sQhovdz6hLH
	Yla/1hLEDLA25MCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D59213707;
	Wed, 12 Feb 2025 05:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jOhBMRowrGeDdwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 05:22:34 +0000
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
Subject: Re: [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
In-reply-to: <20250208231819.GR1977892@ZenIV>
References: <>, <20250208231819.GR1977892@ZenIV>
Date: Wed, 12 Feb 2025 16:22:16 +1100
Message-id: <173933773664.22054.1727909798811618895@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sun, 09 Feb 2025, Al Viro wrote:
> On Fri, Feb 07, 2025 at 08:22:35PM +0000, Al Viro wrote:
> > On Thu, Feb 06, 2025 at 04:42:45PM +1100, NeilBrown wrote:
> > > lookup_and_lock() combines locking the directory and performing a lookup
> > > prior to a change to the directory.
> > > Abstracting this prepares for changing the locking requirements.
> > >=20
> > > done_lookup_and_lock() provides the inverse of putting the dentry and
> > > unlocking.
> > >=20
> > > For "silly_rename" we will need to lookup_and_lock() in a directory that
> > > is already locked.  For this purpose we add LOOKUP_PARENT_LOCKED.
> >=20
> > Ewww...  I do realize that such things might appear in intermediate
> > stages of locking massage, but they'd better be _GONE_ by the end of it.
> > Conditional locking of that sort is really asking for trouble.
> >=20
> > If nothing else, better split the function in two variants and document
> > the differences; that kind of stuff really does not belong in arguments.
> > If you need it to exist through the series, that is - if not, you should
> > just leave lookup_one_qstr() for the "locked" case from the very beginnin=
g.
>=20
> The same, BTW, applies to more than LOOKUP_PARENT_LOCKED part.
>=20
> One general observation: if the locking behaviour of a function depends
> upon the flags passed to it, it's going to cause massive headache afterward=
s.
>=20
> If you need to bother with data flow analysis to tell what given call will
> do, expect trouble.
>=20
> If anything, I would rather have separate lookup_for_removal(), etc., each
> with its locking effects explicitly spelled out.  Incidentally, looking

lookup_for_removal() etc would only be temporarily needed.  Eventually
(I hope) we would get to a place where all filesystems support all
operations with only a shared lock.  When we get there,
lookup_for_remove() and lookup_for_create() would be identical again.

And the difference wouldn't be that one takes a shared lock and the
other takes an exclusive lock.  It would be that one takes a shared or
exclusive lock based on flag X stored somewhere (inode, inode_operations,
...) while the other takes a shared or exclusive lock based on flag Y.

It would be nice to be able to accelerate that and push the locking down
into the filesystems call at once as Linus suggested last time:

https://lore.kernel.org/all/CAHk-=3Dwhz69y=3D98udgGB5ujH6bapYuapwfHS2esWaFrKE=
oi9-Ow@mail.gmail.com/

That would require either adding a new rwsem to each inode, possibly in
the filesystem-private part of the inode, or changing VFS to not lock
the inode at all.  The first would be unwelcome by fs developers I
expect, the second would be a serious challenge.  I started thinking
about and quickly decided I had enough challenges already.

So I think we need some way for the VFS to determine and select the lock
type requires by the filesystem.  Christian suggested a flag in
inode_operations and think that is a good idea.  I originally suggested
a flag in the superblock, but Linus suggested different operations might
want different locking (same email linked above).

But I don't think we can get away without having conditional locking
(like we already do in open_last_lookup() depending on O_CREAT).

Thanks,
NeilBrown

