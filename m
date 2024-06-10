Return-Path: <linux-fsdevel+bounces-21342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C19023DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218561C21D43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BAB12BE91;
	Mon, 10 Jun 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xf5I/HQb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9deXUGW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xf5I/HQb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9deXUGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7E1D6AA;
	Mon, 10 Jun 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029093; cv=none; b=HLe+nqXwZMkLZSmSF8EvTCO3IX+bl9tyKH3lH8S1j3Qxg+TOssuAeKmjTT899GBm+wRo/55iiI8j2us+hNnAmjZrnMVlPz//TcDBGCGhiz9QP9kucST9nbkNup6VuFhyzZszEXQxUm8L6zI5QDoJAzONgoJCXHe2OW2hhvVTEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029093; c=relaxed/simple;
	bh=hITahHwkarjmzwSzI4GNa9eCkEiJ6pq3dy/29gZ+WFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktKPb2B81i15sSs2i1uh5LrhdzsdJN3F9unTKii2anVq+bodpLoLiCKSBko4tlvcH3AzKkPVRkA4IpZNIwxlHnWo31bF9C12z61/pBQInZqsjNVcPB1QWFRqRKolaH2HyaN1d0YyVEv2dlmdFfF35P0XHEEH0di6FV/Sy1W81IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xf5I/HQb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9deXUGW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xf5I/HQb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9deXUGW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0677821B79;
	Mon, 10 Jun 2024 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718029089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIaNHN9Tm36HPHOOL2icrUAvSgiXdDUp+AaYpWLwx54=;
	b=xf5I/HQbziPEMXjU0eGaLjTEUYgDoVf2UQeEo+8e8CBjkB/RKW0Fkd0Fo8yuCPndoKZwIl
	czDp4GD1m318Fn8KAWzD+fkvFwg/3OC9R9ThZsVdS9UvfAZCDBF1cnQdRMIibXmvsNJyLt
	mr/VKTfkm3yXAFVd80LE+v5jXQggMwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718029089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIaNHN9Tm36HPHOOL2icrUAvSgiXdDUp+AaYpWLwx54=;
	b=i9deXUGWvDRZb3AmHZ5CqcdkYFaq/D4g+zQif0ZHNBGAPpvPdtAKzd2aFOpldLccNYipcD
	5dxNDNTKF2a0GdDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xf5I/HQb";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i9deXUGW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718029089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIaNHN9Tm36HPHOOL2icrUAvSgiXdDUp+AaYpWLwx54=;
	b=xf5I/HQbziPEMXjU0eGaLjTEUYgDoVf2UQeEo+8e8CBjkB/RKW0Fkd0Fo8yuCPndoKZwIl
	czDp4GD1m318Fn8KAWzD+fkvFwg/3OC9R9ThZsVdS9UvfAZCDBF1cnQdRMIibXmvsNJyLt
	mr/VKTfkm3yXAFVd80LE+v5jXQggMwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718029089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIaNHN9Tm36HPHOOL2icrUAvSgiXdDUp+AaYpWLwx54=;
	b=i9deXUGWvDRZb3AmHZ5CqcdkYFaq/D4g+zQif0ZHNBGAPpvPdtAKzd2aFOpldLccNYipcD
	5dxNDNTKF2a0GdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE89A13AA0;
	Mon, 10 Jun 2024 14:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yBA5OiALZ2ZeQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Jun 2024 14:18:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A7DDA087F; Mon, 10 Jun 2024 16:18:08 +0200 (CEST)
Date: Mon, 10 Jun 2024 16:18:08 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <20240610141808.vdsflgcbjmgc37dt@quack3>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <ZmVNblggFRgR8bnJ@infradead.org>
 <20240609155506.GT52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609155506.GT52987@frogsfrogsfrogs>
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,vger.kernel.org,fromorbit.com,kernel.org,linux.ibm.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0677821B79
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Sun 09-06-24 08:55:06, Darrick J. Wong wrote:
>        * invalidate_lock: The pagecache struct address_space
>          rwsemaphore that protects against folio removal.

invalidate_lock lock is held for read during insertions and for write
during removals. So holding it pro read indeed protects against folio
removal but holding it for write protects against folio insertion (which
some places also use).

