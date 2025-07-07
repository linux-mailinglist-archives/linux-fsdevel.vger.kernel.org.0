Return-Path: <linux-fsdevel+bounces-54071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B647EAFAEA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E24A04EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AF628AAEE;
	Mon,  7 Jul 2025 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="INDJODQq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z10tIxzR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="INDJODQq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z10tIxzR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B5199934
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877079; cv=none; b=t73lONwQntZQ0rdI/DKdG8J9pEXGSPcoa2+EKT7MB7avKv4bm9soWK1X+qcoRQuZxfrGQ+0CB8UXevxd1t+/bu5UqjPTkbu6KMlu2kMvl0qffK4OLfiRe+1V22/ApDwJ13iJRumwIZh0Y2KZ2p3rFKa8LSKGQyQPscbJpWnvPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877079; c=relaxed/simple;
	bh=raQsBFIaSXKnL2XMPa7Ofruag6TyP/U9z0wS9xmSET8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iItNzWI3icajJKL0sWgvcr4diH+EBN7UWylUm9WV7AMxJNuoIMNPTwEpcCkhNBpM6kzvolYzCDTEyCAcqG+34KuU9LnxQfRdDw+RsekYjaX689gaFqOCOo/ZphT3snBZXTDtPikHkR/opaQr65vBwsjfXurtrBgQytSkkmck0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=INDJODQq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z10tIxzR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=INDJODQq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z10tIxzR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F72D1F38A;
	Mon,  7 Jul 2025 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751877070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiJGgUGtMR4NLXHH7zg2I8MW2e1KtWX3iqbU2F/fRtI=;
	b=INDJODQqIb0gRlAO8QUNpWA2gpqpKBH9kwVjhJWGPsLvNzILLnv13c3XmU71KxSINxOrMd
	Nc1Fo4lizmB7a2ej+sY0H5klbifmDKE2rjkqimrQAZfYvQOmUcavpn6t9GdhYaWjSXM6hB
	xkZJvEYx6pzwq15RnBAGGO4A3hhjKxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751877070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiJGgUGtMR4NLXHH7zg2I8MW2e1KtWX3iqbU2F/fRtI=;
	b=z10tIxzRluGRyVtwblp/rPlfHDdGZrAOJk/Ki9Zg+1zMtMaD6IOvkI+17B2rd0Xlshw5S9
	mkulWt5I6DxZiqDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751877070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiJGgUGtMR4NLXHH7zg2I8MW2e1KtWX3iqbU2F/fRtI=;
	b=INDJODQqIb0gRlAO8QUNpWA2gpqpKBH9kwVjhJWGPsLvNzILLnv13c3XmU71KxSINxOrMd
	Nc1Fo4lizmB7a2ej+sY0H5klbifmDKE2rjkqimrQAZfYvQOmUcavpn6t9GdhYaWjSXM6hB
	xkZJvEYx6pzwq15RnBAGGO4A3hhjKxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751877070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiJGgUGtMR4NLXHH7zg2I8MW2e1KtWX3iqbU2F/fRtI=;
	b=z10tIxzRluGRyVtwblp/rPlfHDdGZrAOJk/Ki9Zg+1zMtMaD6IOvkI+17B2rd0Xlshw5S9
	mkulWt5I6DxZiqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0360C13757;
	Mon,  7 Jul 2025 08:31:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W1LNAM6Fa2irNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Jul 2025 08:31:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2293A0992; Mon,  7 Jul 2025 10:31:09 +0200 (CEST)
Date: Mon, 7 Jul 2025 10:31:09 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, Jan Kara <jack@suse.cz>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: restrict writes to opened btrfs devices
Message-ID: <o22twrini5ofwxdch32ecptztbkp2hjxsqaun5tyxt6yxr2anh@wn267am44avm>
References: <bf74fa9eee7917030235a8883e0a4ff53d9e0938.1751621865.git.wqu@suse.com>
 <20250707-wogen-karate-68a856159174@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-wogen-karate-68a856159174@brauner>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon 07-07-25 09:43:29, Christian Brauner wrote:
> On Fri, Jul 04, 2025 at 07:08:03PM +0930, Qu Wenruo wrote:
> > [WEIRD FLAG EXCLUSION]
> > Commit ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
> > removes the BLK_OPEN_RESTRICT_WRITES flag when opening the devices
> > during mount.
> > 
> > However there is no filesystem except btrfs excluding this flag, which
> > is weird, and lacks a proper explanation why we need such an exception.
> > 
> > [REASON TO EXCLUDE THAT FLAG]
> > Btrfs needs to call btrfs_scan_one_device() to determine the fsid, no
> > matter if we're mounting a new fs or an existing one.
> > 
> > But if a fs is already mounted and that BLK_OPEN_RESTRICT_WRITES is
> > honored, meaning no other write open is allowed for the block device.
> > 
> > Then we want to mount a subvolume of the mounted fs to another mount
> > point, we will call btrfs_scan_one_device() again, but it will fail due
> > to the BLK_OPEN_RESTRICT_WRITES flag (no more write open allowed),
> > causing only one mount point for the fs.
> > 
> > Thus at that time, we have to exclude the BLK_OPEN_RESTRICT_WRITES to
> > allow multiple mount points for one fs.
> > 
> > [WHY IT'S SAFE NOW]
> > The root problem is, we do not need to nor should use BLK_OPEN_WRITE for
> > btrfs_scan_one_device().
> > That function is only to read out the super block, no write at all, and
> > BLK_OPEN_WRITE is only going to cause problems for such usage.
> > 
> > The root problem is fixed by patch "btrfs: always open the device
> > read-only in btrfs_scan_one_device", so btrfs_scan_one_device() will
> > always work no matter if the device is opened with
> > BLK_OPEN_RESTRICT_WRITES.
> > 
> > [ENHANCEMENT]
> > Just remove the btrfs_open_mode(), as the only call site can be replaced
> > with regular sb_open_mode().
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> 
> Ok, very nice!
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Yup, very nice we finally got rid of this exception. Thanks Qu!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

