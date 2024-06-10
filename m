Return-Path: <linux-fsdevel+bounces-21364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80848902B84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 00:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1216E282A33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48E215098E;
	Mon, 10 Jun 2024 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XG3C5uZG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+INlI+K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XG3C5uZG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+INlI+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746B6AAD;
	Mon, 10 Jun 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058321; cv=none; b=HQBWPFMn8Jpnw3kC7No8bMLi8Bqv4Z3+5fjvqWBufuodqm8BreSL4ovJgRqFL+1zdzPTUYLL5m5EsKpMl1W8KeqnLnj+HNQfTOW+6VzaXqaGJb+kUb+6VkZmjJz8sb1D3Dw2u6J21LyvK/xQrqE5zNqQsQgAqtQ9pkpkC8nFJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058321; c=relaxed/simple;
	bh=Y9mlmviA90FzkYQuP4MfYC57idhQL75amxzfIX3EXG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz9/YMCZF3+SKVTxy2UpX6FKf/1OPq/4vcRPOAwxTULbvMnSna4s0JU+VuZimdaUpBs5H+FVple+J1J2TP33lRO2Hvl1WVcx+OhWkoJJ/RIOQ6izzea7BVXxeNYRaC9uSbjrHCJFqqPTq/2ISUFjvFsoGmx4APtFeQLzDOsKveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XG3C5uZG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+INlI+K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XG3C5uZG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+INlI+K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 407B4201C7;
	Mon, 10 Jun 2024 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718058317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArmtGvxIe+kcwY0UlCoojZz8I0YaKyR3KQ9ejBaxqvM=;
	b=XG3C5uZGSacqWFFGXuYpX99bgM1alHWerNBRRPsu2TAWWMXi07peAg7ja77ayMCNfax0ab
	FfW7DgRGgu3RdZHXW43+KuFfVXixmw0tv65kgtH7qus877bWsjUJQeMCT3m20N/lXWCX/I
	nMzQmyMnxWZ8lhGsTmnuFEeSpoXwQHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718058317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArmtGvxIe+kcwY0UlCoojZz8I0YaKyR3KQ9ejBaxqvM=;
	b=7+INlI+K+PO8h0DOfNxZyj1aSVoRrQQuLY4FbxBgZAlTESMQ6H3KdMc9Bbwq1a5LxhlYO8
	X+WJ00HBNY1cPgCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XG3C5uZG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7+INlI+K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718058317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArmtGvxIe+kcwY0UlCoojZz8I0YaKyR3KQ9ejBaxqvM=;
	b=XG3C5uZGSacqWFFGXuYpX99bgM1alHWerNBRRPsu2TAWWMXi07peAg7ja77ayMCNfax0ab
	FfW7DgRGgu3RdZHXW43+KuFfVXixmw0tv65kgtH7qus877bWsjUJQeMCT3m20N/lXWCX/I
	nMzQmyMnxWZ8lhGsTmnuFEeSpoXwQHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718058317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArmtGvxIe+kcwY0UlCoojZz8I0YaKyR3KQ9ejBaxqvM=;
	b=7+INlI+K+PO8h0DOfNxZyj1aSVoRrQQuLY4FbxBgZAlTESMQ6H3KdMc9Bbwq1a5LxhlYO8
	X+WJ00HBNY1cPgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30C0A13A7F;
	Mon, 10 Jun 2024 22:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ednjC019Z2ZHQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Jun 2024 22:25:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4A8FA0889; Tue, 11 Jun 2024 00:25:12 +0200 (CEST)
Date: Tue, 11 Jun 2024 00:25:12 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <20240610222512.onus2iyje7fq3ic3@quack3>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <ZmVNblggFRgR8bnJ@infradead.org>
 <20240609155506.GT52987@frogsfrogsfrogs>
 <20240610141808.vdsflgcbjmgc37dt@quack3>
 <20240610215928.GV52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610215928.GV52987@frogsfrogsfrogs>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 407B4201C7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,infradead.org,gmail.com,vger.kernel.org,fromorbit.com,kernel.org,linux.ibm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]

On Mon 10-06-24 14:59:28, Darrick J. Wong wrote:
> > >    These struct kiocb flags are significant for buffered I/O with
> > >    iomap:
> > > 
> > >        * IOCB_NOWAIT: Only proceed with the I/O if mapping data are
> > >          already in memory, we do not have to initiate other I/O, and
> > >          we acquire all filesystem locks without blocking. Neither
> > >          this flag nor its definition RWF_NOWAIT actually define what
> > >          this flag means, so this is the best the author could come
> > >          up with.
> > 
> > RWF_NOWAIT is a performance feature, not a correctness one, hence the
> > meaning is somewhat vague. It is meant to mean "do the IO only if it
> > doesn't involve waiting for other IO or other time expensive operations".
> > Generally we translate it to "don't wait for i_rwsem, page locks, don't do
> > block allocation, etc." OTOH we don't bother to specialcase internal
> > filesystem locks (such as EXT4_I(inode)->i_data_sem) and we get away with
> > it because blocking on it under constraints we generally perform RWF_NOWAIT
> > IO is exceedingly rare.
> 
> I hate this flag's undocumented nature.  It now makes *documenting*
> things around it hard.  How about:
> 
> "IOCB_NOWAIT: Neither this flag nor its associated definition RWF_NOWAIT
> actually specify what this flag means.  Community members seem to think
> that it means only proceed with the I/O if it doesn't involve waiting
> for expensive operations.  XFS and ext4 appear to reject the IO unless
> the mapping data are already in memory, the filesystem does not have to
> initiate other I/O, and the kernel can acquire all filesystem locks
> without blocking."

I guess this is good enough :)

> > >     Direct Writes
> > > 
> > >    A direct I/O write initiates a write I/O to the storage device to
> > >    the caller's buffer. Dirty parts of the pagecache are flushed to
> > >    storage before initiating the write io. The pagecache is
> > >    invalidated both before and after the write io. The flags value
> > >    for ->iomap_begin will be IOMAP_DIRECT | IOMAP_WRITE with any
> > >    combination of the following enhancements:
> > > 
> > >        * IOMAP_NOWAIT: Write if mapping data are already in memory.
> > >          Does not initiate other I/O or block on filesystem locks.
> > > 
> > >        * IOMAP_OVERWRITE_ONLY: Allocating blocks and zeroing partial
> > >          blocks is not allowed. The entire file range must to map to
> > 							     ^^ extra "to"
> > 
> > >          a single written or unwritten extent. The file I/O range
> > >          must be aligned to the filesystem block size.
> > 
> > This seems to be XFS specific thing? At least I don't see anything in
> > generic iomap code depending on this?
> 
> Hmm.  XFS bails out if the mapping is unwritten and the directio write
> range isn't aligned to the fsblock size.  I think the reason for that is
> because we'd have to zero the unaligned regions outside of the write
> range, and xfs can't do that without synchronizing.  (Or we didn't think
> that was common enough to bother with the code complexity.)
> 
> "The file I/O range must be aligned to the filesystem block size
> if the filesystem supports unwritten mappings but cannot zero unaligned
> regions without exposing stale contents."?

Sounds good.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

