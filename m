Return-Path: <linux-fsdevel+bounces-10004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92605846F73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8A828CB02
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4C13EFEA;
	Fri,  2 Feb 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iZxTg7Vf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ntVWoMxv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iZxTg7Vf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ntVWoMxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E3C101CA;
	Fri,  2 Feb 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874690; cv=none; b=cYHXTpiEyVwNsbbhzvYHjR7yCIAiaOWRLgppCWysJiQqYQ0o0qnpTU8waNTqaoNXtK8bZIyrOZmTXc01t1dHBGsW9xShvMiWjWgMg007KxX3/dfEXISnEZF/eO0+gkbwZ32tzVAF/7WrmkPrM0N+y7viVcjOJq55llUcWNCI73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874690; c=relaxed/simple;
	bh=Q0FmQ7VPsysWLHoPCqtnkOoLIS8+3K60C8LF76KFhhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICuXJqlV6U2piQTD0e1hdBrtfvqhsZ67rwNJAPW6XYlUoTqVCXPpFsKrST2P02d0RL6QIredPXMOTg3cWGdOiNd+6aZdg6w9RhKWcYwmsUFzaopCK8fmF9ne36cGDY+eEmCogV/pwHtZ9E7Jcj2LK/yBG5HRf9M0cyQDbRxbgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iZxTg7Vf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ntVWoMxv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iZxTg7Vf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ntVWoMxv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BD3021D48;
	Fri,  2 Feb 2024 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706874687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEgYQgXGU80MCZQa2lqoL6yQw9jKysV7EDbhZ2hhwqI=;
	b=iZxTg7VfJ2E/pPF4Wc088c3ltNcuxU8mJy3qrlcA3TvZ/7IwnFWY1D2Ci5xFAu09eVqufj
	spt4ty9JIOzbpRQ6+HSFQUxZgqrngodkRqgmbRlLlXws2H2sos9Q+MVovwr/gWg72i52Du
	ieSjt66x+K5ouD9F+Aw7X2pRwsthFGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706874687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEgYQgXGU80MCZQa2lqoL6yQw9jKysV7EDbhZ2hhwqI=;
	b=ntVWoMxv0fiahCiso0Oyr9OpoC7Ovn+sE2o+QmDUqaRxwtJzQ87fJgY75Lw8xTS13Z8WXk
	uWQRU8kQxedmQ0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706874687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEgYQgXGU80MCZQa2lqoL6yQw9jKysV7EDbhZ2hhwqI=;
	b=iZxTg7VfJ2E/pPF4Wc088c3ltNcuxU8mJy3qrlcA3TvZ/7IwnFWY1D2Ci5xFAu09eVqufj
	spt4ty9JIOzbpRQ6+HSFQUxZgqrngodkRqgmbRlLlXws2H2sos9Q+MVovwr/gWg72i52Du
	ieSjt66x+K5ouD9F+Aw7X2pRwsthFGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706874687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEgYQgXGU80MCZQa2lqoL6yQw9jKysV7EDbhZ2hhwqI=;
	b=ntVWoMxv0fiahCiso0Oyr9OpoC7Ovn+sE2o+QmDUqaRxwtJzQ87fJgY75Lw8xTS13Z8WXk
	uWQRU8kQxedmQ0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00018139AB;
	Fri,  2 Feb 2024 11:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZKVOz7XvGWydQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 02 Feb 2024 11:51:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9981BA0809; Fri,  2 Feb 2024 12:51:26 +0100 (CET)
Date: Fri, 2 Feb 2024 12:51:26 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240202115126.mcp5wpha6mniaybs@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
 <20240201110858.on47ef4cmp23jhcv@quack3>
 <20240201-lauwarm-kurswechsel-75ed33e41ba2@brauner>
 <20240201173631.pda5jvi573hevpil@quack3>
 <20240202-umworben-hausdach-0d23c6b08f35@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-umworben-hausdach-0d23c6b08f35@brauner>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 02-02-24 12:45:49, Christian Brauner wrote:
> On Thu, Feb 01, 2024 at 06:36:31PM +0100, Jan Kara wrote:
> > On Thu 01-02-24 17:16:02, Christian Brauner wrote:
> > > On Thu, Feb 01, 2024 at 12:08:58PM +0100, Jan Kara wrote:
> > > > On Tue 23-01-24 14:26:48, Christian Brauner wrote:
> > > > > Make it possible to detected a block device that was opened with
> > > > > restricted write access solely based on its file operations that it was
> > > > > opened with. This avoids wasting an FMODE_* flag.
> > > > > 
> > > > > def_blk_fops isn't needed to check whether something is a block device
> > > > > checking the inode type is enough for that. And def_blk_fops_restricted
> > > > > can be kept private to the block layer.
> > > > > 
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > 
> > > > I don't think we need def_blk_fops_restricted. If we have BLK_OPEN_WRITE
> > > > file against a bdev with bdev_writes_blocked() == true, we are sure this is
> > > > the handle blocking other writes so we can unblock them in
> > > > bdev_yield_write_access()...
> > 
> > ...
> > 
> > > -       if (mode & BLK_OPEN_RESTRICT_WRITES)
> > > +       if (mode & BLK_OPEN_WRITE) {
> > > +               if (bdev_writes_blocked(bdev))
> > > +                       bdev_unblock_writes(bdev);
> > > +               else
> > > +                       bdev->bd_writers--;
> > > +       }
> > > +       if (bdev_file->f_op == &def_blk_fops_restricted)
> > 
> > Uh, why are you leaving def_blk_fops_restricted check here? I'd expect you
> > can delete def_blk_fops_restricted completely...
> 
> Copy-paste error when dumping this into here. Here's the full patch.

Yes, the full patch looks good to me! Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

