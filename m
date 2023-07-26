Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2FB762F80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjGZITD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjGZISK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:18:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062D65BA;
        Wed, 26 Jul 2023 01:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D580F617DC;
        Wed, 26 Jul 2023 08:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2E0C433C7;
        Wed, 26 Jul 2023 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690358872;
        bh=sYGys+As+WzO7HPivnhbGc7rlbLg8G36b1mQc6Z54F4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANGSY0Zohh8cCdjyv8A36pZwjTY898mMpbfB/T+s1SzUn+J8lHtZjcW0HVEFZ4Qxx
         U7bWHewzEk1uCGB/3UhNS5PXxje8UiftUv4R6Q+48gxxmf0Mat7GStYwzmkbq8uY+g
         jx+VI1l/YDN3rTGNcP/i8X27mQ9+uUIZu/+19rib681CSOcFVx0K+o+8vPKxqg+9NM
         3tl/i8elTGX4dw6sCrc789roP9u3KOXOmVKw8oOM/FCfAPTtcnVL1b80K0wLEs1ES0
         kU2Ti8qS2zW3rmck9ItcvT8MGjttg+FpM0SKYPVkXVYE7Ohy43/vkpiF6ko4KYaMb3
         W+ltYbBp0nZsw==
Date:   Wed, 26 Jul 2023 10:07:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230726-einverleiben-kroch-f2521aefed39@brauner>
References: <20230724-gebessert-wortwahl-195daecce8f0@brauner>
 <CAHk-=wiZRxy3983r_nvWG4JP=w+Wi623WA9W6i2GXoTi+=6zWg@mail.gmail.com>
 <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
 <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
 <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
 <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
 <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
 <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:30:32AM -0700, Linus Torvalds wrote:
> On Mon, 24 Jul 2023 at 15:57, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 7/24/23 4:25?PM, Linus Torvalds wrote:
> > > This sentence still worries me.
> > >
> > > Those fixed files had better have their own refcounts from being
> > > fixed. So the rules really shouldn't change in any way what-so-ever.
> > > So what exactly are you alluding to?
> >
> > They do, but they only have a single reference, which is what fixes them
> > into the io_uring file table for fixed files. With the patch from the
> > top of this thread, that should then be fine as we don't need to
> > artificially elevator the ref count more than that.
> 
> No.
> 
> The patch from the top of this thread cannot *possibly* matter for a
> io_uring fixed file.

Yeah, the patch doesn't matter for fixed files. But they copied the
logic from fdget_pos() which was the problem.

> 
> The fdget_pos() always gets the file pointer from the file table. But
> that means that it is guaranteed to have a refcount of at least one.
> 
> If io_uring fixed file holds a reference (and not holding a reference
> would be a huge bug), that in turn means that the minimum refcount is
> now two.
> 
> So the code in fdget_pos() is correct, with or without the patch.

Yes.

> 
> The *only* problem is when something actually violates the refcounting
> rules. Sadly, that's exactly what pidfd_getfd() does, and can
> basically make a private file pointer be non-private without
> synchronizing with the original owner of the fd.
> 
> Now, io_uring may have had its own problems, if it tried to
> re-implement some io_uring-specific version of fdget_pos() for the
> fixed file case, and thought that it could use the file_count() == 1
> trick when it *wasn't* also a file table entry.

Yes, that's what one of the patch versions did and what I pointed out
won't work and what ultimately led me to discover the pidfd_getfd() bug.
(That's also btw, why my explanation was long.)

> 
> But that would be an independent bug from copy-and-pasting code
> without taking the surrounding rules into account.

Yes, exactly what I said in the review.
