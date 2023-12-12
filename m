Return-Path: <linux-fsdevel+bounces-5752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904F80F9D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F71B20FA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7364CD5;
	Tue, 12 Dec 2023 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O2lAc36+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6hSQN+Hk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZJKdM7mA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jx2qyhA4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EBDB7;
	Tue, 12 Dec 2023 13:57:51 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D42FB1FC11;
	Tue, 12 Dec 2023 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702418270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=877oa51gNmgtgp7jxCBaWiixcLQ0cD25bw75ZAXvvJ0=;
	b=O2lAc36+3cZorKrPREGY0l240h1/e9a2e2CxAN5accH6AYJQit6Pqexa5XO480xiHO9azs
	m3Sj5FTRwsHpnA8tGJBvuXFFpfvRl2jOVV1QgWIfN/S0/wwfvpeIGwiY3wdd4velZX042k
	4+6RqbiiDtubhnDXEp1WruA2uy37fW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702418270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=877oa51gNmgtgp7jxCBaWiixcLQ0cD25bw75ZAXvvJ0=;
	b=6hSQN+HkUnwD4GJRkh8mi7s4aRMR/3E/Yg9JuVSEnnCTKg4Pm6gq0NszPUBMN6+A+JUWfx
	Spo77q9rVCnjveBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702418269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=877oa51gNmgtgp7jxCBaWiixcLQ0cD25bw75ZAXvvJ0=;
	b=ZJKdM7mAUpzZiDAOFwNzMcg+XVFTEg6FZ9dIGAdZdATY/Pnyyb3f890eGEj3Y3S8zM3+45
	IJW2HHEePtTEnndjxiMqJDO1604GBbUJ3+zGlTIgyFOXJT2UYZU9+zUpas4p6dHzx1V3qX
	q6Ffr77rFdrnj9JkcVjPtxWgVdAflj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702418269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=877oa51gNmgtgp7jxCBaWiixcLQ0cD25bw75ZAXvvJ0=;
	b=Jx2qyhA4XmO82yEzfF+UAxlEQoKUG7Na1Gi6BDPU4DQDID21XpgDwuIfpum4I/8dD7AYcm
	/hAA3V+VT1o2EHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8421C136C7;
	Tue, 12 Dec 2023 21:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nhnEC1rXeGWDEAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 21:57:46 +0000
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
In-reply-to: <ZXjJyoJQFgma+lXF@dread.disaster.area>
References: <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>,
 <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>,
 <170233878712.12910.112528191448334241@noble.neil.brown.name>,
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>,
 <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>,
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>,
 <20231212152016.GB142380@mit.edu>,
 <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com>,
 <ZXjJyoJQFgma+lXF@dread.disaster.area>
Date: Wed, 13 Dec 2023 08:57:43 +1100
Message-id: <170241826315.12910.12856411443761882385@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.10
X-Spam-Level: 
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.10 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[mindspring.com,mit.edu,molgen.mpg.de,linux.dev,vger.kernel.org,aei.mpg.de,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.10

On Wed, 13 Dec 2023, Dave Chinner wrote:
> On Tue, Dec 12, 2023 at 09:15:29AM -0800, Frank Filz wrote:
> > > On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> > > > On 12/12/23 06:53, Dave Chinner wrote:
> > > >
> > > > > So can someone please explain to me why we need to try to re-invent
> > > > > a generic filehandle concept in statx when we already have a have
> > > > > working and widely supported user API that provides exactly this
> > > > > functionality?
> > > >
> > > > name_to_handle_at() is fine, but userspace could profit from being
> > > > able to retrieve the filehandle together with the other metadata in a
> > > > single system call.
> > >=20
> > > Can you say more?  What, specifically is the application that would want
> > to do
> > > that, and is it really in such a hot path that it would be a user-visib=
le
> > > improveable, let aloine something that can be actually be measured?
> >=20
> > A user space NFS server like Ganesha could benefit from getting attributes
> > and file handle in a single system call.
>=20
> At the cost of every other application that doesn't need those
> attributes.

Why do you think there would be a cost?

statx only returns the attributes that it was asked for.  If an
application doesn't ask for STATX_HANDLE, it doesn't get STATS_HANDLE
and (providing filesystems honour the flag) doesn't pay the price for
generating it (which is often trivial, but may not always be).

NeilBrown


>               That's not a good trade-off - the cost of a syscall is
> tiny compared to the rest of the work that has to be done to create
> a stable filehandle for an inode, even if we have a variant of
> name_to_handle_at() that takes an open fd rather than a path.
>=20
> > Potentially it could also avoid some of the challenges of using
> > name_to_handle_at that is a privileged operation.
>=20
> It isn't. open_by_handle_at() is privileged because it bypasses all
> the path based access checking that a normal open() does. Anyone can
> get a filehandle for a path from the kernel, but few can actually
> use it for anything other than file uniqueness checks....
>=20
> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20


