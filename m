Return-Path: <linux-fsdevel+bounces-43281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349EA505F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A60188B1C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58B24CEDF;
	Wed,  5 Mar 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYUpmr5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9B567D;
	Wed,  5 Mar 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194317; cv=none; b=rHTxIyKGTSxFmC6Gz6irCUGS6TzE5Lw6o/c3xtqZ8pVWB6ib3izt5QbpZeWeChZ1oeLR18WZgPZZ5IblxOrQXacos7YkbWyFGRYycEGYnq3PzZw+dHODS15bSCsZHzfA5wUUuEGpnCwCh8SElOX8G6Og14uxBcLypAGyPNtFWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194317; c=relaxed/simple;
	bh=OvawHCs/kJE9TlRrbjmfJfFS35i27Yx8W9F4l+uWkGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIT+OROTTQrqV1L8CEsRz4dmvLrs9Z18/Pr7L6dYqn03eRUCaqAE+8GtucP9/qB78f4Ug1WBF3zyZA4YJTDhXevWRnPiIhpxCZHF8l2Szn2tsV4+6AZpVr3wlnUWZzfiUVYh2pgH1EDCNMid/ijR5970NRlKnsMm51V6963ACDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYUpmr5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C455C4CED1;
	Wed,  5 Mar 2025 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741194317;
	bh=OvawHCs/kJE9TlRrbjmfJfFS35i27Yx8W9F4l+uWkGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYUpmr5TcXkJt0Lk9VwxOQZ+8WbHe00EfZYh/FurgDEHjCGM6eLAahnlwPasqqeIo
	 5wraWII+1xA9C0PLHLVcxXcES2gBtVwcyqLpbeHZjUtGD4nPlbRrzP7DEfKdQKgcag
	 0z7hGlB1e+qX496vQd/W8agYZOoeyyhpqeNwVEhpPe7leNqDfFlrP/ZqFkpayrtSk/
	 6znx76bYSsBP4iPSl1Y/gVjPT9Rgsnxzrh3IN1ulrchaiodjDeuLoWYfRx9cCTN7NP
	 rOBup8sme9RMF/HuEJ6X2AHw6PUO1n88YqzaC+HbuRgwJ3jIfQctPaV8s9BrmgalnB
	 CEIqMRMiYR6xw==
Date: Wed, 5 Mar 2025 09:05:15 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: brauner@kernel.org, willy@infradead.org, david@fromorbit.com,
	djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <Z8iESw0-f8diPGp8@bombadil.infradead.org>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
 <828e529d-3e42-4b9e-a0ce-a05516a7274d@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <828e529d-3e42-4b9e-a0ce-a05516a7274d@suse.de>

On Wed, Mar 05, 2025 at 08:18:29AM +0100, Hannes Reinecke wrote:
> On 3/5/25 02:53, Luis Chamberlain wrote:
> > The commit titled "block/bdev: lift block size restrictions to 64k"
> > lifted the block layer's max supported block size to 64k inside the
> > helper blk_validate_block_size() now that we support large folios.
> > However in lifting the block size we also removed the silly use
> > cases many filesystems have to use sb_set_blocksize() to *verify*
> > that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
> > happen in-kernel given mkfs utilities *can* create for example an
> > ext4 32k block size filesystem on x86_64, the issue we want to prevent
> > is mounting it on x86_64 unless the filesystem supports LBS.
> > 
> > While, we could argue that such checks should be filesystem specific,
> > there are much more users of sb_set_blocksize() than LBS enabled
> > filesystem on linux-next, so just do the easier thing and bring back
> > the PAGE_SIZE check for sb_set_blocksize() users.
> > 
> > This will ensure that tests such as generic/466 when run in a loop
> > against say, ext4, won't try to try to actually mount a filesystem with
> > a block size larger than your filesystem supports given your PAGE_SIZE
> > and in the worst case crash.
> > 
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> > 
> > Christian, a small fixup for a crash when running generic/466 on ext4
> > in a loop. The issue is obvious, and we just need to ensure we don't
> > break old filesystem expectations of sb_set_blocksize().
> > 
> > This still allows XFS with 32k block size and I even tested with XFS
> > with 32k block size and a 32k sector size set.
> > 
> >   block/bdev.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 3bd948e6438d..de9ebc3e5d15 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -181,7 +181,7 @@ EXPORT_SYMBOL(set_blocksize);
> >   int sb_set_blocksize(struct super_block *sb, int size)
> >   {
> > -	if (set_blocksize(sb->s_bdev_file, size))
> > +	if (size > PAGE_SIZE || set_blocksize(sb->s_bdev_file, size))
> >   		return 0;
> >   	/* If we get here, we know size is validated */
> >   	sb->s_blocksize = size;
> 
> Can you add a comment stating why it's needed, even with LBS?
> It's kinda non-obious, and we don't want to repeat the mistake
> in the future.

Sure.

 Luis

