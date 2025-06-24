Return-Path: <linux-fsdevel+bounces-52715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B5AE5FEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70481922067
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94647279DA1;
	Tue, 24 Jun 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP7bdUWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF942797B8;
	Tue, 24 Jun 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755116; cv=none; b=Fw2DYXPo1A98PbYo1DmmirkLbUPN2F7y90geyEwFNw7JKOlcLU9lnLQLeYz0+AeEOLYReSM/x9my9H0aoMARcQgelbcdwkWqLMmAqxh8fGiauoz3ED/Bw69J6ZM0B4vJmtD4x/LYpc7ltbbt67ZOFnrVyY+vpkPKsoWYIUv7rJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755116; c=relaxed/simple;
	bh=NzkYrE3y/4ukAbFGfXpX/2OWjyRwfjxMktJctW/z0aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeo7FSRtDuSZHVJlGLiLjlj3GpgnerzO96v/FGOtt3a8n5WhzAlRUIKzbRVx8y+gcbw4mKZ3FvP8hPCYJ5sAlAWz3hTs79a0dhqTd0gzrhMrK01N9s+W00qQ9OdrzC35OthGtAh6oBzDnkcdF3x4sTdtifV/txcyNvYi0O982bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP7bdUWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EB4C4CEEF;
	Tue, 24 Jun 2025 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750755115;
	bh=NzkYrE3y/4ukAbFGfXpX/2OWjyRwfjxMktJctW/z0aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP7bdUWE8elg686qYG2qhV58qk1svwKkjFc/QvqmQ4iuCZZWZZU+1eB4t+HdSC0us
	 Mdpgt2W8ZvzkN6dLfm8uUwbhx+x91H8iJUOkSL2sKOCaTq2P1J9h0p6eKBYoj3lXTP
	 ttyyKepDnV1ZEQOPq7pFfpCLhrhdSVD4LMmePwxL6EI413aL5pmN7/N425ml8/WRSj
	 jw04r8Li9KM8wh1BX/O0y+meKuPRPyDUcDy0Z3KPJkzY0rVPYHOh3F6O9S+mWThX4x
	 nErrSwXgOT9ljrKrQs218/M294DB7KlXz0mkkEJZeTAHsn8OjV85IBZhw6W0jDyE6E
	 qEX2RfZ0Jhnxw==
Date: Tue, 24 Jun 2025 10:51:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <20250624-geerntet-haare-2ce4cc42b026@brauner>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>

On Tue, Jun 24, 2025 at 06:57:08AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/23 23:27, Christoph Hellwig 写道:
> > On Mon, Jun 23, 2025 at 12:56:28PM +0200, Christian Brauner wrote:
> > >          void (*shutdown)(struct super_block *sb);
> > > +       void (*drop_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> > >   };
> > > 
> > > You might want to drop a block device independent of whether the device
> > > was somehow lost. So I find that a bit more flexible.
> > 
> > Drop is weird word for what is happening here, and if it wasn't for the
> > context in this thread I'd expect it to be about refcounting in Linux.
> > 
> > When the VFS/libfs does an upcall into the file system to notify it
> > that a device is gone that's pretty much a device loss.  I'm not married
> > to the exact name, but drop seems like a pretty bad choice.
> 
> What about a more common used term, mark_dead()?
> 
> It's already used in blk_holder_ops, and I'd say it's more straighforward to
> me, compared to shutdown()/goingdown().

But it's not about the superblock going down necessarily. It's about the
device going away for whatever reason:

void (*yank_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
void (*pull_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
void (*unplug_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
void (*remove_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);

On a single device superblock unplugging that device would obviously
cause an actual shutdown. On multi-device superblocks it doesn't always.

(That brings me to another thought. Is there a use-case for knowing in
advance whether removing a device would shut down the superblock?
Because then the ability to probe whether a device can be safely
removed or an option to only remove the device if it can be removed
without killing the superblock would be a natural extension.)

