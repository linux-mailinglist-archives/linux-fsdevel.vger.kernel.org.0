Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B164A5A356A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiH0HIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 03:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiH0HIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:08:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1986FF6;
        Sat, 27 Aug 2022 00:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A18AF6100A;
        Sat, 27 Aug 2022 07:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B027CC433C1;
        Sat, 27 Aug 2022 07:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661584082;
        bh=p0KRSMvvBhsJs0c03pHNWDIW9Qt/EnRrmOnfStK+zqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLvlkjUnktj26RRTEJeF29+/+JHbO8XAS/9V4Wiki8lnjsjbLKVT97mLLImiN+62c
         +EpOM247AJ37EeTTDfES3liBnoAa62LtOVdbsIQCqAZwgFhq/a3G9Q8kzPhPMxXk9m
         rI9+KpZadUhXkoHHIFuHm87iZR3ytO2piFQYvBFmhjQ2mNF3wkkcgxI7suT8JRZ2A+
         DVAmVSkYyz4wKEJ+nVPeqplcAYgBznkFuKsC7aSdTh8p6ucLWwQ57+nxuAjSNnTHyK
         qfHYoDrflvFMbCIYPiKxfJG6x9FoBVXZzhDJ9CEuhsJ3Awv6lodlmAAmAtepC2dyQo
         AvX8PSILJ/IBA==
Date:   Sat, 27 Aug 2022 00:07:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 0/9] make statx() return DIO alignment information
Message-ID: <YwnCz/4K8lGS91n+@sol.localdomain>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <3543250c8157c3e0e7e410b268121e4d7d3e9bc2.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3543250c8157c3e0e7e410b268121e4d7d3e9bc2.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 01:19:37PM -0400, Jeff Layton wrote:
> On Fri, 2022-07-22 at 00:12 -0700, Eric Biggers wrote:
> > This patchset makes the statx() system call return direct I/O (DIO)
> > alignment information.  This allows userspace to easily determine
> > whether a file supports DIO, and if so with what alignment restrictions.
> > 
> > Patch 1 adds the basic VFS support for STATX_DIOALIGN.  Patch 2 wires it
> > up for all block device files.  The remaining patches wire it up for
> > regular files on ext4, f2fs, and xfs.  Support for regular files on
> > other filesystems can be added later.
> > 
> > I've also written a man-pages patch, which I'm sending separately.
> > 
> > Note, f2fs has one corner case where DIO reads are allowed but not DIO
> > writes.  The proposed statx fields can't represent this.  My proposal
> > (patch 6) is to just eliminate this case, as it seems much too weird.
> > But I'd appreciate any feedback on that part.
> > 
> > This patchset applies to v5.19-rc7.
> > 
> > Changed v3 => v4:
> >    - Added xfs support.
> > 
> >    - Moved the helper function for block devices into block/bdev.c.
> >    
> >    - Adjusted the ext4 patch to not introduce a bug where misaligned DIO
> >      starts being allowed on encrypted files when it gets combined with
> >      the patch "iomap: add support for dma aligned direct-io" that is
> >      queued in the block tree for 5.20.
> > 
> >    - Made a simplification in fscrypt_dio_supported().
> > 
> > Changed v2 => v3:
> >    - Dropped the stx_offset_align_optimal field, since its purpose
> >      wasn't clearly distinguished from the existing stx_blksize.
> > 
> >    - Renamed STATX_IOALIGN to STATX_DIOALIGN, to reflect the new focus
> >      on DIO only.
> > 
> >    - Similarly, renamed stx_{mem,offset}_align_dio to
> >      stx_dio_{mem,offset}_align, to reflect the new focus on DIO only.
> > 
> >    - Wired up STATX_DIOALIGN on block device files.
> > 
> > Changed v1 => v2:
> >    - No changes.
> > 
> > Eric Biggers (9):
> >   statx: add direct I/O alignment information
> >   vfs: support STATX_DIOALIGN on block devices
> >   fscrypt: change fscrypt_dio_supported() to prepare for STATX_DIOALIGN
> >   ext4: support STATX_DIOALIGN
> >   f2fs: move f2fs_force_buffered_io() into file.c
> >   f2fs: don't allow DIO reads but not DIO writes
> >   f2fs: simplify f2fs_force_buffered_io()
> >   f2fs: support STATX_DIOALIGN
> >   xfs: support STATX_DIOALIGN
> > 
> >  block/bdev.c              | 25 ++++++++++++++++++++
> >  fs/crypto/inline_crypt.c  | 49 +++++++++++++++++++--------------------
> >  fs/ext4/ext4.h            |  1 +
> >  fs/ext4/file.c            | 37 ++++++++++++++++++++---------
> >  fs/ext4/inode.c           | 36 ++++++++++++++++++++++++++++
> >  fs/f2fs/f2fs.h            | 45 -----------------------------------
> >  fs/f2fs/file.c            | 45 ++++++++++++++++++++++++++++++++++-
> >  fs/stat.c                 | 14 +++++++++++
> >  fs/xfs/xfs_iops.c         |  9 +++++++
> >  include/linux/blkdev.h    |  4 ++++
> >  include/linux/fscrypt.h   |  7 ++----
> >  include/linux/stat.h      |  2 ++
> >  include/uapi/linux/stat.h |  4 +++-
> >  13 files changed, 190 insertions(+), 88 deletions(-)
> > 
> > base-commit: ff6992735ade75aae3e35d16b17da1008d753d28
> 
> Hi Eric,
> 
> Can I ask what your plans are with this set? I didn't see it in
> linux-next yet, so I wasn't sure when you were looking to get it merged.
> I'm working on patches to add a new statx field for the i_version
> counter as well and I want to make sure that our work doesn't collide.
> 

I've just sent v5.  I guess I'll try to get it merged for 6.1.  We were a bit
stuck on the read-only DIO issue.  All things considered though, including that
Christoph thinks it's possible for f2fs to support DIO writes on zoned block
devices, I'm willing to bet that read-only DIO doesn't really matter enough for
it to be worth it to add a direction field to STATX_DIOALIGN (which would make
it harder to use STATX_DIOALIGN, as the field would always have to be checked).

- Eric
