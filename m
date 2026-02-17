Return-Path: <linux-fsdevel+bounces-77371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMl5B4uNlGn6FQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 16:47:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE314DADD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9288F30305FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C690A35EDBF;
	Tue, 17 Feb 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="Mn8APs0x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eh20fcjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB31A08AF;
	Tue, 17 Feb 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343234; cv=none; b=CIQAOZXy3C5PlQTv/VOBS2K/4n3yiPMAglZ2MdgXcFMQfX5beNRfxZZSMBMlsFGNbdjheleX94qsejfneXtHQU6OyKl8IrTpUaUCz1LQ5DxnumhHZeYYgtkpkKAITbjZ3sbuT8AQbujVaxfJhMQAUZ4Wmb0cWP5UkauuEGT4nHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343234; c=relaxed/simple;
	bh=/F3CF7kJIJlYdTae/ocf5yJrbawHZOMAk0LiuSCTIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgxMOxDL9x6extm6R6duxkSgAfhOZvmwKc2jOfP8CCFwMr+74UqIys7lEsdlh9+bBa2S4y4Vqw7CHpP8IKUrHr8xOXBFrUQ9e/onOC7yYNLyxqxa1LWqr851Zzl2gKtXiNwwf9tznu/vjtbv1yvEbQ1xGtV+BsiFVRfMMNyNriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=Mn8APs0x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eh20fcjU; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E88A7A0108;
	Tue, 17 Feb 2026 10:47:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 10:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771343230;
	 x=1771429630; bh=eSOHZKYixCwKfgxL+toMTrJrfTKK7cDvAJRVjTf9RM0=; b=
	Mn8APs0x7sHctVRPN8/7iUwyhAmujqeUbTrvmNm6j+FOlZQSs+/73bLRa6geXjbz
	099935qUbifVqUCIxuqwEMwd4cRdQBDF5RJVHCRoL2LYmyra1T04cYK0jGCjB4Ww
	aiosmjsmjhVh5zi9HXP2X2nH+CWmUQFezSawr47QivjSVR03asypxVydDCSzJEip
	1l1nb50Qzvj5XRwtUlZeTxJv7Krl+5fts26S77m+ildbnGuxudoXIuYg0DBXcd/N
	QWQHG3qmhAwZ2rogEfeBYAz1VvqL9we1C+ioIx65wRGnjXK48GeoAufxMfERQmPa
	e87uHR7i06X8tgJbELLHyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771343230; x=
	1771429630; bh=eSOHZKYixCwKfgxL+toMTrJrfTKK7cDvAJRVjTf9RM0=; b=E
	h20fcjUeQD5VDaOOummopqzrHBZf0r3+6stdjYoCheS8QRvS9yb/OGU1xwhJRLaB
	HzuxZsLMWkhcdJuX2AAhxP2m9oGf8VPs4dlhELOxNlwXhxCpEO5IPUxY6Qq5SYCY
	QRPqP8tJPkDWOu5I+33J+MPRYpccOZElANHNqzGX8IH+h/dmcdsdTu5pBTTK9DNj
	/Z8ujUYiP35PUcT0J8r6UEQWsvVRMtz7B6lMQR8+Zb7iGA/1KLWCvjGOe1JC/bee
	rrCQVrghgs4vWEjFQscYYybLZyqGT07MyGI/2rQwh9mgANE8qVn8r7LdDMjrpGwm
	AnaanyrFKK0z2w4/Yoi/A==
X-ME-Sender: <xms:fI2UadxdXWxOkJBqkCf3w_2xjNSc95X5l6befkBvbTGYGq9ya6YceA>
    <xme:fI2UaZLt5zDl_7wWXcGZeRnoWgoze8gE_tmakKEUWp14tpfP5GopDHfId27gpLCzX
    Xb-7PAwxLS2J8nGPfjZDSbXqGYYVhJ-224WBUiVnYsbpks79NTsTw>
