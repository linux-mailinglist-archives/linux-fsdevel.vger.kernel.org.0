Return-Path: <linux-fsdevel+bounces-52723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200DAE6065
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1260D405FB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9FD27AC28;
	Tue, 24 Jun 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMNPHHMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA427A445;
	Tue, 24 Jun 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756419; cv=none; b=KVyQeCJDFP7zmqQBoZB1hxJd8eaqg0F5319ViYvcPneR7Bi6x2jLHkcq65bsmDkZdEcuQhSgNkyoUml7uOlXLM/ad6qFbT45zXm+vN/OWSpj01Ndrw6iF2vyvmLBSfe2CRbXpFLqQEyu0cR6S1gS5ra8KPOVWv7JrDw0f4nalcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756419; c=relaxed/simple;
	bh=ENQDNM8agyaRhChQPBLyYdkAToQeaHv9AicS3tge5bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/36Tkajk4phVtxnAYDMfq0sGtqEmJhsH3O7Q1VXdqvtuXYKT1sPIgj8ooCcnpLGOF4T0s2JBqbN8p5GrFrWwo09GwxwjTIY4Qzlju5+0kw00qRUxEJqbeWyINgbzhGt1U9+Lw/oNuWftvPy2HZJQZ5pk3AU545iaBARFvyJs1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMNPHHMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40C4C4CEE3;
	Tue, 24 Jun 2025 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750756415;
	bh=ENQDNM8agyaRhChQPBLyYdkAToQeaHv9AicS3tge5bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMNPHHMAQOylsqtc6JEIKhF6aASUmXRy/fv+5+8tmWN5aeSkIYSvqPoU41RRgXPhg
	 wPyx9dhPLDhqzLsAH/nEJTsjpUZpbP6u3vR6uta0CDQiTyGAfUw10R8N1uA3GWKghg
	 ujwWudchiWF1zzcHZ1ISvfV4cs7jS4cF2TdzsYHtOhtIAef3aNSvkUmBhsHTHP7zbL
	 MIQgHVis4Pdm5QNo1uLdKQj/iDvWbT/Sgh3KNmqaipFxD4ypG8OOjjaURIL4wOuIJp
	 519wFYxRELRqMvQCvFUCfODajBG3zekVKETfv0joTTz4x7eXHoqPwpm6GvR4Bm/J/4
	 ahPRHcjdb6ABw==
Date: Tue, 24 Jun 2025 11:13:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <20250624-briefe-hassen-f693b4fe3501@brauner>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
 <20250624-geerntet-haare-2ce4cc42b026@brauner>
 <8db82a80-242f-41ff-84b8-601d6dcd9b9d@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8db82a80-242f-41ff-84b8-601d6dcd9b9d@suse.com>

On Tue, Jun 24, 2025 at 06:36:01PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/24 18:21, Christian Brauner 写道:
> > On Tue, Jun 24, 2025 at 06:57:08AM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/6/23 23:27, Christoph Hellwig 写道:
> > > > On Mon, Jun 23, 2025 at 12:56:28PM +0200, Christian Brauner wrote:
> > > > >           void (*shutdown)(struct super_block *sb);
> > > > > +       void (*drop_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> > > > >    };
> > > > > 
> > > > > You might want to drop a block device independent of whether the device
> > > > > was somehow lost. So I find that a bit more flexible.
> > > > 
> > > > Drop is weird word for what is happening here, and if it wasn't for the
> > > > context in this thread I'd expect it to be about refcounting in Linux.
> > > > 
> > > > When the VFS/libfs does an upcall into the file system to notify it
> > > > that a device is gone that's pretty much a device loss.  I'm not married
> > > > to the exact name, but drop seems like a pretty bad choice.
> > > 
> > > What about a more common used term, mark_dead()?
> > > 
> > > It's already used in blk_holder_ops, and I'd say it's more straighforward to
> > > me, compared to shutdown()/goingdown().
> > 
> > But it's not about the superblock going down necessarily. It's about the
> > device going away for whatever reason:
> > 
> > void (*yank_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> > void (*pull_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> > void (*unplug_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> > void (*remove_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> 
> All sound good to me, although the last one sounds better.
> 
> > 
> > On a single device superblock unplugging that device would obviously
> > cause an actual shutdown. On multi-device superblocks it doesn't always.
> > 
> > (That brings me to another thought. Is there a use-case for knowing in
> > advance whether removing a device would shut down the superblock?
> 
> Maybe another interface like can_remove_bdev()?
> 
> It's not hard for btrfs to provide it, we already have a check function
> btrfs_check_rw_degradable() to do that.
> 
> Although I'd say, that will be something way down the road.

Yes, for sure. I think long-term we should hoist at least the bare
infrastructure for multi-device filesystem management into the VFS.
Or we should at least explore whether that's feasible and if it's
overall advantageous to maintenance and standardization. We've already
done a bit of that and imho it's now a lot easier to reason about the
basics already.

> 
> We even don't have a proper way to let end user configure the device loss
> behavior.
> E.g. some end users may prefer a full shutdown to be extra cautious, other
> than continue degraded.

Right.