>        * validity_cookie is a magic freshness value set by the
>          filesystem that should be used to detect stale mappings. For
>          pagecache operations this is critical for correct operation
>          because page faults can occur, which implies that filesystem
>          locks should not be held between ->iomap_begin and
>          ->iomap_end. Filesystems with completely static mappings
>          need not set this value. Only pagecache operations
>          revalidate mappings.
> 
>          XXX: Should fsdax revalidate as well?

AFAICT no. DAX is more like using direct IO for everything. So no writeback
changing mapping state behind your back (and that's the only thing that is
not serialized with i_rwsem or invalidate_lock). Maybe this fact can be
mentioned somewhere around the discussion of iomap_valid() as a way how
locking usually works out?

>    iomap implements nearly all the folio and pagecache management
>    that filesystems once had to implement themselves. This means that
>    the filesystem need not know the details of allocating, mapping,
>    managing uptodate and dirty state, or writeback of pagecache
>    folios. Unless the filesystem explicitly opts in to buffer heads,
>    they will not be used, which makes buffered I/O much more
>    efficient, and willy much happier.
		    ^^^ unless we make it a general noun for someone doing
thankless neverending conversion job, we should give him a capital W ;).

>    These struct kiocb flags are significant for buffered I/O with
>    iomap:
> 
>        * IOCB_NOWAIT: Only proceed with the I/O if mapping data are
>          already in memory, we do not have to initiate other I/O, and
>          we acquire all filesystem locks without blocking. Neither
>          this flag nor its definition RWF_NOWAIT actually define what
>          this flag means, so this is the best the author could come
>          up with.

RWF_NOWAIT is a performance feature, not a correctness one, hence the
meaning is somewhat vague. It is meant to mean "do the IO only if it
doesn't involve waiting for other IO or other time expensive operations".
Generally we translate it to "don't wait for i_rwsem, page locks, don't do
block allocation, etc." OTOH we don't bother to specialcase internal
filesystem locks (such as EXT4_I(inode)->i_data_sem) and we get away with
it because blocking on it under constraints we generally perform RWF_NOWAIT
IO is exceedingly rare.

>       mmap Write Faults
> 
>    The iomap_page_mkwrite function handles a write fault to a folio
>    the pagecache.
     ^^^ to a folio *in* the pagecache? I cannot quite parse the sentence.

>       Truncation
> 
>    Filesystems can call iomap_truncate_page to zero the bytes in the
>    pagecache from EOF to the end of the fsblock during a file
>    truncation operation. truncate_setsize or truncate_pagecache will
>    take care of everything after the EOF block. IOMAP_ZERO will be
>    passed as the flags argument to ->iomap_begin. Callers typically
>    take i_rwsem and invalidate_lock in exclusive mode.

Hum, but i_rwsem and invalidate_lock are usually acquired *before*
iomap_truncate_page() is even called, aren't they? This locking note looks
a bit confusing to me. I'd rather write: "The callers typically hold i_rwsem
and invalidate_lock when calling iomap_truncate_page()." if you want to
mention any locking.

>       Zeroing for File Operations
> 
>    Filesystems can call iomap_zero_range to perform zeroing of the
>    pagecache for non-truncation file operations that are not aligned
>    to the fsblock size. IOMAP_ZERO will be passed as the flags
>    argument to ->iomap_begin. Callers typically take i_rwsem and
>    invalidate_lock in exclusive mode.

Ditto here...

>       Unsharing Reflinked File Data
> 
>    Filesystems can call iomap_file_unshare to force a file sharing
>    storage with another file to preemptively copy the shared data to
>    newly allocate storage. IOMAP_WRITE | IOMAP_UNSHARE will be passed
>    as the flags argument to ->iomap_begin. Callers typically take
>    i_rwsem and invalidate_lock in exclusive mode.

And here.

