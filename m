Return-Path: <linux-fsdevel+bounces-1243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B717D833F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E748B21357
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EC2D7AA;
	Thu, 26 Oct 2023 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fJop7Kvc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0dlhmOeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EC8813
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 13:04:46 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489F191
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 06:04:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 849621FE4D;
	Thu, 26 Oct 2023 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698325483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5BsLDtVQBcVc78Yihpmavv2oYqvbIUOaHPoeMs3kdk=;
	b=fJop7KvcfAb32k5BcR3OUU4T0YlSuVy8jbR/JKV5O6VO38ESl4PaIUeJ7cRkytonlLTxty
	2IoaCM56k0ajs9XW5wUBhGEdyPxOO/or4q898jf4F4P6Kz/stVhj6iaQl8oN4p3nmbdCYW
	zjOsaSZhXW7lQ3IJ8MV+qkXtI/EGFs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698325483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5BsLDtVQBcVc78Yihpmavv2oYqvbIUOaHPoeMs3kdk=;
	b=0dlhmOeYLIpxGy0cz9xLslZRIuMmE7ZecAHwoKw+gspnGp9ntuHwFnhCpGwHtogYG7CvmP
	8VvR5+gKADrcUeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75D891358F;
	Thu, 26 Oct 2023 13:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7O6/HOtjOmUDKQAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 26 Oct 2023 13:04:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0767DA05BC; Thu, 26 Oct 2023 15:04:43 +0200 (CEST)
Date: Thu, 26 Oct 2023 15:04:42 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] fs,block: yield devices
Message-ID: <20231026130442.lvfsjilryuxnnrp6@quack3>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231025172057.kl5ajjkdo3qtr2st@quack3>
 <20231025-ersuchen-restbetrag-05047ba130b5@brauner>
 <20231026103503.ldupo3nhynjjkz45@quack3>
 <20231026-marsch-tierzucht-0221d75b18ea@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-marsch-tierzucht-0221d75b18ea@brauner>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.47
X-Spamd-Result: default: False [-6.47 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.87)[99.43%]

On Thu 26-10-23 14:07:38, Christian Brauner wrote:
> On Thu, Oct 26, 2023 at 12:35:03PM +0200, Jan Kara wrote:
> > This is about those seemingly spurious "device busy" errors when the
> > superblock hasn't closed its devices yet, isn't it?  But we now remove
> 
> Yes, because we tie superblock and block device neatly together.
> 
> > superblock from s_instances list in kill_super_notify() and until that
> > moment SB_DYING is protecting us from racing mounts. So is there some other
> > problem?
> 
> No, there isn't a problem at all. It's all working fine but it was
> initially a little annoying as we had to update filesystems to ensure
> that sb->s_fs_info is kept alive. But it's all fixed.
> 
> The possible advantage is that if we drop all block devices under
> s_umount then we can remove the superblock from fs_type->s_instances in
> the old location again. I'm not convinced it's worth it but it's a
> possible simplification. I'm not even arguing it's objectively better I
> think it's a matter of taste in the end.

Yes. But dropping the main bdev under s_umount is not easy to do with the
current callback structure. We have kill_block_super() calling into
generic_shutdown_super(). Now logically generic_shutdown_super() wants to
teardown bdi (for which it needs to drop s_umount) but bdev is closed only
in kill_block_super() because that's the sb-on-bdev specific call.
Previously we got away with this without spurious EBUSY errors because the
bdev holder was the filesystem type and not the superblock. But after
changing the holder it isn't fine anymore and we have to play these games
with s_instances and SB_DYING.

What we could probably do is to have something like:

	if (sb->s_bdev) {
		blkdev_put(sb->s_bdev);
		sb->s_bdev = NULL;
	}
	if (sb->s_mtd) {
		put_mtd_device(sb->s_mtd);
		sb->s_mtd = NULL;
	}

in generic_shutdown_super() and then remove sb from s_instances, drop
s_umount and cleanup bdi.

Then we can get rid of SB_DYING, kill_super_notify() and stuff but based on
your taste it could be also viewed as kind of layering violation so I'm not
100% convinced this is definitely a way to go.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

