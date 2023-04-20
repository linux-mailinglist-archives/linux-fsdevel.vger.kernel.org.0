Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59F6E97ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjDTPEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 11:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjDTPD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F9B35AF;
        Thu, 20 Apr 2023 08:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0688461559;
        Thu, 20 Apr 2023 15:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CAEC4339C;
        Thu, 20 Apr 2023 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682003036;
        bh=rXpdM/PXidMZuxAWqMp5XA9iSJNFfEvU4AkTCtcfBfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axFDThBCzxyW6grz0ekvb1o3N8C+1Qy9dh8n/bRTsqcUhcXxEoMMf7H5E1/WZbcNG
         uGWGzp+CW1Yjcig+UACPXOuAABUSf2Iqa6c2maOeq7zHb3IYbbJP8XyDt0g1t+1Eej
         i34yHW2Y8rrKMDP32blanK1LciufI8Vo9wu0xpjbIYgba0sGoxp6VdHi1bxEeRuE5h
         wbfPz2KU+ZXgOEdLoBlz3xVryd7utLfvzX0DKQrGkp9/s465TTZa5XBaltVSgvNcPx
         8fw/RuHeWl7btNyptXdHAf1JuDOfAn0l43TybMKMIDKg34ZiSawuAph06SNIx1LNLp
         09mYX427tY4TQ==
Date:   Thu, 20 Apr 2023 08:03:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, SSDR Gost Dev <gost.dev@samsung.com>
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Message-ID: <20230420150355.GG360881@frogsfrogsfrogs>
References: <CGME20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601@eucas1p1.samsung.com>
 <20230414134908.103932-1-hare@suse.de>
 <2466fa23-a817-1dee-b89f-fcbeaca94a9e@samsung.com>
 <a826abe1-332f-22db-982c-ecec67a40585@suse.de>
 <1c76a3fe-5b7a-6f22-78e1-da4a54497ecd@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c76a3fe-5b7a-6f22-78e1-da4a54497ecd@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 02:28:36PM +0200, Pankaj Raghav wrote:
> On 2023-04-20 14:19, Hannes Reinecke wrote:
> >>
> >> **Questions on the future work**:
> >>
> >> As willy pointed out, we have to do this `order = mapping->host->i_blkbits - PAGE_SHIFT` in
> >> many places. Should we pursue something that willy suggested: encapsulating order in the
> >> mapping->flags as a next step?[1]
> >>
> >>
> >> [1] https://lore.kernel.org/lkml/ZDty+PQfHkrGBojn@casper.infradead.org/

I wouldn't mind XFS gaining a means to control folio sizes, personally.
At least that would make it easier to explore things like copy on write
with large weird file allocation unit sizes (2MB, 28k, etc).

> > 
> > Well ... really, not sure.
> > Yes, continue updating buffer_heads would be a logical thing as it could be done incrementally.
> >
> > But really, the end-goal should be to move away from buffer_heads for fs and mm usage. So I wonder
> > if we shouldn't rather look in that direction..
> >
> Yeah, I understand that part. Hopefully, this will be discussed as a part of LSFMM.

Agree.

--D

> 
> But the changes that are done in filemap and readahead needs to be done anyway irrespective of the
> underlying aops right? Or Am I missing something.
> 
> > Cheers,
> > 
> > Hannes
> > 
