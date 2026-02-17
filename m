Return-Path: <linux-fsdevel+bounces-77341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG3PM7IYlGnO/wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:28:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDDD149326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C7AF3019FCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374A62D23A6;
	Tue, 17 Feb 2026 07:28:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49292C2346;
	Tue, 17 Feb 2026 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313321; cv=none; b=gZV4ty3grZ1I7Xi8cC7eyN+pSO2C3YSjMUMGli4aWrRElkYHxu7w9dlOphWkKs/VWjBvFGu6VEQwpXO+mNtZf5EjKMRbcSVSwyMmJy2b3I6OF4Bi7kAMQIM2a9Kmg9NyRNf1hgvdm/1nGClIZUYiVVzRACBVtt41Xp9r60D/vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313321; c=relaxed/simple;
	bh=Atld1AlYathvjB3Io2RjCiQD8G7h5Y49WATacHLj7c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxWQTjYELrWzHSvqop/+mV9qiAfZ3/Km+yC4aXRccdOKqCXgDxdSjhx4DNzJsCqaXHOTW579iyQGgu3lqOzqu2Otd43X9yZMElnNv1ONPmBd54H7ulxRtfo3Y8HJEJiaq11ZEDWt141y6cwrdSfIe5f0PT8IBr6A/RVIhsfauC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id 34EEEE06B6;
	Tue, 17 Feb 2026 08:28:32 +0100 (CET)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 17 Feb 2026 08:28:31 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aZQYWepNXWtozUDU@fedora.fritz.box>
References: <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
 <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
 <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
 <aZC0WdZKA7ohRuHN@fedora>
 <CAJfpegtWNjkxchD0A+k1YQt=1_B4akrU3pNeONRHunEY=LffZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtWNjkxchD0A+k1YQt=1_B4akrU3pNeONRHunEY=LffZg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77341-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EDDD149326
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:43:18PM +0100, Miklos Szeredi wrote:
> On Sat, 14 Feb 2026 at 18:51, Horst Birthelmer <horst@birthelmer.de> wrote:
> 
> > Which part would process those interdependencies?
> > We have multiple options and I'm not entirely sure,
> > the kernel, libfuse, fuse server?
> 
> Kernel: mandatory
> Libfuse: new versions should handle it, but older versions continue to
> work (because the kernel will deal with it)
> Fuse server: optional
> 
> > In the current version none would do any special interpretation and the
> > fuse server will have a specialized handler for a compound type, which
> > automatically 'knows' how to get the right args.
> 
> The API should allow the server to deal with generic compounds, not
> just combinations it actually knows about.
> 
> What we need to define is the types of dependencies, e.g.:
> 
> - default: wait for previous and stop on error
> - copy nodeid in fuse_entry_out from the previous lookup/mk*
> - copy fh in fuse_open_out from previous open

I understand.
Will come up with a new version and we'll see how it works out.

> 
> Thanks,
> Miklos
> 

Thanks for taking the time,
Horst

