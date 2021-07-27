Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1643D707A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhG0Hi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 03:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235518AbhG0Hi0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7E0861108;
        Tue, 27 Jul 2021 07:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627371507;
        bh=hH6uQTAHdrrSIaY1aFLgH9BCERIskl+VRH3TTckavQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asexRtT3wtpqPwdGLVkXyWga3WEH2h1pOVDgsN63yGun/2/Wg4kw5DUF/M3NtGukX
         lu+a5+HfT7nqoRLRmjGNa55Nt0kwdXFBO9tsngMciZFCWzLQRDBeITI5eG5hCU7MOz
         FpD5OApj7eNGcv8TWb70SJiTuHLFKtHzKnim4QqUCf1Rgjwk3P1Vfgk7MU5ZEWiIXR
         aqRjEou+YRBAjqzE56cuIDu9wOHbtgaVGnxB+0xKLWeYZllYzfxErWfZtwXiO6lylK
         NXCTIsZhptfrd/8RY37Fm6NDGu9Q+z7H+kOEQYJLid/+J9C+YhysLsoG9B9GGeJ7oT
         BQ2pyvqpuYoMA==
Date:   Tue, 27 Jul 2021 00:38:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
Message-ID: <YP+38QzXS6kpLGn0@sol.localdomain>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
 <YP2l+1umf9ct/4Sp@sol.localdomain>
 <YP9oou9sx4oJF1sc@google.com>
 <70f16fec-02f6-cb19-c407-856101cacc23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f16fec-02f6-cb19-c407-856101cacc23@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:23:03AM +0800, Chao Yu wrote:
> > > 
> > > Do you have a proper explanation for why preallocations shouldn't be done in
> 
> See commit f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode"),
> f2fs_map_blocks() logic was changed to force allocating a new block address no matter
> previous block address was existed if it is called from write path of DIO. So, in such
> condition, if we preallocate new block address in f2fs_file_write_iter(), we will
> suffer the problem which my trace indicates.
> 
> > > this case?  Note that preallocations are still done for buffered writes, which
> > > may be out-of-place as well; how are those different?
> Got your concern.
> 
> For buffered IO, we use F2FS_GET_BLOCK_PRE_AIO, in this mode, we just preserve
> filesystem block count and tag NEW_ADDR in dnode block, so, it's fine, double
> new block address allocation won't happen during data page writeback.
> 
> For direct IO, we use F2FS_GET_BLOCK_PRE_DIO, in this mode, we will allocate
> physical block address, after preallocation, if we fallback to buffered IO, we
> may suffer double new block address allocation issue... IIUC.
> 
> Well, can we relocate preallocation into f2fs_direct_IO() after all cases which
> may cause fallbacking DIO to buffered IO?
> 

That's somewhat helpful, but I've been doing some more investigation and now I'm
even more confused.  How can f2fs support non-overwrite DIO writes at all
(meaning DIO writes in LFS mode as well as DIO writes to holes in non-LFS mode),
given that it has no support for unwritten extents?  AFAICS, as-is users can
easily leak uninitialized disk contents on f2fs by issuing a DIO write that
won't complete fully (or might not complete fully), then reading back the blocks
that got allocated but not written to.

I think that f2fs will have to take the ext2 approach of not allowing
non-overwrite DIO writes at all...

- Eric
