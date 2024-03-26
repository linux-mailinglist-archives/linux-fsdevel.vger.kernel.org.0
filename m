Return-Path: <linux-fsdevel+bounces-15367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0370788D105
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 23:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80EF321DCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8CC13E030;
	Tue, 26 Mar 2024 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HfwaRW/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tfvi3RyG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HfwaRW/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tfvi3RyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DD38F86;
	Tue, 26 Mar 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492346; cv=none; b=SIxVG81W1907ewZhzlc6nxxyj1/R4dyZUScI7nv3lhkjvfeQL+D+80aAni7LuTCVO6OlI7BAvb3NWTfvOj8Eeve84jYdD9KFf1aJ//yp8zqaGsSRhNl4Heub5FqGZMiioLWF0c+KrOo85ZG+EMj/jFaBRo1GbWWO6Y/aa8g2kB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492346; c=relaxed/simple;
	bh=KQZsXEYrLq0J0F0KnTh5953NbVS39uM+gfRJz5bU2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRgMvyaL3iXaBkisq7gzqkT2bsmt43aOo1YDsdxm1+22TQ3GfyNMut/lcFShg3Ult13ID9A6kosUuZGzVgOo7ueh8YQuOEcHKJa0qkyKTxzioKffcZWVNTkseWU1f1unJhRKj10X7ZoPXwnR1TV2zkq4GlROv1lM9n8fbHQ9w1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HfwaRW/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tfvi3RyG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HfwaRW/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tfvi3RyG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 478B338148;
	Tue, 26 Mar 2024 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711492342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBeh/mkPb1KeQp3wbzFrJcTRkywewG+5OgmGrYZt7vQ=;
	b=HfwaRW/s9j//vBFBf1IIRXYKKvMeEYvJildyEmqzjvvzyMKX3diFgD8BqNrwE0T6w6rWCo
	+gwWODv/RMj/vZ+L4SdWBk6I9pdKwuiYhU3dgTtEE2eqeshQsyjvwu2+k9e/mwXqN6Iq89
	Q5tHc3ZEwb5Wt1oE6L2lkd0epIJSzH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711492342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBeh/mkPb1KeQp3wbzFrJcTRkywewG+5OgmGrYZt7vQ=;
	b=Tfvi3RyGkUPYHZ1//LQi3Vy+9ScXSjipavw7A2I8XezCM3ga6DqHSRPbisWdACUIt1NOwh
	Z86Q3c7eJzafGgBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711492342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBeh/mkPb1KeQp3wbzFrJcTRkywewG+5OgmGrYZt7vQ=;
	b=HfwaRW/s9j//vBFBf1IIRXYKKvMeEYvJildyEmqzjvvzyMKX3diFgD8BqNrwE0T6w6rWCo
	+gwWODv/RMj/vZ+L4SdWBk6I9pdKwuiYhU3dgTtEE2eqeshQsyjvwu2+k9e/mwXqN6Iq89
	Q5tHc3ZEwb5Wt1oE6L2lkd0epIJSzH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711492342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBeh/mkPb1KeQp3wbzFrJcTRkywewG+5OgmGrYZt7vQ=;
	b=Tfvi3RyGkUPYHZ1//LQi3Vy+9ScXSjipavw7A2I8XezCM3ga6DqHSRPbisWdACUIt1NOwh
	Z86Q3c7eJzafGgBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 397E313587;
	Tue, 26 Mar 2024 22:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id f/K/DfZMA2ZmEwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 22:32:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DB87FA0812; Tue, 26 Mar 2024 23:32:13 +0100 (CET)
Date: Tue, 26 Mar 2024 23:32:13 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs,block: yield devices early
Message-ID: <20240326223213.ytrsxxjsq3twfsxy@quack3>
References: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.44
X-Spamd-Result: default: False [-1.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.64)[82.40%]
X-Spam-Flag: NO

On Tue 26-03-24 13:47:22, Christian Brauner wrote:
> Currently a device is only really released once the umount returns to
> userspace due to how file closing works. That ultimately could cause
> an old umount assumption to be violated that concurrent umount and mount
> don't fail. So an exclusively held device with a temporary holder should
> be yielded before the filesystem is gone. Add a helper that allows
> callers to do that. This also allows us to remove the two holder ops
> that Linus wasn't excited about.
> 
> Fixes: f3a608827d1f ("bdev: open block device as files") # mainline only
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
...
> @@ -1012,6 +1005,29 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
>  }
>  EXPORT_SYMBOL(bdev_file_open_by_path);
>  
> +static inline void bd_yield_claim(struct file *bdev_file)
> +{
> +	struct block_device *bdev = file_bdev(bdev_file);
> +	struct bdev_inode *bd_inode = BDEV_I(bdev_file->f_mapping->host);
> +	void *holder = bdev_file->private_data;
> +
> +	lockdep_assert_held(&bdev->bd_disk->open_mutex);
> +
> +	if (WARN_ON_ONCE(IS_ERR_OR_NULL(holder)))
> +		return;
> +
> +	if (holder != bd_inode) {
> +		bdev_yield_write_access(bdev_file);

Hum, what if we teached bdev_yield_write_access() about special bd_inode
holder and kept bdev_yield_write_access() and bd_yield_claim() separate as
they were before this patch? IMHO it would make code a bit more
understandable. Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

