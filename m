Return-Path: <linux-fsdevel+bounces-10253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD0849710
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FD71F221B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160C12E7D;
	Mon,  5 Feb 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZShL6v96";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VuDDe6eC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rf6TkAwO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Q91ZPoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22744134B5;
	Mon,  5 Feb 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126844; cv=none; b=pis5/XqEZ56+Q6OF7S+z/Tr3Xre/aNII2bXZa7+MUhTyWVPBdB56AWfzFgVaX0NSslvP3BMV/gJd7Kb/cmHsHuzBf7ABHx2BP8d6df4aQ5WlQfsNm+xKPUoDNt8k1FnsV+5Z3bTCuTNR6FpDe2N/k5HfIB0RCSWrs7+bPlw+YUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126844; c=relaxed/simple;
	bh=lBT2FCDxIEra83yAYCWariNM8bR1mmYwJ0ppEJawBHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPtzutEgU4WsbWkzxBiPZjkUo4JH0tKrpjSZ4pKK7gQZN2Fm41zS6iWLzwj9F953RtZooGp0HHfIXjYixsJTksQxGj5JxTufLfkxNGxu17fDymesTBXHNN6GxffucDuG9SRTpyIB5I76lhx1GY5Rg6AZ0mbrY0oaSJznJV+WXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZShL6v96; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VuDDe6eC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rf6TkAwO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Q91ZPoQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E163E1F8A6;
	Mon,  5 Feb 2024 09:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707126839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3nxdMBK1Iowwo0h4C04mpiVNd7FN4kqlRYxqdrDtPA=;
	b=ZShL6v96XnRFGm/vzWacwRDuV+mv0TglyE4iFcSrbkl+V4ZB1AjTgYVLITqyZ8tgeJnX4b
	ED4oB0y6ZU03DRfeRUh21G1gHcsYXoqhOgKk3BVVTPgpAWeC54Mhe3ojajE5SrTx6z750t
	fkce5xsQ4vswaH/jghxrUEpqV/6A9Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707126839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3nxdMBK1Iowwo0h4C04mpiVNd7FN4kqlRYxqdrDtPA=;
	b=VuDDe6eC/SvJaAjbX319Y+sx8jWP91wuNQ4dw9KhhuiM5arBX/a8zum5/fJcmd/qFnFBq7
	rcFC6YRuFLpygcAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707126838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3nxdMBK1Iowwo0h4C04mpiVNd7FN4kqlRYxqdrDtPA=;
	b=rf6TkAwONT3achDdsh5M3oXpHMAgbvIv+TRbWsL3id58XPn2H72czkjoVJyPhhAfpFV/FU
	bYnDJaNOqUQk2SyCQFYF6ykA/2YckgY8FpLdJ7B9VMDzkXAd72kpEYFPdjJbo/T2tefQDa
	om4lUT1xFuNguvahHUzyw8nabgQ2cmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707126838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3nxdMBK1Iowwo0h4C04mpiVNd7FN4kqlRYxqdrDtPA=;
	b=1Q91ZPoQS5YSuAeWMNqVlX9AjMO/Hpv5d7WBWwwXmjDW4YaXpYHENpf81TTyNZyLuEKO5i
	MCygOVBeP108ZnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D632F136F5;
	Mon,  5 Feb 2024 09:53:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TulINDawwGWbJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 09:53:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8799AA0809; Mon,  5 Feb 2024 10:53:58 +0100 (CET)
Date: Mon, 5 Feb 2024 10:53:58 +0100
From: Jan Kara <jack@suse.cz>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/4] fs/pipe: Convert to lockdep_cmp_fn
Message-ID: <20240205095358.p322zf5u74fgczlo@quack3>
References: <20240127020833.487907-1-kent.overstreet@linux.dev>
 <20240127020833.487907-2-kent.overstreet@linux.dev>
 <20240202120357.tfjdri5rfd2onajl@quack3>
 <CA+icZUWdUUhWg_-0NvF+6L=EUhj7amv_7HRKHDPvrEBspwHC2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUWdUUhWg_-0NvF+6L=EUhj7amv_7HRKHDPvrEBspwHC2Q@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rf6TkAwO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1Q91ZPoQ
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[36.19%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,linux.dev,vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: E163E1F8A6
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On Fri 02-02-24 13:25:20, Sedat Dilek wrote:
> On Fri, Feb 2, 2024 at 1:12 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 26-01-24 21:08:28, Kent Overstreet wrote:
> > > *_lock_nested() is fundamentally broken; lockdep needs to check lock
> > > ordering, but we cannot device a total ordering on an unbounded number
> > > of elements with only a few subclasses.
> > >
> > > the replacement is to define lock ordering with a proper comparison
> > > function.
> > >
> > > fs/pipe.c was already doing everything correctly otherwise, nothing
> > > much changes here.
> > >
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > I had to digest for a while what this new lockdep lock ordering feature is
> > about. I have one pending question - what is the motivation of this
> > conversion of pipe code? AFAIU we don't have any problems with lockdep
> > annotations on pipe->mutex because there are always only two subclasses?
> >
> >                                                                 Honza
> 
> Hi,
> 
> "Numbers talk - Bullshit walks." (Linus Torvalds)
> 
> In things of pipes - I normally benchmark like this (example):
> 
> root# cat /dev/sdc | pipebench > /dev/null
> 
> Do you have numbers for your patch-series?

Sedat AFAIU this patch is not about performance at all but rather about
lockdep instrumentation... But maybe I'm missing your point?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