>   Direct I/O
> 
>    In Linux, direct I/O is defined as file I/O that is issued
>    directly to storage, bypassing the pagecache.
> 
>    The iomap_dio_rw function implements O_DIRECT (direct I/O) reads
>    and writes for files. An optional ops parameter can be passed to
>    change the behavior of direct I/O. The done_before parameter
>    should be set if writes have been initiated prior to the call. The
>    direction of the I/O is determined from the iocb passed in.
> 
>    The flags argument can be any of the following values:
> 
>        * IOMAP_DIO_FORCE_WAIT: Wait for the I/O to complete even if
>          the kiocb is not synchronous.
> 
>        * IOMAP_DIO_OVERWRITE_ONLY: Allocating blocks, zeroing partial
>          blocks, and extensions of the file size are not allowed. The
>          entire file range must to map to a single written or
				  ^^ extra "to"

>          unwritten extent. This flag exists to enable issuing
>          concurrent direct IOs with only the shared i_rwsem held when
>          the file I/O range is not aligned to the filesystem block
>          size. -EAGAIN will be returned if the operation cannot
>          proceed.

<snip>

>     Direct Writes
> 
>    A direct I/O write initiates a write I/O to the storage device to
>    the caller's buffer. Dirty parts of the pagecache are flushed to
>    storage before initiating the write io. The pagecache is
>    invalidated both before and after the write io. The flags value
>    for ->iomap_begin will be IOMAP_DIRECT | IOMAP_WRITE with any
>    combination of the following enhancements:
> 
>        * IOMAP_NOWAIT: Write if mapping data are already in memory.
>          Does not initiate other I/O or block on filesystem locks.
> 
>        * IOMAP_OVERWRITE_ONLY: Allocating blocks and zeroing partial
>          blocks is not allowed. The entire file range must to map to
							     ^^ extra "to"

>          a single written or unwritten extent. The file I/O range
>          must be aligned to the filesystem block size.

This seems to be XFS specific thing? At least I don't see anything in
generic iomap code depending on this?

>     fsdax Writes
> 
>    A fsdax write initiates a memcpy to the storage device to the
							    ^^ from

>    caller's buffer. The flags value for ->iomap_begin will be
>    IOMAP_DAX | IOMAP_WRITE with any combination of the following
>    enhancements:
> 
>        * IOMAP_NOWAIT: Write if mapping data are already in memory.
>          Does not initiate other I/O or block on filesystem locks.
> 
>        * IOMAP_OVERWRITE_ONLY: Allocating blocks and zeroing partial
>          blocks is not allowed. The entire file range must to map to
							     ^^ extra "to"

>          a single written or unwritten extent. The file I/O range
>          must be aligned to the filesystem block size.
> 
>    Callers commonly hold i_rwsem in exclusive mode.
> 
>     mmap Faults
> 
>    The dax_iomap_fault function handles read and write faults to
>    fsdax storage. For a read fault, IOMAP_DAX | IOMAP_FAULT will be
>    passed as the flags argument to ->iomap_begin. For a write fault,
>    IOMAP_DAX | IOMAP_FAULT | IOMAP_WRITE will be passed as the flags
>    argument to ->iomap_begin.
> 
>    Callers commonly hold the same locks as they do to call their
>    iomap pagecache counterparts.
> 
>     Truncation, fallocate, and Unsharing
> 
>    For fsdax files, the following functions are provided to replace
>    their iomap pagecache I/O counterparts. The flags argument to
>    ->iomap_begin are the same as the pagecache counterparts, with
>    IOMAP_DIO added.
	  ^^^ IOMAP_DAX?

>        * dax_file_unshare
> 
>        * dax_zero_range
> 
>        * dax_truncate_page
> 
>    Callers commonly hold the same locks as they do to call their
>    iomap pagecache counterparts.

>   How to Convert to iomap?
> 
>    First, add #include <linux/iomap.h> from your source code and add
>    select FS_IOMAP to your filesystem's Kconfig option. Build the
>    kernel, run fstests with the -g all option across a wide variety
>    of your filesystem's supported configurations to build a baseline
>    of which tests pass and which ones fail.
> 
>    The recommended approach is first to implement ->iomap_begin (and
>    ->iomap->end if necessary) to allow iomap to obtain a read-only
       ^^^^ ->iomap_end

<snip>

>    Most likely at this point, the buffered read and write paths will
>    still to be converted. The mapping functions should all work
          ^^ need to be

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

