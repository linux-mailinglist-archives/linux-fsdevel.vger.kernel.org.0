Return-Path: <linux-fsdevel+bounces-13235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C286D976
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F20B2321E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 02:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED443A8C7;
	Fri,  1 Mar 2024 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ioxk4WSo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7q6cIrTX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ioxk4WSo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7q6cIrTX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DE3A1BC
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259389; cv=none; b=tZ2Xj/OtW+V/ZZ+lTCA7ACQThbpEYK/WDFjMxeUDDR1+IYdcTgxXZd/2qc9DmITuXIoXn/RxfAfxIYHchEPgvPAhDI7bicX59RPFRY04bT6N0PM5Nwy4fGH+GdVC24Hq+usL3THy8sxUJwt0kL436mc532NEgpzlS5S28sIPC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259389; c=relaxed/simple;
	bh=RM2cJOyjfe+G1BoBRz2bF5fFk5CHnC/PHmUD8fdN+F4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NRXD3M+2ItzkWZayPKy8mfw4ojNAP/Kw6Xpn+g0qYQL8EU5/fDunJkZOJbzYTi3XwI8L8a1L/m0PDyUR6gMCxkw6GQiAM92I9LTrsumMaQRGf7iCRKXeQ92kuSUUWJM8rQihclFCuL1OtbPCoxoQFQV0hGBI/7b3wADMFVFVwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ioxk4WSo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7q6cIrTX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ioxk4WSo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7q6cIrTX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 824451F818;
	Fri,  1 Mar 2024 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709259385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cuFXdCHzzWXu0oiW3kPcFQ29IXMbiDarSwwKonCBIQ=;
	b=ioxk4WSoH2rlOOnf0KU7f2FQM872F5hJ0A30+LdRWI2VOAxKVZbH0dfQPvkpVeuIyqzuxL
	S3dGWTQdtV7TcUWm7p+vtxZVcdwAVhXhrfR1MZ/godRPtgc1KZmHinZmDQhhMFiQodyrEX
	MGRB04NTWl46qPNW2Qk3fQ07RfMNjVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709259385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cuFXdCHzzWXu0oiW3kPcFQ29IXMbiDarSwwKonCBIQ=;
	b=7q6cIrTXGiXvpjazhjBjAqeZS6vB5FuKVy1OmPnyDHyTeWPPbAQIlwlB8ZZIOpjXRJFBQZ
	9nP3JKktKbGnZqDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709259385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cuFXdCHzzWXu0oiW3kPcFQ29IXMbiDarSwwKonCBIQ=;
	b=ioxk4WSoH2rlOOnf0KU7f2FQM872F5hJ0A30+LdRWI2VOAxKVZbH0dfQPvkpVeuIyqzuxL
	S3dGWTQdtV7TcUWm7p+vtxZVcdwAVhXhrfR1MZ/godRPtgc1KZmHinZmDQhhMFiQodyrEX
	MGRB04NTWl46qPNW2Qk3fQ07RfMNjVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709259385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cuFXdCHzzWXu0oiW3kPcFQ29IXMbiDarSwwKonCBIQ=;
	b=7q6cIrTXGiXvpjazhjBjAqeZS6vB5FuKVy1OmPnyDHyTeWPPbAQIlwlB8ZZIOpjXRJFBQZ
	9nP3JKktKbGnZqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24DEA13AB0;
	Fri,  1 Mar 2024 02:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 34USLnU64WXiQgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 01 Mar 2024 02:16:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Matthew Wilcox" <willy@infradead.org>
Cc: "Amir Goldstein" <amir73il@gmail.com>, paulmck@kernel.org,
 lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
 "Kent Overstreet" <kent.overstreet@linux.dev>, "Jan Kara" <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
In-reply-to: <Zd-LljY351NCrrCP@casper.infradead.org>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>,
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>
Date: Fri, 01 Mar 2024 13:16:18 +1100
Message-id: <170925937840.24797.2167230750547152404@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ioxk4WSo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7q6cIrTX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,linux.dev,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 824451F818
X-Spam-Flag: NO

On Thu, 29 Feb 2024, Matthew Wilcox wrote:
> On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> > On Tue, Feb 27, 2024 at 8:56=E2=80=AFPM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> > >
> > > Hello!
> > >
> > > Recent discussions [1] suggest that greater mutual understanding between
> > > memory reclaim on the one hand and RCU on the other might be in order.
> > >
> > > One possibility would be an open discussion.  If it would help, I would
> > > be happy to describe how RCU reacts and responds to heavy load, along w=
ith
> > > some ways that RCU's reactions and responses could be enhanced if neede=
d.
> > >
> >=20
> > Adding fsdevel as this should probably be a cross track session.
>=20
> Perhaps broaden this slightly.  On the THP Cabal call we just had a
> conversation about the requirements on filesystems in the writeback
> path.  We currently tell filesystem authors that the entire writeback
> path must avoid allocating memory in order to prevent deadlock (or use
> GFP_MEMALLOC).  Is this appropriate?  It's a lot of work to assure that
> writing pagecache back will not allocate memory in, eg, the network stack,
> the device driver, and any other layers the write must traverse.
>=20
> With the removal of ->writepage from vmscan, perhaps we can make
> filesystem authors lives easier by relaxing this requirement as pagecache
> should be cleaned long before we get to reclaiming it.
>=20
> I don't think there's anything to be done about swapping anon memory.
> We probably don't want to proactively write anon memory to swap, so by
> the time we're in ->swap_rw we really are low on memory.
>=20
>=20

While we are considering revising mm rules, I would really like to
revised the rule that GFP_KERNEL allocations are allowed to fail.
I'm not at all sure that they ever do (except for large allocations - so
maybe we could leave that exception in - or warn if large allocations
are tried without a MAY_FAIL flag).

Given that GFP_KERNEL can wait, and that the mm can kill off processes
and clear cache to free memory, there should be no case where failure is
needed or when simply waiting will eventually result in success.  And if
there is, the machine is a gonner anyway.

Once upon a time user-space pages could not be ripped out of a process
by the oom killer until the process actually exited, and that meant that
GFP_KERNEL allocations of a process being oom killed should not block
indefinitely in the allocator.  I *think* that isn't the case any more.

Insisting that GFP_KERNEL allocations never returned NULL would allow us
to remove a lot of untested error handling code....

NeilBrown