X-ME-Received: <xmr:fI2UaS063dnAzv8VHGf0UxFZLuYO9TsPYnhFGbMQ31mNL3wUi2pxw_KaQml3ieMaA-nHEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpedtleelvdfgjedvffeiueekfeeuleffhfegfffhgfffkeevueehieehhfei
    gffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvshesrghnrghrrgiivghlrdguvgdpnhgspghrtghpthhtohepvddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
    dprhgtphhtthhopehrihhtvghshhdrlhhishhtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegujhifohhngh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    hprghnkhgrjhdrrhgrghhhrghvsehlihhnuhigrdguvghvpdhrtghpthhtohepohhjrghs
    fihinheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlshhfqdhptgeslhhish
    htshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:fI2UaTcdZYB-mpJIJd5jldcTdiY-2Twjhj8aAHGKT7qzEf-NoLUuiA>
    <xmx:fI2UaW6TbJ9w1l0L50LmdJioh38TY-CiCK6iJHnQdsCrnRppAzeIew>
    <xmx:fI2UaW8wc3tfyzNhknY6_3BJhGTQY-0VBQWWApz6h7_O9W-g0AbiLw>
    <xmx:fI2UadJ6rf-vJ4UZNx7yLVwQXr04L3BfQ7RjiQ30ZLTfPrBi0OhJFQ>
    <xmx:fo2UaSfK4T3HvYEQLinaS7lvlUdt-dAbbSUTo1wOW05RdrqEQEj_EDV5>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 10:47:07 -0500 (EST)
Date: Tue, 17 Feb 2026 10:47:07 -0500
From: Andres Freund <andres@anarazel.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, 
	Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, ritesh.list@gmail.com, jack@suse.cz, 
	ojaswin@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, 
	Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, 
	vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <ndwqem2mzymo6j3zw3mmxk2vh4mnun2fb2s5vrh4nthatlze3u@qjemcazy4agv>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <20260217055103.GA6174@lst.de>
 <CAOQ4uxgdWvJPAi6QMWQjWJ2TnjO=JP84WCgQ+ShM3GiikF=bSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgdWvJPAi6QMWQjWJ2TnjO=JP84WCgQ+ShM3GiikF=bSw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anarazel.de,none];
	R_DKIM_ALLOW(-0.20)[anarazel.de:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77371-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lst.de,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,gmail.com,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andres@anarazel.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[anarazel.de:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,anarazel.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63BE314DADD
X-Rspamd-Action: no action

Hi,

On 2026-02-17 10:23:36 +0100, Amir Goldstein wrote:
> On Tue, Feb 17, 2026 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > I think a better session would be how we can help postgres to move
> > off buffered I/O instead of adding more special cases for them.

FWIW, we are adding support for DIO (it's been added, but performance isn't
competitive for most workloads in the released versions yet, work to address
those issues is in progress).

But it's only really be viable for larger setups, not for e.g.:
- smaller, unattended setups
- uses of postgres as part of a larger application on one server with hard to
  predict memory usage of different components
- intentionally overcommitted shared hosting type scenarios

Even once a well configured postgres using DIO beats postgres not using DIO,
I'll bet that well over 50% of users won't be able to use DIO.


There are some kernel issues that make it harder than necessary to use DIO,
btw:

Most prominently: With DIO concurrently extending multiple files leads to
quite terrible fragmentation, at least with XFS. Forcing us to
over-aggressively use fallocate(), truncating later if it turns out we need
less space. The fallocate in turn triggers slowness in the write paths, as
writing to uninitialized extents is a metadata operation.  It'd be great if
the allocation behaviour with concurrent file extension could be improved and
if we could have a fallocate mode that forces extents to be initialized.

A secondary issue is that with the buffer pool sizes necessary for DIO use on
bigger systems, creating the anonymous memory mapping becomes painfully slow
if we use MAP_POPULATE - which we kinda need to do, as otherwise performance
is very inconsistent initially (often iomap -> gup -> handle_mm_fault ->
folio_zero_user uses the majority of the CPU). We've been experimenting with
not using MAP_POPULATE and using multiple threads to populate the mapping in
parallel, but that feels not like something that userspace ought to have to
do.  It's easier to work around for us that the uninitialized extent
conversion issue, but it still is something we IMO shouldn't have to do.


> Respectfully, I disagree that DIO is the only possible solution.
> Direct I/O is a legit solution for databases and so is buffered I/O
> each with their own caveats.

> Specifically, when two subsystems (kernel vfs and db) each require a huge
> amount of cache memory for best performance, setting them up to play nicely
> together to utilize system memory in an optimal way is a huge pain.

Yep.

Greetings,

Andres Freund

