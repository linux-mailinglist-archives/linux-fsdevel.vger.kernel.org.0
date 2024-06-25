Return-Path: <linux-fsdevel+bounces-22343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1963916867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED931F21957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828F15884A;
	Tue, 25 Jun 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXmL3vq/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TR1fWlHH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXmL3vq/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TR1fWlHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526C14AD2B;
	Tue, 25 Jun 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319994; cv=none; b=l+S9nKTnXrVmhGHGRYPN2zu0aXOlpKGUsQPOxQ886VRWZbef+Qo9dRIWJd5xXX57k+CdXbMkjrPu00UlGvnstzpKYx6pbukg+4JPaHa2+xZA5ZWO5/bGXbGVLrEbdWORxZxMtSrZBrkawiGGs5avnyFwh0JYCMwAp87dTAAyWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319994; c=relaxed/simple;
	bh=Kaoya1t2YxaC5rMdlSgMcjc5K1Lw3xlNtgjPQJZpdxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmjlh4CIMV8MTWe4MPpmItETmvEeZzT8EyzVFYC0pvLjuFhANQe4/BuXExPK0dGgzNUcWUNdUNy1vwXQqLLeFHFBOgq30g65FpNaQzQ4nV4Ia9V6iNwrcBl7dSuzlk08iYi9vjjvfDF49wvDc5WU6vd9We9H1uTWGETcSqO5/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXmL3vq/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TR1fWlHH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXmL3vq/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TR1fWlHH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C1B62190C;
	Tue, 25 Jun 2024 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719319990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0z5xGub+v0MK7RQ8V9Cdx89WLpx0ML3U8kkjSuLpl78=;
	b=DXmL3vq/zrN4bG9OXd1QNuoHAoLRYTB7Yv3eJLHvM1b82THOFXAvQN+qwOoqDpMi30+CyD
	nA7jgA3TLYad9S/6iBdaYKJ2aWbL7k8RY6f9lQiPO+4/xQWIwxiuQoFgFVPjTtt0tCo14t
	7E7uz7tBESNOyCtHUfLe6VQMzSCC/tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719319990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0z5xGub+v0MK7RQ8V9Cdx89WLpx0ML3U8kkjSuLpl78=;
	b=TR1fWlHHr8z2uuov2orDy8Oo0QAuXcjFHqtx1deQAnQpL1vGE5zzhoxFutBE3T81VV7p0l
	PosDJEI8LS68YNCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719319990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0z5xGub+v0MK7RQ8V9Cdx89WLpx0ML3U8kkjSuLpl78=;
	b=DXmL3vq/zrN4bG9OXd1QNuoHAoLRYTB7Yv3eJLHvM1b82THOFXAvQN+qwOoqDpMi30+CyD
	nA7jgA3TLYad9S/6iBdaYKJ2aWbL7k8RY6f9lQiPO+4/xQWIwxiuQoFgFVPjTtt0tCo14t
	7E7uz7tBESNOyCtHUfLe6VQMzSCC/tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719319990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0z5xGub+v0MK7RQ8V9Cdx89WLpx0ML3U8kkjSuLpl78=;
	b=TR1fWlHHr8z2uuov2orDy8Oo0QAuXcjFHqtx1deQAnQpL1vGE5zzhoxFutBE3T81VV7p0l
	PosDJEI8LS68YNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E8AC1384C;
	Tue, 25 Jun 2024 12:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XmiHA7a9emaeDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 12:53:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2B49A087F; Tue, 25 Jun 2024 14:53:09 +0200 (CEST)
Date: Tue, 25 Jun 2024 14:53:09 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
Message-ID: <20240625125309.y2gs4j5jr35kc4z5@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625115257.piu47hzjyw5qnsa6@quack3>
X-Spam-Score: -7.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]

On Tue 25-06-24 13:52:57, Jan Kara wrote:
> On Sat 22-06-24 11:49:02, Yu Ma wrote:
> > There is available fd in the lower 64 bits of open_fds bitmap for most cases
> > when we look for an available fd slot. Skip 2-levels searching via
> > find_next_zero_bit() for this common fast path.
> > 
> > Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
> > free slot is available there, as:
> > (1) The fd allocation algorithm would always allocate fd from small to large.
> > Lower bits in open_fds bitmap would be used much more frequently than higher
> > bits.
> > (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
> > it would never be shrunk. The search size increases but there are few open fds
> > available here.
> > (3) find_next_zero_bit() itself has a fast path inside to speed up searching
> > when size<=64.
> > 
> > Besides, "!start" is added to fast path condition to ensure the allocated fd is
> > greater than start (i.e. >=0), given alloc_fd() is only called in two scenarios:
> > (1) Allocating a new fd (the most common usage scenario) via
> > get_unused_fd_flags() to find fd start from bit 0 in fdt (i.e. start==0).
> > (2) Duplicating a fd (less common usage) via dup_fd() to find a fd start from
> > old_fd's index in fdt, which is only called by syscall fcntl.
> > 
> > With the fast path added in alloc_fd(), pts/blogbench-1.1.0 read is improved
> > by 17% and write by 9% on Intel ICX 160 cores configuration with v6.10-rc4.
> > 
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  fs/file.c | 35 +++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index a3b72aa64f11..50e900a47107 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -515,28 +515,35 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
> >  	if (fd < files->next_fd)
> >  		fd = files->next_fd;
> >  
> > -	if (fd < fdt->max_fds)
> > +	error = -EMFILE;
> > +	if (likely(fd < fdt->max_fds)) {
> > +		if (~fdt->open_fds[0] && !start) {
> > +			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
> 
> So I don't think this is quite correct. If files->next_fd is set, we could
> end up calling find_next_zero_bit() starting from quite high offset causing
> a regression? Also because we don't expand in this case, we could cause access
> beyond end of fdtable?

OK, I've misunderstood the next_fd logic. next_fd is the lowest 0-bit in
the open_fds bitmap so if next_fd is big, the ~fdt->open_fds[0] should
be false. As such the above condition could be rewritten as:

		if (!start && files->next_fd < BITS_PER_LONG)

to avoid loading the first bitmap long if we know it is full? Or we could
maybe go as far as:

		if (!start && fd < BITS_PER_LONG && !test_bit(fd, fdt->open_fds))
			goto fastreturn;

because AFAIU this should work in exactly the same cases as your code?

								Honza

> > +			goto fastreturn;
> > +		}
> >  		fd = find_next_fd(fdt, fd);
> > +	}
> > +
> > +	if (unlikely(fd >= fdt->max_fds)) {
> > +		error = expand_files(files, fd);
> > +		if (error < 0)
> > +			goto out;
> > +		/*
> > +		 * If we needed to expand the fs array we
> > +		 * might have blocked - try again.
> > +		 */
> > +		if (error)
> > +			goto repeat;
> > +	}
> >  
> > +fastreturn:
> >  	/*
> >  	 * N.B. For clone tasks sharing a files structure, this test
> >  	 * will limit the total number of files that can be opened.
> >  	 */
> > -	error = -EMFILE;
> > -	if (fd >= end)
> > +	if (unlikely(fd >= end))
> >  		goto out;
> >  
> > -	error = expand_files(files, fd);
> > -	if (error < 0)
> > -		goto out;
> > -
> > -	/*
> > -	 * If we needed to expand the fs array we
> > -	 * might have blocked - try again.
> > -	 */
> > -	if (error)
> > -		goto repeat;
> > -
> >  	if (start <= files->next_fd)
> >  		files->next_fd = fd + 1;
> >  
> > -- 
> > 2.43.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

