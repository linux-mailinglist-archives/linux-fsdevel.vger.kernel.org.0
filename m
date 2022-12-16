Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA664E6D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 06:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLPFEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 00:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiLPFE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:04:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8514A04E;
        Thu, 15 Dec 2022 21:04:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6890B81C9A;
        Fri, 16 Dec 2022 05:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B0CC433D2;
        Fri, 16 Dec 2022 05:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671167065;
        bh=51ypuloz2foDttekJgabwM5fTg/0aKUSlqb1chQkiko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ulbrsgxk0UBUAIIX/DLUXa1GMj9oKn3Dim3Kc7FQJsAlwHxvG934GOXOcys42SkzI
         UBQRcS/df3r69nGRL8a5f8s09cjP0avxJFwfQMOWna6bJ2xtTdfAjYiwnL2tTA2XEx
         qoYGJPtoDU2+QXuSfY/xae34OBtjPxov/SdhDtmI3KywRqZFJWdQohgzKXU55jwQza
         wBVTm/X6E/cYu55XpCIMFBMdjURnPhwZrV8piZ9UnuUxTrdJAAdj7p9CfW2blmwooa
         5eJ+bzPt40KbXsyNZlt4AJyDI5yfpen+UxsmLOAIhmxVKe2ilalf5okS/Iv9dj7FeN
         xKITdoVLS5W7Q==
Date:   Thu, 15 Dec 2022 21:04:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] fs-verity support for XFS
Message-ID: <Y5v8V2BLONOVByTm@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <Y5jllLwXlfB7BzTz@sol.localdomain>
 <20221213221139.GZ3600936@dread.disaster.area>
 <Y5ltzp6yeMo1oDSk@sol.localdomain>
 <20221214230632.GA1971568@dread.disaster.area>
 <Y5rDCcYGgH72Wn/e@sol.localdomain>
 <20221215205737.GD1971568@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215205737.GD1971568@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 07:57:37AM +1100, Dave Chinner wrote:
> > 
> > Well, that's why my patch uses kvmalloc() to allocate the bitmap.
> > 
> > I did originally think it was going to have to be a sparse bitmap that ties into
> > the shrinker so that pages of it can be evicted.  But if you do the math, the
> > required bitmap size is only 1 / 2^22 the size of the file, assuming the Merkle
> > tree uses SHA-256 and 4K blocks.  So a 100MB file only needs a 24-byte bitmap,
> > and the bitmap for any file under 17GB fits in a 4K page.
> > 
> > My patch puts an arbitrary limit at a 1 MiB bitmap, which would be a 4.4TB file.
> > 
> > It's not ideal to say "4 TB Ought To Be Enough For Anybody".  But it does feel
> > that it's not currently worth the extra complexity and runtime overhead of
> > implementing a full-blown sparse bitmap with cache eviction support, when no one
> > currently has a use case for fsverity on files anywhere near that large.
> 
> I think we can live with that for the moment, but I suspect that 4TB
> filesize limit will become an issue sooner rather than later. What
> will happen if someone tries to measure a file larger than this
> limit? What's the failure mode?
> 

FS_IOC_ENABLE_VERITY will fail with EFBIG.

- Eric
