Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05352E322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbiETD1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiETD1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:27:44 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 314C78DDF6;
        Thu, 19 May 2022 20:27:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4126E10E68AE;
        Fri, 20 May 2022 13:27:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nrtIh-00E6GN-MT; Fri, 20 May 2022 13:27:39 +1000
Date:   Fri, 20 May 2022 13:27:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
Message-ID: <20220520032739.GB1098723@dread.disaster.area>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YobNXbYnhBiqniTH@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62870aad
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=-h69JAkiF4VdWyV60hkA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 04:06:05PM -0700, Darrick J. Wong wrote:
> On Wed, May 18, 2022 at 04:50:05PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Traditionally, the conditions for when DIO (direct I/O) is supported
> > were fairly simple: filesystems either supported DIO aligned to the
> > block device's logical block size, or didn't support DIO at all.
> > 
> > However, due to filesystem features that have been added over time (e.g,
> > data journalling, inline data, encryption, verity, compression,
> > checkpoint disabling, log-structured mode), the conditions for when DIO
> > is allowed on a file have gotten increasingly complex.  Whether a
> > particular file supports DIO, and with what alignment, can depend on
> > various file attributes and filesystem mount options, as well as which
> > block device(s) the file's data is located on.
> > 
> > XFS has an ioctl XFS_IOC_DIOINFO which exposes this information to
> > applications.  However, as discussed
> > (https://lore.kernel.org/linux-fsdevel/20220120071215.123274-1-ebiggers@kernel.org/T/#u),
> > this ioctl is rarely used and not known to be used outside of
> > XFS-specific code.  It also was never intended to indicate when a file
> > doesn't support DIO at all, and it only exposes the minimum I/O
> > alignment, not the optimal I/O alignment which has been requested too.
> > 
> > Therefore, let's expose this information via statx().  Add the
> > STATX_IOALIGN flag and three fields associated with it:
> > 
> > * stx_mem_align_dio: the alignment (in bytes) required for user memory
> >   buffers for DIO, or 0 if DIO is not supported on the file.
> > 
> > * stx_offset_align_dio: the alignment (in bytes) required for file
> >   offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
> >   on the file.  This will only be nonzero if stx_mem_align_dio is
> >   nonzero, and vice versa.
> > 
> > * stx_offset_align_optimal: the alignment (in bytes) suggested for file
> >   offsets and I/O segment lengths to get optimal performance.  This
> >   applies to both DIO and buffered I/O.  It differs from stx_blocksize
> >   in that stx_offset_align_optimal will contain the real optimum I/O
> >   size, which may be a large value.  In contrast, for compatibility
> >   reasons stx_blocksize is the minimum size needed to avoid page cache
> >   read/write/modify cycles, which may be much smaller than the optimum
> >   I/O size.  For more details about the motivation for this field, see
> >   https://lore.kernel.org/r/20220210040304.GM59729@dread.disaster.area
> 
> Hmm.  So I guess this is supposed to be the filesystem's best guess at
> the IO size that will minimize RMW cycles in the entire stack?  i.e. if
> the user does not want RMW of pagecache pages, of file allocation units
> (if COW is enabled), of RAID stripes, or in the storage itself, then it
> should ensure that all IOs are aligned to this value?
> 
> I guess that means for XFS it's effectively max(pagesize, i_blocksize,
> bdev io_opt, sb_width, and (pretend XFS can reflink the realtime volume)
> the rt extent size)?  I didn't see a manpage update for statx(2) but
> that's mostly what I'm interested in. :)

Yup, xfs_stat_blksize() should give a good idea of what we should
do. It will end up being pretty much that, except without the need
to a mount option to turn on the sunit/swidth return, and always
taking into consideration extent size hints rather than just doing
that for RT inodes...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
