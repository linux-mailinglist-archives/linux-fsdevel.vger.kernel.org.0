Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2487526EE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiENGKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 02:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiENGKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 02:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933F195
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 23:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3B76062B
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 May 2022 06:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCAAC34113;
        Sat, 14 May 2022 06:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652508604;
        bh=q/ID6tbRdZpX5OEsHFcMNO3iAzeVV2HIl2WBCDbIvYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bImNBPV4/NQR0KnMZ9/Qo1vujgs886oVI43Jvo320T1fcATCJqGiBG8NbPwCt2qmD
         CrOdre3lwUAOBSIweCvXvcJsGvRIV89UHJztD7RzuNrGKWw1HiaYclkmKX1xrgAy36
         qkw5ul+seN0+Zgu6mbWSv8UfhKcQKz8zHKQNir3oauzM6CSV/4VgGguCPh4On9eMRH
         OC5OuQqkTqpFSuuWZzKgATD35VatRxQXcsJLxzpUmXhz1W3xbfILCKUzfILMLs/m2Q
         RHBDWztcKSVTKYwAvf9i+tFoEVK3pS8jFe2wjYSrI6kqjRP27+HtU7IMlDrx6Y1nWp
         noIM3+hXFw2EA==
Date:   Fri, 13 May 2022 23:10:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Freeing page flags
Message-ID: <Yn9Huu//3AJ2hu/L@sol.localdomain>
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> 1. PG_error.  It's basically useless.  If the page was read successfully,
> PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
> doesn't use PG_error.  Some filesystems do, and we need to transition
> them away from using it.

One of the uses of PG_error is in ext4 and f2fs to keep track of decryption
(fscrypt) and verity (fs-verity) failures on pages in a bio being read.
Decryption and verity happen in separate phases, so PG_error is used to record
which subset of pages a decryption error occurred on.  Similarly, PG_error is
also used to record which subset of pages a verity error occurred on, which the
filesystem uses to decide whether to set PG_uptodate afterwards.

If we had to get rid of it, one idea would be:

* Don't keep track of decryption failures on a per-page basis; just fail the
  whole bio if one occurs.  That's how the block layer works, after all; you
  just get one ->bi_status and not an individual status for each page.  Also,
  decryption failures never really happen in practice anyway.

* Also merge together the verity step and the setting-uptodate+unlocking step,
  so that PG_error isn't needed to propagate the page status between these.
  This should work since verity only happens at the end anyway.

I was also thinking about just unlocking pages as errors occur on them.  I think
that wouldn't work, because the filesystem wouldn't be able to distinguish
between pages it still has locked and pages that got re-locked by someone else.

- Eric
