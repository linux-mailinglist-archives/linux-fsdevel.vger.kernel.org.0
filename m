Return-Path: <linux-fsdevel+bounces-77994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOjqKvOinGnqJgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:56:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2527117BE51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18A0730364FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438F736997C;
	Mon, 23 Feb 2026 18:55:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97E1EFF8D;
	Mon, 23 Feb 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872959; cv=none; b=Wcdpu6ORZUH0l1nJz/80bmc7ZZP0YEo3rkgbVseMLCyRfMMf8prhy/Ql9/lUYy/ji96yegeSTlC/zYNT/C7l2Fg92jiacVNe4EDDeGk9Alcy4b6vMbzh97AMfI4lQsNmjvCiEJxVt+NoxRXRghTclo8X1VlMwH5G57uK5N3NVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872959; c=relaxed/simple;
	bh=vtJZ4PadBHebTQEBEXNF+Yo455CaPLKjlfD1awC25MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu3Fo4QbqAFORq2BARM6rh3Ksl9UtdFrvoLQvhPzULW5Hl9I1RZXl0yNBElfJutz2/hE2KR6cFduv5GU2sUQ9EamCR+ytcwa8ACU7i0lrW06Y+qufkuXwE+yj3L7WjBcR0Sin1WPR1LTtXj9JFhDqKlAucn1svmFuDtBbKRgXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id 61063E04F7;
	Mon, 23 Feb 2026 19:55:48 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Mon, 23 Feb 2026 19:55:47 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Jim Harris <jim.harris@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mgurtovoy@nvidia.com, 
	ksztyber@nvidia.com, Luis Henriques <luis@igalia.com>
Subject: Re: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT
 is set
Message-ID: <aZyhkJSO7Ae7y1Pv@fedora.fritz.box>
References: <20260220204102.21317-1-jiharris@nvidia.com>
 <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
 <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
 <fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com>
 <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77994-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fedora.fritz.box:mid]
X-Rspamd-Queue-Id: 2527117BE51
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:53:33PM +0100, Miklos Szeredi wrote:
> On Mon, 23 Feb 2026 at 16:37, Bernd Schubert <bernd@bsbernd.com> wrote:
> 
> > After the discussion about LOOKUO_HANDLE my impression was actually that
> > we want to use compounds for the atomic open.
> 
> I think we want to introduce an atomic operation that does a lookup +
> an optional mknod, lets call this LOOKUP_CREATE_FH, this would return
> a flag indicating whether the file was created or if it existed prior
> to the operation.
> 
> Then, instead of the current CREATE operation there would be a
> compound with LOOKUP_CREATE_FH + OPEN.
> 
> Does that make sense?

What is wrong with a compound doing LOOKUP + MKNOD + OPEN?
If the fuse server knows how to process that 'group' atomically
in one big step it will do the right thing, 
if not, we will call those in series and sort out the data 
in kernel afterwards.

If we preserve all flags and the real results we can do pretty
much exactly the same thing that is done at the moment with just
one call to user space.

That was actually what I was experimenting with.

The MKNOD in the middle is optional depending on the O_CREAT flag.

> 
> Thanks,
> Miklos

Cheers,
Horst

