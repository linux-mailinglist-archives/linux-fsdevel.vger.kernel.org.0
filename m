Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35B5530A6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 10:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiEWHfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiEWHfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 03:35:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA5B15816
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 00:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CC16B80EF0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 06:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC1BC385A9;
        Mon, 23 May 2022 06:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653287911;
        bh=IxV2xEnELBCWTNVkpfzlHZTWu9iVcgmoMIakHEHqRiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccpuctTadwS6Yaj3W5zy3j2oITInf+y3bPwvoWgXDbWP18rRJnGDgi8aJxaMfE8kn
         sp+bIuUpfJAg23YSleajy0XRPwbhN21Z67DjSbf7OdzB0M+7xFlkKwe5Q0f72nz6G1
         gpELVl8fLcbBOgDTlzZGq0FVEfd5pWrOUwI4eIm++70DsaS07dHGWgrvXAzEiasiIT
         pe8qBrGhytzU84KsmSYf2Pa0R8qUKJr2cjXC27ItZgGPXqJzSfCrcFlNRHs+ds/E7U
         z9vFI/JGtcVT0XWEbzJGAZK9EUvgCP5ldHkffX/6hdTbO4VSRT3IgwfVy/DtpJkCIs
         92E3hsi9LyEWw==
Date:   Mon, 23 May 2022 09:38:23 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Freeing page flags
Message-ID: <Yosr35sTk3l9nBy1@kernel.org>
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
> The LWN writeup [1] on merging the MGLRU reminded me that I need to send
> out a plan for removing page flags that we can do without.
> 
> 4. I think I can also consolidate PG_slab and PG_reserved into a "single
> bit" (not really, but change the encoding so that effectively they only
> take a single bit).

PG_reserved could be a PageType, AFAIR no reserved pages are ever mapped to
userspace
 
> That gives us 4 bits back, which should relieve the pressure on page flag
> bits for a while.  I have Thoughts on PG_private_2 and PG_owner_priv_1,
> as well as a suspicion that not all combinations of referenced, lru,
> active, workingset, reclaim and unevictable are possible, and there
> might be scope for a better encoding.  But I don't know that we need to
> do that work; gaining back 4 bits is already a Big Deal.
> 
> I'm slowly doing the PG_private transition as part of the folio work.
> For example, eagle eyed reviewers may have spotted that there is no
> folio_has_buffers().  Converted code calls folio_buffers() and checks
> if it's NULL.  Help from filesystem maintainers on removing the uses of
> PG_error gratefully appreciated.
> 
> [1] https://lwn.net/Articles/894859/
> 

-- 
Sincerely yours,
Mike.
