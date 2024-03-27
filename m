Return-Path: <linux-fsdevel+bounces-15388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F888DAE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 11:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB7E1F2A8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956FD39840;
	Wed, 27 Mar 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wtQJpxmz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="57VDItSE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4JUTXki";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vnl9J7E7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504E45975
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533687; cv=none; b=UkjjeioRY//yFzgT7WNijqER6qgG8l6V/N0JPnGA1nS7NdI7YVHn75H+i0/k4t/a3OuhUca9V4l/2xVXP48OE594Hk++hlw4QC5N5bpd7vQM7v+g5fBERK8oq+JMUq3cDwJBBNAcwJWQn6jeme9+8CfUySGwSmaV4IWsrF2Lby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533687; c=relaxed/simple;
	bh=G9CdM9cUOGIt27SesyAYEfbHuhBhS22GFmqE0yXFXiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhBeXtcxrA8cbDunwq90Fml67bUy0hgSYNqKgejQhzF520a65JPWMcod6MZBdxP6CCVhFblKAEMdciUFSdWRwvvRSD83527VxfdBV7htFcHx3ElTFQHd5uNPnO6J89/oHKTGodMT0m56gL2ndOBQKofySNyvUsPSrjOl1JE4Dd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wtQJpxmz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=57VDItSE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4JUTXki; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vnl9J7E7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF61E601F9;
	Wed, 27 Mar 2024 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711533683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsPSx7lxtpbSBFMZOzQ9J1UWr3fqA595PyZT9Vy+e6Q=;
	b=wtQJpxmzlwPQokYQCIbxD0dr840RdVBNIAqwMwzwfUMhaRY7GoeDhGjPDtTQTDZMMO8EpU
	jo2F7sIbcTjoZCctlHJWgpK3YI24qH2M8APdOmtBc83lNplu+46U7zpyxccFyZfH/dE+sf
	955gfrow03hX4g3nWMj/FB0hz4xeEI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711533683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsPSx7lxtpbSBFMZOzQ9J1UWr3fqA595PyZT9Vy+e6Q=;
	b=57VDItSEKEl8PEYDSUIdFfPdATxV6tm5vX7pteI7/KgYdgeU6tAa4m7NetwlVZHbuVlc5B
	Avg3quv/Q2Y2OWAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711533682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsPSx7lxtpbSBFMZOzQ9J1UWr3fqA595PyZT9Vy+e6Q=;
	b=i4JUTXkipDkICKhFCpQt/zU8in5z7i5ub/o+CVxiqDYT6TpsWulT7cQsXO/oYNMA7YB2n2
	JFEFck6k+laG2EA4Iam4u4MGRz1Dt7zfJCeElnEUhP4Qvo7VoXlJ6IFeTJsaxIK0aYr9ga
	oLO1XAhykg7axs9PAjBIRqOZlJvRRAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711533682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsPSx7lxtpbSBFMZOzQ9J1UWr3fqA595PyZT9Vy+e6Q=;
	b=Vnl9J7E7RvwtC4A5GT6FWcglseVRTZj1ubqQHe9YTqC3yvEUxHk1FON4bo2CXrAHunwmmu
	Zp9bQnf3PBoNiYDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BDDE13AC5;
	Wed, 27 Mar 2024 10:01:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id B6ALJnLuA2b7EAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 27 Mar 2024 10:01:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49C2DA0812; Wed, 27 Mar 2024 11:01:22 +0100 (CET)
Date: Wed, 27 Mar 2024 11:01:22 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] fsnotify: rename fsnotify_{get,put}_sb_connectors()
Message-ID: <20240327100122.odg6bc4lgsrryt6w@quack3>
References: <20240317184154.1200192-1-amir73il@gmail.com>
 <20240317184154.1200192-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317184154.1200192-2-amir73il@gmail.com>
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[44.72%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Sun 17-03-24 20:41:45, Amir Goldstein wrote:
> Instead of counting the number of connectors in an sb, we would like
> to count the number of watched objects per priority group.
> 
> As a start, create an accessor fsnotify_sb_watched_objects() to
> s_fsnotify_connectors and rename the fsnotify_{get,put}_sb_connectors()
> helpers to fsnotify_{get,put}_sb_watchers() to better describes the
> counter.
> 
> Increment the counter at the end of fsnotify_attach_connector_to_object()
> if connector was attached instead of decrementing it on race to connect.
> 
> This is fine, because fsnotify_delete_sb() cannot be running in parallel
> to fsnotify_attach_connector_to_object() which requires a reference to
> a filesystem object.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
...
> +static void fsnotify_put_inode_ref(struct inode *inode)
> +{
> +	iput(inode);
> +	fsnotify_put_sb_watched_objects(inode->i_sb);
> +}

This is a UAF issue. Will fix on commit. Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

