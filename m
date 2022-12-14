Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1F64C411
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 07:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiLNGwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 01:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLNGwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 01:52:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41045582;
        Tue, 13 Dec 2022 22:52:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 801EB6181B;
        Wed, 14 Dec 2022 06:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6922C433D2;
        Wed, 14 Dec 2022 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671000732;
        bh=uB3/VeNb2+E5JcJLM4VRq5oQgPUO+MOKFU9Idpe8kfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tv7bJx11/Nf8xIF4/IPCrqHr/oMMr3GMNPMXn9BsPnTJs1UllJNc+YUKkxQ4XrUjr
         uaE8SkfeZTxkKYahp1KiDWkmzplxNwrtSPbNfWiN1eDhAR5mmjAc1eRwn5DdUR1P7e
         6hP88Y6OP1JNKbtmj0hYNvm48WfPgFQYCH3mMpHiVdM62rN4Xoe00J7jsnYAQnRM4F
         3KoLCwvB8ynUWg0rroOVvpjtk6nABvzTfF1lqOSrCB6wBqehaamLGpvCqiB3hV179D
         k1mRPe2fJdfzngWC6ACZudjojASw9H3LgNnSf2YgRhiRH/n3qkloUmRTNtOrJwghvp
         m6SxKQw37dD9Q==
Date:   Tue, 13 Dec 2022 22:52:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] pagemap: add mapping_clear_large_folios()
 wrapper
Message-ID: <Y5lym4fJK+9u2cxe@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-3-aalbersh@redhat.com>
 <Y5i8igBLu+6OQt8H@casper.infradead.org>
 <Y5jTosRngrhzPoge@sol.localdomain>
 <20221213211010.GX3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213211010.GX3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 08:10:10AM +1100, Dave Chinner wrote:
> On Tue, Dec 13, 2022 at 11:33:54AM -0800, Eric Biggers wrote:
> > On Tue, Dec 13, 2022 at 05:55:22PM +0000, Matthew Wilcox wrote:
> > > I'm happy to work with you to add support for large folios to verity.
> > > It hasn't been high priority for me, but I'm now working on folio support
> > > for bufferhead filesystems and this would probably fit in.
> > 
> > I'd be very interested to know what else is needed after commit 98dc08bae678
> > ("fsverity: stop using PG_error to track error status") which is upstream now,
> > and
> > https://lore.kernel.org/linux-fsdevel/20221028224539.171818-1-ebiggers@kernel.org/T/#u
> > ("fsverity: support for non-4K pages") which is planned for 6.3.
> 
> Did you change the bio interfaces to iterate a bvec full of
> variable sized folios, or does it still expect a bio to only have
> PAGE_SIZE pages attached to it?
> 

You can take a look at fsverity_verify_bio() with
https://lore.kernel.org/r/20221028224539.171818-2-ebiggers@kernel.org applied.
It uses bio_for_each_segment_all() to iterate through the bio's segments.  For
each segment, it verifies each data block in the segment, assuming bv_len and
bv_offset are multiples of the Merkle tree block size.  The file position of
each data block is computed as '(page->index << PAGE_SHIFT) + bv_offset'.

I suppose the issue is going to be that only the first page of a folio actually
has an index.  Using bio_for_each_folio_all() would avoid this problem, I think?

- Eric
