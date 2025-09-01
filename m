Return-Path: <linux-fsdevel+bounces-59746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4D0B3DCDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B49017A7DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D79A2FB975;
	Mon,  1 Sep 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YI5Y6Fu5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0LQRU2Gb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YI5Y6Fu5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0LQRU2Gb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768932FB62E
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716280; cv=none; b=OMdbgXtrVC3hKe3aV5+bYU3wLOuoAXa5D23MfpIjMcXvjFbEeb+4lyo+t8upEyxF2v2Gn3kFyMtIDgSxezsbPnvG5y63E6xiZ2qB8pPH+Zm9t0sKtHvL2mufAVevK+Vc1HoVZhBG0DMo7Q3J7Poua5SdRC/5AHeGolxozy6wpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716280; c=relaxed/simple;
	bh=JgrniebZA5MUxD6Vin67nWaETutQuO9cOLiuFbvnoME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKlaQ9/kNJXDVSUyhFnxqqbrRgA+/XL0Cpjkp1/KL3dNVWaWAUhU0JY607Ssvo0mE/6AWUBRV/KuVQHH6rvr/JMIxn31oXP+c6V3pmrSEF3vfAFon5/CV5qTsqQ+GpLsgXig86YRtLBkoBgLvmNrvmnZp0CHsX4BuHhbTG44G08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YI5Y6Fu5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0LQRU2Gb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YI5Y6Fu5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0LQRU2Gb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 766431F385;
	Mon,  1 Sep 2025 08:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756716276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1YWKWcrajp/C3u2xK+YpqGsYdKR60yvLnLmFWr2s/s=;
	b=YI5Y6Fu5FOeOSWxbzUSkl6LfpY67t6ZGu0YSGjvpz0z0nGFPRcWy0anzr/Vb2UxrVqDCMn
	Bo5gGdtymVyy6GrTFDV/fJfVPF4s1yMXcf+UbeOot98uZcXP9r0G5gUf80X2qjHha9osbh
	EkHU51pyQTNpziLm3Bjy/w1ZjzGfQKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756716276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1YWKWcrajp/C3u2xK+YpqGsYdKR60yvLnLmFWr2s/s=;
	b=0LQRU2GbJv1+qG7K51OmbKsjnVD6ZNg+QiNPmc99/vM8+eoxSX7eRf7riE+Jq9o0wsoc/P
	I1/PMQmd2+x62mCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YI5Y6Fu5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0LQRU2Gb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756716276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1YWKWcrajp/C3u2xK+YpqGsYdKR60yvLnLmFWr2s/s=;
	b=YI5Y6Fu5FOeOSWxbzUSkl6LfpY67t6ZGu0YSGjvpz0z0nGFPRcWy0anzr/Vb2UxrVqDCMn
	Bo5gGdtymVyy6GrTFDV/fJfVPF4s1yMXcf+UbeOot98uZcXP9r0G5gUf80X2qjHha9osbh
	EkHU51pyQTNpziLm3Bjy/w1ZjzGfQKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756716276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1YWKWcrajp/C3u2xK+YpqGsYdKR60yvLnLmFWr2s/s=;
	b=0LQRU2GbJv1+qG7K51OmbKsjnVD6ZNg+QiNPmc99/vM8+eoxSX7eRf7riE+Jq9o0wsoc/P
	I1/PMQmd2+x62mCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5996A136ED;
	Mon,  1 Sep 2025 08:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QWbbFfRctWirYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 08:44:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E37DEA099B; Mon,  1 Sep 2025 10:44:27 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:44:27 +0200
From: Jan Kara <jack@suse.cz>
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, Theodore Ts'o <tytso@mit.edu>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <i464joalmbxbu2yow2uvkbo3eioj3l4zihzzl2odegr4qqzr7u@4ycu45fecyz7>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <20250826220033.GW39973@ZenIV>
 <0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru>
 <20250827115247.GD1603531@mit.edu>
 <6d37ce87-e6bf-bd3e-81a9-70fdf08b9c4c@ispras.ru>
 <20250831202244.290823f2@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831202244.290823f2@pumpkin>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 766431F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Sun 31-08-25 20:22:44, David Laight wrote:
> On Wed, 27 Aug 2025 16:05:51 +0300 (MSK)
> Alexander Monakov <amonakov@ispras.ru> wrote:
> 
> > On Wed, 27 Aug 2025, Theodore Ts'o wrote:
> > 
> > > On Wed, Aug 27, 2025 at 10:22:14AM +0300, Alexander Monakov wrote:  
> > > > 
> > > > On Tue, 26 Aug 2025, Al Viro wrote:
> > > >   
> > > > > Egads...  Let me get it straight - you have a bunch of threads sharing descriptor
> > > > > tables and some of them are forking (or cloning without shared descriptor tables)
> > > > > while that is going on?  
> > > > 
> > > > I suppose if they could start a new process in a more straightforward manner,
> > > > they would. But you cannot start a new process without fork. Anyway, I'm but
> > > > a messenger here: the problem has been hit by various people in the Go community
> > > > (and by Go team itself, at least twice). Here I'm asking about a potential
> > > > shortcoming in __fput that exacerbates the problem.  
> > > 
> > > I'm assuming that the problem is showing up in real life when users
> > > run a go problem using "go run" where the golang compiler freshly
> > > writes the executable, and then fork/exec's the binary.  And using
> > > multiple threads sharing descriptor tables was just to make a reliable
> > > reproducer?  
> > 
> > You need at least two threads: while one thread does open-write-close-fork,
> > there needs to be another thread that forks concurrently with the write.
> 
> Is this made worse by the code that defers fput to a worker thread?
> (or am I misremembering things again?)

fput() is offloaded to task work (i.e., it happens on exit of a task to
userspace). But I don't think it impacts this particular problem in a
significant way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

