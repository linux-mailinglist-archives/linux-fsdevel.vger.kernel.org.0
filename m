Return-Path: <linux-fsdevel+bounces-22485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B6918047
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520182832E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A5A17F36D;
	Wed, 26 Jun 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="raMl5Av/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FYQE0SC5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="raMl5Av/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FYQE0SC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FF149E06;
	Wed, 26 Jun 2024 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402871; cv=none; b=LhwCmKZqRjNy3w2kqKm7u+rwgus8ZsZVtFyL8A4EXNArE9MvVJQii7PnTLqpuzb5dpC0+kZTt/zsCxVmoznCGjCmq2AKLWQGkfzS4H2QyxX0fXtXjNtppzGooM/TskaymO8n35c9zTcxKaWPm9BMb/rDqSzgRmo2QzffoJ3YUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402871; c=relaxed/simple;
	bh=boDIopYnqO4P4NEPfMNr06+WimcJciiKHHal+1Bjkd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfuFcki6TrQpAcexZya33HKR/XiHf//J21YK1lYV7hGWREjGxtMlBvxnxWeJqMHAsIhioHjwHPtgNS4yPaZb72PPSCQwsL88AtehayCbOdn8wIJxI4WSFlcnZK1WCwQkO/vDo0hxB2LFYikJPZyxz4qtZy9WL8v/Ylu3fN3D2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=raMl5Av/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FYQE0SC5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=raMl5Av/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FYQE0SC5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C0FD21ACE;
	Wed, 26 Jun 2024 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719402867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jdMtu3iSZNngR8dnxl3fkVRY+pOtnN97BZybFpmE24=;
	b=raMl5Av/AjEtW3otRVVhoT+HqtmeRSfD6MESxE/R7Yg5uy3Jwu9thj+xRVInF3gxdoTl4B
	ZFrXfLSLOM8W9umHWUo7gWUAn44/kSKcRjixjHUDRpHKKUUkwwmRBkvUxL78eHjmq1GlYa
	FYyMI4Ri4yyx8QUN9RsjLDUCsb569MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719402867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jdMtu3iSZNngR8dnxl3fkVRY+pOtnN97BZybFpmE24=;
	b=FYQE0SC5dVXIakJQkesRIbLlnJgogaY6OlAAUrUsQdQy/n+Z9KyQcTKGEbT6ftHo9GHYNl
	9sJsK3CcYtA57dDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="raMl5Av/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FYQE0SC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719402867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jdMtu3iSZNngR8dnxl3fkVRY+pOtnN97BZybFpmE24=;
	b=raMl5Av/AjEtW3otRVVhoT+HqtmeRSfD6MESxE/R7Yg5uy3Jwu9thj+xRVInF3gxdoTl4B
	ZFrXfLSLOM8W9umHWUo7gWUAn44/kSKcRjixjHUDRpHKKUUkwwmRBkvUxL78eHjmq1GlYa
	FYyMI4Ri4yyx8QUN9RsjLDUCsb569MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719402867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jdMtu3iSZNngR8dnxl3fkVRY+pOtnN97BZybFpmE24=;
	b=FYQE0SC5dVXIakJQkesRIbLlnJgogaY6OlAAUrUsQdQy/n+Z9KyQcTKGEbT6ftHo9GHYNl
	9sJsK3CcYtA57dDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E20413AAD;
	Wed, 26 Jun 2024 11:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lsPFHnMBfGYWIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Jun 2024 11:54:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37362A082B; Wed, 26 Jun 2024 13:54:27 +0200 (CEST)
