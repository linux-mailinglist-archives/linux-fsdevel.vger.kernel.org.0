Return-Path: <linux-fsdevel+bounces-76424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNUdFn+LhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:22:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7D8F25EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 708483030EE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD96A3D34A4;
	Thu,  5 Feb 2026 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qFn1R5IY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqiIM4Y8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qFn1R5IY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqiIM4Y8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A393D3490
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294093; cv=none; b=YXJwMkTS+MaP6Mnw5kW9XX8MXkUt/lCIBFMrs+Xfl07THGpAzrSEOqjHpEJdUtOuFl+fXbyvlELeVOvThmJ/LQRitp5QrvMxCcazIGDTw1S78taRtqymB3pDzn9ZnhWyGzPgYpEZ/VZar5YaRkrHvGar8T1W258usj4mCvQzabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294093; c=relaxed/simple;
	bh=qNW2890p8UbP5TyLdPSapSQG9zMim8uZEJvK8SqLrEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmnwZzM1N1oq0m108Nv1UqO3v+II1mY1k0f9yYs2FhjzIH1ghvo/fVYdujaX0NDTRfgcCjB3hyocATZqAzu4/FE8zQshHwUXhEsslGk2ZiGAo/ut4r6ySVmnzJx0tFvsDD5RaetbfXIFoT8i8F71wFO7jESGY3rI9tzPM53GMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qFn1R5IY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqiIM4Y8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qFn1R5IY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqiIM4Y8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 568945BDA2;
	Thu,  5 Feb 2026 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770294091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IW64qyTb9m2ml2RSRkBPjQexYWMmZ5YenryH5wNBEIY=;
	b=qFn1R5IYx0CbcwUAzz7livNr+vbnPFnXOQeWjyqu5le97rM2DLn9KH4yZHuEmR42T0Ly3i
	ExRHBd+cl9D+MV5w3i4mKVFbLxOsFC8eyYYjYO6H2OOHooZe7vRxKLQTlMyEA2AVvOuPxJ
	r++cn638KXsGF47FlhJ/AThN6SauRtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770294091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IW64qyTb9m2ml2RSRkBPjQexYWMmZ5YenryH5wNBEIY=;
	b=rqiIM4Y8Ad/63qSKP0Vh+hN/9wZdjVmDtiGpQcUeU+qU/k53AxfntorXu8Q9G1/CtHNA+r
	10PKG77XauGYzLCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qFn1R5IY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rqiIM4Y8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770294091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IW64qyTb9m2ml2RSRkBPjQexYWMmZ5YenryH5wNBEIY=;
	b=qFn1R5IYx0CbcwUAzz7livNr+vbnPFnXOQeWjyqu5le97rM2DLn9KH4yZHuEmR42T0Ly3i
	ExRHBd+cl9D+MV5w3i4mKVFbLxOsFC8eyYYjYO6H2OOHooZe7vRxKLQTlMyEA2AVvOuPxJ
	r++cn638KXsGF47FlhJ/AThN6SauRtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770294091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IW64qyTb9m2ml2RSRkBPjQexYWMmZ5YenryH5wNBEIY=;
	b=rqiIM4Y8Ad/63qSKP0Vh+hN/9wZdjVmDtiGpQcUeU+qU/k53AxfntorXu8Q9G1/CtHNA+r
	10PKG77XauGYzLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 415AC3EA63;
	Thu,  5 Feb 2026 12:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iILvD0uLhGnfOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 12:21:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 013AEA09D8; Thu,  5 Feb 2026 13:21:26 +0100 (CET)
Date: Thu, 5 Feb 2026 13:21:26 +0100
From: Jan Kara <jack@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, repnop@google.com, 
	shuah@kernel.org
Subject: Re: [RFC PATCH] selftests: fanotify: Add basic create/modify/delete
 event
Message-ID: <kn2il642ie7z3obmojppjd7kdyswuqrkpsabozeyvm62va64ak@6ss43nmzmjl6>
References: <dnncglg3x26gdsshcniw5yb4l2zlxz6qcwjqyekkpngb6v26q4@ftqnoe5eeapy>
 <20260205100437.1834-1-always.starving0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205100437.1834-1-always.starving0@gmail.com>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76424-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0F7D8F25EB
X-Rspamd-Action: no action

Hello!

On Thu 05-02-26 19:04:34, Jinseok Kim wrote:
> Thanks for the feedback!
> 
> I agree LTP has very comprehensive fanotify/inotify tests.
> 
> However, the motivation for adding basic tests to kernel selftests is:
>     - Quick and lightweight regression checking during kernel
>     development/boot (no external LTP install needed)
>     - Non-root basic cases (many LTP tests require root or complex setup)

Hum, I don't quite buy the "LTP is difficult to run" argument. I find it as
hard as running kernel selftests to be honest :). I don't even bother
installing LTP and just directly run testcases from LTP source tree. The
"LTP tests require root" is a valid argument but not really problematic for
the setup I use.

The point I'm trying to make is: I'm not strictly opposed to fanotify
kernel selftests but they do add some maintenance burden and I don't see the
usefulness of this. So maybe can you start with explaining your usecase -
how are these tests going to make your life easier?

> Do you think a different approach (LTP improvement instead)
> would be better?

As Amir wrote we definitely don't plan on moving all tests from LTP to
selftests so if you are missing some functionality from tests in LTP, it
would be good to add it there...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

