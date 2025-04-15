Return-Path: <linux-fsdevel+bounces-46488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B1A8A357
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FF617E361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5C20AF62;
	Tue, 15 Apr 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr932TZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0F19DF48;
	Tue, 15 Apr 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732073; cv=none; b=U+PztnzRASszrcvwso5s/1dhCLojE01H4ZuAsvifltNiLguhL4vIom6hqePiHkU/L+sgFSYmfLaJ8RUu3pG/jAUIdIaVurFpQQfm8Kcur1YJW3kTLlS975+/U73A3j74IAYrFlkQ8SMG+2EqXKJcK4kZky4rVSg0VKsLLoCt+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732073; c=relaxed/simple;
	bh=kxmFcQDJ+JlN9IfPV3DM8E3EagG+moUhDz8DUHXPMkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb3mZakG8HgUn0S06GpuspjvkwygTzy6TBTxzLrOP6fI7s6BfycrvPAdByOkT26qRpIHkEdeTq4QqDgNlqHxQxYxCc8rL5+fV7hv1yqS7Grd89MZGLglz82Pgx6nYrHwez2vd1an5RrWrlaJN8oycAnVqYq7krk9B54k1ejBDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr932TZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C55C4CEEB;
	Tue, 15 Apr 2025 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744732073;
	bh=kxmFcQDJ+JlN9IfPV3DM8E3EagG+moUhDz8DUHXPMkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dr932TZVkc9yCxpr4kJ6POc0QEMnT2JGyjYw3eFy0cjgaTuIqDQPyqjKLPss6VFI4
	 Qa7qjCYibaB6mt+sdNawo5jePudUTkq7svKOPdJyX32IzxSBhoRDGwr/Wi1u2oLDNy
	 bq1WXDPexYb+N3+LjqtasY5ueOOF09THvoNggnff0CbdQO2FPapLtUMpLbucBLc7E9
	 KNEDfXq38XRaHDhaQkQyB0fBxSWAqlbZCtQGQop8ZH3x3CWLYO0TNPqv4O1Bj0JmbW
	 edj3LSONuxjLsv3yTJmjLvV7ih63uD443nMoICh9l4GWybMRggMgRjkEUmVgMuScJc
	 9er4nsuafOrLA==
Date: Tue, 15 Apr 2025 08:47:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
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
Message-ID: <Z_5_p3t_fNUBoG7Y@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
 <Z_2J9bxCqAUPgq42@bombadil.infradead.org>
 <20250415-freihalten-tausend-a9791b9c3a03@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-freihalten-tausend-a9791b9c3a03@brauner>

On Tue, Apr 15, 2025 at 11:05:38AM +0200, Christian Brauner wrote:
> On Mon, Apr 14, 2025 at 03:19:33PM -0700, Luis Chamberlain wrote:
> > On Mon, Apr 14, 2025 at 02:09:46PM -0700, Luis Chamberlain wrote:
> > > On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > > > > @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> > > > >  			}
> > > > >  			bh = bh->b_this_page;
> > > > >  		} while (bh != head);
> > > > > +		spin_unlock(&mapping->i_private_lock);
> > > > 
> > > > No, you've just broken all simple filesystems (like ext2) with this patch.
> > > > You can reduce the spinlock critical section only after providing
> > > > alternative way to protect them from migration. So this should probably
> > > > happen at the end of the series.
> > > 
> > > So you're OK with this spin lock move with the other series in place?
> > > 
> > > And so we punt the hard-to-reproduce corruption issue as future work
> > > to do? Becuase the other alternative for now is to just disable
> > > migration for jbd2:
> > > 
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 1dc09ed5d403..ef1c3ef68877 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -3631,7 +3631,6 @@ static const struct address_space_operations ext4_journalled_aops = {
> > >  	.bmap			= ext4_bmap,
> > >  	.invalidate_folio	= ext4_journalled_invalidate_folio,
> > >  	.release_folio		= ext4_release_folio,
> > > -	.migrate_folio		= buffer_migrate_folio_norefs,
> > >  	.is_partially_uptodate  = block_is_partially_uptodate,
> > >  	.error_remove_folio	= generic_error_remove_folio,
> > >  	.swap_activate		= ext4_iomap_swap_activate,
> > 
> > BTW I ask because.. are your expectations that the next v3 series also
> > be a target for Linus tree as part of a fix for this spinlock
> > replacement?
> 
> Since this is fixing potential filesystem corruption I will upstream
> whatever we need to do to fix this. Ideally we have a minimal fix to
> upstream now and a comprehensive fix and cleanup for v6.16.

Despite our efforts we don't yet have an agreement on how to fix the
ext4 corruption, becuase Jan noted the buffer_meta() check in this patch
is too broad and would affect other filesystems (I have yet to
understand how, but will review).

And so while we have agreement we can remove the spin lock to fix the
sleeping while atomic incurred by large folios for buffer heads by this
patch series, the removal of the spin lock would happen at the end of
this series.

And so the ext4 corruption is an existing issue as-is today, its
separate from the spin lock removal goal to fix the sleeping while
atomic..

However this series might be quite big for an rc2 or rc3 fix for that spin
lock removal issue. It should bring in substantial performance benefits
though, so it might be worthy to consider. We can re-run tests with the
adjustment to remove the spin lock until the last patch in this series.

The alternative is to revert the spin lock addition commit for Linus'
tree, ie commit ebdf4de5642fb6 ("mm: migrate: fix reference check race
between __find_get_block() and migration") and note that it in fact does
not fix the ext4 corruption as we've noted, and in fact causes an issue
with sleeping while atomic with support for large folios for buffer
heads. If we do that then we  punt this series for the next development
window, and it would just not have the spin lock removal on the last
patch.

Jan Kara, Christian, thoughts?

  Luis

