Return-Path: <linux-fsdevel+bounces-77307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDQRFcI+k2kg2wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:58:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7655145D9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E2B030305D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405A3321A3;
	Mon, 16 Feb 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="jNP6/UIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BdzMv320"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4E19CC28;
	Mon, 16 Feb 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257468; cv=none; b=I306mGmocOdlVvOwSWQjGem1YPHpLeXyK/4tn61dcbWY1xyvtkJXa8/90P5oYe+uvmmp3caL7agZwdnrgUCClm4o2p+I0G+43CVgMiZ0EzHnocxf55d+mDc9sJ1Ccs9zpk+euRlcIfpbGNTsYwkk3NYsB0RcrvBfDNEt3acHYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257468; c=relaxed/simple;
	bh=87pzktPufHzCthSnDht78xrj6MKlwJefHV1B6sHG0Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx973L8Avpf4HHXJnXE5R+L8iHwFOpGwVrkP6e1Kiryvevc2E1IDQsj4qQpvB81JoEeYZGIZZdHgEmcrE8H3RpJCr71x5woQflNbsNBOjTG4SaT2Q2ZQMgFqI3q84EBmaqlnp/sFtnr/a3RuSqmqHLZlDMyWieyUvgsZBPimkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=jNP6/UIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BdzMv320; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7253A7A017A;
	Mon, 16 Feb 2026 10:57:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 16 Feb 2026 10:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771257466; x=1771343866; bh=8ny6L3zkCf
	X0j47xfHrpkoxrxspJzdvPThy0B9HOMh4=; b=jNP6/UIn5h67c4pHOIJt6WcBFQ
	3Ez9eAHvBKjWUSGOP4z1rJU0bZDj72VpXbJqJ19zf6F/UO0VdFXizuY4co3ti2T9
	CsDdHZr8YznwA16hnBSinl23TMH9oth63/L6WVm4PO1OiUzxakZ3Zb6ROdyb9yM7
	4o1eD8VZ5vXcZEQDCUWD6TfPu0s0hDVlGOqQNUGy2KXipcxLg+01VwCbRRyAW2lm
	lKlz41EngtphONWUuwGvlEj7Nset88WpvMccOofU9A06fy6roLH9czpXEHQYUhsW
	ziKTnS9Z4Ifp8a2oT6BO2cscSBwXXhX6WzMfUE/+EEnKibNzNZruRgWAmebw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771257466; x=1771343866; bh=8ny6L3zkCfX0j47xfHrpkoxrxspJzdvPThy
	0B9HOMh4=; b=BdzMv320tFvUAITz5K7ZBbhslwF0II4hV0vFg0VgmUMLJrWN+a3
	rC32xlNR88mYbvbOuelZmvsDlY42gj3KWMsSFSupy9iyiPvAzk+qEO6ma5kYQA+Z
	gh+sC8QShDOhwn9kIMU29pnNE4TFZJlBezaImBVzhEXHmIULUlj5Hp565a0kcgDo
	yrU/ZPgr/rgMwcotIMPOOsDhbs3OT6WYqN6KUqbAmSkjwhg2FiFFvbPIlImv8VPI
	Ezi7dkiVb2sizvwRUTTRueZgZ/sdTHU6NOCxTeq/j0vpLZfubh3NJJMYGvYM0Gm9
	axnEf2iw38s0sbV/vKASyWq+2Ja4ZrP+C6w==
X-ME-Sender: <xms:eT6TaYhy7ZiIUMNV9o5zAxxBmLsgQ-F0vPzNVDppUIY-4mPVavQg0A>
    <xme:eT6TaX9RQwxh4SJ0Z-Qh42ytjdQ5z27PsbfnK7H5uNwbGqR-bMc3_EiJRQ6FNJzs0
    wigUHEjKXN69XL2mOVzIMZeT9A9G8eoDM5w7xYX1hqP7z2I8IRbCQ>
