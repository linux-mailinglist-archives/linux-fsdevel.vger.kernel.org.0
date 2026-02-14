Return-Path: <linux-fsdevel+bounces-77220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFgzISW2kGn5cQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 18:51:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78F13CA50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 18:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FF4F3029241
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD312D8DB8;
	Sat, 14 Feb 2026 17:51:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A7155C82;
	Sat, 14 Feb 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771091470; cv=none; b=Crvzgt9EgjbQHABDlEQ4KVPtAb7+cISsV15Gmn/Xcz2XqkLMNfOoYqCrNsPAT6siK2pXUcAO6Cy1uIYSBqQLGb3ihPiQsagUpBlzcSf52OOO9zzFPGlUK1wtVximVZaZYC4zJbfNIbhxlTg46QztYdJI39D3uWmFLleOKuX2f/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771091470; c=relaxed/simple;
	bh=y6EbmyGspHh4LzwRLlILnklBh1yh6Hp0wePXfgzXvx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVBGRkcVMedJk9ZeHJnAXB+v6A/ot7sZqBAW6oo6czWzUf/RnE+O4jpXDc7svEx2Ggip4Fqjl1Cgmggt//JIA9rNcMnywS5nzyuNPd7FOh284Hx5tSUPmttRjdtiU8o5shidLO8Ypydy0npNt9rzo8OsgRacR/UTbKm3GyeCItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (ip-176-198-081-007.um43.pools.vodafone-ip.de [176.198.81.7])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 3D33FE0323;
	Sat, 14 Feb 2026 18:50:56 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Sat, 14 Feb 2026 18:50:53 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aZC0WdZKA7ohRuHN@fedora>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
 <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
 <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77220-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.de:email]
X-Rspamd-Queue-Id: DE78F13CA50
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 05:35:30PM -0800, Joanne Koong wrote:
> On Thu, Feb 12, 2026 at 3:44 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> > On Thu, Feb 12, 2026 at 11:43:12AM +0100, Bernd Schubert wrote:
> > > On 2/12/26 11:16, Miklos Szeredi wrote:
> > > > On Thu, 12 Feb 2026 at 10:48, Bernd Schubert <bernd@bsbernd.com> wrote:
> > > >> On 2/12/26 10:07, Miklos Szeredi wrote:
> > > >>> On Wed, 11 Feb 2026 at 21:36, Bernd Schubert <bernd@bsbernd.com> wrote:
> > > >>>
> > > >
> > > >>> So as a first iteration can we just limit compounds to small in/out sizes?
> > > >>
> > > >> Even without write payload, there is still FUSE_NAME_MAX, that can be up
> > > >> to PATH_MAX -1. Let's say there is LOOKUP, CREATE/OPEN, GETATTR. Lookup
> > > >> could take >4K, CREATE/OPEN another 4K. Copying that pro-actively out of
> > > >> the buffer seems a bit overhead? Especially as libfuse needs to iterate
> > > >> over each compound first and figure out the exact size.
> > > >
> > > > Ah, huge filenames are a thing.  Probably not worth doing
> > > > LOOKUP+CREATE as a compound since it duplicates the filename.  We
> > > > already have LOOKUP_CREATE, which does both.  Am I missing something?
> > >
> > > I think you mean FUSE_CREATE? Which is create+getattr, but always
> > > preceded by FUSE_LOOKUP is always sent first? Horst is currently working
> > > on full atomic open based on compounds, i.e. a totally new patch set to
> > > the earlier versions. With that LOOKUP
> > >
> > > Yes, we could use the same file name for the entire compound, but then
> > > individual requests of the compound rely on an uber info. This info
> > > needs to be created, it needs to be handled on the other side as part of
> > > the individual parts. Please correct me if I'm wrong, but this sounds
> > > much more difficult than just adding an info how much space is needed to
> > > hold the result?
> >
> > I have a feeling we have different use cases in mind and misunderstand each other.
> >
> > As I see it:
> > From the discussion a while ago that actually started the whole thing I understand
> > that we have combinations of requests that we want to bunch together for a
> > specific semantic effect. (see OPEN+GETATTR that started it all)
> >
> > If that is true, then bunching together more commands to create 'compounds' that
> > semantically linked should not be a problem and we don't need any algorithm for
> > recosntructing the args. We know the semantics on both ends and craft the compounds
> > according to what is to be accomplished (the fuse server just provides the 'how')
> >
> > From the newer discussion I have a feeling that there is the idea floating around
> > that we should bunch together arbitrary requests to have some performance advantage.
> > This was not my initial intention.
> > We could do that however if we can fill the args and the requests are not
> > interdependent.
> 
> I have a series of (very unpolished) patches from last year that does
> basically this. When libfuse does a read on /dev/fuse, the kernel
> crams in as many requests off the fiq list as it can fit into the
> buffer. On the libfuse side, when it iterates through that buffer it
> offloads each request to a worker thread to process/execute that
> request. It worked the same way on the dev uring side. I put those
> changes aside to work on the zero copy stuff, but if there's interest
> I can go back to those patches and clean them up and put them through
> some testing. I don't think the work overlaps with your compound
> requests stuff though. The compound requests would be a request inside
> the larger batch.

I would like to have your patch for the processing of multiple requests
and the compound for handling semantically related requests.

> >
> > If we can signal to the fuse server what we expect as result
> > (at least the allocated memory) I think we can do both, but I would like to have the
> > emphasis more on the semantic grouping for the moment.
> >
> > Do you guys think that there will ever be a fuse server that doesn't support compounds
> > and all of them are handled by something like libfuse and the request handlers are just
> > called without having to handle not even one unseparatebale semantic 'group'?
> 
> If I'm understanding the question correctly, yes imo this is likely.
> But I think that's fine. In my opinion, the main benefit from this is
> saving on the context switching cost. I don't really see the problem
> if libfuse has to issue the requests separately and sequentially if
> the requests have dependency chains and  the server doesn't have a
> special handler for that specific compound request combo (which imo I
> don't think libfuse should even add, as I dont see what the purpose of
> it is that can't be done by sending each request to each separate
> handler sequentially).

Which part would process those interdependencies?
We have multiple options and I'm not entirely sure, 
the kernel, libfuse, fuse server?

In the current version none would do any special interpretation and the
fuse server will have a specialized handler for a compound type, which
automatically 'knows' how to get the right args.

> Thanks,
> Joanne
> 
> > >
> > > Thanks,
> > > Bernd

Thanks,
Horst

