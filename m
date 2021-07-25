Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C43D4F56
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jul 2021 19:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGYRQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 13:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGYRQr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:16:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FCE06052B;
        Sun, 25 Jul 2021 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627235837;
        bh=e/IOT6aLgM/vFCn/0MMYqLC9/0uViRF4ZtqRX35F+sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYXgZljB7L/v8+LISB1zPqkBLZ+KVdE58D8YU92HaY2sNgpnh191qmRSdAcIcf9xr
         fCG0bnZeif5q/Jol0JhZANiZXv7veDY0bCgaMITJuU8wbJgy6VhOxtby/83Epde6/d
         wdzpa9GDDhL1A7IJPK1SEHrkPQDdVfoT9Rq/5nh7mDh0+fKqypOZXaDwahKTqZGHi4
         aUAcH1jNsgAPZyYQB4UF8D1a97/UnXwAwIL/S+5yZ70lRmAua9TnpX0UL/epsVNYpL
         yicORP/grKkfV2Z+yysiNyZAnie7wJouR/8OgVFCPne6LxmVjow/UGhZF6dQMhn6o0
         6q7tk9egQI7Xw==
Date:   Sun, 25 Jul 2021 10:57:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
Message-ID: <YP2l+1umf9ct/4Sp@sol.localdomain>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 25, 2021 at 06:50:51PM +0800, Chao Yu wrote:
> On 2021/7/16 22:39, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > f2fs_write_begin() assumes that all blocks were preallocated by
> > default unless FI_NO_PREALLOC is explicitly set.  This invites data
> > corruption, as there are cases in which not all blocks are preallocated.
> > Commit 47501f87c61a ("f2fs: preallocate DIO blocks when forcing
> > buffered_io") fixed one case, but there are others remaining.
> 
> Could you please explain which cases we missed to handle previously?
> then I can check those related logic before and after the rework.

Any case where a buffered write happens while not all blocks were preallocated
but FI_NO_PREALLOC wasn't set.  For example when ENOSPC was hit in the middle of
the preallocations for a direct write that will fall back to a buffered write,
e.g. due to f2fs_force_buffered_io() or page cache invalidation failure.

> 
> > -			/*
> > -			 * If force_buffere_io() is true, we have to allocate
> > -			 * blocks all the time, since f2fs_direct_IO will fall
> > -			 * back to buffered IO.
> > -			 */
> > -			if (!f2fs_force_buffered_io(inode, iocb, from) &&
> > -					f2fs_lfs_mode(F2FS_I_SB(inode)))
> > -				goto write;
> 
> We should keep this OPU DIO logic, otherwise, in lfs mode, write dio
> will always allocate two block addresses for each 4k append IO.
> 
> I jsut test based on codes of last f2fs dev-test branch.

Yes, I had misread that due to the weird goto and misleading comment and
translated it into:

        /* If it will be an in-place direct write, don't bother. */
        if (dio && !f2fs_lfs_mode(sbi))
                return 0;

It should be:

        if (dio && f2fs_lfs_mode(sbi))
                return 0;

Do you have a proper explanation for why preallocations shouldn't be done in
this case?  Note that preallocations are still done for buffered writes, which
may be out-of-place as well; how are those different?

- Eric
