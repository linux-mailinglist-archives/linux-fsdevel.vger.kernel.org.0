Return-Path: <linux-fsdevel+bounces-41557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD81A31CB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 04:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B8E3A1826
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624291DED5F;
	Wed, 12 Feb 2025 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W7raJaMC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LZrZPVy3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W7raJaMC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LZrZPVy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E951DB377;
	Wed, 12 Feb 2025 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330691; cv=none; b=oj10bowfxE1BPqk884aoXL00jzg+xIGp0fzrnsh7FS8drDFZS8h8cl7jYL+VqKUo4OZ6/MX/ceGUpvssj2nSEQ1cO1fWLS/erE7iIMa+0nw2SD8nWbyhZBbezlV4TSXXeE3AGWpsZ8uHRC7ePWt1o3DWz05eTfmnGCFzC+TrRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330691; c=relaxed/simple;
	bh=sjoxuN6QSRfjKAjfIkMPHR0s5BhlT/7aqUv+w6L6NRY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Pe8a+RQfisB9f3xcAr0YVLKBnmJ6AIBg+QFMLfAEDP6tsC+FPYohNqZ9+Udt8r2fmzHzyI+FBPA/8f+hmSEzo1dxv3FBKpqTqEzif47RXKcfgCxoxLnpgAsUSRXtzbcNhS3CW4DSv8exkzoiU16M6MVI6g91pxsl7TByzGd6KFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W7raJaMC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LZrZPVy3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W7raJaMC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LZrZPVy3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF42C33877;
	Wed, 12 Feb 2025 03:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739330687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=388J2s0I5CtwWuSOgY24hGTF1UofaDMuI6SPdzdGXBM=;
	b=W7raJaMCfuJ9XnnWi1o7mKadFUyu7/yF6VUeAqY5vt7TyK/wERKyBmHwZmJ5ojVEhcYUjM
	M+1tpi7pxeTv+NsblV+7I8k9y5rSYp7Z5nFS9vlW23VkIN4D2PZK1qbETk+e5pJzdQCuE1
	/5D8tb61kLkxLugvNHNQBCQw5Uf9vMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739330687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=388J2s0I5CtwWuSOgY24hGTF1UofaDMuI6SPdzdGXBM=;
	b=LZrZPVy3gX+I21QTFod2gtgxxgN5zwcHOWsPOoUyudykvqNl/dgkT7UAM5r07OeFK6hXsS
	d0B/4YAHGipY4LAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W7raJaMC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LZrZPVy3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739330687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=388J2s0I5CtwWuSOgY24hGTF1UofaDMuI6SPdzdGXBM=;
	b=W7raJaMCfuJ9XnnWi1o7mKadFUyu7/yF6VUeAqY5vt7TyK/wERKyBmHwZmJ5ojVEhcYUjM
	M+1tpi7pxeTv+NsblV+7I8k9y5rSYp7Z5nFS9vlW23VkIN4D2PZK1qbETk+e5pJzdQCuE1
	/5D8tb61kLkxLugvNHNQBCQw5Uf9vMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739330687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=388J2s0I5CtwWuSOgY24hGTF1UofaDMuI6SPdzdGXBM=;
	b=LZrZPVy3gX+I21QTFod2gtgxxgN5zwcHOWsPOoUyudykvqNl/dgkT7UAM5r07OeFK6hXsS
	d0B/4YAHGipY4LAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D376F13707;
	Wed, 12 Feb 2025 03:24:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZNVRH3gUrGe4WAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 03:24:40 +0000
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
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
In-reply-to: <2daod6ozirkzppfbbqe4jozw3w4u6pscjc32j6ghuu6vxme7om@abckfzrou5cl>
References:
 <>, <2daod6ozirkzppfbbqe4jozw3w4u6pscjc32j6ghuu6vxme7om@abckfzrou5cl>
