Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC24E62AFA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKOXsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 18:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKOXsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:48:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FB9F64;
        Tue, 15 Nov 2022 15:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93FC960C89;
        Tue, 15 Nov 2022 23:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCD4C433C1;
        Tue, 15 Nov 2022 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556114;
        bh=OdIB60WCiKgiVdrlaQ1X+riGns5M5D4iYH1L7Fp6VEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4BaDGbZVnV6Nt165ohbpw9UVCIpoeCr5mSpRB7XHeV5VOBhwtJLM/ejEh1Wy2NK0
         elyss08X564tK0GksVIM4yYYze4RxQLg3ZgFYSdGuCzbk1kMnle/tH1+6tUJWybVDk
         +3skUANZL2RzxojAQXyxczbR09gphEdnUkFnisJNfLt4IupSJJqtJLLF0hQyyLxXJm
         B/I7YyE8lW08SqDamDxUKcuN3YzbqRTW4G4wCAYPz53lTVH06c8tqLvOdktBvN63nv
         X9YhxflWJ3WmLOwFZRr5Fse0Qdfg7B51TESPnbNlXMZ2TXxdEEwYqfAAGHF8imly5P
         E2sGBHaZFXfQQ==
Date:   Tue, 15 Nov 2022 15:48:33 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/9] xfs: xfs_bmap_punch_delalloc_range() should take a
 byte range
Message-ID: <Y3Qhbi0aGDe+QG22@magnolia>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-7-david@fromorbit.com>
 <Y3NRfgxWcenyCe+i@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3NRfgxWcenyCe+i@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:44:46AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 15, 2022 at 12:30:40PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > All the callers of xfs_bmap_punch_delalloc_range() jump through
> > hoops to convert a byte range to filesystem blocks before calling
> > xfs_bmap_punch_delalloc_range(). Instead, pass the byte range to
> > xfs_bmap_punch_delalloc_range() and have it do the conversion to
> > filesystem blocks internally.
> 
> Ok, so we do this here.   Why can't we just do this earlier and
> avoid the strange inbetween stage with a wrapper?

Probably to avoid rewriting the previous patch with this units change,
is my guess.  Dave, do you want to merge with this patch 4?  I'm
satisfied enough with patches 4 and 6 that I'd rather get this out to
for-next for further testing than play more patch golf.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D
