Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B034E763031
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGZIpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGZIpV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE54E4;
        Wed, 26 Jul 2023 01:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1637A61876;
        Wed, 26 Jul 2023 08:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83F9C433C8;
        Wed, 26 Jul 2023 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690360602;
        bh=3GlqyY7ypdrd9XrUgZY7qfg/u44TMTUBNKPVjbSg/SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWXeSZyl4iTP+6W28CAgdid2jQ8mzv+lgOehgwlr7yioXG4f/MsLy4iqzS5wSDT32
         MV83MJhzw04CUCJl/CkmoLr5z2noBw28fRJGywwWTw569MR+DkPC4bMZbbRtxzlkCW
         +06OGRyhJdo4qCo3o4kfVkM3BCq1162cCP843dHSOlFDeGAH4tdHM+fldAUXE6PcyR
         96Xnn/o9lyUyFtBiYbI4dXRyU2Kg3oLNUNErY+kdMAAX/dHyXZUPA4lpne400Ae0/D
         C1mEZLDIyugZ+SAUin4W/b2HiWqzpA8CARzXen8xDgEw6kp+HMDARcLG0FT9xTsflw
         rCBHU7mvYTAdw==
Date:   Wed, 26 Jul 2023 10:36:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230726-antik-abwinken-87647ff63ec8@brauner>
References: <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
 <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
 <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
 <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
 <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
 <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
 <8d1069bf-4c0b-22be-e4c4-5f2b1eb1f7e8@kernel.dk>
 <CAHk-=whMEd2J5otKf76zuO831sXi4OtgyBTozq_wE43q92=EiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whMEd2J5otKf76zuO831sXi4OtgyBTozq_wE43q92=EiQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:51:37PM -0700, Linus Torvalds wrote:
> On Tue, 25 Jul 2023 at 13:41, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > Right, but what if the original app closes the file descriptor? Now you
> > have the io_uring file table still holding a reference to it, but it'd
> > just be 1. Which is enough to keep it alive, but you can still have
> > multiple IOs inflight against this file.
> 
> Note that fdget_pos() fundamentally only works on file descriptors
> that are there - it's literally looking them up in the file table as
> it goes along. And it looks at the count of the file description as it
> is looked up. So that refcount is guaranteed to exist.
> 
> If the file has been closed, fdget_pos() will just fail because it
> doesn't find it.
> 
> And if it's then closed *afterwards*, that's fine and doesn't affect
> anything, because the locking has been done and we saved away the
> status bit as FDPUT_POS_UNLOCK, so the code knows to unlock even if
> the file descriptor in the meantime has turned back to having just a
> single refcount.

Yes, and to summarize which I tried in my description for the commit.
The getdents support patchset would have introduced a bug because the
patchset copied the fdget_pos() file_count(file) > 1 optimization into
io_uring.

That works fine as long as the original file descriptor used to register
the fixed file is kept. The locking will work correctly as
file_count(file) > 1 and no races are possible neither via getdent calls
using the original file descriptor nor via io_uring using the fixed file
or even mixing both.

But as soon as the original file descriptor is closed the f_count for
the file drops back to 1 but continues to be usable from io_uring via
the fixed file. Now the optimization that the patchset wanted to copy
over would cause bugs as multiple racing getdent requests would be
possible using the fixed file.

The simple thing ofc is that io_uring just always grabs the position
lock and never does this optimization. The authors were just unaware
because it wasn't obvious to them that fixed files would not work with
the optimization.

I caught that during review but then immediately realized that the
file_count(file) > 1 optimization was unfortunately broken in another
way, which ultimately led to this commit.