Date: Wed, 26 Jun 2024 13:54:27 +0200
From: Jan Kara <jack@suse.cz>
To: "Ma, Yu" <yu.ma@intel.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
Message-ID: <20240626115427.d3x7g3bf6hdemlnq@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
X-Rspamd-Queue-Id: 8C0FD21ACE
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 25-06-24 23:33:34, Ma, Yu wrote:
> On 6/25/2024 8:53 PM, Jan Kara wrote:
> > On Tue 25-06-24 13:52:57, Jan Kara wrote:
> > > On Sat 22-06-24 11:49:02, Yu Ma wrote:
> > > > There is available fd in the lower 64 bits of open_fds bitmap for most cases
> > > > when we look for an available fd slot. Skip 2-levels searching via
> > > > find_next_zero_bit() for this common fast path.
> > > > 
> > > > Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
> > > > free slot is available there, as:
> > > > (1) The fd allocation algorithm would always allocate fd from small to large.
> > > > Lower bits in open_fds bitmap would be used much more frequently than higher
> > > > bits.
> > > > (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
> > > > it would never be shrunk. The search size increases but there are few open fds
> > > > available here.
> > > > (3) find_next_zero_bit() itself has a fast path inside to speed up searching
> > > > when size<=64.
> > > > 
> > > > Besides, "!start" is added to fast path condition to ensure the allocated fd is
> > > > greater than start (i.e. >=0), given alloc_fd() is only called in two scenarios:
> > > > (1) Allocating a new fd (the most common usage scenario) via
> > > > get_unused_fd_flags() to find fd start from bit 0 in fdt (i.e. start==0).
> > > > (2) Duplicating a fd (less common usage) via dup_fd() to find a fd start from
> > > > old_fd's index in fdt, which is only called by syscall fcntl.
> > > > 
> > > > With the fast path added in alloc_fd(), pts/blogbench-1.1.0 read is improved
> > > > by 17% and write by 9% on Intel ICX 160 cores configuration with v6.10-rc4.
> > > > 
> > > > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > > > ---
> > > >   fs/file.c | 35 +++++++++++++++++++++--------------
> > > >   1 file changed, 21 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/fs/file.c b/fs/file.c
> > > > index a3b72aa64f11..50e900a47107 100644
> > > > --- a/fs/file.c
> > > > +++ b/fs/file.c
> > > > @@ -515,28 +515,35 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
> > > >   	if (fd < files->next_fd)
> > > >   		fd = files->next_fd;
> > > > -	if (fd < fdt->max_fds)
> > > > +	error = -EMFILE;
> > > > +	if (likely(fd < fdt->max_fds)) {
> > > > +		if (~fdt->open_fds[0] && !start) {
> > > > +			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
> > > So I don't think this is quite correct. If files->next_fd is set, we could
> > > end up calling find_next_zero_bit() starting from quite high offset causing
> > > a regression? Also because we don't expand in this case, we could cause access
> > > beyond end of fdtable?
> > OK, I've misunderstood the next_fd logic. next_fd is the lowest 0-bit in
> > the open_fds bitmap so if next_fd is big, the ~fdt->open_fds[0] should
> > be false. As such the above condition could be rewritten as:
> > 
> > 		if (!start && files->next_fd < BITS_PER_LONG)
> > 
> > to avoid loading the first bitmap long if we know it is full? Or we could
> > maybe go as far as:
> > 
> > 		if (!start && fd < BITS_PER_LONG && !test_bit(fd, fdt->open_fds))
> > 			goto fastreturn;
> > 
> > because AFAIU this should work in exactly the same cases as your code?
> > 
> > 								Honza
> 
> Thanks Honza for the good concern and suggestions here, while both above
> conditions are not enough to ensure that there is available fd in the first
> 64 bits of open_fds. As next_fd just means there is no available fd before
> next_fd, just imagine that fd from 0 to 66 are already occupied, now fd=3 is
> returned back, then next_fd would be set as 3 per fd recycling logic (i.e.
> in __put_unused_fd()), next time when alloc_fd() being called, it would
> return fd=3 to the caller and set next_fd=4. Then next time when alloc_fd()
> being called again, next_fd==4, but actually it's already been occupied. So
> find_next_zero_bit() is needed to find the real 0 bit anyway.

Indeed, thanks for correcting me! next_fd is just a lower bound for the
first free fd.

> The conditions
> should either be like it is in patch or if (!start && !test_bit(0,
> fdt->full_fds_bits)), the latter should also have the bitmap loading cost,
> but another point is that a bit in full_fds_bits represents 64 bits in
> open_fds, no matter fd >64 or not, full_fds_bits should be loaded any way,
> maybe we can modify the condition to use full_fds_bits ?

So maybe I'm wrong but I think the biggest benefit of your code compared to
plain find_next_fd() is exactly in that we don't have to load full_fds_bits
into cache. So I'm afraid that using full_fds_bits in the condition would
destroy your performance gains. Thinking about this with a fresh head how
about putting implementing your optimization like:

--- a/fs/file.c
+++ b/fs/file.c
@@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
        unsigned int maxbit = maxfd / BITS_PER_LONG;
        unsigned int bitbit = start / BITS_PER_LONG;
 
+       /*
+        * Optimistically search the first long of the open_fds bitmap. It
+        * saves us from loading full_fds_bits into cache in the common case
+        * and because BITS_PER_LONG > start >= files->next_fd, we have quite
+        * a good chance there's a bit free in there.
+        */
+       if (start < BITS_PER_LONG) {
+               unsigned int bit;
+
+               bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
+               if (bit < BITS_PER_LONG)
+                       return bit;
+       }
+
        bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
        if (bitbit >= maxfd)
                return maxfd;

Plus your optimizations with likely / unlikely. This way the code flow in
alloc_fd() stays more readable, we avoid loading the first open_fds long
into cache if it is full, and we should get all the performance benefits?

								Honza

 
> > > > +			goto fastreturn;
> > > > +		}
> > > >   		fd = find_next_fd(fdt, fd);
> > > > +	}
> > > > +
> > > > +	if (unlikely(fd >= fdt->max_fds)) {
> > > > +		error = expand_files(files, fd);
> > > > +		if (error < 0)
> > > > +			goto out;
> > > > +		/*
> > > > +		 * If we needed to expand the fs array we
> > > > +		 * might have blocked - try again.
> > > > +		 */
> > > > +		if (error)
> > > > +			goto repeat;
> > > > +	}
> > > > +fastreturn:
> > > >   	/*
> > > >   	 * N.B. For clone tasks sharing a files structure, this test
> > > >   	 * will limit the total number of files that can be opened.
> > > >   	 */
> > > > -	error = -EMFILE;
> > > > -	if (fd >= end)
> > > > +	if (unlikely(fd >= end))
> > > >   		goto out;
> > > > -	error = expand_files(files, fd);
> > > > -	if (error < 0)
> > > > -		goto out;
> > > > -
> > > > -	/*
> > > > -	 * If we needed to expand the fs array we
> > > > -	 * might have blocked - try again.
> > > > -	 */
> > > > -	if (error)
> > > > -		goto repeat;
> > > > -
> > > >   	if (start <= files->next_fd)
> > > >   		files->next_fd = fd + 1;
> > > > -- 
> > > > 2.43.0
> > > > 
> > > -- 
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

