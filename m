Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343354C2E1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 15:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiBXOVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 09:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiBXOVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:21:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2129A565
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 06:20:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 29A6F2114D;
        Thu, 24 Feb 2022 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645712436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RDcs/CkP/x+4Zkkm7ZlXwkQJaMvDpvbOuiIOvwiR4c=;
        b=feYC2gwdX3eBni5vO6O7Olh1cJL+PxK4BOEQxoLXYD4SspMuvfdaBI9Zs9pVClxi+UzTam
        7XjOq108YizWTx53dl2RFkL8/19B54K1syDb/yh/t1CfHbJVcyIPns66AQyb5/LO2mrCMo
        cA23VB9ctjRiOKt4puIrqYgoOl1ybNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645712436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RDcs/CkP/x+4Zkkm7ZlXwkQJaMvDpvbOuiIOvwiR4c=;
        b=sxn0ysGLoxzS+ULwopUBAP9Ow1+uPH1cdohaRh9FIPDVGLorHNM/kGlBb5cHrkESgZP8dD
        LoYQiMAAVwjSrYBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 02293A3B83;
        Thu, 24 Feb 2022 14:20:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 48A4AA0605; Thu, 24 Feb 2022 15:20:30 +0100 (CET)
Date:   Thu, 24 Feb 2022 15:20:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fsnotify ignored mask related fixes
Message-ID: <20220224142030.d26iu4fz4at5ohuf@quack3.lan>
References: <20220223151438.790268-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223151438.790268-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Wed 23-02-22 17:14:36, Amir Goldstein wrote:
> The two patches are functionally unrelated, but they both incorporate
> information from the ignored mask into the object's interest mask.
> 
> The 1st patch is a fix for a minor functional bug.
> LTP test fanotify10 has a workaround for this bug, see comment:
>   /* XXX: temporary hack may be removed in the future */
> The test is to remove the hack and see that fanotify10 passes.
> 
> The 2nd patch is a performance optimization that you suggested.
> Last time I posted it, you asked for performance numbers [1], so I ran
> some micro benchmarks (see results below [3]).
> 
> Note that the other patch from that first posting ("optimize merging of
> marks with no ignored masks") did not demonstrate any visible
> improvements with the benchmarks that I ran so I left it out.
> 
> The micro benchmark is a simple program [2] that writes 1 byte at a time
> in a loop. I ran it on tmpfs once without any mark and once with a mark
> with a mask for DELETE_SELF event.
> 
> On upstream kernel, runtime with a mark is always ~25% longer.
> With the optimization patch applied, runtime with a mark is most of the
> time (but not always) very close to the runtime without a mark.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20201203145220.GH11854@quack2.suse.cz/
> [2] https://github.com/amir73il/fsnotify-utils/blob/master/src/test/ioloop.c
> [3] Performance test results:

Thanks! Both patches look good to me, I have added them to my tree (just
included shortened performance results into the changelog of the second
patch).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
