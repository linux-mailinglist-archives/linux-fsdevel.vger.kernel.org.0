Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372DA4EAB2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 12:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiC2KZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiC2KZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E462A251;
        Tue, 29 Mar 2022 03:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 040CF611DF;
        Tue, 29 Mar 2022 10:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871E5C340ED;
        Tue, 29 Mar 2022 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648549432;
        bh=XJLnOhavV8EgimN80lCNvH8tMMHjSYGDC4GO3Sa86+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfFXzVSxU4r6703Rsr5iLbRlNhe4Jfbhy7sMLarQXy1M2/LHRZNZ3uJTR6+T9VOxc
         OUs3nWeF7CZ8ELRK06MGP8gRp8bxeeJyvGrM8HwJ6bzk9aehX0T5zm/5ZYIO0eH3WB
         2Cp9nGFw/zSyRW3Bf0T9eze0s9yF4aEtV3tlk35ElsSrvAl2SXaPj1qNu81LgokOTu
         +skCc2O7iWVLFAdMQ2+mqXrKWQyAWEL5by70VQiyjqt9KVzK+xZpMZpqH+EFvGZhGI
         XDuP2jiNDvUTd805YI+qc+1be4zKqxzwEoJZg+s9vwEMOhocpTr/XnaXy571ftL+eX
         W/hv/mQelwSnQ==
Date:   Tue, 29 Mar 2022 12:23:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
Message-ID: <20220329102347.iu6mlbv5c76ci3j7@wittgenstein>
References: <20220326114009.1690-1-aissur0002@gmail.com>
 <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
 <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
 <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 27, 2022 at 03:21:18PM -0700, Linus Torvalds wrote:
> On Sun, Mar 27, 2022 at 2:53 PM <aissur0002@gmail.com> wrote:
> >
> > I am sorry, that was my first attempt to contribute to the kernel and
> > I messed up a little bit with the patch tag: it is actually a single,
> > standalone patch and there has been nothing posted previously.
> 
> No problem, thanks for clarifying.
> 
> But the patch itself in that case is missing some detail, since it
> clearly doesn't apply to upstream.
> 
> Anyway:
> 
> > In few words, an error occurs while executing close_range() call with
> > CLOSE_RANGE_UNSHARE flag: in __close_range() the value of
> > max_unshare_fds (later used as max_fds in dup_fd() and copy_fd_bitmaps())
> > can be an arbitrary number.
> >
> >   if (max_fd >= last_fd(files_fdtable(cur_fds)))
> >     max_unshare_fds = fd;
> >
> > and not be a multiple of BITS_PER_LONG or BITS_PER_BYTE.
> 
> Very good, that's the piece I was missing. I only looked in fs/file.c,
> and missed how that max_unshare_fds gets passed from __close_range()
> into fork.c for unshare_fd() and then back to file.c and dup_fd(). And
> then affects sane_fdtable_size().
> 
> I _think_ it should be sufficient to just do something like
> 
>        max_fds = ALIGN(max_fds, BITS_PER_LONG)
> 
> in sane_fdtable_size(), but honestly, I haven't actually thought about
> it all that much. That's just a gut feel without really analyzing
> things - sane_fdtable_size() really should never return a value that
> isn't BITS_PER_LONG aligned.
> 
> And that whole close_range() is why I added Christian Brauner to the
> participant list, though, so let's see if Christian has any comments.
> 
> Christian?

(Sorry, I was heads-deep in some other fs work and went into airplaine
mode. I'm back.)

So I investigated a similar report a little while back and I spent quite
a lot of time trying to track this down but didn't find the cause.
If you'd call:

close_range(131, -1, CLOSE_RANGE_UNSHARE);

for an fdtable that is smaller than 131 then we'd call:

unshare_fd(..., 131)
\dup_fd(..., 131)
  \sane_fdtable_size(..., 131)

So sane_fdtable_size() would return 131 which is not aligned. This
couldn't happen before CLOSE_RANGE_UNSHARE afaict. I'll try to do a
repro with this with your suggested fix applied.

Christian
