Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2158C6C2194
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 20:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCTTdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 15:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCTTdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:33:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE261A485;
        Mon, 20 Mar 2023 12:27:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h31so7269807pgl.6;
        Mon, 20 Mar 2023 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679340446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkgmEiza+evw+yax/ljvpmBQmJQb9hjfUuWvcM6s700=;
        b=a8o7RuQZTDENSPx5XvzWznaBzNP5z6AlSkBXYl7vEWx5u7YvPgesbwFzJdAmnuUjgF
         Bxm9BzO7nCPq5dllrQlEyHAYh2VdnKE5ASot9/O+49cRHJPb8Azv0CPvrjBVJ9qck0yK
         f1BNrpCEmC/4+3HeEP83CSBe/wNp+ceTs5S7hhftp0dgtNMyRfx/AC8m1hBmSFeyQCfg
         vVHeIfHZSxfZIQGDk7aEpPvhniMrq8H4gFNCXQC8+Xva3pvwb4h/bO/PAM15kwZHa1lt
         mdqE1vwviSCYk79jl7K9ia7G71abd8pJrdqb0vGAAQKl3w5hBqJqRqAYTzn8ke91QXdH
         UE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679340446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkgmEiza+evw+yax/ljvpmBQmJQb9hjfUuWvcM6s700=;
        b=AWHjJsG6LqX7/CTu/tf1Jodafd5g17KWlNaNNbhFVWKDbTRkaT6GPuJmeR0/7zv8vw
         nUz4g0tBmWNUiWd3Xk9ZbCyT6bcsguP9qoh3s6Ug/GySDCM53SyZQ5K7a+7SrlfmqFGi
         FbDf6HgepeCU/fGnKwWcQKkrW3II7Qs2E7OqZuhTCpWE3WMbCZ2PyBKd7f8rlWL1IpSQ
         vMGr15Y9/MObi8vw9+JXr+s8SFFgFsb5rddDajQ2aV0wE240r6zz1/qwI2+2YCDulX++
         /LqFRYYBHowM2f1Q5DWYbyiCbibfE0C5OyUTvilL4GTd/QdJORsj3yB4z6a5VImiN8AE
         rg5g==
X-Gm-Message-State: AO0yUKWAKba8+fSgQvlTwMOKYvQ6DI5eygAkMMFXFH2tiVIt+k+BvPbU
        +ln5fbU7yTVgpm98cq0lhK72eexdbN4fOl6CoO4=
X-Google-Smtp-Source: AK7set/B+h8PGdYkzEvicRB6qDM1/Nmbo++zBoeLy/Co429TjW3Dalrr6+7bDk/2Vdu+h2e64o+v6QjwpTR0kogd7Ng=
X-Received: by 2002:a65:51cd:0:b0:502:d6c1:a72 with SMTP id
 i13-20020a6551cd000000b00502d6c10a72mr2193405pgq.12.1679340445973; Mon, 20
 Mar 2023 12:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
In-Reply-To: <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Mon, 20 Mar 2023 19:27:14 +0000
Message-ID: <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 5:14=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 20, 2023 at 4:52=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > So before we continue down that road should we maybe treat this as a
> > chance to fix the old bug? Because this behavior of returning -ENOTDIR
> > has existed ever since v5.7 now. Since that time we had three LTS
> > releases all returning ENOTDIR even if the file was created.
>
> Ack.
>
> I think considering that the return value has been broken for so long,
> I think we can pretty much assume that there are no actual users of
> it, and we might as well clean up the semantics properly.
>
> Willing to send that patch in and we'll get it tested in the crucible
> of the real world?

That sounds good to me, I can do that. What kind of new semantics are
we talking about here?

I originally found this when testing every kind of possibly-odd edge
case in path
walking/open(2). From the systems I've tested on (not too diverse, basicall=
y
NetBSD, FreeBSD, Linux 6.2.2, and now, when looking for a regression,
a variety of kernels since 2009), 4 behaviors occurred:

1) Pre v5.7 Linux did the open-dir-if-exists-else-create-regular-file
we all know and """love""".
2) Post 5.7, we started returning this buggy -ENOTDIR error, even when
successfully creating a file.
3) NetBSD just straight up returns EINVAL on open(O_DIRECTORY | O_CREAT)
4) FreeBSD's open(O_CREAT | O_DIRECTORY) succeeds if the file exists
and is a directory. Fails with -ENOENT if it falls onto the "O_CREAT"
path (i.e it doesn't try to create the file at all, just ENOENT's;
this changed relatively recently, in 2015)

Note that all of these behaviors are allowed by POSIX (in fact, I
would not call the old Linux behavior a *bug*, just really odd
semantics).

So, again, what kind of behavior change do we want here? IMO, the best
and least destructive would probably
be to emulate FreeBSD behavior here. I don't think open(O_DIRECTORY |
O_CREAT) returning -ENOTDIR
if it doesn't exist (as Christian suggested, I think?) makes any sort
of sense here.

Just my 2c.

--=20
Pedro
