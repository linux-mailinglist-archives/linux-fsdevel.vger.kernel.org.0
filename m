Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB53D6BAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 04:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhG0BTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 21:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233249AbhG0BTg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:19:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF4396044F;
        Tue, 27 Jul 2021 02:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627351203;
        bh=CYY5a6sXIUbXvvfmh1fGeu1HRzHcSsYfC7Nc5x16e70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pItbtAATkfk4wHGbbuFmHFmL9idsCNcWp3oQZtLKut2gzqJ3yKMVfusToCb1jnPl3
         dIAVq7L0wtLtmbmKAhFso9RFDQyE2phgvh1YvDGOdh2d42gX1Hhoay+UN+uRruMXP2
         tH1BlMXGrEcmrN3e8Luks14d6Dk4Q5B684dNC6wHArjXcH1xspCOgacuX9nS1NuLB6
         aYQFWgqkA966lhvCyvzdWgKwnS8BWTQAN+1sC1TGGkOArU3gLYN/c2CvOB9wO59/In
         obrTifawxMcYLOYfNa24jOekdgZqLgjazIGA5dFItMMFkxOoeyGBxRU8m651lU6kWa
         luJ38w87JD5hg==
Date:   Mon, 26 Jul 2021 19:00:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
Message-ID: <YP9oou9sx4oJF1sc@google.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
 <YP2l+1umf9ct/4Sp@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YP2l+1umf9ct/4Sp@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/25, Eric Biggers wrote:
> On Sun, Jul 25, 2021 at 06:50:51PM +0800, Chao Yu wrote:
> > On 2021/7/16 22:39, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > f2fs_write_begin() assumes that all blocks were preallocated by
> > > default unless FI_NO_PREALLOC is explicitly set.  This invites data
> > > corruption, as there are cases in which not all blocks are preallocated.
> > > Commit 47501f87c61a ("f2fs: preallocate DIO blocks when forcing
> > > buffered_io") fixed one case, but there are others remaining.
> > 
> > Could you please explain which cases we missed to handle previously?
> > then I can check those related logic before and after the rework.
> 
> Any case where a buffered write happens while not all blocks were preallocated
> but FI_NO_PREALLOC wasn't set.  For example when ENOSPC was hit in the middle of
> the preallocations for a direct write that will fall back to a buffered write,
> e.g. due to f2fs_force_buffered_io() or page cache invalidation failure.
> 
> > 
> > > -			/*
> > > -			 * If force_buffere_io() is true, we have to allocate
> > > -			 * blocks all the time, since f2fs_direct_IO will fall
> > > -			 * back to buffered IO.
> > > -			 */
> > > -			if (!f2fs_force_buffered_io(inode, iocb, from) &&
> > > -					f2fs_lfs_mode(F2FS_I_SB(inode)))
> > > -				goto write;
> > 
> > We should keep this OPU DIO logic, otherwise, in lfs mode, write dio
> > will always allocate two block addresses for each 4k append IO.
> > 
> > I jsut test based on codes of last f2fs dev-test branch.
> 
> Yes, I had misread that due to the weird goto and misleading comment and
> translated it into:
> 
>         /* If it will be an in-place direct write, don't bother. */
>         if (dio && !f2fs_lfs_mode(sbi))
>                 return 0;
> 
> It should be:
> 
>         if (dio && f2fs_lfs_mode(sbi))
>                 return 0;

Hmm, this addresses my 250 failure. And, I think the below commit can explain
the case.

commit 47501f87c61ad2aa234add63e1ae231521dbc3f5
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Tue Nov 26 15:01:42 2019 -0800

    f2fs: preallocate DIO blocks when forcing buffered_io

    The previous preallocation and DIO decision like below.

                             allow_outplace_dio              !allow_outplace_dio
    f2fs_force_buffered_io   (*) No_Prealloc / Buffered_IO   Prealloc / Buffered_IO
    !f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO

    But, Javier reported Case (*) where zoned device bypassed preallocation but
    fell back to buffered writes in f2fs_direct_IO(), resulting in stale data
    being read.

    In order to fix the issue, actually we need to preallocate blocks whenever
    we fall back to buffered IO like this. No change is made in the other cases.

                             allow_outplace_dio              !allow_outplace_dio
    f2fs_force_buffered_io   (*) Prealloc / Buffered_IO      Prealloc / Buffered_IO
    !f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO

    Reported-and-tested-by: Javier Gonzalez <javier@javigon.com>
    Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
    Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    Reviewed-by: Chao Yu <yuchao0@huawei.com>
    Reviewed-by: Javier González <javier@javigon.com>
    Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>


> 
> Do you have a proper explanation for why preallocations shouldn't be done in
> this case?  Note that preallocations are still done for buffered writes, which
> may be out-of-place as well; how are those different?
> 
> - Eric
