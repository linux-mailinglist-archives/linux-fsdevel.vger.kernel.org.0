Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463F67B6ED3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJCQpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjJCQpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:45:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0209E;
        Tue,  3 Oct 2023 09:45:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F408C433C8;
        Tue,  3 Oct 2023 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696351508;
        bh=dop7RZSVr+4/mLN3z5UedbVXHAn1xpij/cdcv21p87g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TLl6iFVWym0CSjXj60zbILQQLypWm1S8Pz/F/KicfpRKTEQUhJ/5j0JFSl+mwvOkZ
         JuTCHpTVZl009+pJEfQfQ0MHzUy66KTaNixEjnk6d0W0PFDQ5rXISq/jGw0cjRjDob
         WmLVbHiFlhHuREzrk4F/+bWZvxydDTDLAEwxCPvV9XiC/TK8ooguUQJwztWDvJdcoG
         p9M7YlpPyVkEMUZVmge8W3Gu7p6Fsvom2NHY+glzXoqQOpeZbxx+hrifTn3BtjSBEt
         USvlMVsLwyUrWbr8yk4wY7eA6a1cmwF5bKKPrqFycP3YsRzPr/AuCD9mxxkJIY/zSG
         gd0jZeD8DG3kg==
Date:   Tue, 3 Oct 2023 09:45:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Jann Horn <jannh@google.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20231003164505.GA624737@dev-arch.thelio-3990X>
References: <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
 <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner>
 <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
 <CAGudoHHuQ2PjmX5HG+E6WMeaaOhSNEhdinCssd75dM0P+3ZG8Q@mail.gmail.com>
 <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
 <20230930-glitzer-errungenschaft-b86880c177c4@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930-glitzer-errungenschaft-b86880c177c4@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

> >From d266eee9d9d917f07774e2c2bab0115d2119a311 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Fri, 29 Sep 2023 08:45:59 +0200
> Subject: [PATCH] file: convert to SLAB_TYPESAFE_BY_RCU
> 
> In recent discussions around some performance improvements in the file
> handling area we discussed switching the file cache to rely on
> SLAB_TYPESAFE_BY_RCU which allows us to get rid of call_rcu() based
> freeing for files completely. This is a pretty sensitive change overall
> but it might actually be worth doing.
> 
> The main downside is the subtlety. The other one is that we should
> really wait for Jann's patch to land that enables KASAN to handle
> SLAB_TYPESAFE_BY_RCU UAFs. Currently it doesn't but a patch for this
> exists.
> 
> With SLAB_TYPESAFE_BY_RCU objects may be freed and reused multiple times
> which requires a few changes. So it isn't sufficient anymore to just
> acquire a reference to the file in question under rcu using
> atomic_long_inc_not_zero() since the file might have already been
> recycled and someone else might have bumped the reference.
> 
> In other words, callers might see reference count bumps from newer
> users. For this is reason it is necessary to verify that the pointer is
> the same before and after the reference count increment. This pattern
> can be seen in get_file_rcu() and __files_get_rcu().
> 
> In addition, it isn't possible to access or check fields in struct file
> without first aqcuiring a reference on it. Not doing that was always
> very dodgy and it was only usable for non-pointer data in struct file.
> With SLAB_TYPESAFE_BY_RCU it is necessary that callers first acquire a
> reference under rcu or they must hold the files_lock of the fdtable.
> Failing to do either one of this is a bug.
> 
> Thanks to Jann for pointing out that we need to ensure memory ordering
> between reallocations and pointer check by ensuring that all subsequent
> loads have a dependency on the second load in get_file_rcu() and
> providing a fixup that was folded into this patch.
> 
> Cc: Jann Horn <jannh@google.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

<snip>

> --- a/arch/powerpc/platforms/cell/spufs/coredump.c
> +++ b/arch/powerpc/platforms/cell/spufs/coredump.c
> @@ -74,10 +74,13 @@ static struct spu_context *coredump_next_context(int *fd)
>  	*fd = n - 1;
>  
>  	rcu_read_lock();
> -	file = lookup_fd_rcu(*fd);
> -	ctx = SPUFS_I(file_inode(file))->i_ctx;
> -	get_spu_context(ctx);
> +	file = lookup_fdget_rcu(*fd);
>  	rcu_read_unlock();
> +	if (file) {
> +		ctx = SPUFS_I(file_inode(file))->i_ctx;
> +		get_spu_context(ctx);
> +		fput(file);
> +	}
>  
>  	return ctx;
>  }

This hunk now causes a clang warning (or error, since arch/powerpc builds
with -Werror by default) in next-20231003.

  $ make -skj"$(nproc)" ARCH=powerpc LLVM=1 ppc64_guest_defconfig arch/powerpc/platforms/cell/spufs/coredump.o
  ...
  arch/powerpc/platforms/cell/spufs/coredump.c:79:6: error: variable 'ctx' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
     79 |         if (file) {
        |             ^~~~
  arch/powerpc/platforms/cell/spufs/coredump.c:85:9: note: uninitialized use occurs here
     85 |         return ctx;
        |                ^~~
  arch/powerpc/platforms/cell/spufs/coredump.c:79:2: note: remove the 'if' if its condition is always true
     79 |         if (file) {
        |         ^~~~~~~~~
  arch/powerpc/platforms/cell/spufs/coredump.c:69:25: note: initialize the variable 'ctx' to silence this warning
     69 |         struct spu_context *ctx;
        |                                ^
        |                                 = NULL
  1 error generated.

Cheers,
Nathan
