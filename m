Return-Path: <linux-fsdevel+bounces-79329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOEBLST4p2l1nAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:15:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6401FD661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFE2A3013714
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A87394782;
	Wed,  4 Mar 2026 09:12:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B8389115;
	Wed,  4 Mar 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615528; cv=none; b=XVCXbG6y6wm5INSwd9LfazVL3oSjAtcyGvUzBh+CYEauRdB/mf1xXx4HocvzGatY1/T20mBhltzAl4A75QEEwjlFBeG3RDnTzEG74y9e5N6EDIZ0j/uq/o7kusJFo/yruaybsNT5fy7SchYnAH1sCK5qMtIEi8TbNC/zJpUWwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615528; c=relaxed/simple;
	bh=PeLbgETD8VZ36DV6hCrBG9NIe09gUvSX0ySCUczzQaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drCoU+285dSPbhwUBm7lBcHcDh52WnjnvgolilQ8MZWF84m+XNQBDlYyMHQ5oyX3Twqyenfxll75TVvkZ2CKxcNtwOGthcx1vtRcdM9dWOynXhNsDt3hwOlXpd8Wax/3Ds94NUdUV7muYhgmX/GNZt6LEM4Iwv9SvZzZCYz1LFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id A2BDCE0270;
	Wed,  4 Mar 2026 10:11:57 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 4 Mar 2026 10:11:56 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Horst Birthelmer <horst@birthelmer.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH v6 3/3] fuse: add an implementation of
 open+getattr
Message-ID: <aaf2evE-RU1Ro_TJ@fedora-3.fritz.box>
References: <aaFJEeeeDrdqSEX9@fedora.fritz.box>
 <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box>
 <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
 <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com>
 <20260303050614.GO13829@frogsfrogsfrogs>
 <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com>
 <aaa4oXWKKaaY2RJW@fedora.fritz.box>
 <CAJnrk1Z5uR+TpV-rNbfx4NNWQ=uY2BeS+wADvYN4vNtx7kmw+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z5uR+TpV-rNbfx4NNWQ=uY2BeS+wADvYN4vNtx7kmw+Q@mail.gmail.com>
X-Rspamd-Queue-Id: CF6401FD661
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79329-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.873];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,birthelmer.de:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:19:43PM -0800, Joanne Koong wrote:
> On Tue, Mar 3, 2026 at 2:39 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > On Tue, Mar 03, 2026 at 11:03:14AM +0100, Miklos Szeredi wrote:
> > > On Tue, 3 Mar 2026 at 06:06, Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Mon, Mar 02, 2026 at 09:03:26PM +0100, Bernd Schubert wrote:
> > > > >
> > > > > On 3/2/26 19:56, Joanne Koong wrote:
> > >
> > > > > > The overhead for the server to fetch the attributes may be nontrivial
> > > > > > (eg may require stat()). I really don't think we can assume the data
> > > > > > is locally cached somewhere. Why always compound the getattr to the
> > > > > > open instead of only compounding the getattr when the attributes are
> > > > > > actually invalid?
> > > > > >
> > > > > > But maybe I'm wrong here and this is the preferable way of doing it.
> > > > > > Miklos, could you provide your input on this?
> > >
> > > Yes, it makes sense to refresh attributes only when necessary.
> > >
> >
> > OK, I will add a 'compound flag' for optional operations and don't
> > execute those, when the fuse server does not support compounds.
> >
> > This way we can always send the open+getattr, but if the fuse server
> > does not process this as a compound (aka. it would be costly to do it),
> > we only resend the FUSE_OPEN. Thus the current behavior does not change
> > and we can profit from fuse servers that actually have the possibility to
> > give us the attributes.
> 
> in my opinion, this adds additional complexity for no real benefit.  I
> think we'll rarely hit a case where it'll be useful to speculatively
> prefetch attributes that are already valid that is not already
> accounted for by the attr_timeout the server set.
> 

So the current consensus would be to use the compound when we 
either don't have the data, or it has become invalid, 
and use the current behavior  
(just do an open and don't worry about the stale attributes) 
when we have unexpired attributes?

Thanks,
Horst

