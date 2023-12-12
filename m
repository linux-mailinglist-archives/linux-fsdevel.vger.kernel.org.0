Return-Path: <linux-fsdevel+bounces-5751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B8680F9C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AAA1C20DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA6164CD0;
	Tue, 12 Dec 2023 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xOgz47cw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OpdQZT2I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xLS4rqkG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AqDIONAl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BBFAB;
	Tue, 12 Dec 2023 13:54:06 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEFED224F2;
	Tue, 12 Dec 2023 21:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702418045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6C2uf4af0UQgbCoB9eQ2Jfg7popc+OfjUqFFa9tECQ=;
	b=xOgz47cwyma+RZnMQycA1dbCwl9oE+87ewqg/gqXtdJLiliV71pd60fYisJnuGUGibfq7J
	MR2kM0vpKo5InzxXrDTFuQcZaBTQPKo+SOaar1+AB0StCuSxfQ5hpcVsyxRgMV6STRtb82
	PozZexR/iI6SxfKESDl/YnuaW7sGXXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702418045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6C2uf4af0UQgbCoB9eQ2Jfg7popc+OfjUqFFa9tECQ=;
	b=OpdQZT2ILsyVd2NXC5ynpStCY4zIHbqv8UbqaXNtAByTKCGy+r7u3va4PzZcq+/W5/tQp4
	f5iNn4cZjWslPJDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702418044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6C2uf4af0UQgbCoB9eQ2Jfg7popc+OfjUqFFa9tECQ=;
	b=xLS4rqkGVzVa/3SjruZFT0gDTOnB1ULXwvjdDrwtRmi6ZTme0bmBKkwDSlGhQkUZF687jE
	y8C9PVtydiaVdEoWmp6YWvcJqXBvoxoFuSw7Dr3NiElN99gge0eyNSGxmwrPqRmz2eLEQP
	eWwZ+D1NzLjaEGGaiFOyNtox2q1UiEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702418044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6C2uf4af0UQgbCoB9eQ2Jfg7popc+OfjUqFFa9tECQ=;
	b=AqDIONAlq3nGy3zeCwk2R7zSelgj2CwNmSYgbtepGz4KtNYV7GtXNkff2HnfPfJFI5aMIG
	meSjkUfBJyo9m2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52303136C7;
	Tue, 12 Dec 2023 21:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qXlwOnfWeGVWDwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 21:53:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Dave Chinner" <david@fromorbit.com>,
 "Donald Buczek" <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
 "Stefan Krueger" <stefan.krueger@aei.mpg.de>,
 "David Howells" <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
 "Josef Bacik" <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
In-reply-to:
 <CAJfpegvNVXoxn3gW9-38YfY5u0FLjXTCDxcv5OtS-p0=0ocQvg@mail.gmail.com>
References: <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>,
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>,
 <20231212-impfung-linden-6f973f2ade19@brauner>,
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>,
 <20231212-neudefinition-hingucken-785061b73237@brauner>,
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>,
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>,
 <20231212154302.uudmkumgjaz5jouw@moria.home.lan>,
 <CAJfpegvOEZwZgcbAeivDA+X0qmfGGjOxdvq-xpGQjYuzAJxzkw@mail.gmail.com>,
 <20231212160829.vybfdajncvugweiy@moria.home.lan>,
 <CAJfpegvNVXoxn3gW9-38YfY5u0FLjXTCDxcv5OtS-p0=0ocQvg@mail.gmail.com>
Date: Wed, 13 Dec 2023 08:53:56 +1100
Message-id: <170241803693.12910.13577623411851816833@noble.neil.brown.name>
X-Spam-Level: *****
X-Spam-Score: 5.60
X-Spam-Level: 
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: CEFED224F2
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xLS4rqkG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AqDIONAl;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Spamd-Result: default: False [-8.82 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.64%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,fromorbit.com,molgen.mpg.de,vger.kernel.org,aei.mpg.de,redhat.com,toxicpanda.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -8.82

On Wed, 13 Dec 2023, Miklos Szeredi wrote:
> On Tue, 12 Dec 2023 at 17:08, Kent Overstreet <kent.overstreet@linux.dev> w=
rote:
>=20
> > In short, STATX_ATTR_INUM_NOT_UNIQUE is required to tell userspace when
> > they _must_ do the new thing if they care about correctness; it provides
> > a way to tell userspace what guarantees we're able to provide.
>=20
> That flag would not help with improving userspace software.

Are you sure?

Suppose I wanted to export an filesystem using some protocol (maybe one
called "NFSv4"), and suppose this protocol supported the communication
of an attribute called "fileid" which was optional but requires to be
fully unique if provided at all.

If I had access to STATX_ATTR_INUM_NOT_UNIQUE, then I could not export
the fileid when it didn't met the protocol requirements, but could when
it did.

This may not be a strong case for the inclusion of the flag it is, I
think, a clear indication that "would not help" is what our fact
checkers would call "over-reach".

NeilBrown

>=20
> What would help, if said software started using a unique identifier.
> We already seem to have a unique ID in the form of file handles,
> though some exotic filesystems might allow more than one fh to refer
> to the same inode, so this still needs some looking into.
>=20
> The big problem is that we can't do a lot about existing software, and
> must keep trying to keep st_ino unique for the foreseeable future.
>=20
> Thanks,
> Miklos
>=20


