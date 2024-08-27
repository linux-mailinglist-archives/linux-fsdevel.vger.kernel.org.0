Return-Path: <linux-fsdevel+bounces-27477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF03E961ABA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E18284E6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9A1D47AD;
	Tue, 27 Aug 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SBAT3tAe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5AgJLDqf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SBAT3tAe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5AgJLDqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC019EEBB;
	Tue, 27 Aug 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802075; cv=none; b=i088kYQD2pdAPBwgMJ0KmbCTN88xlDBlvY/NZrOqByivbY3inQoA8JfYVkrJG7/RepgG/ssXOeQxVm/ZDb9Mh/LTUFeqTvxdL0v9cV370KTydyC6iRs0bmtoq9aTjvvRb6jjDPFdiS8+59923YtCpuYqfptSaqHkuqR+hYicCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802075; c=relaxed/simple;
	bh=LYdJv23YyA0CZ22xRz/04LCVm+2iaiZliB2Hi+43aSw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DtFnPnvCB8LvF8BBmQ1junhiKiibNXSb2TuzAnCjjETzABgg6xE2+c0d3xbhY6SHAtXLASsY4L5sv0wshjYFq2hKlpIZXKevJEK/QWVro8p0EvF30lQFLQ1XOdA+lkSsU3yP2gRq35as4aPDLEBkz5gZN0SIhTTR4C93ZvHHQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SBAT3tAe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5AgJLDqf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SBAT3tAe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5AgJLDqf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D9DF21A95;
	Tue, 27 Aug 2024 23:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724802071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeCtlCGJTU+AITpIO4mVFzyCmwUAFHhxGTbK9lG6m98=;
	b=SBAT3tAeMk+WKtm/vWhhJc81Rzk7Lj0GZaUAsxdoBQ4cMFVZrQshGifnH9VzFWpDOLaesQ
	FcaPWpQ5kgvUT5N9M8gRMz5Udh72EMaN8T+J+wrMgFBxVyMPDg7UckmRTo8+7ccfELCUrp
	yZIzmoFB37exXIsx3kAvh8jtzirVWwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724802071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeCtlCGJTU+AITpIO4mVFzyCmwUAFHhxGTbK9lG6m98=;
	b=5AgJLDqfzyNJz2C+YpOKC6JSeNHJD9wIE1nIpjdd3bT5dYSmhagzEdEwuMtMDo3+Vdiozw
	i70ur8axmdofuIAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SBAT3tAe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5AgJLDqf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724802071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeCtlCGJTU+AITpIO4mVFzyCmwUAFHhxGTbK9lG6m98=;
	b=SBAT3tAeMk+WKtm/vWhhJc81Rzk7Lj0GZaUAsxdoBQ4cMFVZrQshGifnH9VzFWpDOLaesQ
	FcaPWpQ5kgvUT5N9M8gRMz5Udh72EMaN8T+J+wrMgFBxVyMPDg7UckmRTo8+7ccfELCUrp
	yZIzmoFB37exXIsx3kAvh8jtzirVWwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724802071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeCtlCGJTU+AITpIO4mVFzyCmwUAFHhxGTbK9lG6m98=;
	b=5AgJLDqfzyNJz2C+YpOKC6JSeNHJD9wIE1nIpjdd3bT5dYSmhagzEdEwuMtMDo3+Vdiozw
	i70ur8axmdofuIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CEF613724;
	Tue, 27 Aug 2024 23:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R9efNBRkzmbkNgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Aug 2024 23:41:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
In-reply-to: <aec659a886f7da3beded2b0ecce452e1599f9adc.camel@hammerspace.com>
References:
 <>, <aec659a886f7da3beded2b0ecce452e1599f9adc.camel@hammerspace.com>
Date: Wed, 28 Aug 2024 09:41:05 +1000
Message-id: <172480206591.4433.15677232468943767302@noble.neil.brown.name>
X-Rspamd-Queue-Id: 8D9DF21A95
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 28 Aug 2024, Trond Myklebust wrote:
> On Wed, 2024-08-28 at 07:49 +1000, NeilBrown wrote:
> > On Tue, 27 Aug 2024, Trond Myklebust wrote:
> > > > 
> > > > 
> > > > > On Aug 25, 2024, at 9:56 PM, NeilBrown <neilb@suse.de> wrote:
> > > > > 
> > > > > While I'm not advocating for an over-the-wire request to map a
> > > > > filehandle to a struct nfsd_file*, I don't think you can
> > > > > convincingly
> > > > > argue against it without concrete performance measurements.
> > > > 
> > > 
> > > What is the value of doing an open over the wire? What are you
> > > trying
> > > to accomplish that can't be accomplished without going over the
> > > wire?
> > 
> > The advantage of going over the wire is avoiding code duplication.
> > The cost is latency.  Obviously the goal of LOCALIO is to find those
> > points where the latency saving justifies the code duplication.
> > 
> > When opening with AUTH_UNIX the code duplication to determine the
> > correct credential is small and easy to review.  If we ever wanted to
> > support KRB5 or TLS I would be a lot less comfortable about reviewing
> > the code duplication.
> > 
> > So I think it is worth considering whether an over-the-wire open is
> > really all that costly.  As I noted we already have an over-the-wire
> > request at open time.  We could conceivably send the LOCALIO-OPEN
> > request at the same time so as not to add latency.  We could receive
> > the
> > reply through the in-kernel backchannel so there is no RPC reply.
> > 
> > That might all be too complex and might not be justified.  My point
> > is
> > that I think the trade-offs are subtle and I think the FAQ answer
> > cuts
> > off an avenue that hasn't really been explored.
> > 
> 
> So, your argument is that if there was a hypothetical situation where
> we wanted to add krb5 or TLS support, then we'd have more code to
> review?
> 
> The counter-argument would be that we've already established the right
> of the client to do I/O to the file. This will already have been done
> by an over-the-wire call to OPEN (NFSv4), ACCESS (NFSv3/NFSv4) or
> CREATE (NFSv3). Those calls will have used krb5 and/or TLS to
> authenticate the user. All that remains to be done is perform the I/O
> that was authorised by those calls.

The other thing that remains is to get the correct 'struct cred *' to
store in ->f_cred (or to use for lookup in the nfsd filecache).

> 
> Furthermore, we'd already have established that the client and the
> knfsd instance are running in the same kernel space on the same
> hardware (whether real or virtualised). There is no chance for a bad
> actor to compromise the one without also compromising the other.
> However, let's assume that somehow is possible: How does throwing in an
> on-the-wire protocol that is initiated by the one and interpreted by
> the other going to help, given that both have access to the exact same
> RPCSEC_GSS/TLS session and shared secret information via shared kernel
> memory?
> 
> So again, what problem are you trying to fix?

Conversely:  what exactly is this FAQ entry trying to argue against?

My current immediate goal is for the FAQ to be useful.  It mostly is,
but this one question/answer isn't clear to me.

Thanks,
NeilBrown

