Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E5610895
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 05:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiJ1DNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 23:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJ1DN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B7C53A64;
        Thu, 27 Oct 2022 20:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AFC8625E1;
        Fri, 28 Oct 2022 03:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769B7C433D6;
        Fri, 28 Oct 2022 03:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666926807;
        bh=A/Ht1k7frUyb1xRQOUCXBGytpx30yjPUQYTes+OL/Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kI1uZGkAUhsXaZZ93NzrZsPLwISjzFXe0upCU16sTSSYrOKVtBEbmGNvqLRENTLPR
         1n/PWBptw/t2QSpkPK5gaTmNB/avC2D9ExaK0AoraEGnrLdMZhs8fCvz5fQWdMYl9O
         asPi3w9Stci6WpnAehQBlPhEhAIWyUCiobrDGlUYX6hwCjRfRf0I7G9TTfvnZ/ZTKc
         AhN3DvInXERC3WChd8f/SkiBtIskwpGpN3isj+WkTo379VbMF955Nn/o+1XuMTVuEe
         YE4j0qIlC9Cs+sA6rF6imJAD0liyyeMihziINAdp/aWePJZWp680zUwIH6+aFS5exE
         ZhWmfsyThQeYQ==
Date:   Thu, 27 Oct 2022 20:13:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] fscrypt fix for 6.1-rc3
Message-ID: <Y1tI1ek80kCrsi2R@sol.localdomain>
References: <Y1oPDy2mpOd91+Ii@sol.localdomain>
 <CAHk-=wjDQiJn6YUJ18Nb=L82qsgx3LBLtQu0xANeVoc6OAzFtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDQiJn6YUJ18Nb=L82qsgx3LBLtQu0xANeVoc6OAzFtQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:58:03AM -0700, Linus Torvalds wrote:
> On Wed, Oct 26, 2022 at 9:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Fix a memory leak that was introduced by a change that went into -rc1.
> 
> Unrelated to the patch in question, but since it made me look, I wish
> code like that fscrypt_destroy_keyring() function would be much more
> obvious about the whole "yes, I can validly be called multiple times"
> (not exactly idempotent, but you get the idea).
> 
> Yes, it does that
> 
>         struct fscrypt_keyring *keyring = sb->s_master_keys;
>         ...
>         if (!keyring)
>                 return;
>         ...
>         sb->s_master_keys = NULL;
> 
> but it's all spread out so that you have to actually look for it (and
> check that there's not some other early return).
> 
> Now, this would need an atomic xchg(NULL) to be actually thread-safe,
> and that's not what I'm looking for - I'm just putting out the idea
> that for functions that are intentionally meant to be cleanup
> functions that can be called multiple times serially, we should strive
> to make that more clear.
> 
> Just putting that sequence together at the very top of the function
> would have helped, being one simple visually obvious pattern:
> 
>         keyring = sb->s_master_keys;
>         if (!keyring)
>                 return;
>         sb->s_master_keys = NULL;
> 
> makes it easier to see that yes, it's fine to call this sequentially.
> 
> It also, incidentally, tends to generate better code, because that
> means that we're just done with 'sb' entirely after that initial
> sequence and that it has better register pressure and cache patterns.
> 
> No, that code generation is not really important here, but just a sign
> that this is just a good coding pattern in general - not just good for
> people looking at the code, but for the compiler and hardware too.
> 

Thanks Linus.  That makes sense in general, but in this case ->s_master_keys
gets used in the middle of the function, in fscrypt_put_master_key_activeref().
I maybe should have made fscrypt_put_master_key_activeref() take the super_block
as an argument, which would have made this a bit clearer.

- Eric
