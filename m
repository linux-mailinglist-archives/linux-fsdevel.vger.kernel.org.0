Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF53D85E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 04:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhG1C3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 22:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhG1C3Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 22:29:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7069F60F9D;
        Wed, 28 Jul 2021 02:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627439364;
        bh=92/QU5E2eSQ6Mi3MNPH50dd6V05Hb7i5VrQtXsDNLTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sngqlEFdZ1mpdSmM5PMlNOmlefHphaw0iNtvYJjbHzNcP7420wr+CKetnrlksePur
         aejSQgZbvhFwgqUm6+p1O054oZMR+q6GVxJzE+RiSgaJiP1Z87znO7NMDCVXBtANAT
         oWEL9N7F5jY+1NJ9qwJthdTmYyMvnhD3CX9CXBS60bn8k7UPy+BwFzXyI6s7JdxBue
         mN+YTqXdHR5rDvjH3CuS7qsjthNPZPeTpCs4GCtSpaBbG8sWzyEvUupdBjkUpsoLCe
         GZzHTlnLkHEbDv9iUKo+0likZYp16Bs2oyrEJkd+nJEs1vbL4e9NfKyTi3+KHBzb0V
         fvfy9XVBs+gYw==
Date:   Tue, 27 Jul 2021 19:29:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
Message-ID: <YQDBA2xqbIQPPivQ@google.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
 <YP2l+1umf9ct/4Sp@sol.localdomain>
 <YP9oou9sx4oJF1sc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP9oou9sx4oJF1sc@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/26, Jaegeuk Kim wrote:
> On 07/25, Eric Biggers wrote:
> > On Sun, Jul 25, 2021 at 06:50:51PM +0800, Chao Yu wrote:
> > > On 2021/7/16 22:39, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > f2fs_write_begin() assumes that all blocks were preallocated by
> > > > default unless FI_NO_PREALLOC is explicitly set.  This invites data
> > > > corruption, as there are cases in which not all blocks are preallocated.
> > > > Commit 47501f87c61a ("f2fs: preallocate DIO blocks when forcing
> > > > buffered_io") fixed one case, but there are others remaining.
> > > 
> > > Could you please explain which cases we missed to handle previously?
> > > then I can check those related logic before and after the rework.
> > 
> > Any case where a buffered write happens while not all blocks were preallocated
> > but FI_NO_PREALLOC wasn't set.  For example when ENOSPC was hit in the middle of
> > the preallocations for a direct write that will fall back to a buffered write,
> > e.g. due to f2fs_force_buffered_io() or page cache invalidation failure.
> > 
> > > 
> > > > -			/*
> > > > -			 * If force_buffere_io() is true, we have to allocate
> > > > -			 * blocks all the time, since f2fs_direct_IO will fall
> > > > -			 * back to buffered IO.
> > > > -			 */
> > > > -			if (!f2fs_force_buffered_io(inode, iocb, from) &&
> > > > -					f2fs_lfs_mode(F2FS_I_SB(inode)))
> > > > -				goto write;
> > > 
> > > We should keep this OPU DIO logic, otherwise, in lfs mode, write dio
> > > will always allocate two block addresses for each 4k append IO.
> > > 
> > > I jsut test based on codes of last f2fs dev-test branch.
> > 
> > Yes, I had misread that due to the weird goto and misleading comment and
> > translated it into:
> > 
> >         /* If it will be an in-place direct write, don't bother. */
> >         if (dio && !f2fs_lfs_mode(sbi))
> >                 return 0;
> > 
> > It should be:
> > 
> >         if (dio && f2fs_lfs_mode(sbi))
> >                 return 0;
> 
> Hmm, this addresses my 250 failure. And, I think the below commit can explain
> the case.

In addition to this, I got failure on generic/263, and the below change fixes
it. (I didn't take a look at deeply tho.)

--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4344,8 +4344,13 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter)
                        return ret;
        }

-       map.m_lblk = (pos >> inode->i_blkbits);
-       map.m_len = ((pos + count - 1) >> inode->i_blkbits) - map.m_lblk + 1;
+       map.m_lblk = F2FS_BLK_ALIGN(pos);
+       map.m_len = F2FS_BYTES_TO_BLK(pos + count);
+       if (map.m_len > map.m_lblk)
+               map.m_len -= map.m_lblk;
+       else
+               map.m_len = 0;
+
