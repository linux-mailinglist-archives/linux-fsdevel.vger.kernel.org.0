Return-Path: <linux-fsdevel+bounces-77340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFbRNxsYlGm4/wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:26:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53314930D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD6523018768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 07:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AFB2D23A6;
	Tue, 17 Feb 2026 07:26:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D512D0C7B;
	Tue, 17 Feb 2026 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313173; cv=none; b=O0exMIqooAW+JQWS/K5Yrb9xxTzZwjpw/loS5OtC06YucoREgS0KRmERb+OnyQtfl8dxy/qkgDvRLZPSjq3SJyx3Bm8Neqfz0BN6pmhFhz3kM1XByvuzj/DHkv3T+SzIwlR7xytJf4FTjXiHYmfnspkF0MKNl0dE2n/xT6kiZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313173; c=relaxed/simple;
	bh=YECGY6qz6BTUj4LMbm/Bc/JxzeLCd/SUG8MblRqkiPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwgy11NkB4LdfBf2/aSyda6LpVnV4Ri6zYKonuuj6wURr8tnrbDtgPubQ71O/EhfMi28JbyLfkcZxTlSwTuF/nYXITZGh9yb8ljZIAyytvh+xcxFF47TyY3xX9vSakQHKUJ0oVBrEi9cmpAGKt0OWFKRBdxsxQIBEvuqa1ZPgsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id AD5A5E0557;
	Tue, 17 Feb 2026 08:26:02 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 17 Feb 2026 08:26:02 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aZQXcVNAlpyy4LH1@fedora.fritz.box>
References: <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
 <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
 <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
 <aZC0WdZKA7ohRuHN@fedora>
 <CAJfpegtWNjkxchD0A+k1YQt=1_B4akrU3pNeONRHunEY=LffZg@mail.gmail.com>
 <CAJfpeguOWLd-WvYMU3oTYPTq_3ZXfdUEX6eD0+M6FNZYc-qw1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguOWLd-WvYMU3oTYPTq_3ZXfdUEX6eD0+M6FNZYc-qw1Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77340-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,bsbernd.com,birthelmer.com,ddn.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:email]
X-Rspamd-Queue-Id: 5C53314930D
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 04:22:13PM +0100, Miklos Szeredi wrote:
> On Mon, 16 Feb 2026 at 12:43, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Sat, 14 Feb 2026 at 18:51, Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > > Which part would process those interdependencies?
> 
> Another interesting question is which entity is responsible for
> undoing a partial success?
> 
> E.g. if in a compound mknod succeeds while statx fails, then the
> creation needs to be undone.   Since this sort of partial failure
> should be rare, my feeling is that this should be done by the kernel
> to avoid adding complexity to all layers.
> 
> This could be a problem in a distributed fs, where the ephemeral
> object might cause side effects.  So in these cases the server needs
> to deal with partial failures for maximum correctness.

I completely agree, that the kernel has to handle this.
And I think that the implementation of the particular compound
(like the function fuse_open_and_getattr() in the current example
has to deal with this)
These are the cases where we cannot have an automatic decoding deal
with the error since we don't have the information and data of the 
actual semantics.

> 
> Thanks,
> Miklos
> 

