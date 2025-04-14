Return-Path: <linux-fsdevel+bounces-46417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AACA88EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 00:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972C117ABD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1B1F4184;
	Mon, 14 Apr 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkPm2Eow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16C188733;
	Mon, 14 Apr 2025 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669176; cv=none; b=BTAeIa2Pv0SATusobj3kpk2i+67VeBrXQ8J0bVxWBBe4p+JKOOdCt9dOyM9VlEgcuWY3NZBxTjdIrWvE6itgH2dFpJt2NdVfSGXA/yOXZS/TCzWvqrMLv+OAlMc1caBLPHfRqf2nkilPhwqqzaw/I13LKYlHVpaWL6R5hDUpyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669176; c=relaxed/simple;
	bh=mtdkZa9At4gqYPvemsMEfO3+E3F5DanxmFy4R/Y/aB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke0hgW8o2ZTSDPf5OqFvFbj4315AKAPULieuyIpJtw7HgjZmBVDuDJmlVUZ82av4cRc68jDE/5bcZ6w/+d0RsQ3okDK8H2BjcyMcqWxESNWjpFdUMOGCLrp3BB6HoyUJU0cd9PopX8q+36iM114CbdlcaCAkYpAIEs3Cwpg7pQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkPm2Eow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4551EC4CEE2;
	Mon, 14 Apr 2025 22:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744669175;
	bh=mtdkZa9At4gqYPvemsMEfO3+E3F5DanxmFy4R/Y/aB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkPm2EowAckq6jWd8gZEXzwMkf2QfMHUiQMFIy70E3iGwRekztQJYTjbsOXAyNgxc
	 UhZ8s6IeIsggwhrBv2pYCQ1fBM3JGQNTX/oMfFY6BP8O7yQ9C9yjdW8Nyl3O6wEkK4
	 YQ+smEWeXDZvwpGIJargk+S1j0E82kaQfJ/QzoGdAGJjF9BodZhuHXbn+XJ7nBWHmT
	 fFXUzBi6mPZ7MMoK6TcqtjAUygbTH+3s4QkYAFxcGX1R8zClgalptG26Hc2tCPGNdz
	 fZKzSti0QDZc3QQtCzlKxDyPFsh8Gl5TyLAJs1x+AfszKPhoCIDtB/04DnwfKIfMgu
	 2TlrKfL4qgGHg==
Date: Mon, 14 Apr 2025 15:19:33 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net,
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com,
	david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <Z_2J9bxCqAUPgq42@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_15mCAv6nsSgRTf@bombadil.infradead.org>

On Mon, Apr 14, 2025 at 02:09:46PM -0700, Luis Chamberlain wrote:
> On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > > @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> > >  			}
> > >  			bh = bh->b_this_page;
> > >  		} while (bh != head);
> > > +		spin_unlock(&mapping->i_private_lock);
> > 
> > No, you've just broken all simple filesystems (like ext2) with this patch.
> > You can reduce the spinlock critical section only after providing
> > alternative way to protect them from migration. So this should probably
> > happen at the end of the series.
> 
> So you're OK with this spin lock move with the other series in place?
> 
> And so we punt the hard-to-reproduce corruption issue as future work
> to do? Becuase the other alternative for now is to just disable
> migration for jbd2:
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1dc09ed5d403..ef1c3ef68877 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3631,7 +3631,6 @@ static const struct address_space_operations ext4_journalled_aops = {
>  	.bmap			= ext4_bmap,
>  	.invalidate_folio	= ext4_journalled_invalidate_folio,
>  	.release_folio		= ext4_release_folio,
> -	.migrate_folio		= buffer_migrate_folio_norefs,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_folio	= generic_error_remove_folio,
>  	.swap_activate		= ext4_iomap_swap_activate,

BTW I ask because.. are your expectations that the next v3 series also
be a target for Linus tree as part of a fix for this spinlock
replacement?

  Luis

