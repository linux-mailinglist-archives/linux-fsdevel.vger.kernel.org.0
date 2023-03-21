Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942E46C341C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 15:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCUOZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCUOYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BC6457E2;
        Tue, 21 Mar 2023 07:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46C3961C4A;
        Tue, 21 Mar 2023 14:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39451C433D2;
        Tue, 21 Mar 2023 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679408658;
        bh=qsraTqGwu6+J0SRLHT96USugJal80D3atzvcCU45Q3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0vlqTUzRpd20j+5HGfKFcSgC/h0nYVe/ANfS1k0Hg5dxOo04aINd0z60Sl1ERrEp
         0QHIK+VHv3XFEFTxQYsByULdp3zTVj8Aw2a3JRHDgKORnLYyED1yHGhXLkiO524lVV
         D9zh7hZWUahLQDXqN3BCfS6RyBS/Fre/p/V3tGk+jUMoVeIUnjEUxSC60oHMHf1Fpn
         meWKoxuWHOiy69N3gbL1KpjF5qhDQwUZpwibGouvU2xagdX9+MWSEyLeKogMH9jgMD
         /lKB8fJeKcjXeQvns6IOvVSeHhA+gIN7tNlyhxdIBOT+RFQxTS8cFdfgEuN+k7s4Bn
         sgau/zBK3J/PQ==
Date:   Tue, 21 Mar 2023 15:24:13 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <20230321142413.6mlowi5u6ewecodx@wittgenstein>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
 <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:24:52PM -0700, Linus Torvalds wrote:
> On Mon, Mar 20, 2023 at 12:27 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > 1) Pre v5.7 Linux did the open-dir-if-exists-else-create-regular-file
> > we all know and """love""".
> 
> So I think we should fall back to this as a last resort, as a "well,
> it's our historical behavior".
> 
> > 2) Post 5.7, we started returning this buggy -ENOTDIR error, even when
> > successfully creating a file.
> 
> Yeah, I think this is the worst of the bunch and has no excuse (unless
> some crazy program has started depending on it, which sounds really
> *really* unlikely).
> 
> > 3) NetBSD just straight up returns EINVAL on open(O_DIRECTORY | O_CREAT)
> > 4) FreeBSD's open(O_CREAT | O_DIRECTORY) succeeds if the file exists
> > and is a directory. Fails with -ENOENT if it falls onto the "O_CREAT"
> > path (i.e it doesn't try to create the file at all, just ENOENT's;
> > this changed relatively recently, in 2015)
> 
> Either of these sound sensible to me.
> 
> I suspect (3) is the clearest case.

Yeah, we should try that.

> 
> And (4) might be warranted just because it's closer to what we used to
> do, and it's *possible* that somebody happens to use O_DIRECTORY |
> O_CREAT on directories that exist, and never noticed how broken that
> was.

I really really hope that isn't the case because (4) is pretty nasty.
Having to put this on a manpage seems nightmarish.

> 
> And (4) has another special case: O_EXCL. Because I'm really hoping
> that O_DIRECTORY | O_EXCL will always fail.

I've detailed the semantics for that in the commit message below...

> 
> Is the proper patch something along the lines of this?

Yeah, I think that would do it and I think that's what we should try to
get away with. I just spent time and took a look who passes O_DIRECTORY
and O_CREAT and interestingly there are a number of comments roughly
along the lines of the following example:

/* Ideally we could use openat(O_DIRECTORY | O_CREAT | O_EXCL) here
 * to create and open the directory atomically

suggests that people who specify O_DIRECTORY | O_CREAT are interested in
creating a directory. But since this never did work they don't tend to
use that flag combination (I've collected a few samples in [1] to [4].).

(As a sidenote, posix made an interpretation change a long time ago to
at least allow for O_DIRECTORY | O_CREAT to create a directory (see [3]).

But that's a whole different can of worms and I haven't spent any
thoughts even on feasibility. And even if we should probably get through
a couple of kernels with O_DIRECTORY | O_CREAT failing with EINVAL first.)

> 
>    --- a/fs/open.c
>    +++ b/fs/open.c
>    @@ -1186,6 +1186,8 @@ inline int build_open_flags(const struct
> open_how *how, struct open_flags *op)
> 
>         /* Deal with the mode. */
>         if (WILL_CREATE(flags)) {
>    +            if (flags & O_DIRECTORY)
>    +                    return -EINVAL;

This will be problematic because for weird historical reasons O_TMPFILE
includes O_DIRECTORY so this would unfortunately break O_TMPFILE. :/
I'll try to have a patch ready in a bit.

I spent a long time digging through potential users of this nonsense.

Link: https://lore.kernel.org/lkml/20230320071442.172228-1-pedro.falcato@gmail.com
Link: https://sources.debian.org/src/flatpak/1.14.4-1/subprojects/libglnx/glnx-dirfd.c/?hl=324#L324 [1]
Link: https://sources.debian.org/src/flatpak-builder/1.2.3-1/subprojects/libglnx/glnx-shutil.c/?hl=251#L251 [2]
Link: https://sources.debian.org/src/ostree/2022.7-2/libglnx/glnx-dirfd.c/?hl=324#L324 [3]
Link: https://www.openwall.com/lists/oss-security/2014/11/26/14 [4]
