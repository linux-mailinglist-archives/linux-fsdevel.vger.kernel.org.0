Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D1A7AC78A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 12:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjIXK1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIXK1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:27:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F78E7;
        Sun, 24 Sep 2023 03:26:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4694C433C8;
        Sun, 24 Sep 2023 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695551215;
        bh=7cLQg98m6+9eW+6GoIBst+Vv8YYV01tpEGvVQDPRTYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOLcmHJ2gPMA313OsvVYvG5W3of3l46X2wWZ0KdIE4Shwn1QyDv/5P8e9CtzzoIgH
         DktH2T+W9CFC9FKWVRPhEv1jNL8bvxyV3GkoXVNgg/k+t7VadSe+8/wA6xJwdc/MVa
         pHz55+R561UZc/w5H3sPPCYeSoI+t3anl/Bdln//jM0FoyhL3qrQb8N1fSthtK2rt0
         +RnffvW95OeLAqRWeWnNIYh+hvb84eEjwwc8rcNULX3+E/hOJ7M1aG27h1l/53ADUI
         IaT8xh1/gMFL8uAtsQ3r13hEedAAQHpZ3O5R0crwtpqel0pFpdcVYhVKFOASEayD7x
         2Ovsk2WTipgSw==
Date:   Sun, 24 Sep 2023 12:26:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [GIT PULL v2] timestamp fixes
Message-ID: <20230924-trial-dennoch-e641f0e0ee1b@brauner>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
 <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
 <CAOQ4uxgFb250Na9cJz0Jo-ioPynWCk0vxTDU-6hAKoEVQhgvRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgFb250Na9cJz0Jo-ioPynWCk0vxTDU-6hAKoEVQhgvRg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Those workloads are broken garbage, and we should *not* use that kind
> > of sh*t to decide on VFS internals.
> >
> 
> Sorry, I phrased it completely wrong.

Thanks for clearing this up. I had just formulated my own reply but I'll
happily delete it. :)

> The workloads don't expect 1ns resolution.

Yes, they don't. In the revert explanation I just used that number to
illustrate the general ordering problem. The workload that surfaced the
issue is just plain weird of course but it points to a more general
ordering problem.

> The workloads just compare timestamps of objects and expect some sane
> not-before ordering rules.

Yes.

> If user visible timestamps are truncated to 100ns all is good.

Yes.
