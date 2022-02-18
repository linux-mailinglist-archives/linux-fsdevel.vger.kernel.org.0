Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2CA4BB172
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 06:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiBRFbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 00:31:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBRFbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:31:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7395079C63;
        Thu, 17 Feb 2022 21:31:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4E861E9A;
        Fri, 18 Feb 2022 05:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664A7C340E9;
        Fri, 18 Feb 2022 05:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645162281;
        bh=lyKt5YoIwrlI8Prw+lFo2isAq5Rr39stn2K/Eebeiu4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=osv5OaEV+RyyN6/6QKJvV+rFrS3Av585sT+jh4/JzWwo4eYpMU0eswXzRsYecBO5/
         v3qJSrq5pW/LP7jpMC2j8oDyISjfquhP8DEvxDKcw7M56pdLUowztgM3NBUaJ7HFgk
         4VLd6oZZDAYnzxfxL85TxlTHVOJ7v/pQoZ7+lRsNUZQMyjyB3GhRfIGaCDHZbzmSTw
         Y1ANNhumXO+JFL3rQ7xXuClcmHa1y4c4q0mtljErniiASH5RzOAv8WJUZpGBasq1Xc
         IJz4ZH1fGLo8I3tMq3pMHCSKop55gzYcnhdCbvtvqNT3u1yOVEdnHTk9jD/dfapAKJ
         /WW+tfZdxGvZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F13EB5C1AC1; Thu, 17 Feb 2022 21:31:20 -0800 (PST)
Date:   Thu, 17 Feb 2022 21:31:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Chris Mason <clm@fb.com>,
        linux-fsdevel@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH][RFC] ipc,fs: use rcu_work to free struct ipc_namespace
Message-ID: <20220218053120.GV4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220217153620.4607bc28@imladris.surriel.com>
 <Yg8StKzTWh+7FLuA@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg8StKzTWh+7FLuA@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 03:29:56AM +0000, Al Viro wrote:
> On Thu, Feb 17, 2022 at 03:36:20PM -0500, Rik van Riel wrote:
> > The patch works, but a cleanup question for Al Viro:
> > 
> > How do we get rid of #include "../fs/mount.h" and the raw ->mnt_ns = NULL thing
> > in the cleanest way?
> 
> Hell knows...  mnt_make_shortterm(mnt) with big, fat warning along the lines of
> "YOU MUST HAVE AN RCU GRACE PERIOD BEFORE YOU DROP THAT REFERENCE!!!", perhaps?

Rik's patch uses queue_rcu_work(), which always uses a normal grace
period.  Therefore, one way of checking that an RCU grace period has
elapsed is as follows:

Step 1: Get a snapshot of the normal grace-period state:

	rcuseq = get_state_synchronize_rcu(); // In mainline

Step 2: Verify that a normal grace period has elapsed since step 1:

	WARN_ON_ONCE(!poll_state_synchronize_rcu(rcuseq));

These functions are both in mainline.

And apologies for my answer on IRC being unhelpful.  Here is hoping that
this is more to the point.

							Thanx, Paul

------------------------------------------------------------------------

PS.  Just in case it ever becomes relevant, if Rik's patch were instead
     to use synchronize_rcu() or synchronize_rcu_expedited() to wait for
     the grace period, it would be necessary to capture both the normal
     and expedited grace-period state:

Step 1: Get a snapshot of both the normal and the expedited state:

	rcuseq = get_state_synchronize_rcu();
	rcuxseq = get_state_synchronize_rcu_expedited();

Step 2: Verify that either a normal or expedited grace period has
	elapsed since step 1:

	WARN_ON_ONCE(!poll_state_synchronize_rcu(rcuseq) &&
		     !poll_state_synchronize_rcu_expedited(rcuxseq));

The reason for doing both is that synchronize_rcu_expedited() and
synchronize_rcu() can both be switched between using normal and expedited
grace periods.  Not just at boot time, but also at runtime.  Fun.

The two expedited functions are in -rcu rather than mainline, so if
someone does ever need them, please let me know.
