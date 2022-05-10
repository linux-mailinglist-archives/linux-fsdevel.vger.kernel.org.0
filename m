Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AF520C6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 05:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiEJDxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 23:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiEJDxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 23:53:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F93BA4B
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 20:49:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so18457105edw.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 May 2022 20:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csH2b0yln8VJjIPZKUY8Qo0Oj23Oo4VsNy+UnhWpwO0=;
        b=oYECvY6qXcMfackrkGXaEF2Uh8uHzvWghh2G/m/tPRNi9b9hcdKAzXapnkBfurvbuY
         cQk/LXQg4Z0ssHXJbTax12Vpmb8NOErMzH+BaeZdW79uWkpm8VtbWCTuTP6+XBtrszqm
         My2e+l5cAmZyvF0loTH1IJeyRjko0Bh2atekA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csH2b0yln8VJjIPZKUY8Qo0Oj23Oo4VsNy+UnhWpwO0=;
        b=MrjY5Nt2NT+CkQk3yI7slmXR+LnbX+kah7ChW5Zlp0CcMim78kq/3ulbK86DxgizZs
         QH6/NuypktguH3AYCrU50T0l2kfu4+j5E9hDU1fvS0jWgWkQbJRdmB+HtOA4VxUMrpOL
         OFDzqmhwULv6h9I6H+z8C7o3T8kCc9ONk58yRgkn50ni6WM+klr+qzJH7/KURB13bG4/
         uudvvFGUSpHxXvNVbNgyfEHj4APk4IO638ldjMsE4kCdlAXyyKNa0GCzwlS5Lrc305WK
         zthKYSiRwCwLKkJmA2PBZoxx5YIXP0/vWk++Gq2/4l/w3KI7gwlHfOiF4yBoPG7MMgnU
         gSQg==
X-Gm-Message-State: AOAM533UYvY7mq4HdDtxOdudACVjKjEgYXA9SUtM5aXloTyMzgLbdpel
        1KgqPeRqck+EyZjMLoD/AwJxq+r0yc69oYjteAVP2A==
X-Google-Smtp-Source: ABdhPJwob4/gCvx9CBCx7p8HvSC7iJaxs4G3456S0eeE4V5/ze1040Hv+xp4UizOuDERM7sfMDPdbXRTbaFZ5ah5tNU=
X-Received: by 2002:a05:6402:5ca:b0:423:f330:f574 with SMTP id
 n10-20020a05640205ca00b00423f330f574mr20595539edx.116.1652154556554; Mon, 09
 May 2022 20:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
In-Reply-To: <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 May 2022 05:49:04 +0200
Message-ID: <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 May 2022 at 14:48, Christian Brauner <brauner@kernel.org> wrote:

> One comment about this. We really need to have this interface support
> giving us mount options like "relatime" back in numeric form (I assume
> this will be possible.). It is royally annoying having to maintain a
> mapping table in userspace just to do:
>
> relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
> ro       -> MS_RDONLY/MOUNT_ATTR_RDONLY
>
> A library shouldn't be required to use this interface. Conservative
> low-level software that keeps its shared library dependencies minimal
> will need to be able to use that interface without having to go to an
> external library that transforms text-based output to binary form (Which
> I'm very sure will need to happen if we go with a text-based
> interface.).

Agreed.

>   This pattern of requesting the size first by passing empty arguments,
>   then allocating the buffer and then passing down that buffer to
>   retrieve that value is really annoying to use and error prone (I do
>   of course understand why it exists.).
>
>   For real xattrs it's not that bad because we can assume that these
>   values don't change often and so the race window between
>   getxattr(GET_SIZE) and getxattr(GET_VALUES) often doesn't matter. But
>   fwiw, the post > pre check doesn't exist for no reason; we do indeed
>   hit that race.

That code is wrong.  Changing xattr size is explicitly documented in
the man page as a non-error condition:

       If size is specified as zero, these calls return the  current  size  of
       the  named extended attribute (and leave value unchanged).  This can be
       used to determine the size of the buffer that should be supplied  in  a
       subsequent  call.   (But, bear in mind that there is a possibility that
       the attribute value may change between the two calls,  so  that  it  is
       still necessary to check the return status from the second call.)

>
>   In addition, it is costly having to call getxattr() twice. Again, for
>   retrieving xattrs it often doesn't matter because it's not a super
>   common operation but for mount and other info it might matter.

You don't *have* to retrieve the size, it's perfectly valid to e.g.
start with a fixed buffer size and double the size until the result
fits.

> * Would it be possible to support binary output with this interface?
>   I really think users would love to have an interfact where they can
>   get a struct with binary info back.

I think that's bad taste.   fsinfo(2) had the same issue.  As well as
mount(2) which still interprets the last argument as a binary blob in
certain cases (nfs is one I know of).

>   Especially for some information at least. I'd really love to have a
>   way go get a struct mount_info or whatever back that gives me all the
>   details about a mount encompassed in a single struct.

If we want that, then can do a new syscall with that specific struct
as an argument.

>   Callers like systemd will have to parse text and will end up
>   converting everything from text into binary anyway; especially for
>   mount information. So giving them an option for this out of the box
>   would be quite good.

What exactly are the attributes that systemd requires?

>   Interfaces like statx aim to be as fast as possible because we exptect
>   them to be called quite often. Retrieving mount info is quite costly
>   and is done quite often as well. Maybe not for all software but for a
>   lot of low-level software. Especially when starting services in
>   systemd a lot of mount parsing happens similar when starting
>   containers in runtimes.

Was there ever a test patch for systemd using fsinfo(2)?  I think not.

Until systemd people start to reengineer the mount handing to allow
for retrieving a single mount instead of the complete mount table we
will never know where the performance bottleneck lies.

>
> * If we decide to go forward with this interface - and I think I
>   mentioned this in the lsfmm session - could we please at least add a
>   new system call? It really feels wrong to retrieve mount and other
>   information through the xattr interfaces. They aren't really xattrs.

I'd argue with that statement.  These are most definitely attributes.
As for being extended, we'd just extended the xattr interface...

Naming aside... imagine that read(2) has always been used to retrieve
disk data, would you say that reading data from proc feels wrong?
And in hindsight, would a new syscall for the purpose make any sense?

Thanks,
Miklos
