Return-Path: <linux-fsdevel+bounces-21559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806C905B12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 20:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06EE1F244CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F88002E;
	Wed, 12 Jun 2024 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dZxwggmy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fg6SnWWA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDgu+xu4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f7szkrT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7A71747;
	Wed, 12 Jun 2024 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217215; cv=none; b=YXW3kRptNS8WZFwYfyfJiLMLcCbmslQgZzax6yeq5+GN64eSR5EomALRYrxjBk9YHDf5+GQanfo7nAzRl6jjEtmfNZc/i4kkEIjon2MtpQTdtL3GmyQhoQ/r2vt6Dmq2x8ekPv5Y4ljP3EZR0ku25efVMfp6SXmk90wikISqU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217215; c=relaxed/simple;
	bh=faZcWAtuhGHaOkTzDVhSBkGucdApEpkt4Q3fVDWYs7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrLIz0HCapxulNmByt2sUUREr/PaK2p0YtJXdbbMSKaNDjDRvfVkogMvUSSP12nAsQTKANWmNM9m8KxokQTh5GkeUqBT3V7/YxVIurfJbzakgBZTkDEY5qNtBWFZ3tPGxeRiBNRpuW+BJuI/qm7fnrthy5L92ggteBbZ//LCnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dZxwggmy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fg6SnWWA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDgu+xu4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f7szkrT6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB0075C59B;
	Wed, 12 Jun 2024 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718217211;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cer0If1HAzS1rq/ObJK8fArocZBEgcs+4FYJpm4dg4=;
	b=dZxwggmyjmFUy63iHNTvDyRLbG13qNf4s0ubon5OSgaFlFrnnr65wXuX/aIcq/m4xQVsbj
	UVtqeUGup4wgn7qvntKEYiYPHH92C685yhCiow+6SqK/xJJ86KfB7iKWctXX+WPB4Djdkl
	sqKpCSO3gvDhN2bn7jCMWgJ2tYRG24A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718217211;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cer0If1HAzS1rq/ObJK8fArocZBEgcs+4FYJpm4dg4=;
	b=Fg6SnWWADfIITUHwLRladDGkpicCEqjnlG60sfSfVBFjq7f1pImTaSsdE0dshb49H3SxgW
	BwRrputQOBTXDeBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oDgu+xu4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f7szkrT6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718217210;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cer0If1HAzS1rq/ObJK8fArocZBEgcs+4FYJpm4dg4=;
	b=oDgu+xu4+2JNKwuihxt4l0qvk2awI+eQgEE6QHvqwyMGCAW7uxl58ipfD1d3D0YIcqn+d5
	a0cCIPL8xmbIM7rzSwKNzdmyhRC0geoT7c0lGu0ch1qACjjHhIwZHTBwpzt7/PjxgELpUb
	NIe4g1jHsYVbsVoDexHfc2B/G8/JiFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718217210;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cer0If1HAzS1rq/ObJK8fArocZBEgcs+4FYJpm4dg4=;
	b=f7szkrT6v/B8HF1uMBpeASFn1Dm8YWMWkyGOQL4F/bNB1A6MkMevBe7orRRK06jFhDBeaL
	3bBRX15oFPuflwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD09B1372E;
	Wed, 12 Jun 2024 18:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +xn3LfrpaWZRDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 18:33:30 +0000
Date: Wed, 12 Jun 2024 20:33:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
	hch@infradead.org
Subject: Re: [PATCH v4 2/2] btrfs: use iget5_locked_rcu
Message-ID: <20240612183329.GI18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240611173824.535995-1-mjguzik@gmail.com>
 <20240611173824.535995-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611173824.535995-3-mjguzik@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DB0075C59B
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 11, 2024 at 07:38:23PM +0200, Mateusz Guzik wrote:
> With 20 threads each walking a dedicated 1000 dirs * 1000 files
> directory tree to stat(2) on a 32 core + 24GB ram vm:
> 
> before: 3.54s user 892.30s system 1966% cpu 45.549 total
> after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)
> 
> Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Acked-by: David Sterba <dsterba@suse.com>

