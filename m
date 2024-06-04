Return-Path: <linux-fsdevel+bounces-20940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B868FB035
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 12:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497901C23223
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C71B145321;
	Tue,  4 Jun 2024 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DC9xw6k6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvYjR7Fw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DC9xw6k6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvYjR7Fw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CA143755;
	Tue,  4 Jun 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497715; cv=none; b=XosmlXCZKUCLvuH6A9Y6ssFV6BSLwf/cy8P1ufxEEb9bteyH+GabfKhR0LVuTQJ3qIhOPoXHJDDnGLNJisHpAYbFwqPIcHUZUmebzQSxCZzd2nPwH8+Rkyf1st0qc9vif4zoH/Rkd//YHxi4lTmdBNVuZF5YTCCJEFAgAdQ/Sgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497715; c=relaxed/simple;
	bh=dp0fo3XdeqZlYypGl9DeIj5tcmNB7aysxjzk84H8XLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6osS0DlXs2MBCQYdRUyaS9Y5FLSLIaG1XA9LPYapI5dYZxJS+I/+4MrlJwWAznR1eRsD6tpGzFpF5o/O7Gp2eTta7gz2YcY0uYtkktRZDVYkiHyILkqU2XjYjn0QA8TLBjyC4XuwU4g8cfs64mm+0HWLbfVc51wDRfGQbL/a6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DC9xw6k6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvYjR7Fw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DC9xw6k6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvYjR7Fw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C0651F7E1;
	Tue,  4 Jun 2024 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717497711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwFOiU/WbAmM69GrLyMIrhX7BpOE7tyHdXUtBfNPkvA=;
	b=DC9xw6k6BGTGAmaiJWgeOUFIL0h6Nok4Ol0RGeCiIMDyhIFIbOrI/4ozp5hFb5CucGJCTJ
	4G8NF9ID5nE0gV2ziqoj3AtkRs2xk/XPiQmFLqKw+OYON9+WHXbuAADDAeVblM4lvhnxf0
	YjwP5eHXnoRwOrNScpO57UO5MRRc19o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717497711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwFOiU/WbAmM69GrLyMIrhX7BpOE7tyHdXUtBfNPkvA=;
	b=CvYjR7FwREKuPNr9YcV1PPc7aMaUHAk1Mt90+xMoRHT7OoIkh0h3GBZ/zs1joWWPtIIQES
	8lA5cSjQJJoI1WBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DC9xw6k6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CvYjR7Fw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717497711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwFOiU/WbAmM69GrLyMIrhX7BpOE7tyHdXUtBfNPkvA=;
	b=DC9xw6k6BGTGAmaiJWgeOUFIL0h6Nok4Ol0RGeCiIMDyhIFIbOrI/4ozp5hFb5CucGJCTJ
	4G8NF9ID5nE0gV2ziqoj3AtkRs2xk/XPiQmFLqKw+OYON9+WHXbuAADDAeVblM4lvhnxf0
	YjwP5eHXnoRwOrNScpO57UO5MRRc19o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717497711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwFOiU/WbAmM69GrLyMIrhX7BpOE7tyHdXUtBfNPkvA=;
	b=CvYjR7FwREKuPNr9YcV1PPc7aMaUHAk1Mt90+xMoRHT7OoIkh0h3GBZ/zs1joWWPtIIQES
	8lA5cSjQJJoI1WBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 753FD13A93;
	Tue,  4 Jun 2024 10:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pZSbHG/vXmYRRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Jun 2024 10:41:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2D054A086D; Tue,  4 Jun 2024 12:41:51 +0200 (CEST)
Date: Tue, 4 Jun 2024 12:41:51 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	hch@infradead.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/splice: don't block splice_direct_to_actor() after
 data was read
