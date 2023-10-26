Return-Path: <linux-fsdevel+bounces-1232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFF7D80CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F2282046
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F102D791;
	Thu, 26 Oct 2023 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pITSSsH8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1VpoW5Cl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575832D78D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 10:35:07 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B069C18A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 03:35:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F43B1FE29;
	Thu, 26 Oct 2023 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698316504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QY2qw7SQne6AFa6nGEm49zIDWmI870qs650Bll4DQog=;
	b=pITSSsH8fX3+PNAdSCcygSv29valG/NKVBUBTXemLsvidbEfH7jrK2c6u2G6UDWjKAmjAw
	3FjdIz6rlHy5RGoMW+MWV/Mo/lKj69cAl6ZgwDEDkZf51e57nMmCBeRBRegz97uY5LaOpH
	BIKueKBOXaTf3LyMFca84IJxodyGRdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698316504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QY2qw7SQne6AFa6nGEm49zIDWmI870qs650Bll4DQog=;
	b=1VpoW5ClCWd9LRxa5T+AaiqxukNadLDkzkl1pHbN+OsKokfnqSpMaHEghzi2xsOhM0O/ii
	+6UFhs8rXdtt+7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 509EE1358F;
	Thu, 26 Oct 2023 10:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OqypE9hAOmV1VQAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 26 Oct 2023 10:35:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE6FAA05BC; Thu, 26 Oct 2023 12:35:03 +0200 (CEST)
Date: Thu, 26 Oct 2023 12:35:03 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] fs,block: yield devices
Message-ID: <20231026103503.ldupo3nhynjjkz45@quack3>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231025172057.kl5ajjkdo3qtr2st@quack3>
 <20231025-ersuchen-restbetrag-05047ba130b5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-ersuchen-restbetrag-05047ba130b5@brauner>

On Wed 25-10-23 22:46:29, Christian Brauner wrote:
> On Wed, Oct 25, 2023 at 07:20:57PM +0200, Jan Kara wrote:
> > Hello!
> > 
> > On Tue 24-10-23 16:53:38, Christian Brauner wrote:
> > > This is a mechanism that allows the holder of a block device to yield
> > > device access before actually closing the block device.
> > > 
> > > If a someone yields a device then any concurrent opener claiming the
> > > device exclusively with the same blk_holder_ops as the current owner can
> > > wait for the device to be given up. Filesystems by default use
> > > fs_holder_ps and so can wait on each other.
> > > 
> > > This mechanism allows us to simplify superblock handling quite a bit at
> > > the expense of requiring filesystems to yield devices. A filesytems must
> > > yield devices under s_umount. This allows costly work to be done outside
> > > of s_umount.
> > > 
> > > There's nothing wrong with the way we currently do things but this does
> > > allow us to simplify things and kills a whole class of theoretical UAF
> > > when walking the superblock list.
> > 
> > I'm not sure why is it better to create new ->yield callback called under
> > sb->s_umount rather than just move blkdev_put() calls back into
> > ->put_super? Or at least yielding could be done in ->put_super instead of
> 
> The main reason was to not call potentially expensive
> blkdev_put()/bdev_release() under s_umount. If we don't care about this
> though then this shouldn't be a problem.

So I would not be really concerned about performance here. The superblock
is dying, nobody can do anything about that until the superblock is fully
dead and cleaned up. Maybe some places could skip such superblocks more
quickly but so far I'm not convinced it matters in practice (e.g. writeback
holds s_umount over the whole sync(1) time and nobody complains). And as
you mention below, we have been doing this for a long time without anybody
really complaining.

> And yes, then we need to move
> blkdev_put()/bdev_release() under s_umount including the main block
> device. IOW, we need to ensure that all bdev calls are done under
> s_umount before we remove the superblock from the instance list.

This is about those seemingly spurious "device busy" errors when the
superblock hasn't closed its devices yet, isn't it?  But we now remove
superblock from s_instances list in kill_super_notify() and until that
moment SB_DYING is protecting us from racing mounts. So is there some other
problem?

> I think
> that should be fine but I wanted to propose an alternative to that as
> well: cheap mark-for-release under s_umount and heavy-duty without
> s_umount. But I guess it doesn't matter because most filesystems did use
> to close devices under s_umount before anyway. Let me know what you
> think makes the most sense.

I think we should make it as simple as possible for filesystems. As I said
above I don't think s_umount hold time really matters so the only thing
that limits us are locking constraints. During superblock shutdown the only
thing that currently cannot be done under s_umount (that I'm aware of) is the
teardown of the sb->s_bdi because that waits for writeback threads and
those can be blocked waiting for s_umount.

So if we wanted we could just move ext4 & xfs bdev closing back into
->put_super to avoid ext4_kill_sb() and somewhat slim down xfs_mount_free()
but otherwise I don't see much space for simplification or need for adding
more callbacks :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

