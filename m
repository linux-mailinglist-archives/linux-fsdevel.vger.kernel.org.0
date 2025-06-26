Return-Path: <linux-fsdevel+bounces-53068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8829AE99B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 11:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7CA7AD245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 09:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D629C35F;
	Thu, 26 Jun 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7b4RJXz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149972957C2;
	Thu, 26 Jun 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929025; cv=none; b=s9Zw5g8mz+YbOCfiOMKEMl+CVnrdYSB7Dt4aI/3sPLKl0GeUiE6Eh7j7Gzf/JI/vAPJuNEihUeq09eVSPOxOx4tvbeq4TtImHIMjHFvsD/1xHkVLvPaePpLATGwBaZzuraWb2vRxEDq0UYd7zi6+XvSycLNgSpgD9/68peKZ+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929025; c=relaxed/simple;
	bh=pAsXc+z6pmAVZPSnPeaJT/d72XIws/Jf+INsZWbA8VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4/09BNRHMuGQ8o0wj1NdgmXb/A3LBFB3WqUsTWVwU+t/PuTRu3ewHAQLdBAEjzJL0JVAppuNarRK/DWSizFgw/94NfrOjrKQjj/W2YJIcSoznPkR5+EAjV8GjioTBQfnR2INeOTmowk3IV7UBPCTpBfwjrsVnxXYwYNbomteTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7b4RJXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2850BC4CEEB;
	Thu, 26 Jun 2025 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750929024;
	bh=pAsXc+z6pmAVZPSnPeaJT/d72XIws/Jf+INsZWbA8VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7b4RJXz1MM4XQQNveHTnlPOkEEJksy/ImMxNixSS8UgSagk+x7yJ2bv5jACpJbFs
	 SU8JRVCyvunjZENY5MRekXjdq0qhPyUANo/DMiULMZF8HtHcKF3xuPAckH7tj+tXzR
	 Z6VWR2E2DPznvQRfTvB/nTpJzTq6RUmEOojCK5HJ6LsCIvYgJLWLeMT29AocHTkkmh
	 J8K82h56xjiLgAZe8AbLdG9AsqtFTz/a3ipi6DANHFtddFCalCV0PDXWGDvIIz0hjV
	 YldA76mosdJ8JuCp2m5G5ybPRboyfiwTI9JNlQ3wwKV35ovuFI6mY1TUVWOy+XtMor
	 VUyNovkUXOPkw==
Date: Thu, 26 Jun 2025 11:10:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
Message-ID: <20250626-fazit-neubau-ef77346c5d8b@brauner>
References: <cover.1750895337.git.wqu@suse.com>
 <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
 <20250626-schildern-flutlicht-36fa57d43570@brauner>
 <e8709e52-5a64-470e-922f-c026190fcd91@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8709e52-5a64-470e-922f-c026190fcd91@suse.com>

On Thu, Jun 26, 2025 at 06:14:03PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/26 18:08, Christian Brauner 写道:
> > On Thu, Jun 26, 2025 at 09:23:42AM +0930, Qu Wenruo wrote:
> > > The new remove_bdev() call back is mostly for multi-device filesystems
> > > to handle device removal.
> > > 
> > > Some multi-devices filesystems like btrfs can have the ability to handle
> > > device lose according to the setup (e.g. all chunks have extra mirrors),
> > > thus losing a block device will not interrupt the normal operations.
> > > 
> > > Btrfs will soon implement this call back by:
> > > 
> > > - Automatically degrade the fs if read-write operations can be
> > >    maintained
> > > 
> > > - Shutdown the fs if read-write operations can not be maintained
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   fs/super.c         |  4 +++-
> > >   include/linux/fs.h | 18 ++++++++++++++++++
> > >   2 files changed, 21 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/super.c b/fs/super.c
> > > index 80418ca8e215..07845d2f9ec4 100644
> > > --- a/fs/super.c
> > > +++ b/fs/super.c
> > > @@ -1463,7 +1463,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
> > >   		sync_filesystem(sb);
> > >   	shrink_dcache_sb(sb);
> > >   	evict_inodes(sb);
> > > -	if (sb->s_op->shutdown)
> > > +	if (sb->s_op->remove_bdev)
> > > +		sb->s_op->remove_bdev(sb, bdev, surprise);
> > > +	else if (sb->s_op->shutdown)
> > >   		sb->s_op->shutdown(sb);
> > 
> > This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
> > really dislike this pattern. It introduces the possibility that a
> > filesystem accidently implement both variants and assumes both are
> > somehow called. That can be solved by an assert at superblock initation
> > time but it's still nasty.
> > 
> > The other thing is that this just reeks of being the wrong api. We
> > should absolutely aim for the methods to not be mutually exclusive. I
> > hate that with a passion. That's just an ugly api and I want to have as
> > little of that as possible in our code.
> 
> So what do you really want?
> 
> The original path to expand the shutdown() callback is rejected, and now the
> new callback is also rejected.
> 
> I guess the only thing left is to rename shutdown() to remove_bdev(), add
> the new parameters and keep existing fses doing what they do (aka,
> shutdown)?

Yes. My original understanding had been that ->remove_bdev() would be
called in a different codepath than ->shutdown() and they would be
complimentary. So sorry for the back and forth here. If that's not the
case I don't see any point in having two distinct methods.

> 
> Thanks,
> Qu
> 
> > 
> > >   	super_unlock_shared(sb);
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index b085f161ed22..5e84e06c7354 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2367,7 +2367,25 @@ struct super_operations {
> > >   				  struct shrink_control *);
> > >   	long (*free_cached_objects)(struct super_block *,
> > >   				    struct shrink_control *);
> > > +	/*
> > > +	 * Callback to shutdown the fs.
> > > +	 *
> > > +	 * If a fs can not afford losing any block device, implement this callback.
> > > +	 */
> > >   	void (*shutdown)(struct super_block *sb);
> > > +
> > > +	/*
> > > +	 * Callback to handle a block device removal.
> > > +	 *
> > > +	 * Recommended to implement this for multi-device filesystems, as they
> > > +	 * may afford losing a block device and continue operations.
> > > +	 *
> > > +	 * @surprse:	indicates a surprise removal. If true the device/media is
> > > +	 *		already gone. Otherwise we're prepareing for an orderly
> > > +	 *		removal.
> > > +	 */
> > > +	void (*remove_bdev)(struct super_block *sb, struct block_device *bdev,
> > > +			    bool surprise);
> > >   };
> > 
> > Yeah, I think that's just not a good api. That looks a lot to me like we
> > should just collapse both functions even though earlier discussion said
> > we shouldn't. Just do:
> > 
> > s/shutdown/remove_bdev/
> > 
> > or
> > 
> > s/shutdown/shutdown_bdev()
> > 
> > The filesystem will know whether it has to kill the filesystem or if it
> > can keep going even if the device is lost. Hell, if we have to we could
> > just have it return whether it killed the superblock or just the device
> > by giving the method a return value. But for now it probably doesn't
> > matter.
> 

