Return-Path: <linux-fsdevel+bounces-5749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DBD80F9AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA151F2141E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7576B64CC6;
	Tue, 12 Dec 2023 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qe0OtyHS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3VwMRIhH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qe0OtyHS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3VwMRIhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D50AB;
	Tue, 12 Dec 2023 13:47:03 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 691381FC11;
	Tue, 12 Dec 2023 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702417622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/XRyt8s+5AZZPOy8gPCrtIgcXx1RZiBmYtD5C4ajYs=;
	b=qe0OtyHSjzpUW3DRKm0zx2L1OckOVxJIR1OmvhEgmgUtaG8Y0+jpSkPqUSqhEJJuEl1kKh
	+RQo38kVHR6mpCLkRm7sfsS4CcFZO7JeaKd2EWCnrVvtM51mQEiZIppHzm8k1+3u/Yogc9
	YG2q/JOT5zoOhclk+dcK+Yr1rUe/1qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702417622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/XRyt8s+5AZZPOy8gPCrtIgcXx1RZiBmYtD5C4ajYs=;
	b=3VwMRIhHYrphIWCIzhyr5GbDA9vsc/ZiNFsI8DhXSmbAt+q3on7iw1J6gP34m+Fcn6E5/B
	48c8UHULgXuSMqBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702417622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/XRyt8s+5AZZPOy8gPCrtIgcXx1RZiBmYtD5C4ajYs=;
	b=qe0OtyHSjzpUW3DRKm0zx2L1OckOVxJIR1OmvhEgmgUtaG8Y0+jpSkPqUSqhEJJuEl1kKh
	+RQo38kVHR6mpCLkRm7sfsS4CcFZO7JeaKd2EWCnrVvtM51mQEiZIppHzm8k1+3u/Yogc9
	YG2q/JOT5zoOhclk+dcK+Yr1rUe/1qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702417622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/XRyt8s+5AZZPOy8gPCrtIgcXx1RZiBmYtD5C4ajYs=;
	b=3VwMRIhHYrphIWCIzhyr5GbDA9vsc/ZiNFsI8DhXSmbAt+q3on7iw1J6gP34m+Fcn6E5/B
	48c8UHULgXuSMqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F01CF136C7;
	Tue, 12 Dec 2023 21:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E1H6JdHUeGVZDQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 21:46:57 +0000
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
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
References: <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>,
 <170233878712.12910.112528191448334241@noble.neil.brown.name>,
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>,
 <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>,
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>,
 <20231212-impfung-linden-6f973f2ade19@brauner>,
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>,
 <20231212-neudefinition-hingucken-785061b73237@brauner>,
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>,
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
Date: Wed, 13 Dec 2023 08:46:54 +1100
Message-id: <170241761429.12910.13323799451396212981@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -2.32
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.49
X-Spamd-Result: default: False [-2.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.19)[89.04%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,fromorbit.com,molgen.mpg.de,vger.kernel.org,aei.mpg.de,redhat.com,toxicpanda.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Wed, 13 Dec 2023, Miklos Szeredi wrote:
> On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.dev> w=
rote:
>=20
> > Other poeple have been finding ways to contribute to the technical
> > discussion; just calling things "ugly and broken" does not.
>=20
> Kent, calm down please.  We call things "ugly and broken" all the
> time.  That's just an opinion, you are free to argue it, and no need
> to take it personally.

But maybe we shouldn't.  Maybe we should focus on saying what, exactly,
is unpleasant to look at and way.  Or what exactly causes poor
funcationality.
"ugly" and "broken" are not particularly useful words in a technical
discussion.  I understand people want to use them, but they really need
to be backed up with details.  It is details that matter.

NeilBrown


>=20
> Thanks,
> Miklos
>=20
>=20


