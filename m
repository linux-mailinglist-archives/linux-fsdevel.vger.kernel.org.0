Return-Path: <linux-fsdevel+bounces-48881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63014AB530D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E5A167412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CD2417E6;
	Tue, 13 May 2025 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g0SavODX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UOOyyqUY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g0SavODX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UOOyyqUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C629239E69
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133043; cv=none; b=oTB8G9Y0309oMXWcWFPlyL7V2bVq2n+yQmsZwruOLH9TCO5bVtaWY0y/kM4ckIPBBPX9NoppPQU3isZIKu4gCI5DzzlxYYrmoEVKYt7tOCsdSZUL306kCWgx6rtU8RntmQ7lTYuYCb8p4/Fc1cSxSJhP8sAXXIFMd3sQUBawGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133043; c=relaxed/simple;
	bh=JOMeqyEoDj4vkesUvdnVnpqlFYDHJBvDc1WYqwSSUOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsCEjUKdeMHXKHGdSCxu82n7qvld+hMM0wPOYy51Etnbr9R5VKrWaoqMS8oJaJuRPvhrfLWLDUcXEc14JEUw4g8tBqTFcikhD9woKWms+qXvOIlNOvmIJzTu3Q0hzhmsYhLrsWPc8tQ21iJHlxdddbvcfjDLbaa7cKDA3Oqdyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g0SavODX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UOOyyqUY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g0SavODX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UOOyyqUY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04F1A211A7;
	Tue, 13 May 2025 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747133040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqRhh12uOMrMoumVgK2eTFLenrim4mZSK8O3H6qWdK0=;
	b=g0SavODXjGqhOM+54LKGeEX+N06siCnd4d/LYlfGVwgYBCp+mUBpkKwFLrjN0jeBZcnjbk
	LLaEkqZTsVfbdbFzhqUXmnpELZBifkFb4cMOicXpnva1X53M8/WofvnV5p1DMKIz04xNCZ
	yYZ5kOdpODl+rcm/EUnlLAVw50XaOzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747133040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqRhh12uOMrMoumVgK2eTFLenrim4mZSK8O3H6qWdK0=;
	b=UOOyyqUYcB0ETv5/lI/kHyjlthOL60FvbOeuYcyRiDZB9sGaLjc5uUA2WCKkkn835Ms+g3
	HwAnvXY+2WXrKSAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g0SavODX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UOOyyqUY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747133040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqRhh12uOMrMoumVgK2eTFLenrim4mZSK8O3H6qWdK0=;
	b=g0SavODXjGqhOM+54LKGeEX+N06siCnd4d/LYlfGVwgYBCp+mUBpkKwFLrjN0jeBZcnjbk
	LLaEkqZTsVfbdbFzhqUXmnpELZBifkFb4cMOicXpnva1X53M8/WofvnV5p1DMKIz04xNCZ
	yYZ5kOdpODl+rcm/EUnlLAVw50XaOzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747133040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqRhh12uOMrMoumVgK2eTFLenrim4mZSK8O3H6qWdK0=;
	b=UOOyyqUYcB0ETv5/lI/kHyjlthOL60FvbOeuYcyRiDZB9sGaLjc5uUA2WCKkkn835Ms+g3
	HwAnvXY+2WXrKSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB18A137E8;
	Tue, 13 May 2025 10:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ICtiOW8iI2jPIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 13 May 2025 10:43:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 34C6DA0AFB; Tue, 13 May 2025 12:43:51 +0200 (CEST)
Date: Tue, 13 May 2025 12:43:51 +0200
From: Jan Kara <jack@suse.cz>
To: Nick Chan <towinchenmi@gmail.com>
Cc: 
	Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>, Yangtao Li <frank.li@vivo.com>, ethan@ethancedwards.com, 
	asahi@lists.linux.dev, brauner@kernel.org, dan.carpenter@linaro.org, 
	ernesto@corellium.com, gargaditya08@live.com, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	sven@svenpeter.dev, tytso@mit.edu, viro@zeniv.linux.org.uk, willy@infradead.org, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
Message-ID: <itb4w3r7ypoitotmazkdkkz6tg4xewr26ffupm563aiwogarmc@prntwvbjksyb>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com>
 <20250512234024.GA19326@eaf>
 <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 04F1A211A7
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[gmail.com,vivo.com,ethancedwards.com,lists.linux.dev,kernel.org,linaro.org,corellium.com,live.com,linuxfoundation.org,suse.cz,vger.kernel.org,svenpeter.dev,mit.edu,zeniv.linux.org.uk,infradead.org,dubeyko.com,physik.fu-berlin.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action

On Tue 13-05-25 12:13:23, Nick Chan wrote:
> 
> Ernesto A. Fernández 於 2025/5/13 清晨7:40 寫道:
> > Hi Yangtao,
> >
> > On Mon, May 12, 2025 at 04:11:22AM -0600, Yangtao Li wrote:
> >> I'm interested in bringing apfs upstream to the community, and perhaps
> >> slava and adrian too.
> > Do you have any particular use case in mind here? I don't mind putting in
> > the work to get the driver upstream, but I don't want to be fighting people
> > to convince them that it's needed. I'm not even sure about it myself.
> 
> These are the use cases I can think of:
> 
> 
> 1. When running Linux on Apple Silicon Mac, accessing the xART APFS
> volume is required for enabling some SEP functionalities.
> 
> 2. When running Linux on iPhone, iPad, iPod touch, Apple TV (currently
> there are Apple A7-A11 SoC support in upstream), resizing the main APFS
> volume is not feasible especially on A11 due to shenanigans with the
> encrypted data volume. So the safe ish way to store a file system on the
> disk becomes a using linux-apfs-rw on a (possibly fixed size) volume that
> only has one file and that file is used as a loopback device.
> 
> (do note that the main storage do not currently work upstream and I only have storage working on A11 downstream)
> 
> 3. Obviously, accessing Mac files from Linux too, not sure how big of a use case that is but apparently it is
> big enough for hfsplus to continue receive patches here and there.

I can see that accessing APFS filesystem is useful at times. But the
question is: why do we need it in the kernel? Why isn't a FUSE driver
enough? Because for relatively niche usecase like this that is a much more
acceptable (and easier to maintain) choice.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

