Return-Path: <linux-fsdevel+bounces-825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF9B7D0F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 14:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FBC282591
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B21199DB;
	Fri, 20 Oct 2023 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NCH6nyAh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TvZxT0uf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A66199D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 12:04:40 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0302C9F
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 05:04:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F259219CD;
	Fri, 20 Oct 2023 12:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697803477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYMPZ6ys4lB4T9tCk7h7jDsvJBMMVkLCmIu6i0I16Hk=;
	b=NCH6nyAh4vTXQXs1aKpqjIIWRtbLdVM807Ha62fsaBYclrDwiaX59piKQt5JL6CARgn59A
	F9MW4iMfpGKyBt08mRxkVj/xPjDzl9KSz2SN+PITTnS/RNJ2bJe/EwsD5wounbpFqZ8oa8
	+DkgvRJ7PzFZOV9giS7ELUvOm00qXVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697803477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYMPZ6ys4lB4T9tCk7h7jDsvJBMMVkLCmIu6i0I16Hk=;
	b=TvZxT0uf4mrc6QNGrZYVZw3HGkeRK3bQJtBAs9Tedl9zYB80c23QUk8JIQK2k9TeLBmDbj
	cTD7OWntvgXYxeBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4985C13584;
	Fri, 20 Oct 2023 12:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wJMBEtVsMmUMfQAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 20 Oct 2023 12:04:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6DFE9A06E3; Fri, 20 Oct 2023 14:04:36 +0200 (CEST)
Date: Fri, 20 Oct 2023 14:04:36 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under
 bdev->bd_holder_lock
Message-ID: <20231020120436.jgxdlawibpfuprnz@quack3>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%]

On Fri 20-10-23 13:31:20, Christian Brauner wrote:
> On Thu, Oct 19, 2023 at 06:40:27AM -0700, Christoph Hellwig wrote:
> > On Thu, Oct 19, 2023 at 10:33:36AM +0200, Christian Brauner wrote:
> > > some device removal. I also messed around with the loop code and
> > > specifically used LOOP_CHANGE_FD to force a disk_force_media_change() on
> > > a filesystem.
> > 
> > Can you wire that up for either blktests or xfstests as well?
> 
> Yeah, I'll try to find some time to do this.
> 
> So while I was testing this I realized that the behavior of
> LOOP_CHANGE_FD changed in commit 9f65c489b68d ("loop: raise media_change
> event") and I'm not clear whether this is actually correct or not.
> 
> loop(4) states
>               
> "Switch the backing store of the loop device to the new file identified
>  file descriptor specified in the (third) ioctl(2) argument, which is an
>  integer.  This operation is possible only if the loop device is
>  read-only and the new backing store is the same size and type as the
>  old backing store."
> 
> So the original use-case for this ioctl seems to have been to silently
> swap out the backing store. Specifcially it seems to have been used once
> upon a time for live images together with device mapper over read-only
> loop devices. Where device mapper can direct the writes to some other
> location or sm.

LOOP_CHANGE_FD was an old hacky way to switch from read-only installation
image to a full-blown RW filesystem without reboot. I'm not sure about
details how it was supposed to work but reportedly Al Viro implemented that
for Fedora installation back in the old days.

> Assuming that's correct, I think as long as you have something like
> device mapper that doesn't use blk_holder_ops it would still work. But
> that commit changed behavior for filesystems because we now do:
> 
> loop_change_fd()
> -> disk_force_media_change()
>    -> bdev_mark_dead()
>       -> bdev->bd_holder_ops->mark_dead::fs_mark_dead()
> 
> So in essence if you have a filesystem on a loop device via:
> 
> truncate -s 10G img1
> mkfs.xfs -f img1
> LOOP_DEV=$(sudo losetup -f --read-only --show img1)
> 
> truncate -s 10G img2
> sudo ./loop_change_fd $LOOP_DEV ./img2
> 
> We'll shut down that filesystem. I personally think that's correct and
> it's buggy not to do that when we have the ability to inform the fs
> about media removal but technically it kinda defeats the original
> use-case for LOOP_CHANGE_FD.

I agree that it breaks the original usecase for LOOP_CHANGE_FD. I'd say it
also shows nobody is likely using LOOP_CHANGE_FD anymore. Maybe time to try
deprecating it?

> In practice however, I don't think it matters because I think no one is
> using LOOP_CHANGE_FD in that way. Right now all this is a useful for is
> a bdev_mark_dead() test.

:)

> And one final question:
> 
> dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> disk_force_media_change(lo->lo_disk);
> /* more stuff */
> dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> 
> What exactly does that achieve? Does it just delay the delivery of the
> uevent after the disk sequence number was changed in
> disk_force_media_change()? Because it doesn't seem to actually prevent
> uevent generation.

Well, if you grep for dev_get_uevent_suppress() you'll notice there is
exactly *one* place looking at it - the generation of ADD event when adding
a partition bdev. I'm not sure what's the rationale behind this
functionality.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

