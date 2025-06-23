Return-Path: <linux-fsdevel+bounces-52527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD7AE3D7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F7A3A856E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771523D284;
	Mon, 23 Jun 2025 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX7qROy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4A21B19D;
	Mon, 23 Jun 2025 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676192; cv=none; b=dqwvYR4pL3v4isJFXXImyVFFKZn0swj4rFDvv4+7tprOSAoLRTJT4YTfvy/1AKk7EJIVys5eMuRMoAORO7Q/TaSg32JOMthkI8pizq8GHEEFWlouqPUiPIulKByaRmaV/rsrg+GFvDLRsY0FQ62zHr5iZ+aTNDR9our4pX4GdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676192; c=relaxed/simple;
	bh=kX2mhekJF3VKbrcozAI14iPIsZq4GToTAHuxaKXvHjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge6urnXQSOZZkT+SUY8XZEduvUbFvtqgh+lknW4T7A8vnzg/CtfL/LedD75/EnYhqMLa/Zm9NwfTnGv4At0cc4GmrAG/ypAAXTixqwyAl73ysf7M+9To/wK+B1sMfc18Dy+40tgSjVtl/0HpYoh/AROHWXihNWxbhMaAbXNR/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX7qROy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFC6C4CEF4;
	Mon, 23 Jun 2025 10:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750676192;
	bh=kX2mhekJF3VKbrcozAI14iPIsZq4GToTAHuxaKXvHjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uX7qROy+oWdsmYhYOldCkrykZjpk9u4+W/jlObMmhYKnD44/pMft53K90+xAPnsxj
	 gyMJjx0TIYpjpC3M+BpImWiR6gY9qhwi5d6NnIQzsJPWePLBqkfxh0LA9IsMeTOSDB
	 RGDrGmC2HXjV3FNicCqIBIBj++9dlu+9+Gm7g4qqyEGI7RRflJOmmnQ5pU1gh889+E
	 vfYQcRSKLgO5j+0C45iaOm5uYznkRowts6IfbVjnZVS4+5Mb1vBfiwUySNhk1xqB1v
	 fpNJGXLNqqehGXE/5MQFKUY22eLa6tFHMiIynRoYO0eZ6z/SYHX65um2D1OG5G66Wh
	 4AyTAuTCzjVGA==
Date: Mon, 23 Jun 2025 12:56:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <20250623-worte-idolisieren-75354608512a@brauner>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFji5yfAvEeuwvXF@infradead.org>

On Sun, Jun 22, 2025 at 10:15:19PM -0700, Christoph Hellwig wrote:
> On Fri, Jun 20, 2025 at 05:36:52PM +0200, Jan Kara wrote:
> > On Fri 20-06-25 15:17:28, Qu Wenruo wrote:
> > > Currently we already have the super_operations::shutdown() callback,
> > > which is called when the block device of a filesystem is marked dead.
> > > 
> > > However this is mostly for single(ish) block device filesystems.
> > > 
> > > For multi-device filesystems, they may afford a missing device, thus may
> > > continue work without fully shutdown the filesystem.
> > > 
> > > So add a new super_operation::shutdown_bdev() callback, for mutli-device
> > > filesystems like btrfs and bcachefs.
> > > 
> > > For now the only user is fs_holder_ops::mark_dead(), which will call
> > > shutdown_bdev() if supported.
> > > If not supported then fallback to the original shutdown() callback.
> > > 
> > > Btrfs is going to add the usage of shutdown_bdev() soon.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > Thanks for the patch. I think that we could actually add 'bdev' that
> > triggered shutdown among arguments ->shutdown takes instead of introducing
> > a new handler.
> 
> I don't really think that's a good idea as-is.  The current ->shutdown
> callback is called ->shutdown because it is expected to shut the file
> system down.  That's why I suggested to Qu to add a new devloss callback,
> to describe that a device is lost.  In a file system with built-in
> redundancy that is not a shutdown.  So Qu, please add a devloss
> callback.  And maybe if we have no other good use for the shutdown
> callback we can remove it in favor of the devloss one.  But having
> something named shutdown take the block device and not always shutting
> the file system down is highly confusing.

I think we should add:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b085f161ed22..1d07f862a6a2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2368,6 +2368,7 @@ struct super_operations {
        long (*free_cached_objects)(struct super_block *,
                                    struct shrink_control *);
        void (*shutdown)(struct super_block *sb);
+       void (*drop_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
 };

You might want to drop a block device independent of whether the device
was somehow lost. So I find that a bit more flexible.

