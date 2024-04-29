Return-Path: <linux-fsdevel+bounces-18112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A702C8B5D9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F29B2BD6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299058565D;
	Mon, 29 Apr 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PRmbeGke";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdx9pgDW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tGoa0Lh8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c597n5tO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C977F10;
	Mon, 29 Apr 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403922; cv=none; b=OE5xCpxWpc/C1LHEfAtDIC3I4eH+7NVd6DTDz0zvJmrOYTH7V4yAp98judaYZx/Ys4ppGk1yePnmfP+zPpO90H/oKnAe7zkpcXz1PaqShKa7oXt35raJAjREPIiPW3n3Tb/1XCcAzlhfzhlf1x7x2zCFPJBRdFLHpM//i+Wh+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403922; c=relaxed/simple;
	bh=9BSrIGMt7GgU3+M07CHV10/InLf/tZrxzxknIJ9QNno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIfPJrPXvB+dPUUGw47CbRy056v49DLG9rJ12vR7b2kTl+CXDlfpPMZPlXrgE2fuxqKW4Q2j04XKobuCy5dF82lS5juzIU1hA8Z/qUOg4DJGniuO7hKUqfgkbLS+C4zOEOJU5HM3FtQoK+cRmpOVTxSiBLhYU38/QN2A0K0cshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PRmbeGke; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdx9pgDW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tGoa0Lh8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c597n5tO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D66233389C;
	Mon, 29 Apr 2024 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714403919;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8b75GpkVFQOdY4wZRWGIsjV3aXBX+Qd/nRtPV9BlNw=;
	b=PRmbeGkeifRWDpqo4ck1nUZbkwHbMzTbY1KItDl6JZyC+LcGGXpqjfDRCr+SVOhPKmVrKZ
	rwdAlR2BS5v0t7IiBrOyc9eK172ZJuaaX4ecEEJH6NjGngHrryXY6LhwE9XJimNoQdZoQY
	zgBtzAdNPLGELktKBM1KrLbtU9D3oyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714403919;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8b75GpkVFQOdY4wZRWGIsjV3aXBX+Qd/nRtPV9BlNw=;
	b=kdx9pgDWkJUf+sEe3Z3hKBbZI5uYIVvdnCW5fE/uINq4Mwx4SwWz5RwpOyozz8inMbnyoz
	Rwk5UbOTZTguo5DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tGoa0Lh8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=c597n5tO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714403918;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8b75GpkVFQOdY4wZRWGIsjV3aXBX+Qd/nRtPV9BlNw=;
	b=tGoa0Lh8ROLyUPeHsF3Tdz+huTXeNboCWaGxFUy4yjjv+kAdf0bP1SU3TjzNCuxkjGoZq3
	TViVgsOPFTVnviw7nRgCQrUGAoop//cHM/r1m/KympSu4Ift03995PCA/FZDPGTPTDreLN
	ogTb9n6leDZBS83JqRAEAv+f1BRDaLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714403918;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8b75GpkVFQOdY4wZRWGIsjV3aXBX+Qd/nRtPV9BlNw=;
	b=c597n5tOZZHFb58CgtAbcEJ2U5m0pq1vntZ5MrweQUDxJTxpl4/W1X0DGz+s9Wossp0MFJ
	D4joEON5d7HNF2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BADF8138A7;
	Mon, 29 Apr 2024 15:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t2laLU66L2apGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 15:18:38 +0000
Date: Mon, 29 Apr 2024 17:11:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/7] btrfs_get_dev_args_from_path(): don't call
 set_blocksize()
Message-ID: <20240429151124.GC2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240427210920.GR2118490@ZenIV>
 <20240427211230.GF1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427211230.GF1495312@ZenIV>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D66233389C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Sat, Apr 27, 2024 at 10:12:30PM +0100, Al Viro wrote:
> We don't have bdev opened exclusive there.  And I'm rather dubious
> about the need to do set_blocksize() anywhere in btrfs, to be
> honest - there's some access to page cache of underlying block
> devices in there, but it's nowhere near the hot paths, AFAICT.

Long time ago we fixed a bug that involved set_blocksize(), 6f60cbd3ae44
("btrfs: access superblock via pagecache in scan_one_device").
Concurrent access from scan, mount and mkfs could interact and some
writes would be dropped, but the argument was rather not to use
set_blocksize.

I do not recall all the details but I think that the problem was when it
was called in the middle of the other operation in progress. The only
reason it's ever called is for the super block read and to call it
explicitly from our code rather than rely on some eventual call from
block layer.  But it's more than 10 years ago and things have changed,
we don't use buffer_head for superblock anymore.

> In any case, btrfs_get_dev_args_from_path() only needs to read
> the on-disk superblock and copy several fields out of it; all
> callers are only interested in devices that are already opened
> and brought into per-filesystem set, so setting the block size
> is redundant for those and actively harmful if we are given
> a pathname of unrelated device.

Calling set_blocksize on already opened devices will avoid the
scan/mount/mkfs interactions so this seems safe.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/btrfs/volumes.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f15591f3e54f..43af5a9fb547 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -482,10 +482,12 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
>  
>  	if (flush)
>  		sync_blockdev(bdev);
> -	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
> -	if (ret) {
> -		fput(*bdev_file);
> -		goto error;
> +	if (holder) {
> +		ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);

The subject mentions a different function, you're removing it from
btrfs_get_bdev_and_sb() not btrfs_get_dev_args_from_path().

> +		if (ret) {
> +			fput(*bdev_file);
> +			goto error;
> +		}
>  	}
>  	invalidate_bdev(bdev);
>  	*disk_super = btrfs_read_dev_super(bdev);
> @@ -498,6 +500,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
>  	return 0;
>  
>  error:
> +	*disk_super = NULL;
>  	*bdev_file = NULL;
>  	return ret;
>  }
> -- 
> 2.39.2
> 

