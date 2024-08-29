Return-Path: <linux-fsdevel+bounces-27782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C415963F91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097201F25C32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D318DF60;
	Thu, 29 Aug 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m1LRORsd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XwUj/2C7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m1LRORsd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XwUj/2C7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE418D649;
	Thu, 29 Aug 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922615; cv=none; b=TD2fyeM+HLCHoTUEbnevR+4Y1RDBM+sn0DL59bX6/ShQy2w9y5XV2qZeW4x73raWEz0FT4bbB5PWYuo46ago4/3mKVct6M7ABFBBUn1mROoEKETN4kIP1PB0OjdPUURu3Tsj2CsVWrKu/U/sIgIQGP/nPfqmr2/6qo+V3647tLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922615; c=relaxed/simple;
	bh=MEcRl9ZhNrQZozxSU0zQS8bPAunwYULwwQ6bqjpUt/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg9mv73Q8AYQi5WvCT+LCNZQQ7m4pQ2fZal2lr50bqX1ETC8zKqt2x3CNh96cWbvbAEGCrFf8PyNNPV0ISLre6Zoez9UfhYqZeMH/hSWkCiWjJmDRIbmTWedSssIZ+XDLqlcMFZtykHIU5MwRiqOJ2GNHhky4FBYAk8CkD35Tt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m1LRORsd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XwUj/2C7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m1LRORsd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XwUj/2C7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A21021290;
	Thu, 29 Aug 2024 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724922611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+wRzqzeOftsxEeIDfwEbJpnsPlpLcci829W2RncfvI=;
	b=m1LRORsd19qLzzaTDDXVLREufeiv1QdcYDUD3SA5zUtAN0bQ1Y7TP4WjRYcaBULtDM7afu
	Q0tJW3QmNR2jDugns/HY24spVRTY84LfqKhNw7GeTm05gelxkGFjubSYodmBuegBFIVY3l
	C8tjn+a24U9eQtb/h+W2ai8YhNBm0+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724922611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+wRzqzeOftsxEeIDfwEbJpnsPlpLcci829W2RncfvI=;
	b=XwUj/2C7kyOcEsuiDQakj61nXJ+UyPoYZqgx3ToFVB/TACmFXItLs6VevBP+we1LuWFrHu
	7Z8EfMGOUfAUZ9CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724922611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+wRzqzeOftsxEeIDfwEbJpnsPlpLcci829W2RncfvI=;
	b=m1LRORsd19qLzzaTDDXVLREufeiv1QdcYDUD3SA5zUtAN0bQ1Y7TP4WjRYcaBULtDM7afu
	Q0tJW3QmNR2jDugns/HY24spVRTY84LfqKhNw7GeTm05gelxkGFjubSYodmBuegBFIVY3l
	C8tjn+a24U9eQtb/h+W2ai8YhNBm0+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724922611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+wRzqzeOftsxEeIDfwEbJpnsPlpLcci829W2RncfvI=;
	b=XwUj/2C7kyOcEsuiDQakj61nXJ+UyPoYZqgx3ToFVB/TACmFXItLs6VevBP+we1LuWFrHu
	7Z8EfMGOUfAUZ9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D4C613408;
	Thu, 29 Aug 2024 09:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MmTBFvM60Ga7bAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 09:10:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D2A3A0965; Thu, 29 Aug 2024 11:10:07 +0200 (CEST)
Date: Thu, 29 Aug 2024 11:10:07 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org,
	corbet@lwn.net, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, kernel-dev@igalia.com,
	kernel@gpiccoli.net, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V5] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Message-ID: <20240829091007.swglkuf2ybpexgs6@quack3>
References: <20240828145045.309835-1-gpiccoli@igalia.com>
 <20240828162753.GO6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828162753.GO6043@frogsfrogsfrogs>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 28-08-24 09:27:53, Darrick J. Wong wrote:
> On Wed, Aug 28, 2024 at 11:48:58AM -0300, Guilherme G. Piccoli wrote:
> > Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
> > devices") added a Kconfig option along with a kernel command-line tuning to
> > control writes to mounted block devices, as a means to deal with fuzzers like
> > Syzkaller, that provokes kernel crashes by directly writing on block devices
> > bypassing the filesystem (so the FS has no awareness and cannot cope with that).
> > 
> > The patch just missed adding such kernel command-line option to the kernel
> > documentation, so let's fix that.
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Looks good to me now,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Fun unrelated question: do we want to turn on bdev_allow_write_mounted
> if lockdown is enabled?  In that kind of environment, we don't want to
> allow random people to scribble, given how many weird ext4 bugs we've
> had to fix due to syzbot.

It would be desirable. But it will break some administrative tasks
currently so I'm not sure users are really prepared for that? But with
recent util-linux those should be mostly limited to filesystem-specific
tooling issues (tune2fs is definitely broken and needs new kernel
interfaces to be able to work, I think resize2fs is also broken but that
should be fixable within e2fsprogs though it requires larger refactoring
AFAIR).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

