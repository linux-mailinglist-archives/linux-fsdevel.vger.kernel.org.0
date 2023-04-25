Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAF96EE405
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjDYOgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjDYOgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45E13FAD;
        Tue, 25 Apr 2023 07:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EE7562616;
        Tue, 25 Apr 2023 14:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0F5C433EF;
        Tue, 25 Apr 2023 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682433392;
        bh=+kk30ThPWVCr+ufa0kwWhG4W22jpqiL839hXy4+jZEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jsv+wWj1fuIfDk5+XpldOqPiBFqDj6vBgwXDRxsE1Qq39ZYTiUYlT2tpTIuYTQHg/
         1WNGfsoQdBM7G23lvOTO2ybM8mQk0zDAjeYDdoZySMl2zTwZFGlQ2DOk43zKVCEp6M
         CtFMa5F6fSY0JMWp1QTIgtqSRbwUnoWOzNL7TdaJg+OnNYhYXnvP7gN8TwEurN5U8g
         HixenrRfVLlA0HyiSpiebfUp5Dap255dcIBRcHQ02GlpOZ+FnVQBP51C5r4zEg+IUJ
         UyS6PP9xQIA5I8Rq5g8L2VQ8OPWmNbUCo+bDcwa29a9aOd0CUOd6J9+B8lfzoG/NMN
         2lnA1melEr5YQ==
Date:   Tue, 25 Apr 2023 16:36:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230425-mulmig-wandschmuck-75699afb1ecc@brauner>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230425135429.GQ3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425135429.GQ3390869@ZenIV>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 02:54:29PM +0100, Al Viro wrote:
> On Tue, Apr 25, 2023 at 02:34:15PM +0200, Christian Brauner wrote:
> 
> > It is rife with misunderstandings just looking at what we did in
> > kernel/fork.c earlier:
> > 
> > 	retval = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
> >         [...]
> >         pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
> >                                      O_RDWR | O_CLOEXEC);
> > 
> > seeing where both get_unused_fd_flags() and both *_getfile() take flag
> > arguments. Sure, for us this is pretty straightforward since we've seen
> > that code a million times. For others it's confusing why there's two
> > flag arguments. Sure, we could use one flags argument but it still be
> > weird to look at.
> 
> First of all, get_unused_fd_flags() doesn't give a damn about O_RDWR and
> anon_inode_getfile() - about O_CLOEXEC.  Duplicating the expression in
> places like that is cargo-culting.

I distinctly remember us having that conversation about how to do this
nicely back then and fwiw this is your patch... ;)
6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")

So sure, that was my point: people are confused why there's two flag
arguments and what exactly has to go into them and just copy-paste
whatever other users already have.

>  
> > But with this api we also force all users to remember that they need to
> > cleanup the fd and the file - but definitely one - depending on where
> > they fail.
> > 
> > But conceptually the fd and the file belong together. After all it's the
> > file we're about to make that reserved fd refer to.
> 
> Why?  The common pattern is
> 	* reserve the descriptor
> 	* do some work that might fail
> 	* get struct file set up (which also might fail)
> 	* do more work (possibly including copyout, etc.)
> 	* install file into descriptor table
> 
> We want to reserve the descriptor early, since it's about the easiest
> thing to undo.  Why bother doing it next to file setup?  That can be
> pretty deep in call chain and doing it that way comes with headache
> about passing the damn thing around.  And cleanup rules with your
> variant end up being more complicated.
> 
> Keep the manipulations of descriptor table as close to the surface
> as possible.  The real work is with file references; descriptors
> belong in userland and passing them around kernel-side is asking
> for headache.

Imho, there's different use-cases.

There's definitely one where people allocate a file descriptor early on
and then sometimes maybe way later allocate a struct file and install
it. And that's where exposing and using get_unused_fd_flags() and
fd_install() is great and works fine.

But there's also users that do the reserve an fd and allocate a file at
the same time or receive both at the same time as the seccomp notifier,
scm creds, or pidfds. The receive_fd* stuff is basically a version of
the sketch I did without the ability to simply use a struct and not
having to open-code everything multiple times.

I never expected excitement around this as it was difficult enough to
get that receive_fd* thing going so I'm not arguing for this to be the
ultima ratio...
