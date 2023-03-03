Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6BF6A9962
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 15:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjCCO1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 09:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCCO1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:27:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E85D8A5;
        Fri,  3 Mar 2023 06:27:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 870FFCE2190;
        Fri,  3 Mar 2023 14:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE4EC433EF;
        Fri,  3 Mar 2023 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677853657;
        bh=/vxaNZ5rwBGIbgZ8NHY9ELd8ytSWcXt6XhBuyAA/cz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnYpHgaOL+bJo4A8CkAEl73v4A24L0+czK8af3C1xqlwGSa0mx+HqvYwFaKvA6WBF
         0gC1lx6n47Sm884rZlm3TOBlVYM5eTc2AlSTDNVImQ7ezp23spewWYNedzF8u8MYFI
         yTgUAS41mqEzNy/TNPE3ZfxcIrYs6wgoB9bbIhkHmPIgq1qrkhi8nEAH+u9NdyHpWZ
         3MyBSScK/DCv2YMwUAt7hRJkbF+LDEbaA0vdFhaejDlgy0LR4QBz+ynv0yTdTAl/yR
         hHZompDyn2L9MGL7fR9pZle/CruXznxUTajg4RGjeI57B0p6sdrurAIzvSkhtWRYgB
         3OD6o8VUeO7bA==
Date:   Fri, 3 Mar 2023 15:27:32 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <20230303142732.2xsfnkhphlivwjb3@wittgenstein>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <ZADmuzDEr6yznutq@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZADmuzDEr6yznutq@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 06:11:07PM +0000, Al Viro wrote:
> On Thu, Mar 02, 2023 at 09:30:25AM +0100, Christian Brauner wrote:
> > On Mon, Feb 27, 2023 at 04:44:06PM -0800, Linus Torvalds wrote:
> > > On Wed, Jan 25, 2023 at 7:56 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> > > >
> > > > Turns out for typical consumers the resulting creds would be identical
> > > > and this can be checked upfront, avoiding the hard work.
> > > 
> > > I've applied this v3 of the two patches.
> > > 
> > > Normally it would go through Al, but he's clearly been under the
> > > weather and is drowning in email. Besides, I'm comfortable with this
> > > particular set of patches anyway as I was involved in the previous
> > > round of access() overhead avoidance with the whole RCU grace period
> > > thing.
> > > 
> > > So I think we're all better off having Al look at any iov_iter issues.
> > > 
> > > Anybody holler if there are issues,
> > 
> > Fwiw, as long as you, Al, and others are fine with it and I'm aware of
> > it I'm happy to pick up more stuff like this. I've done it before and
> > have worked in this area so I'm happy to help with some of the load.
> 
> TBH, I've missed that series; patches look sane, so consider them
> belatedly ACKed.
> 
> And I've no problem with sharing the load - you have been doing that with
> idmapping stuff anyway.  As far as I'm concerned, I generally trust your
> taste; it doesn't matter that I won't disagree with specific decisions,
> of course, but...

Thanks, I appreciate that!

Sure, you won't agree with everything. That's kinda expected for reasons
of preference alone but also simply because there's a lot of stuff that
probably only you know atm. In general, I never pick up any stuff I
can't review myself unless it's in-your-face obvious or it already has
acks from the subject matter experts.

But it is much easier to help maintain vfs stuff now that you made it
clear that you're ok with this. So I'm happy to share more of the vfs
maintenance workload.
