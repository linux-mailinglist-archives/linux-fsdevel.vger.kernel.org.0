Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFD254D5CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 02:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353552AbiFPAFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 20:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiFPAFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BD54FB2;
        Wed, 15 Jun 2022 17:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BCA61A77;
        Thu, 16 Jun 2022 00:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE0FC3411A;
        Thu, 16 Jun 2022 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655337899;
        bh=twKDf6UE+kS3vngFTnZTxVTzoWdtagr989JXNITgwOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgVdLgvp0/JpnSn+TbW+19ECVOHgg2dvTd36K9dJ22dJewyA3ZwH85RLqqQhJ4rwu
         eQRyLfRWbmNBVSY1p7ja1StME1gpGVXoweCk085gvuq5K3fYghi7s3zN8llC5NB4DT
         7wMD56EHiUonIGs1WJIuErOZsdSVBXzjwJossod7XVa/UXSqTAr+0i+J9fC9mSo86u
         MC0so6r8yjPi2hY2EBAN05ziiHSbiTb48hzbZsYl8kqWGa29RP58h+SFfWlo9UOmhj
         mkduUSoEiKc7lQO9oM1+UBROu6epiy9J3JLrz6s5NI0683ClKMWFzU9kyryIEZ0z5n
         RaO3GdDZGXmCw==
Date:   Wed, 15 Jun 2022 17:04:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
Message-ID: <YqpzqZQgu0Zz+vW1@sol.localdomain>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
 <20220520032739.GB1098723@dread.disaster.area>
 <YqgbuDbdH2OLcbC7@sol.localdomain>
 <YqnapOLvHDmX/3py@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqnapOLvHDmX/3py@infradead.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 06:12:04AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 13, 2022 at 10:25:12PM -0700, Eric Biggers wrote:
> > While working on the man-pages update, I'm having second thoughts about the
> > stx_offset_align_optimal field.  Does any filesystem other than XFS actually
> > want stx_offset_align_optimal, when st[x]_blksize already exists?  Many network
> > filesystems, as well as tmpfs when hugepages are enabled, already report large
> > (megabytes) sizes in st[x]_blksize.  And all documentation I looked at (man
> > pages for Linux, POSIX, FreeBSD, NetBSD, macOS) documents st_blksize as
> > something like "the preferred blocksize for efficient I/O".  It's never
> > documented as being limited to PAGE_SIZE, which makes sense because it's not.
> 
> Yes.  While st_blksize is utterly misnamed, it has always aways been
> the optimal I/O size.
> 
> > Perhaps for now we should just add STATX_DIOALIGN instead of STATX_IOALIGN,
> > leaving out the stx_offset_align_optimal field?  What do people think?
> 
> Yes, this sounds like a good plan.

One more thing.  I'm trying to add support for STATX_DIOALIGN on block devices.
Unfortunately I don't think it is going to work, at all, since the inode is for
the device node and not the block device itself.  This is true even after the
file is opened (I previously thought that at least that case would work).

Were you expecting that this would work on block devices?  It seems they will
need a different API -- a new BLK* ioctl, or files in /sys/block/$dev/queue.

- Eric
