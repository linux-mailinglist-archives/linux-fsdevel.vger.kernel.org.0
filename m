Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D191D64BDC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 21:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiLMUNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 15:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiLMUNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:13:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989501C412;
        Tue, 13 Dec 2022 12:13:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E1C66172F;
        Tue, 13 Dec 2022 20:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F3EC433D2;
        Tue, 13 Dec 2022 20:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670962414;
        bh=zBH7B86oLAqWP3iZC632QVJ4wsXRReJ/PogHuPh5uDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbgKbwBD6pmhwWw1vUMc0THjYnKVpDnl+WeZqD86WR0JKUVbEj1xyKtF1YFHkqGpn
         3oOp6uBWR4mAtvQHvzR3Ga8oQyuZIQIDGCjbjFCZM6bCuB3b3CqZDRZADV0M8EU3ws
         /V7uobNNMyS5lbLrFLbJiDxMryJkT02Yg1l49IP6QBJ6u9B12a5Wpct3l2nrNf5fZy
         C79hUDKZlomoBBj0vjmZfq6WaYSDokLWAgaLeb4GRgzxiFSek3bQuyacqkj3gEAK+f
         SONCCkHqJnSSaK1E0kJb4vcl1yDaAYgfq0Or21UGNJVsMDs2L+o7sobW3BMSpcYzUA
         zticDKMtjn91A==
Date:   Tue, 13 Dec 2022 12:13:32 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] xfs: add fs-verity support
Message-ID: <Y5jc7P1ZeWHiTKRF@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-11-aalbersh@redhat.com>
 <Y5jNvXbW1cXGRPk2@sol.localdomain>
 <Y5jQ9+L9u2oTc+O/@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jQ9+L9u2oTc+O/@magnolia>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:22:31AM -0800, Darrick J. Wong wrote:
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
> > 
> > Hopefully you don't need fs_block_size > page_size or
> 
> Not right this second, but large folios (and the ability to demand them)
> are probably the last major piece that we need to support running
> 64k-fsblock filesystems on x86.
> 
> > merkle_tree_block_size > fs_block_size?
> 
> Doubtful.
> 

Thanks for the info.  Actually, I think

	merkle_tree_block_size <= fs_block_size <= page_size

is wrong.  It should actually be

	merkle_tree_block_size <= min(fs_block_size, page_size)

So there shouldn't actually be a problem with fs_block_size > page_size
(assuming that the filesystem doesn't have unrelated problems with it).

merkle_tree_block_size <= page_size comes from the way that fs/verity/verify.c
works (again, talking about the version with my patchset "fsverity: support for
non-4K pages" applied, and not the current upstream version which has a stronger
assumption of merkle_tree_block_size == page_size).

merkle_tree_block_size <= fs_block_size comes from the fact that every time data
is verified, it must be Merkle tree block aligned.  Maybe even that is not
necessarily a problem, if the filesystem waits to collect a full page (or folio)
before verifying it.  But ext4 will do a FS block at a time.

- Eric
