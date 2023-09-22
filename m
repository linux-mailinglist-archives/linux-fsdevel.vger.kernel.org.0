Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E547AB217
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjIVM2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIVM2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:28:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524B599;
        Fri, 22 Sep 2023 05:28:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B5EC433C7;
        Fri, 22 Sep 2023 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695385708;
        bh=KiaYuFGK03yGp8RIzWR+0QJ4yp3iBkhq46kGwBQ6cDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gz8gLvVX8Ot1xF3TjeyQFLtEcFE4/4YpZrexOIhPX3Pjted3U162J8TUvOIXBq4na
         +cmTp3CFM8xMf/pxMThl5L70PaHRSrRett/O6sLkKaxKsP6XtKJDHQeafJOHa2voMm
         orMza1QO1TYzDODT2dcdTDAl/KZswMOI1+nA71Bu4lwG4ZYR35ItjhTAM+Eidysoga
         V/KeB2QtI8qaSrgwxorCE1ql66+jkO1eUz5nNiEzvPn0Tm2Dz1k6pPx9BAtIeQz9cc
         IiUn+bTtCvis1twSlJpzVzWG0LUMl2pOSaI/2rdJhUrd+qr2szCZrz+GNRt4uG91tj
         IBaD9KVo96H4g==
Date:   Fri, 22 Sep 2023 14:28:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL v2] timestamp fixes
Message-ID: <20230922-halunken-teilweise-b118ac91eeb1@brauner>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAHk-=wjDAqOs5TFuxxEOSST-5-LJJkAS5cEMrDu-pgiYsrjyNw@mail.gmail.com>
 <bc96335d0427d0e7ded2ea7e1d0db55c7e484909.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc96335d0427d0e7ded2ea7e1d0db55c7e484909.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I'll have to think about it. The first step is to get all of the

I think it'd be best if we start off with converting the other times in
struct inode to accessor and leave the questions whether timestamps-
until-2292 are enough to solve for later. I don't think the torn
timestamp reads is all that of a pressing issue and mixing both things
up might just stall what is otherwise already a worthy cleanup.
