Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E26F0385
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbjD0Jkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbjD0Jk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512E91BF3;
        Thu, 27 Apr 2023 02:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA0566396F;
        Thu, 27 Apr 2023 09:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A64C433EF;
        Thu, 27 Apr 2023 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682588427;
        bh=EPSMq7xCZFH2sMKq/nkbfxGJzJc5a1WXEejXdekkC4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLTMWS8VGBqwzdJfLwJE+7A9u+DEnjPgQiIWYf/BLLZR58T6PLtVdXbXfxXC5EcS6
         6MwMLrav/ul04f4y/r46AXSeyAX+SnckAXHKm+9hux6jjlUJL1D++wc4CJ7BrMNDXF
         00KC2N9O93KVc7DXn+/MGvF0za+OUdib8fFNlfxb7croShnDlWwSY3oWT6BIL8oMXf
         LfePty3jdB24BHzy6oWyPe05FkNPE3t7Xj9GuaEQGKRr4+5eAmNcN96lptCPQbK60C
         C5JYQfj6MxnHV84TX40JF3RuEScWdbjRclwjE+rOCbDPMPNagmZAjvGV5aIz6t9sZj
         67TxxgIicGnYA==
Date:   Thu, 27 Apr 2023 11:40:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230427-beobachten-flugzeit-300ecf4ae0a3@brauner>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV>
 <20230427073908.GA3390869@ZenIV>
 <20230427-postweg-ruder-ae997dab3346@brauner>
 <20230427085952.GB3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427085952.GB3390869@ZenIV>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 09:59:52AM +0100, Al Viro wrote:
> On Thu, Apr 27, 2023 at 10:33:38AM +0200, Christian Brauner wrote:
> 
> > File descriptor installation is not core functionality for drivers. It's
> > just something that they have to do and so it's not that people usually
> > put a lot of thought into it. So that's why I think an API has to be
> > dumb enough. A three call api may still be simpler to use than an overly
> > clever single call api.
> 
> Grep and you will see...  Seriously, for real mess take a look at e.g.
> drivers/gpu/drm/amd/amdkfd/kfd_chardev.c.  See those close_fd() calls in
> there?  That's completely wrong - you can't undo the insertion into
> descriptor table.

I mean, yes. There's literally a description how that's wrong in my pr
message...

> 
> I'm not suggesting that for the core kernel, but there's a plenty of
> drivers that do descriptor allocation.

That's undisputed. What I tried to say was that this is not their main
focus. The point is their design thinking is not centered on fd handling
that's just something they have to do and so they don't think about
cleanly handling for example installing an fd and the closing it again
in some failure path. And I'm not sure one should be just harshly
judging them. They're almost bound to get this wrong. You'd need to know
a bit about file descriptors to have this in mind. File descriptor
handling is subtle.

I mean, look at cachefiles_ondemand_get_fd()...
