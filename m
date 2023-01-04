Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4667C65CD96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 08:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjADHZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 02:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjADHZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:25:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D022A44D;
        Tue,  3 Jan 2023 23:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2E51B811A3;
        Wed,  4 Jan 2023 07:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFCBC433D2;
        Wed,  4 Jan 2023 07:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672817120;
        bh=EY0QIS6ah2VRlLsuBHHzFqCxhBDp5eEMXYtwzaAjNBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8eevhPlbLQQByJxtZSN0ftIYXlnqoyA5BJUM6AP5KbL8Hdw0HMg2nuBQ5sdlamXc
         LExL2VFObRchVEVgRsCm15mnz4C6rXRbtTsMN2cr4b6oRiHMmmABbSNflU3EWaJhst
         5J1PEpb3DqjERtGwRqlzrEMz3WeV19T0b43MtEWOjh9knfnp7tviL6qmTp7aHZSXLT
         IEN/P6uhszJ2K9eZEk+XPP3yijgHtnJlqNNbbV7wSwv2r5oqXKVzoj6Y3IR7JL9E+a
         vEiPUYFi+z+qSUbJ0/w3bVi8IcSNUBhhDXmmHc9rII8AQDlMi9JWlYLQi6CtdvuVhT
         N9g/5kMqBLp7w==
Date:   Tue, 3 Jan 2023 23:25:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 00/11] fsverity: support for non-4K pages
Message-ID: <Y7Up3kpGcJr0FCgq@sol.localdomain>
References: <20221223203638.41293-1-ebiggers@kernel.org>
 <Y7UeuYVkyy2/fWF1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7UeuYVkyy2/fWF1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 12:08:09PM +0530, Ojaswin Mujoo wrote:
> Hi Eric,
> 
> I have roughly gone through the series and run the (patched) xfstests on
> this patchset on a powerpc machine with 64k pagesize and 64k,4k and 1k
> merkle tree size on EXT4 and everything seems to work correctly. 
> 
> Just for records, test generic/692 takes a lot of time to complete with
> 64k merkel tree size due to the calculations assuming it to be 4k,
> however I was able to manually test that particular scenario. (I'll try
> to send a patch to fix the fstest later).
> 
> Anyways, feel free to add:
> 
> Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Since I was not very familiar with the fsverty codebase, I'll try to
> take some more time to review the code and get back with any
> comments/RVBs.
> 
> Regards,
> ojaswin

Thanks Ojaswin!  That's a good point about generic/692.  The right fix for it is
to make it use $FSV_BLOCK_SIZE instead of 4K in its calculations.

I suppose you saw that issue by running the test on ext4 with fs_block_size ==
page_size == 64K, causing xfstests to use merkle_tree_block_size == 64K by
default.  Thanks for doing that; that's something I haven't been able to test
yet.  My focus has been on merkle_tree_block_size < page_size.
merkle_tree_block_size > 4K should just work, though, assuming
merkle_tree_block_size <= min(fs_block_size, page_size).  (Or
merkle_tree_block_size == fs_block_size == page_size before this patch series.)

- Eric
