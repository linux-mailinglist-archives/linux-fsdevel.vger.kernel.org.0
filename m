Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE170FC9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjEXR0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjEXR0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812712B;
        Wed, 24 May 2023 10:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1924635DA;
        Wed, 24 May 2023 17:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039B2C433D2;
        Wed, 24 May 2023 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684949190;
        bh=6ais0B4n+elxHH0f009UAvpBDtwEouF2kYNBz48DV6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6jjYw4NK0MEoBx0IrMgxdkQXNyNy4XIvIXSSnR/ymqI/p7r/rP5JzFQdVsqMlb5z
         R7+2Tl8q9t4mmFVuy00NGCkhZitINnhFXzN/Ryy+doLViotkeEgmn3Hbr7LCikypmG
         Pa/+HTndaer8RCQQRfwyLjSrnxisu4SmqRqrw0XbNjVFs4WnntGpWNL1+GjjCHFKBX
         VwzHJkbWWTdaDELDKQj26hpFr6DZlI8dlLB3QdEUZDMAldcHgj3jnKKzGNG1rQtyYk
         LFWQuiw0Yi55H7+zvTL45X/VRaJ4N2AuulHpEaGfma+QiWte3GZpfj9+sp4HqbSQAa
         0rpATA8vEfjCQ==
Date:   Wed, 24 May 2023 19:26:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, tycho@tycho.pizza
Subject: Re: [RFC v7 1/2] epoll: Implement eventpoll_replace_file()
Message-ID: <20230524-quirlig-leckt-5e89366ede47@brauner>
References: <20230524063933.2339105-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524063933.2339105-1-aloktiagi@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 06:39:32AM +0000, aloktiagi wrote:
> Introduce a mechanism to replace a file linked in the epoll interface with a new
> file.
> 
> eventpoll_replace() finds all instances of the file to be replaced and replaces
> them with the new file and the interested events.h

I've spent a bit more time on this and I have a few more
questions/thoughts.

* What if the seccomp notifier replaces a pollable file with a
  non-pollable file? Right now you check that the file is pollable and
  if it isn't you're not updating the file references in the epoll
  instance for the file descriptor you updated. Why these semantics and
  not e.g., removing all instances of that file referring to the updated
  fd?

* What if the seccomp notifier replaces the file of a file descriptor
  with an epoll file descriptor? If the fd and original file are present
  in an epoll instance does that mean you add the epoll file into all
  epoll instances? That also means you create nested epoll instances
  which are supported but are subject to various limitations. What's the
  plan?

* What if you have two threads in the same threadgroup that each have a
  seccomp listener profile attached to them. Both have the same fd open.

  Now both replace the same fd concurrently. Both threads concurrently
  update references in the epoll instances now since the spinlock and
  mutex are acquired and reacquired again. Afaict, you can end up with
  some instances of the fd temporarily generating events for file1 and
  other instances generating events for file2 while the replace is in
  progress. Thus generating spurious events and userspace might be
  acting on a file descriptor that doesn't yet refer to the new file?
  That's possibly dangerous.

  Maybe I'm mistaken but if so I'd like to hear the details why that
  can't happen.

  Thinking about it what if the same file is registered via multiple fds
  at the same time? Can't you end up in a scenario where you have the
  same fd referring to different files in one or multiple epoll
  instance?

  I mean, you can get into that situation via dup2() where you change
  the file descriptor to refer to a different file but the fd might
  still be registered in the epoll instance referring to the old file
  provided there's another fd open holding the old file alive.

  The difference though is that userspace must've been dumb enough to
  actually do that whereas now this can just happen behind their back
  misleading them.

  Honestly, the kernel can't give you any atomicity in replacing these
  references and if so it would require new possibly invasive locking
  that would very likely not be acceptable upstream just for the sake of
  this feature. I still have a very hard time seeing any of this
  happening.

* I haven't looked at the codepath that tries to restore the old file on
  failure. That might introduce even more weirdness.