X-ME-Received: <xmr:eT6TaVIf5ahnHo_4mr99E4_Qc3ozO5CRvGpwHgIp8cscheAJayHWW9Jukn5rm39hE2-qbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepheeiudduuedvleetjedujeffgeeiueevgeehjedtgeehueekledthfelhefh
    geelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdgu
    vgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrihhtvghshhdrlhhishhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhies
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehprghnkhgrjhdrrh
    grghhhrghvsehlihhnuhigrdguvghvpdhrtghpthhtohepohhjrghsfihinheslhhinhhu
    gidrihgsmhdrtghomhdprhgtphhtthhopehlshhfqdhptgeslhhishhtshdrlhhinhhugi
    dqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggv
X-ME-Proxy: <xmx:eT6TaQY6AOTmuO-eiDc2jyfM8Qa83v5y5WghAv_duMKrl_625G_eow>
    <xmx:eT6TaQgNIRQ4QYpWgiLXRkrs7g6kWwRJytm6vJeR7oZUbk3d1nRzbA>
    <xmx:eT6Tad6T-bM66v1fbCzXuMHeZUNnv_OpR1gFDTASS_eYK6jsRj3i2w>
    <xmx:eT6TaQqyEeQ8IlZfnoHLXgIKu_lJdfCKwvXF6vyd9E2tiSn7YtxT1g>
    <xmx:ej6Taf5s9cJOCvzk2wAxZZHwlzUlaswk1VbSZywx80cTTUpeVNnqhVE3>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 10:57:45 -0500 (EST)
Date: Mon, 16 Feb 2026 10:57:44 -0500
From: Andres Freund <andres@anarazel.de>
To: Jan Kara <jack@suse.cz>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de, ritesh.list@gmail.com, 
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, 
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <fh3hxyhoezqzcsabqjr2glft2uvrx5bkyx6pejek3uskpm5ow4@zym4kmg5o2bm>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anarazel.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anarazel.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77307-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andres@anarazel.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[anarazel.de:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anarazel.de:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: C7655145D9E
X-Rspamd-Action: no action

Hi,

On 2026-02-16 12:38:59 +0100, Jan Kara wrote:
> On Fri 13-02-26 19:02:39, Ojaswin Mujoo wrote:
> > Another thing that came up is to consider using write through semantics
> > for buffered atomic writes, where we are able to transition page to
> > writeback state immediately after the write and avoid any other users to
> > modify the data till writeback completes. This might affect performance
> > since we won't be able to batch similar atomic IOs but maybe
> > applications like postgres would not mind this too much. If we go with
> > this approach, we will be able to avoid worrying too much about other
> > users changing atomic data underneath us.
> >
> > An argument against this however is that it is user's responsibility to
> > not do non atomic IO over an atomic range and this shall be considered a
> > userspace usage error. This is similar to how there are ways users can
> > tear a dio if they perform overlapping writes. [1].
>
> Yes, I was wondering whether the write-through semantics would make sense
> as well.

As outlined in
https://lore.kernel.org/all/zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s/
that is something that would be useful for postgres even orthogonally to
atomic writes.

If this were the path to go with, I'd suggest adding an RWF_WRITETHROUGH and
requiring it to be set when using RWF_ATOMIC on an buffered write. That way,
if the kernel were to eventually support buffered atomic writes without
immediate writeback, the semantics to userspace wouldn't suddenly change.


> Intuitively it should make things simpler because you could
> practially reuse the atomic DIO write path. Only that you'd first copy
> data into the page cache and issue dio write from those folios. No need for
> special tracking of which folios actually belong together in atomic write,
> no need for cluttering standard folio writeback path, in case atomic write
> cannot happen (e.g. because you cannot allocate appropriately aligned
> blocks) you get the error back rightaway, ...
>
> Of course this all depends on whether such semantics would be actually
> useful for users such as PostgreSQL.

I think it would be useful for many workloads.

As noted in the linked message, there are some workloads where I am not sure
how the gains/costs would balance out (with a small PG buffer pool in a write
heavy workload, we'd loose the ability to have the kernel avoid redundant
writes). It's possible that we could develop some heuristics to fall back to
doing our own torn-page avoidance in such cases, although it's not immediately
obvious to me what that heuristic would be.  It's also not that common a
workload, it's *much* more common to have a read heavy workload that has to
overflow in the kernel page cache, due to not being able to dedicate
sufficient memory to postgres.

Greetings,

Andres Freund

