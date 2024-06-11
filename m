Return-Path: <linux-fsdevel+bounces-21411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3083490393D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F5EB23FA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00EF179675;
	Tue, 11 Jun 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhZ1dL5x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqazwZue";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhZ1dL5x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqazwZue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46854750;
	Tue, 11 Jun 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103016; cv=none; b=fMftUsxxHrj72Mj4MZFVzaIey1X3lr7XFojNpqvdH72zak4vK1x2YmvphKc7P5uD9gAL4v1siLVrFLe9XX+8xELOpDdtrzeicrFXS0h7g16IyH2pP9HB3hESJeQp7RfP9vQJp5U/4bDyJYOpsle7kVBlxOTBzmm+f5gVgmgwCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103016; c=relaxed/simple;
	bh=4OQWurBLg6ITnbrw/kreyyF8cXe3Cg5VvJjLeU3dcqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkJFhehmoy/7TeCYzh8Z72xXtkfVs9R36LQfp0O6g87QT449NMYjEbe7gs2e1LI3o0RyvPJvEV9pcvEjZYZJ/Wlykzzr+ioilOwnBnV0/BucgKjatiMXo5/PFwd+TOpOkVvnLh0fMQt1LzYiw3qTxzyytQvDOn/0fS7kYKTvPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhZ1dL5x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqazwZue; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhZ1dL5x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqazwZue; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DBCC1F8B8;
	Tue, 11 Jun 2024 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718103012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlnbA2I4Hofv+rr3VVFY9IuMhH6n5TZ/ixyUmIprXfg=;
	b=JhZ1dL5xsXf95CgEVnDnTCJCOvalFbuwIIZ0CyoDmBj6MilROt1CIF1jelCwueHMauOkec
	nDH5tqIoKlnU3L3R3WMRGeFixPIb+/HHLVKqdlBfPXqL2pngxNbv3f+ziUSzsTpFhAt3Zd
	k+5Ystkyi9fUZz29ca4v1OmmbSuajds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718103012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlnbA2I4Hofv+rr3VVFY9IuMhH6n5TZ/ixyUmIprXfg=;
	b=HqazwZuemOlc/Pg/B54V7341Ja7ecnd9F0XRL/HsSR39COZg9Rx2uCDhVprQNqSzkNqiBt
	ibJ8HInMv5kCuPDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JhZ1dL5x;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HqazwZue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718103012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlnbA2I4Hofv+rr3VVFY9IuMhH6n5TZ/ixyUmIprXfg=;
	b=JhZ1dL5xsXf95CgEVnDnTCJCOvalFbuwIIZ0CyoDmBj6MilROt1CIF1jelCwueHMauOkec
	nDH5tqIoKlnU3L3R3WMRGeFixPIb+/HHLVKqdlBfPXqL2pngxNbv3f+ziUSzsTpFhAt3Zd
	k+5Ystkyi9fUZz29ca4v1OmmbSuajds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718103012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlnbA2I4Hofv+rr3VVFY9IuMhH6n5TZ/ixyUmIprXfg=;
	b=HqazwZuemOlc/Pg/B54V7341Ja7ecnd9F0XRL/HsSR39COZg9Rx2uCDhVprQNqSzkNqiBt
	ibJ8HInMv5kCuPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56BD8137DF;
	Tue, 11 Jun 2024 10:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nSooFeQraGbzDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Jun 2024 10:50:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A9C8A0880; Tue, 11 Jun 2024 12:50:12 +0200 (CEST)
Date: Tue, 11 Jun 2024 12:50:11 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
	hch@infradead.org
Subject: Re: [PATCH v3 1/2] vfs: add rcu-based find_inode variants for iget
 ops
Message-ID: <20240611105011.ofuqtmtdjddskbrt@quack3>
References: <20240611101633.507101-1-mjguzik@gmail.com>
 <20240611101633.507101-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611101633.507101-2-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6DBCC1F8B8
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Tue 11-06-24 12:16:31, Mateusz Guzik wrote:
> Instantiating a new inode normally takes the global inode hash lock
> twice:
> 1. once to check if it happens to already be present
> 2. once to add it to the hash
> 
> The back-to-back lock/unlock pattern is known to degrade performance
> significantly, which is further exacerbated if the hash is heavily
> populated (long chains to walk, extending hold time). Arguably hash
> sizing and hashing algo need to be revisited, but that's beyond the
> scope of this patch.
> 
> A long term fix would introduce finer-grained locking. An attempt was
> made several times, most recently in [1], but the effort appears
> stalled.
> 
> A simpler idea which solves majority of the problem and which may be
> good enough for the time being is to use RCU for the initial lookup.
> Basic RCU support is already present in the hash. This being a temporary
> measure I tried to keep the change as small as possible.
> 
> iget_locked consumers (notably ext4) get away without any changes
> because inode comparison method is built-in.
> 
> iget5_locked and ilookup5_nowait consumers pass a custom callback. Since
> removal of locking adds more problems (inode can be changing) it's not
> safe to assume all filesystems happen to cope.  Thus iget5_locked_rcu,
> ilookup5_rcu and ilookup5_nowait_rcu get added, requiring manual
> conversion.
> 
> In order to reduce code duplication find_inode and find_inode_fast grow
> an argument indicating whether inode hash lock is held, which is passed
> down should sleeping be necessary. They always rcu_read_lock, which is
> redundant but harmless. Doing it conditionally reduces readability for
> no real gain that I can see. RCU-alike restrictions were already put on
> callbacks due to the hash spinlock being held.
> 
> There is a real cache-busting workload scanning millions of files in
> parallel (it's a backup server thing), where the initial lookup is
> guaranteed to fail resulting in the 2 lock acquires.
> 
> Implemented below is a synthehic benchmark which provides the same
> behavior. [I shall note the workload is not running on Linux, instead it
> was causing trouble elsewhere. Benchmark below was used while addressing
> said problems and was found to adequately represent the real workload.]
> 
> Total real time fluctuates by 1-2s.
> 
> With 20 threads each walking a dedicated 1000 dirs * 1000 files
> directory tree to stat(2) on a 32 core + 24GB RAM vm:
> 
> ext4 (needed mkfs.ext4 -N 24000000):
> before:	3.77s user 890.90s system 1939% cpu 46.118 total
> after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)
> 
> Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz
> 
> [1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Nice speedups and the patch looks good to me. It would be lovely to get
Dave's speedups finished but this is already nice. I've found just two nits:

> +/**
> + * ilookup5 - search for an inode in the inode cache
      ^^^ ilookup5_rcu

> + * @sb:		super block of file system to search
> + * @hashval:	hash value (usually inode number) to search for
> + * @test:	callback used for comparisons between inodes
> + * @data:	opaque data pointer to pass to @test
> + *
> + * This is equivalent to ilookup5, except the @test callback must
> + * tolerate the inode not being stable, including being mid-teardown.
> + */
...
> +struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned long hashval,
> +		int (*test)(struct inode *, void *), void *data);

I'd prefer wrapping the above so that it fits into 80 columns.

Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

