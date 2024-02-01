Return-Path: <linux-fsdevel+bounces-9911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7076845EA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7B428EB02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECA63CA0;
	Thu,  1 Feb 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nY399TsQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RT/Q78Yj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nY399TsQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RT/Q78Yj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0785C04A;
	Thu,  1 Feb 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808995; cv=none; b=Hf6K73UkW4d9m9V/vqRO+6lCNeQPfw5OcTgHhogBVjf3zOsuPI+28WCH7ZhnrWaXYrUsL3qAZnuwuTFnDYaIMaBN9o+d4IUxv7W4VkSvCk3xhe3nNpIA9kIxJTwa5RFURoxb92dPVonSmFJS0dqhBoqSQyiURjN8pAbzULMyx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808995; c=relaxed/simple;
	bh=TBmGaKe0krDiygVUYxtlPNQ4KktkWuvWJWggeWjjYo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbCx7nLQocxGgCpcvP1qb78ATDYnsvSB/5Ry5MZzAdvYmHfvDzG/tzEIXvh5ZBlP9x2NRqD/MI/sSQhmPe9GTH28PDEzRpBnkXde3ni3p8yN53+W51LT3D4HnQxfGeVZGofHUx1fLCwEsOHHh1yr7L9USb9j4E1rqPrGBJe8pTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nY399TsQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RT/Q78Yj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nY399TsQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RT/Q78Yj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 38E731FBF0;
	Thu,  1 Feb 2024 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706808992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jihreb443vt7QH9UloB81ix+EeA28Som6yjedwgNsXw=;
	b=nY399TsQbZYg6Eye277HGPLHR5bngfIgDjWBq0V47Vy2sqLmgF13MTi37VwpOVA06ah1Lf
	/o8n7BSe1dgZKAl82SdSwCjaxB3OQOB2v5iLzYQA5CQy6Xq4U4Q6kRYJ6Ey9AMXEAtMTFS
	oXkxTrwOUsKlq5MpllbMJA+IdmSS3zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706808992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jihreb443vt7QH9UloB81ix+EeA28Som6yjedwgNsXw=;
	b=RT/Q78YjpbrMkr8vBhVbumrldMjonPivcaxo+h+q7wUr3Sg/mX7AaDcmu/5X0vWviC+yRo
	JQr+nQwwabV9yCCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706808992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jihreb443vt7QH9UloB81ix+EeA28Som6yjedwgNsXw=;
	b=nY399TsQbZYg6Eye277HGPLHR5bngfIgDjWBq0V47Vy2sqLmgF13MTi37VwpOVA06ah1Lf
	/o8n7BSe1dgZKAl82SdSwCjaxB3OQOB2v5iLzYQA5CQy6Xq4U4Q6kRYJ6Ey9AMXEAtMTFS
	oXkxTrwOUsKlq5MpllbMJA+IdmSS3zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706808992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jihreb443vt7QH9UloB81ix+EeA28Som6yjedwgNsXw=;
	b=RT/Q78YjpbrMkr8vBhVbumrldMjonPivcaxo+h+q7wUr3Sg/mX7AaDcmu/5X0vWviC+yRo
	JQr+nQwwabV9yCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E85D139AB;
	Thu,  1 Feb 2024 17:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ylViC6DWu2W3JwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 17:36:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B184BA0809; Thu,  1 Feb 2024 18:36:31 +0100 (CET)
Date: Thu, 1 Feb 2024 18:36:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240201173631.pda5jvi573hevpil@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
 <20240201110858.on47ef4cmp23jhcv@quack3>
 <20240201-lauwarm-kurswechsel-75ed33e41ba2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-lauwarm-kurswechsel-75ed33e41ba2@brauner>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.11)[66.33%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.29

On Thu 01-02-24 17:16:02, Christian Brauner wrote:
> On Thu, Feb 01, 2024 at 12:08:58PM +0100, Jan Kara wrote:
> > On Tue 23-01-24 14:26:48, Christian Brauner wrote:
> > > Make it possible to detected a block device that was opened with
> > > restricted write access solely based on its file operations that it was
> > > opened with. This avoids wasting an FMODE_* flag.
> > > 
> > > def_blk_fops isn't needed to check whether something is a block device
> > > checking the inode type is enough for that. And def_blk_fops_restricted
> > > can be kept private to the block layer.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > I don't think we need def_blk_fops_restricted. If we have BLK_OPEN_WRITE
> > file against a bdev with bdev_writes_blocked() == true, we are sure this is
> > the handle blocking other writes so we can unblock them in
> > bdev_yield_write_access()...

...

> -       if (mode & BLK_OPEN_RESTRICT_WRITES)
> +       if (mode & BLK_OPEN_WRITE) {
> +               if (bdev_writes_blocked(bdev))
> +                       bdev_unblock_writes(bdev);
> +               else
> +                       bdev->bd_writers--;
> +       }
> +       if (bdev_file->f_op == &def_blk_fops_restricted)

Uh, why are you leaving def_blk_fops_restricted check here? I'd expect you
can delete def_blk_fops_restricted completely...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

