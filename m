Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475FE64BE03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 21:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiLMUjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 15:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiLMUjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:39:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E03614D19;
        Tue, 13 Dec 2022 12:39:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C435B61539;
        Tue, 13 Dec 2022 20:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C996C433D2;
        Tue, 13 Dec 2022 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670963981;
        bh=iqmnRcLzovr7AC8+O+z/TL7d5dOtxq+rCVzO+zKWMF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvyXz4OfIm+//NGHUZop571fzQR48B+BzJqViL2SeQ5zfqNXbBJ4q5kp2Gj24vU1j
         zO8zsK5fFS9cADogTL6rEq4uLij/fG9nhaCamjzdEPu2dHi2YeSzR2L6j5Zuf4wcLh
         QMoMzPbjLmx+su3SR8z3W38vbiqVJFXAnfCIqE2r/w4yOAvV4lqwz4Q3WdNqytkXMN
         PlaqDgfGAzExipK3hj7PX5F/CQZspGs4DAugpne4KhQZE8kGWpzomwYsTOT8GrAMya
         b5Jl1J7ruohxunpUqPl2dKh1xXVFbQ5E50eF+q9iM7C0Lweowom927v5IgBbioEJJW
         A6GgTTZizgBZA==
Date:   Tue, 13 Dec 2022 12:39:39 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] xfs: add fs-verity support
Message-ID: <Y5jjC5kcF4kCiwNB@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-11-aalbersh@redhat.com>
 <Y5jNvXbW1cXGRPk2@sol.localdomain>
 <20221213203319.GV3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213203319.GV3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 07:33:19AM +1100, Dave Chinner wrote:
> On Tue, Dec 13, 2022 at 11:08:45AM -0800, Eric Biggers wrote:
> > On Tue, Dec 13, 2022 at 06:29:34PM +0100, Andrey Albershteyn wrote:
> > > 
> > > Also add check that block size == PAGE_SIZE as fs-verity doesn't
> > > support different sizes yet.
> > 
> > That's coming with
> > https://lore.kernel.org/linux-fsdevel/20221028224539.171818-1-ebiggers@kernel.org/T/#u,
> > which I'll be resending soon and I hope to apply for 6.3.
> > Review and testing of that patchset, along with its associated xfstests update
> > (https://lore.kernel.org/fstests/20221211070704.341481-1-ebiggers@kernel.org/T/#u),
> > would be greatly appreciated.
> > 
> > Note, as proposed there will still be a limit of:
> > 
> > 	merkle_tree_block_size <= fs_block_size <= page_size
> 
> > Hopefully you don't need fs_block_size > page_size or
> 
> Yes, we will.
> 
> This back on my radar now that folios have settled down. It's
> pretty trivial for XFS to do because we already support metadata
> block sizes > filesystem block size. Here is an old prototype:
> 
> https://lore.kernel.org/linux-xfs/20181107063127.3902-1-david@fromorbit.com/

As per my follow-up response
(https://lore.kernel.org/r/Y5jc7P1ZeWHiTKRF@sol.localdomain),
I now think that wouldn't actually be a problem.

> > merkle_tree_block_size > fs_block_size?
> 
> That's also a desirable addition.
> 
> XFS is using xattrs to hold merkle tree blocks so the merkle tree
> storage is are already independent of the filesystem block size and
> page cache limitations. Being able to using 64kB merkle tree blocks
> would be really handy for reducing the search depth and overall IO
> footprint of really large files.

Well, the main problem is that using a Merkle tree block of 64K would mean that
you can never read less than 64K at a time.

- Eric
