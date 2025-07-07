Return-Path: <linux-fsdevel+bounces-54112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB3BAFB5C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C178F3BF26A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91282D8DA0;
	Mon,  7 Jul 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j0a9EoLz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gP3A2roJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j0a9EoLz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gP3A2roJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E91E22FC
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898160; cv=none; b=u0qnFgIGI2ej/+2HvIoWP05nC3EFTc1f4qmBF/7CloVkyjCdP/AIm1pyR6ZkMZsoVYY6zrpCClRK1214TtMNshZYJ1JTh7cTK0IeH6Gte0iQjx5xEVfQKPz6hE/80QfPBkwBpvc+Xy2+PvtfJMzZaR+o+4AZ6BQztfB6bRt/VI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898160; c=relaxed/simple;
	bh=AlTOX4kESqHjb63o2ciOY15wgcb588awJiOzEM5f6cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H34pgVt6UpRNO3raWqPV7jFYJJyUrzqzsMJOPAU9FEtT4bZe2H4ll451xlnE7CaEssILD3t8MFdJ7lKrhPhub8V9ozZj1pksgBHsHgHsGp+5FXSi8GGLTnuWC6A7RuAcBlhAIxDVcy8dnhNybL+lXt1ee69yhkJJNWnNG/WnP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j0a9EoLz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gP3A2roJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j0a9EoLz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gP3A2roJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5EDC21166;
	Mon,  7 Jul 2025 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751898156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3Le2vDmz8/dfPi3kiyKnJe8mbmdRkOgGk5sr8tCyy8=;
	b=j0a9EoLzzc4dLD6RVriyzmsOpiWBzBkuy+KeqG0Ar1AlK1FhSGCZWgCiP4dduu3UDKfmIN
	eN1qev/xy56omuid7hl7ox83LR6rklshk+TO1rgrN/8Nw8l+Yf4rpaBVsOZH0tiHY54Z1L
	zQNK0dU0/G+gBfcXySSuVS1Ak6eujqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751898156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3Le2vDmz8/dfPi3kiyKnJe8mbmdRkOgGk5sr8tCyy8=;
	b=gP3A2roJEmfTxwcMUSW8v07QsRKRhPUrf2pPYGiRt8U4NBFMqcIElMQsqn0NZjjkAsqVuk
	WMfdmBtMkyV6HDAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j0a9EoLz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gP3A2roJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751898156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3Le2vDmz8/dfPi3kiyKnJe8mbmdRkOgGk5sr8tCyy8=;
	b=j0a9EoLzzc4dLD6RVriyzmsOpiWBzBkuy+KeqG0Ar1AlK1FhSGCZWgCiP4dduu3UDKfmIN
	eN1qev/xy56omuid7hl7ox83LR6rklshk+TO1rgrN/8Nw8l+Yf4rpaBVsOZH0tiHY54Z1L
	zQNK0dU0/G+gBfcXySSuVS1Ak6eujqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751898156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3Le2vDmz8/dfPi3kiyKnJe8mbmdRkOgGk5sr8tCyy8=;
	b=gP3A2roJEmfTxwcMUSW8v07QsRKRhPUrf2pPYGiRt8U4NBFMqcIElMQsqn0NZjjkAsqVuk
	WMfdmBtMkyV6HDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E14713757;
	Mon,  7 Jul 2025 14:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /vXAHSzYa2jYLQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Jul 2025 14:22:36 +0000
Date: Mon, 7 Jul 2025 16:22:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: restrict writes to opened btrfs devices
Message-ID: <20250707142231.GF4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bf74fa9eee7917030235a8883e0a4ff53d9e0938.1751621865.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf74fa9eee7917030235a8883e0a4ff53d9e0938.1751621865.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A5EDC21166
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Fri, Jul 04, 2025 at 07:08:03PM +0930, Qu Wenruo wrote:
> [WEIRD FLAG EXCLUSION]
> Commit ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
> removes the BLK_OPEN_RESTRICT_WRITES flag when opening the devices
> during mount.
> 
> However there is no filesystem except btrfs excluding this flag, which
> is weird, and lacks a proper explanation why we need such an exception.

It's somewhere in the discussions for the patch and there was a
dependency on the series reworking the device opening to be read-only
which I did not consider safe for inclusion. You've worked on that
recently and fixed a few problems and it made it all possible.

The code this patch is removing was added by Linus during merge and was
not obvious that was needed.

> [REASON TO EXCLUDE THAT FLAG]
> Btrfs needs to call btrfs_scan_one_device() to determine the fsid, no
> matter if we're mounting a new fs or an existing one.
> 
> But if a fs is already mounted and that BLK_OPEN_RESTRICT_WRITES is
> honored, meaning no other write open is allowed for the block device.
> 
> Then we want to mount a subvolume of the mounted fs to another mount
> point, we will call btrfs_scan_one_device() again, but it will fail due
> to the BLK_OPEN_RESTRICT_WRITES flag (no more write open allowed),
> causing only one mount point for the fs.
> 
> Thus at that time, we have to exclude the BLK_OPEN_RESTRICT_WRITES to
> allow multiple mount points for one fs.
> 
> [WHY IT'S SAFE NOW]
> The root problem is, we do not need to nor should use BLK_OPEN_WRITE for
> btrfs_scan_one_device().
> That function is only to read out the super block, no write at all, and
> BLK_OPEN_WRITE is only going to cause problems for such usage.
> 
> The root problem is fixed by patch "btrfs: always open the device
> read-only in btrfs_scan_one_device", so btrfs_scan_one_device() will
> always work no matter if the device is opened with
> BLK_OPEN_RESTRICT_WRITES.
> 
> [ENHANCEMENT]
> Just remove the btrfs_open_mode(), as the only call site can be replaced
> with regular sb_open_mode().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add more details about the original problem
>   And the fix that unintentionally solved the original problem.

Please add it to for-next, thanks.