Date: Wed, 12 Feb 2025 14:24:33 +1100
Message-id: <173933067340.22054.18350404503459085707@noble.neil.brown.name>
X-Rspamd-Queue-Id: BF42C33877
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 11 Feb 2025, Kent Overstreet wrote:
> On Mon, Feb 10, 2025 at 12:20:15PM +1100, NeilBrown wrote:
> > On Sat, 08 Feb 2025, Kent Overstreet wrote:
> > > On Fri, Feb 07, 2025 at 06:30:00PM +1100, NeilBrown wrote:
> > > > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > > > On Fri, Feb 07, 2025 at 05:34:23PM +1100, NeilBrown wrote:
> > > > > > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > > > > > On Fri, Feb 07, 2025 at 03:53:52PM +1100, NeilBrown wrote:
> > > > > > > > Do you think there could be a problem with changing the error=
 returned
> > > > > > > > in this circumstance? i.e. if you try to destroy a subvolume =
with a
> > > > > > > > non-existant name on a different filesystem could getting -EN=
OENT
> > > > > > > > instead of -EXDEV be noticed?
> > > > > > >=20
> > > > > > > -EXDEV is the standard error code for "we're crossing a filesys=
tem
> > > > > > > boundary and we can't or aren't supposed to be", so no, let's n=
ot change
> > > > > > > that.
> > > > > > >=20
> > > > > >=20
> > > > > > OK.  As bcachefs is the only user of user_path_locked_at() it sho=
uldn't
> > > > > > be too hard.
> > > > >=20
> > > > > Hang on, why does that require keeping user_path_locked_at()? Just
> > > > > compare i_sb...
> > > > >=20
> > > >=20
> > > > I changed user_path_locked_at() to not return a dentry at all when the
> > > > full path couldn't be found.  If there is no dentry, then there is no
> > > > ->d_sb.
> > > > (if there was an ->i_sb, there would be an inode and this all wouldn't
> > > > be an issue).
> > > >=20
> > > > To recap: the difference happens if the path DOESN'T exist but the
> > > > parent DOES exist on a DIFFERENT filesystem.  It is very much a corner
> > > > case and the error code shouldn't matter.  But I had to ask...
> > >=20
> > > Ahh...
> > >=20
> > > Well, if I've scanned the series correctly (sorry, we're on different
> > > timezones and I haven't had much caffeine yet) I hope you don't have to
> > > keep that function just for bcachefs - but I do think the error code is
> > > important.
> > >=20
> > > Userspace getting -ENOENT and reporting -ENOENT to the user will
> > > inevitably lead to head banging frustration by someone, somewhere, when
> > > they're trying to delete something and the system is tell them it
> > > doesn't exist when they can see it very much does exist, right there :)
> > > the more precise error code is a very helpful cue...
> > >=20
> >=20
> > ???
> > You will only get -ENOENT if there is no ent.  There is no question of a
> > confusing error message.
> > If you ask for a non-exist name on the correct filesystem, you get -ENOENT
> > If you ask for an existing name of the wrong filesystem, you get -EXDEV
> > That all works as expected and always has.
> >=20
> > But what if you ask for a non-existing name in a directory on the
> > wrong filesystem? =20
> > The code you originally wrote in 42d237320e9817a9 would return
> > -ENOENT because that it what user_path_at() would return.
>=20
> Ahh - ok, I think I see where I misread before
>=20
> > But using user_path_at() is "wrong" because it doesn't lock the directory
> > so ->d_parent is not guaranteed to be stable.
> > Al fixed that in bbe6a7c899e7f265c using user_path_locked_at(), but
> > that doesn't check for a negative dentry so Al added a check to return
> > -ENOENT, but that was added *after* the test that returns -EXDEV.
> >=20
> > So now if you call subvolume_destroy on a non-existing name in a
> > directory on the wrong filesystem, you get -EXDEV.  I think that is
> > a bit weird but not a lot weird.
>=20
> Yeah, we don't need to preserve that. As long as calling it on a name
> that _does_ exist on a different filesystem returns -EXDEV, that's all I
> care about.
>=20
> So assuming that's the case you can go ahead and add my acked-by...

Cool - thanks.

>=20
> Nit: I would go back and stare at the patch some more, but threading got
> completely fubar so I can't find anything. Doh.
>=20

:-)

NeilBrown



> > My patch will change it back to -ENOENT - the way you originally wrote
> > it.
> >=20
> > I hope you are ok with that.
>=20
> Yes, sounds good.
>=20