Message-ID: <20240604104151.73n3zmn24hxmmwj6@quack3>
References: <20240604092431.2183929-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604092431.2183929-1-max.kellermann@ionos.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8C0651F7E1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue 04-06-24 11:24:31, Max Kellermann wrote:
> If userspace calls sendfile() with a very large "count" parameter, the
> kernel can block for a very long time until 2 GiB (0x7ffff000 bytes)
> have been read from the hard disk and pushed into the socket buffer.
> 
> Usually, that is not a problem, because the socket write buffer gets
> filled quickly, and if the socket is non-blocking, the last
> direct_splice_actor() call will return -EAGAIN, causing
> splice_direct_to_actor() to break from the loop, and sendfile() will
> return a partial transfer.
> 
> However, if the network happens to be faster than the hard disk, and
> the socket buffer keeps getting drained between two
> generic_file_read_iter() calls, the sendfile() system call can keep
> running for a long time, blocking for disk I/O over and over.
> 
> That is undesirable, because it can block the calling process for too
> long.  I discovered a problem where nginx would block for so long that
> it would drop the HTTP connection because the kernel had just
> transferred 2 GiB in one call, and the HTTP socket was not writable
> (EPOLLOUT) for more than 60 seconds, resulting in a timeout:
> 
>   sendfile(4, 12, [5518919528] => [5884939344], 1813448856) = 366019816 <3.033067>
>   sendfile(4, 12, [5884939344], 1447429040) = -1 EAGAIN (Resource temporarily unavailable) <0.000037>
>   epoll_wait(9, [{EPOLLOUT, {u32=2181955104, u64=140572166585888}}], 512, 60000) = 1 <0.003355>
>   gettimeofday({tv_sec=1667508799, tv_usec=201201}, NULL) = 0 <0.000024>
>   sendfile(4, 12, [5884939344] => [8032418896], 2147480496) = 2147479552 <10.727970>
>   writev(4, [], 0) = 0 <0.000439>
>   epoll_wait(9, [], 512, 60000) = 0 <60.060430>
>   gettimeofday({tv_sec=1667508869, tv_usec=991046}, NULL) = 0 <0.000078>
>   write(5, "10.40.5.23 - - [03/Nov/2022:21:5"..., 124) = 124 <0.001097>
>   close(12) = 0 <0.000063>
>   close(4)  = 0 <0.000091>
> 
> In newer nginx versions (since 1.21.4), this problem was worked around
> by defaulting "sendfile_max_chunk" to 2 MiB:
> 
>  https://github.com/nginx/nginx/commit/5636e7f7b4

Well, I can see your pain but after all the kernel does exactly what
userspace has asked for?

> Instead of asking userspace to provide an artificial upper limit, I'd
> like the kernel to block for disk I/O at most once, and then pass back
> control to userspace.
> 
> There is prior art for this kind of behavior in filemap_read():
> 
> 	/*
> 	 * If we've already successfully copied some data, then we
> 	 * can no longer safely return -EIOCBQUEUED. Hence mark
> 	 * an async read NOWAIT at that point.
> 	 */
> 	if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
> 		iocb->ki_flags |= IOCB_NOWAIT;

Do note the IOCB_WAITQ test - this means that the request is coming from
io_uring and that has a retry logic to handle short reads. I'm really
nervous about changing sendfile behavior to unconditionally returning short
writes. In particular see this in do_sendfile():

#if 0
        /*
         * We need to debate whether we can enable this or not. The
         * man page documents EAGAIN return for the output at least,
         * and the application is arguably buggy if it doesn't expect
         * EAGAIN on a non-blocking file descriptor.
         */
        if (in.file->f_flags & O_NONBLOCK)
                fl = SPLICE_F_NONBLOCK;
#endif

We have been through these discussions in the past and so far we have
always decided the chances for userspace breakage are too big. After all
there's no substantial difference between userspace issuing a 2GB read(2) and
2GB sendfile(2). In both cases you are going to be blocked for a long
time and there are too many userspace applications that depend on this
behavior...

So I don't think we want to change the current behavior. We could create a
new interface to provide the semantics you want (like a flag to sendfile(2)
- which would mean a new syscall) but I'm wondering whether these days
io_uring isn't a better answer if you want to more closely control IO
behavior of your application and are willing to change used interface.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

