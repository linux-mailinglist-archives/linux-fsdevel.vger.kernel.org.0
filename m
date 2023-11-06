Return-Path: <linux-fsdevel+bounces-2077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924997E2006
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EFA1C20B09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578C518E24;
	Mon,  6 Nov 2023 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ri0o3/ic";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Fp1sON+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1518B1B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 11:30:51 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728C9BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 03:30:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0FB31F88D;
	Mon,  6 Nov 2023 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699270248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9TnOEEjKzfOal4gBX+SxjF4DzFwQ8LPtUZ6pRU65Y8=;
	b=Ri0o3/ictn2wFknZqf0WpZUPDIMnBfMxVS4hOyPzaMW6Ig2X/FXNjodUKR5IPy0HhewoFj
	4P0vE5rjbwDYGwbSDG87lPOLmgesumbV41Eqr4qYRRbBLEJJHXZLj/YcI0Umj/iegLFmw8
	gdRx3pf2wu23uXVbngUCs+WIK1ANK4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699270248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9TnOEEjKzfOal4gBX+SxjF4DzFwQ8LPtUZ6pRU65Y8=;
	b=6Fp1sON+77O1AgeoI+q3OgtO36Xw/2pmeE/5yEH7pYOmubjc38dGxQZc7Z60t6PM/Dgn16
	cOdco+zbhgBGXzAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF9AB138E5;
	Mon,  6 Nov 2023 11:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id o1/ALmjOSGUnMgAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 06 Nov 2023 11:30:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50C9DA07BE; Mon,  6 Nov 2023 12:30:48 +0100 (CET)
Date: Mon, 6 Nov 2023 12:30:48 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH v2 2/2] fs: handle freezing from multiple devices
Message-ID: <20231106113048.f6qdsfma3scxikbq@quack3>
References: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
 <20231104-vfs-multi-device-freeze-v2-2-5b5b69626eac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-vfs-multi-device-freeze-v2-2-5b5b69626eac@kernel.org>

On Sat 04-11-23 15:00:13, Christian Brauner wrote:
> Before [1] freezing a filesystems through the block layer only worked
> for the main block device as the owning superblock of additional block
> devices could not be found. Any filesystem that made use of multiple
> block devices would only be freezable via it's main block device.
> 
> For example, consider xfs over device mapper with /dev/dm-0 as main
> block device and /dev/dm-1 as external log device. Two freeze requests
> before [1]:
> 
> (1) dmsetup suspend /dev/dm-0 on the main block device
> 
>     bdev_freeze(dm-0)
>     -> dm-0->bd_fsfreeze_count++
>     -> freeze_super(xfs-sb)
> 
>     The owning superblock is found and the filesystem gets frozen.
>     Returns 0.
> 
> (2) dmsetup suspend /dev/dm-1 on the log device
> 
>     bdev_freeze(dm-1)
>     -> dm-1->bd_fsfreeze_count++
> 
>     The owning superblock isn't found and only the block device freeze
>     count is incremented. Returns 0.
> 
> Two freeze requests after [1]:
> 
> (1') dmsetup suspend /dev/dm-0 on the main block device
> 
>     bdev_freeze(dm-0)
>     -> dm-0->bd_fsfreeze_count++
>     -> freeze_super(xfs-sb)
> 
>     The owning superblock is found and the filesystem gets frozen.
>     Returns 0.
> 
> (2') dmsetup suspend /dev/dm-1 on the log device
> 
>     bdev_freeze(dm-0)
>     -> dm-0->bd_fsfreeze_count++
>     -> freeze_super(xfs-sb)
> 
>     The owning superblock is found and the filesystem gets frozen.
>     Returns -EBUSY.
> 
> When (2') is called we initiate a freeze from another block device of
> the same superblock. So we increment the bd_fsfreeze_count for that
> additional block device. But we now also find the owning superblock for
> additional block devices and call freeze_super() again which reports
> -EBUSY.
> 
> This can be reproduced through xfstests via:
> 
>     mkfs.xfs -f -m crc=1,reflink=1,rmapbt=1, -i sparse=1 -lsize=1g,logdev=/dev/nvme1n1p4 /dev/nvme1n1p3
>     mkfs.xfs -f -m crc=1,reflink=1,rmapbt=1, -i sparse=1 -lsize=1g,logdev=/dev/nvme1n1p6 /dev/nvme1n1p5
> 
>     FSTYP=xfs
>     export TEST_DEV=/dev/nvme1n1p3
>     export TEST_DIR=/mnt/test
>     export TEST_LOGDEV=/dev/nvme1n1p4
>     export SCRATCH_DEV=/dev/nvme1n1p5
>     export SCRATCH_MNT=/mnt/scratch
>     export SCRATCH_LOGDEV=/dev/nvme1n1p6
>     export USE_EXTERNAL=yes
> 
>     sudo ./check generic/311
> 
> Current semantics allow two concurrent freezers: one initiated from
> userspace via FREEZE_HOLDER_USERSPACE and one initiated from the kernel
> via FREEZE_HOLDER_KERNEL. If there are multiple concurrent freeze
> requests from either FREEZE_HOLDER_USERSPACE or FREEZE_HOLDER_KERNEL
> -EBUSY is returned.
> 
> We need to preserve these semantics because as they are uapi via
> FIFREEZE and FITHAW ioctl()s. IOW, freezes don't nest for FIFREEZE and
> FITHAW. Other kernels consumers rely on non-nesting freezes as well.
> 
> With freezes initiated from the block layer freezes need to nest if the
> same superblock is frozen via multiple devices. So we need to start
> counting the number of freeze requests.
> 
> If FREEZE_HOLDER_BDEV is passed alongside FREEZE_HOLDER_KERNEL or
> FREEZE_HOLDER_USERSPACE we allow the caller to nest freeze calls.

FREEZE_HOLDER_BDEV should be FREEZE_MAY_NEST I guess.

> To accommodate the old semantics we split the freeze counter into two
> counting kernel initiated and userspace initiated freezes separately. We
> can then also stop recording FREEZE_HOLDER_* in struct sb_writers.
> 
> We also simplify freezing by making all concurrent freezers share a
> single active superblock reference count instead of having separate
> references for kernel and userspace. I don't see why we would need two
> active reference counts. Neither FREEZE_HOLDER_KERNEL nor
> FREEZE_HOLDER_USERSPACE can put the active reference as long as they are
> concurrent freezers anwyay. That was already true before we allowed
> nesting freezes.
> 
> Survives various fstests runs with different options including the
> reproducer, online scrub, and online repair, fsfreze, and so on. Also
> survives blktests.
> 
> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
> Link: https://lore.kernel.org/linux-block/87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64
> Fixes: [1]: bfac4176f2c4 ("bdev: implement freeze and thaw holder operations") # no backport needed
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Just one more typo fix below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1930,6 +2008,13 @@ static int wait_for_partially_frozen(struct super_block *sb)
>   * userspace can both hold a filesystem frozen.  The filesystem remains frozen
>   * until there are no kernel or userspace freezes in effect.
>   *
> + * A filesystem may hold multiple devices and thus a filesystems may be
> + * frozen through the block layer via multiple block devices. In this
> + * case the request is marked as being allowed to nest passig
							  ^^ passing

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

