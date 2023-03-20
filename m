Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE606C2290
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 21:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCTUZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjCTUZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:25:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642F928D2D
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 13:25:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so18756527edd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679343910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crb5gaca3LAL3QSUXcVibd0Ph4xO6N/3m0QFmJdNuPA=;
        b=BLRXv6G1ID56F82XpWEhsLLXGi6naVJ5iSbdkQA7SE/Atqr0psA60I1mjhCS3ExRmt
         kO7EB0NChmWHwqiRx7d86y1GMB4mdZiKi4Ci8uHv8ZAi7MT/jE9/gM7ABk3rBXSbr1Rd
         RSrIKRwSr296G/Su9ZKl0smQU9mGe8tS6BCT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679343910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Crb5gaca3LAL3QSUXcVibd0Ph4xO6N/3m0QFmJdNuPA=;
        b=6sHjMJDMIxyn0ggMBzSS3iSwYmuOtwfF/dnzgnrIQ8egK0fus5Yq9kKlJqVtw6SFJF
         NvvSxXBKFXMuDeDbDM3RMb4tDxtQJlkSAE+0ozYAfpGG9COpSbtnDf7zRM8l+DX4zCR4
         LYJ/WQxf5rdCGmfY8C82uv1qFsk5b/5mUpiuElsGplNNjxVhfO5Utwx5kjW9Apx4+jXN
         W5Lh1WJOgsJ/v6iKl3TQtuMLwROuLkrP/CbNZS5KCYr6Hi3M2Nff3qO9Qy4l8P/tEnBH
         1CFQCTYbjQfRFL9xbj3qnZgEHJqYufFtQ2Eycn3zV/7eNn+z7Mh7K4+u/pgwku7c2j2U
         Cpgg==
X-Gm-Message-State: AO0yUKXifdKC2Nyo8EX+9MLcYPiIuVqWyK5UQi+inrHChXRyZDZR1unm
        TWN6+znCkWFHHnMd4EH7fOg9vSLBgBc3Xh7BcrzVCJTZ
X-Google-Smtp-Source: AK7set/3YWsTfqoGoaiE9TNC5+qAvWpXDemlYEbHhj6QisAmlm5GSMVIUQQHE7QzsiXQTUx9nG1gzg==
X-Received: by 2002:a17:907:2162:b0:92d:44ca:1137 with SMTP id rl2-20020a170907216200b0092d44ca1137mr344828ejb.43.1679343910417;
        Mon, 20 Mar 2023 13:25:10 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id qh7-20020a170906eca700b0092bea699124sm4837252ejb.106.2023.03.20.13.25.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 13:25:10 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id b20so18756257edd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 13:25:09 -0700 (PDT)
X-Received: by 2002:a17:906:2c04:b0:931:6e39:3d0b with SMTP id
 e4-20020a1709062c0400b009316e393d0bmr142412ejh.15.1679343909563; Mon, 20 Mar
 2023 13:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
In-Reply-To: <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 13:24:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
Message-ID: <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:27=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
>
> 1) Pre v5.7 Linux did the open-dir-if-exists-else-create-regular-file
> we all know and """love""".

So I think we should fall back to this as a last resort, as a "well,
it's our historical behavior".

> 2) Post 5.7, we started returning this buggy -ENOTDIR error, even when
> successfully creating a file.

Yeah, I think this is the worst of the bunch and has no excuse (unless
some crazy program has started depending on it, which sounds really
*really* unlikely).

> 3) NetBSD just straight up returns EINVAL on open(O_DIRECTORY | O_CREAT)
> 4) FreeBSD's open(O_CREAT | O_DIRECTORY) succeeds if the file exists
> and is a directory. Fails with -ENOENT if it falls onto the "O_CREAT"
> path (i.e it doesn't try to create the file at all, just ENOENT's;
> this changed relatively recently, in 2015)

Either of these sound sensible to me.

I suspect (3) is the clearest case.

And (4) might be warranted just because it's closer to what we used to
do, and it's *possible* that somebody happens to use O_DIRECTORY |
O_CREAT on directories that exist, and never noticed how broken that
was.

And (4) has another special case: O_EXCL. Because I'm really hoping
that O_DIRECTORY | O_EXCL will always fail.

Is the proper patch something along the lines of this?

   --- a/fs/open.c
   +++ b/fs/open.c
   @@ -1186,6 +1186,8 @@ inline int build_open_flags(const struct
open_how *how, struct open_flags *op)

        /* Deal with the mode. */
        if (WILL_CREATE(flags)) {
   +            if (flags & O_DIRECTORY)
   +                    return -EINVAL;
                if (how->mode & ~S_IALLUGO)
                        return -EINVAL;
                op->mode =3D how->mode | S_IFREG;

I dunno. Not tested, not thought about very much.

What about O_PATH? I guess it's fine to create a file and only get a
path fd to the result?

             Linus
