Return-Path: <linux-fsdevel+bounces-46445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A055A8976E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DCE189D591
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EC027FD68;
	Tue, 15 Apr 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnDaFjao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E927EC89;
	Tue, 15 Apr 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707946; cv=none; b=hQBJIeF1q0lafGVzkkWItUovRSI1G6JAhOREOnmXsEG1U4MO5aL3s2dBsNUYa/uYUnwN07pikeVu38pqivGxfzCQeOud02rfHbt+qrENRvAuwyLa9E1iuGwr+ot3gweXvjAmU9FLyjZOZacNzv4L1BubW01lvtv/PnxkVQq+JNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707946; c=relaxed/simple;
	bh=Jk1eZdnZg7G5vh0w7ZZMU2B0/djohjlF/9UhwnoXVqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl24PJfeP+i/7+hi9qXvOwy8hJkiN04ROFOy0dpgKVPqnW1TTjHO+jq1s2Lb8oeNZWr3vD7mveVtdf4iE8rncFpgYOAX2N2DcDx9xmR6dIlKtvcyZrhOoHfOH316aP7LsRnSFx2oxG6rAYUfU/b7DHph5fEz70eeaZVhXa0x+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnDaFjao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D349C4CEDD;
	Tue, 15 Apr 2025 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744707946;
	bh=Jk1eZdnZg7G5vh0w7ZZMU2B0/djohjlF/9UhwnoXVqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnDaFjaoBbP4Ukx95bRanjXNjAhy3CPInDT7xMQPQ9yzQiJf4C55jyHbKIXkNhxVl
	 hJysns7LjdmPe0fO2wmPSEbzyBco46UODoD0j+j+kl3v3SU44XIrnewY70CWY37OeK
	 pfLLQ72QvzY1o9jaww271/RexBEWW2Dl2FA48OmMXBYk28jE3aJtnOQxnsAPsIchGC
	 pfwPrGPaUGI5eSOZZxjBYpPhQyunRS/kpgzS9eXFsfU4F3k3uVEEOzlVcLpJLcKmmP
	 /j5uUgwzbKjkCVPJL18oLf9pDxhAsBPH7tvvbjaZVAi9mx15ZVUEYXjLdU1fB9dN69
	 /jeeXnNuBORqw==
Date: Tue, 15 Apr 2025 11:05:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net, willy@infradead.org, 
	hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk, 
	hare@suse.de, david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <20250415-freihalten-tausend-a9791b9c3a03@brauner>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
 <Z_2J9bxCqAUPgq42@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_2J9bxCqAUPgq42@bombadil.infradead.org>

On Mon, Apr 14, 2025 at 03:19:33PM -0700, Luis Chamberlain wrote:
> On Mon, Apr 14, 2025 at 02:09:46PM -0700, Luis Chamberlain wrote:
> > On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > > > @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> > > >  			}
> > > >  			bh = bh->b_this_page;
> > > >  		} while (bh != head);
> > > > +		spin_unlock(&mapping->i_private_lock);
> > > 
> > > No, you've just broken all simple filesystems (like ext2) with this patch.
> > > You can reduce the spinlock critical section only after providing
> > > alternative way to protect them from migration. So this should probably
> > > happen at the end of the series.
> > 
> > So you're OK with this spin lock move with the other series in place?
> > 
> > And so we punt the hard-to-reproduce corruption issue as future work
> > to do? Becuase the other alternative for now is to just disable
> > migration for jbd2:
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 1dc09ed5d403..ef1c3ef68877 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3631,7 +3631,6 @@ static const struct address_space_operations ext4_journalled_aops = {
> >  	.bmap			= ext4_bmap,
> >  	.invalidate_folio	= ext4_journalled_invalidate_folio,
> >  	.release_folio		= ext4_release_folio,
> > -	.migrate_folio		= buffer_migrate_folio_norefs,
> >  	.is_partially_uptodate  = block_is_partially_uptodate,
> >  	.error_remove_folio	= generic_error_remove_folio,
> >  	.swap_activate		= ext4_iomap_swap_activate,
> 
> BTW I ask because.. are your expectations that the next v3 series also
> be a target for Linus tree as part of a fix for this spinlock
> replacement?

Since this is fixing potential filesystem corruption I will upstream
whatever we need to do to fix this. Ideally we have a minimal fix to
upstream now and a comprehensive fix and cleanup for v6.16.

