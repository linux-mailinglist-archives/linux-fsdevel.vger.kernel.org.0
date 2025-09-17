Return-Path: <linux-fsdevel+bounces-61951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A5B807BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DA1BC2832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D64333A90;
	Wed, 17 Sep 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y90Y8EaR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3plVSZ8s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y90Y8EaR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3plVSZ8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4B220F5C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122438; cv=none; b=udpmKNyoJGMcBSS0v71+VMoeWqi/5DYSBsd4urk/s27uP6fKTGTlpDqKymgNqPMoZiaE6Am0DLUQ0fRLTm4mSpVW3bnmPLOHYaBSol+RE2Rm9ga7/FSibPWY0uJw+Qy/pltM/HnANkxKWoUnFPTto+iMRIEZy/rLS+RK3xQkZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122438; c=relaxed/simple;
	bh=/LO4PR4MHCg4VJdLZXiWotYb16n75l2OrLKP76EGfx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg5AkRhvUPrZrjr/Gkia9Ogdzrj8UP1epgZnjC0NB58xGpO79gQQse7oxuvXqTOgpv8Gfkwgm2uMNXNruAukllLvdX35Z2TQM3pUnS5A3CMAwhnC+LFJtD+GGaSxF1OoP1t2XLw6M4dcY4G7OJaT5nWLLIzFByCg/FtyQBCzgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y90Y8EaR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3plVSZ8s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y90Y8EaR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3plVSZ8s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72046206BE;
	Wed, 17 Sep 2025 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758122434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O30QVKalEyJcj8v2V+u+N14GAJfliqbqZqVd3cyCdF8=;
	b=y90Y8EaRXeKbmQM8CZaMvsN0nOr1ZJi0pOTV6rxulwfLrxW2ebeQPIrpTpHChGA9HPsyl6
	4j8CkR/QqaXXR14Y7ovf+Npsik/u/nS3pMMjRFl+3K+z+69duwT29VWceUstsR5/aT2Rj3
	UlccGbg79S7FYmt/YNMGxMdcKRCqvqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758122434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O30QVKalEyJcj8v2V+u+N14GAJfliqbqZqVd3cyCdF8=;
	b=3plVSZ8sUJRShcLCni69PgPQMfIgPE2fk0dU+D6nLxYgB9b3ZOJ1jL/3cpKKq3x+HjMgQQ
	Qwr2+/UXX40imqDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758122434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O30QVKalEyJcj8v2V+u+N14GAJfliqbqZqVd3cyCdF8=;
	b=y90Y8EaRXeKbmQM8CZaMvsN0nOr1ZJi0pOTV6rxulwfLrxW2ebeQPIrpTpHChGA9HPsyl6
	4j8CkR/QqaXXR14Y7ovf+Npsik/u/nS3pMMjRFl+3K+z+69duwT29VWceUstsR5/aT2Rj3
	UlccGbg79S7FYmt/YNMGxMdcKRCqvqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758122434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O30QVKalEyJcj8v2V+u+N14GAJfliqbqZqVd3cyCdF8=;
	b=3plVSZ8sUJRShcLCni69PgPQMfIgPE2fk0dU+D6nLxYgB9b3ZOJ1jL/3cpKKq3x+HjMgQQ
	Qwr2+/UXX40imqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60EA4137C3;
	Wed, 17 Sep 2025 15:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9HdfF8LRymgeHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Sep 2025 15:20:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5BF9A077E; Wed, 17 Sep 2025 17:20:29 +0200 (CEST)
Date: Wed, 17 Sep 2025 17:20:29 +0200
From: Jan Kara <jack@suse.cz>
To: Pavel Emelyanov <xemul@scylladb.com>
Cc: linux-fsdevel@vger.kernel.org, 
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>
Subject: Re: [PATCH] inode: Relax RWF_NOWAIT restriction for EINTR in
 file_modified_flags()
Message-ID: <5pzb4pxshhgytfki6s52jhnuyxa3hgsyzhcwkdz4qlvpkwimwp@ngsfvqn7i4yc>
References: <20250912142626.4018-1-xemul@scylladb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912142626.4018-1-xemul@scylladb.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hello!

On Fri 12-09-25 17:26:26, Pavel Emelyanov wrote:
> When performing AIO write, the file_modified_flags() function checks
> whether or not to update inode times. In case update is needed and iocb
> carries the RWF_NOWAIT flag, the check return EINTR error that quickly
> propagates into iocb completion without doing any IO.
> 
> This restriction effectively prevents doing AIO writes with nowait flag,
> as file modifications really imply time update.
> 
> However, in the filesystem is mounted with SB_LAZYTIME flag, this
> restriction can be raised, as updating inode times should happen in a
> lazy manner, by marking the inode dirty and postponing on-disk updates
> that may require locking.
> 
> Signed-off-by: Pavel Emelyanov <xemul@scylladb.com>
...
> diff --git a/fs/inode.c b/fs/inode.c
> index 01ebdc40021e..d65584d25a00 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2369,7 +2369,7 @@ static int file_modified_flags(struct file *file, int flags)
>  	ret = inode_needs_update_time(inode);
>  	if (ret <= 0)
>  		return ret;
> -	if (flags & IOCB_NOWAIT)
> +	if ((flags & IOCB_NOWAIT) && !(inode->i_sb->s_flags & SB_LAZYTIME))
>  		return -EAGAIN;

The idea isn't bad but this implementation is wrong for several reasons.
Firstly, if S_VERSION is set in 'ret', then generic_update_time() will call
__mark_inode_dirty(I_DIRTY_SYNC) which generally means blocking inside the
filesystem. This is easy to fix. Secondly, there are filesystems
implementing their ->update_time method which may (and does for some
filesystems) block. Hence for this to work we need to propagate the
information about RWF_NOWAIT into inode_update_time() and ->update_time
callbacks or at the very least keep the old behavior if ->update_time is
set - depending on which filesystems you're more interested in ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

