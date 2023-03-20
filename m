Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445FA6C2501
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 23:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCTW7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 18:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCTW7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F1B3C09;
        Mon, 20 Mar 2023 15:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CA61618A6;
        Mon, 20 Mar 2023 22:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB9CC433EF;
        Mon, 20 Mar 2023 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679353176;
        bh=za2Gl7eeUWgx7zbEJwo9bzWn5tZ8aI+vrlqCpm0t8sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFKytX4Q33Rhin2D5ugs6L0tIMzUAcK7BqaWJ03fIiZCBn9ncz4aEg+YwYrfxBs6T
         TisZTe/l+EYQ6UkUpZUuA/+sy80QraO9frJn6omCWYlD/pwok5XKcDu1N8rEESWmXb
         Z0yORlSLS1A4Uu4iiPFkcJig26ct0AOFurx6+mnEzQAIjWBvL5pr3VGaJyPoePxGi0
         Rn3BgbFgXqV9QZhRrBJ9P8xWpaE+MHvHG0VKXcXOBKv/jywYwu9tuKq4Jb5GBaoCqa
         gmAd9/7NflUZ2aeLcubhAmTyV6iZGJ8132teVju1vwWy3+W1cuP+I8ycXMtFDNoG5L
         j0Lbij3Mh5BGA==
Date:   Mon, 20 Mar 2023 15:59:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] fscrypt fix for v6.3-rc4
Message-ID: <20230320225934.GB21979@sol.localdomain>
References: <20230320205617.GA1434@sol.localdomain>
 <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:16:48PM -0700, Linus Torvalds wrote:
> On Mon, Mar 20, 2023 at 1:56 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> >       fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref()
> 
> Side note: please just use WARN_ON_ONCE() for things like this, not WARN_ON.
> 
> If it's triggerable, it should be triggered only once rather than
> flood the logs and possibly cause a DoS.
> 
> And if it's not triggerable, the "ONCE" doesn't matter.
> 
> I note that fscypt in general seems to be *way* too happy with
> WARN_ON() as some kind of debugging aid.
> 
> It's not good in general (printf for debugging is wonderful, but
> shouldn't be left in the sources to rot for all eternity), but it's
> particularly not good in that form.
> 

Yes, I agree that most of the WARN_ONs should be WARN_ON_ONCEs.  I think I've
been assuming that WARN_ON is significantly more lightweight than WARN_ON_ONCE.
But that doesn't seem to be the case, especially since commit 19d436268dde
("debug: Add _ONCE() logic to report_bug()").

But besides that, I believe WARN* is generally being used appropriately in
fs/crypto/.  It's used when assumptions made by the code are violated, but where
the hard crash of a BUG() is not necessary.  I think this is a good thing to
have, versus the alternative of doing nothing and making it much harder to track
down bugs...  Some particularly bad crypto bugs that we can easily WARN about,
such as IVs being truncated, may not even be detectable by users otherwise.

There are probably a few that should be removed, though.  I'm also considering
whether the refcounting-related ones should use CHECK_DATA_CORRUPTION, though
that may run afoul of the "don't use BUG() unless absolutely needed" rule...

- Eric
