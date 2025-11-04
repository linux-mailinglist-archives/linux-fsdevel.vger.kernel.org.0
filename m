Return-Path: <linux-fsdevel+bounces-66892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1C2C2FE67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 09:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA933A388D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78B312826;
	Tue,  4 Nov 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJelJtuU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4p1dZ/c2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJelJtuU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4p1dZ/c2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0A310621
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244912; cv=none; b=lol60LED6o/FEZkwdNpiZXgSQrwqxbDx7FZWcb2hGewQ/AXHUjCJebH76fbm73AJeteFBnBeS5Lb2X99l1bA+FI4LLxIEee22ySEQiZkVx3b4fMRz2N7zn8blQwqM8fGHBAY6f/FO5fkeBGYknGm8ZWdlPWSEAQN7qlb5NXUzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244912; c=relaxed/simple;
	bh=8fYHcJC59dzvTALRk1run5UIH5IBqVktUtXdkaXYD6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O84wC3augeuDDB5wVntGHg7dH8LTgAILPWXc/kOfXK6W9xtNiDqh5Fdm7CmhfNv9ZMxip3s+M/S3jIg6ThCd0UVsKyK0kXg2PA5Bx5him0wWSqB4w//WRWyM62w4H1Gsjw4p6awvXA7jhzO/R6wYy+hVruWcvY8jtDyNfK20Bb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJelJtuU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4p1dZ/c2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJelJtuU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4p1dZ/c2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4319B211A3;
	Tue,  4 Nov 2025 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762244908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IglUw+83FxSZEK7irW6V2E1U276pgIeIQesGBlV1oqU=;
	b=sJelJtuUv4lQTg8ie3DMnzIgGDMvgeWmlm4GYzVfhvKoHbM2BrF1CxDpsgK3o/QcoCNma0
	PDKjP/YBkzpBuCbdMOv4Kdbshtl745BHXwpEZHJK1Cn0oce0n+LTieIydGdhwatxfA25Ux
	2Eelmdq2V81Pa8F6dd3zB15eIPuWu/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762244908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IglUw+83FxSZEK7irW6V2E1U276pgIeIQesGBlV1oqU=;
	b=4p1dZ/c2SPw5N66FsO/zL4OweL6IL7W+kL6SLXpPvNUcJuF2uPLnzK1n+DdEqW4Fiy783I
	krACTHr8WDGZl9BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762244908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IglUw+83FxSZEK7irW6V2E1U276pgIeIQesGBlV1oqU=;
	b=sJelJtuUv4lQTg8ie3DMnzIgGDMvgeWmlm4GYzVfhvKoHbM2BrF1CxDpsgK3o/QcoCNma0
	PDKjP/YBkzpBuCbdMOv4Kdbshtl745BHXwpEZHJK1Cn0oce0n+LTieIydGdhwatxfA25Ux
	2Eelmdq2V81Pa8F6dd3zB15eIPuWu/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762244908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IglUw+83FxSZEK7irW6V2E1U276pgIeIQesGBlV1oqU=;
	b=4p1dZ/c2SPw5N66FsO/zL4OweL6IL7W+kL6SLXpPvNUcJuF2uPLnzK1n+DdEqW4Fiy783I
	krACTHr8WDGZl9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 378D613ADD;
	Tue,  4 Nov 2025 08:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kVyLDSy5CWm1WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 08:28:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6A83A2812; Tue,  4 Nov 2025 09:28:27 +0100 (CET)
Date: Tue, 4 Nov 2025 09:28:27 +0100
From: Jan Kara <jack@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
Message-ID: <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
 <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 04-11-25 07:25:06, Qu Wenruo wrote:
> 
> 
> 在 2025/11/3 22:26, Christoph Hellwig 写道:
> > The emergency sync being non-blocking goes back to day 1.  I think the
> > idea behind it is to not lock up a already messed up system by
> > blocking forever, even if it is in workqueue.  Changing this feels
> > a bit risky to me.
> 
> Considering everything is already done in task context (baked by the global
> per-cpu workqueue), it at least won't block anything else.
> 
> And I'd say if the fs is already screwed up and hanging, the
> sync_inodes_one_sb() call are more likely to hang than the final sync_fs()
> call.

Well, but notice that sync_inodes_one_sb() is always called with wait == 0
from do_sync_work() exactly to skip inodes already marked as under
writeback, locked pages or pages under writeback as waiting for these has
high chances of locking up. Suddently calling sync_fs_one_sb() with wait ==
1 can change things. That being said for ext4 the chances of locking up
ext4_sync_fs() with wait == 1 after sync_fs_one_sb() managed to do
non-trivial work are fairly minimal so I don't have strong objections
myself.

> > On Mon, Nov 03, 2025 at 02:37:29PM +1030, Qu Wenruo wrote:
> > > At this stage, btrfs is only one super block update away to be fully committed.
> > > I believe it's the more or less the same for other fses too.
> > 
> > Most file systems do not need a superblock update to commit data.
> 
> That's the main difference, btrfs always needs a superblock update to switch
> metadata due to its metadata COW nature.
> 
> The only good news is, emergency sync is not that a hot path, we have a lot
> of time to properly fix.

I'd say even better news is that emergency sync is used practically only
when debugging the kernel. So we can do what we wish and will have to live
with whatever pain we inflict onto ourselves ;).

> > > The problem is the next step, sync_bdevs().
> > > Normally other fses have their super block already updated in the page
> > > cache of the block device, but btrfs only updates the super block during
> > > full transaction commit.
> > > 
> > > So sync_bdevs() may work for other fses, but not for btrfs, btrfs is
> > > still using its older super block, all pointing back to the old metadata
> > > and data.
> > > 
> > 
> > At least for XFS, no metadata is written through the block device
> > mapping anyway.
> > 
> 
> So does that mean sync_inodes_one_sb() on XFS (or even ext4?) will always
> submit needed metadata (journal?) to disk?

No, sync_inodes_one_sb() will just prepare transaction in memory (both for
ext4 and xfs). For ext4 sync_fs_one_sb() with wait == 0 will start writeback
of this transaction to the disk and sync_fs_one_sb() with wait == 1 will make
sure the transaction is fully written out (committed). For xfs
sync_fs_one_sb() with wait == 0 does nothing, sync_fs_one_sb() with wait
== 1 makes sure the transaction is committed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

