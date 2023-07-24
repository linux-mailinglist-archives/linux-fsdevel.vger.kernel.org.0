Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8623275FB3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjGXPyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGXPx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:53:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459610E3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 08:53:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9939fbb7191so952848366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690214031; x=1690818831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gGgctA2utHA8Ao8JF1uO8HVoivYG2O9nLkJv2/8DmH8=;
        b=JVWXqJAxDgZpjEpGxa0aAZkvDjjTaKiQ8mFdp2sPgRJuID6aRIV/E9Nx/RLoFJTHqR
         J3VrH+xas43LBUcTnD3U/e95vtIar72kzk3MlX1JgCxpKajLiX8aucCK8LrsLU8haeGb
         gqTwAskoMH+gObYWgDQe89Jjb5bdNQ8JNtabw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214031; x=1690818831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGgctA2utHA8Ao8JF1uO8HVoivYG2O9nLkJv2/8DmH8=;
        b=GvQCDLvsP9amK9HWKXnOqCg/xQ80Xo9ZHN1uXuXiNkErLsjYtfxQ/UvM/WO35QZhhv
         uOYbCsR+PM0FsoWXAgSDLYQtw09sDyl3E0inSW6Tes4c5k+/ali6hcTxmjeRmwvTi9i8
         AZHzIA0lUkrOgMtHCnL9yqdq//G8RECQR0iCGnP35PCS0e2gfcHovWQCQ2CmeyJYYcfm
         S/bEIcfQL7620bJ/fcQExiDGHCrOQoICEygbln0cxrGv/8awcwm1skHylDUV5lz3xYN+
         wKgTE2hA0Ab3Phs8NK+E7qsI8xChguvw9sg1b4hYPRv0UaUpjIxmlajRLS/NI4xYxXaX
         IbkA==
X-Gm-Message-State: ABy/qLaQBOccZq9CSwBifBLXatlY5ENFUejFxjQiLK+jtCrFXRjHzgwZ
        S5ky04QkD729VHQDI5YvTh1yG/gwduPUSk++0Upp9Q==
X-Google-Smtp-Source: APBJJlELaBmglaOeGocpnslhrfyRMXKCTqtEcfF/9rYVqrNEuYodG+2PvjgrACKb/DzC1Kd4+RIYqg==
X-Received: by 2002:a17:907:86a8:b0:966:1bf2:2af5 with SMTP id qa40-20020a17090786a800b009661bf22af5mr16483745ejc.22.1690214031097;
        Mon, 24 Jul 2023 08:53:51 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id jj28-20020a170907985c00b0098d93142ce1sm6890798ejc.109.2023.07.24.08.53.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:53:50 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11552722a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 08:53:50 -0700 (PDT)
X-Received: by 2002:a05:6402:1212:b0:521:ad49:8493 with SMTP id
 c18-20020a056402121200b00521ad498493mr10321795edw.6.1690214029969; Mon, 24
 Jul 2023 08:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
In-Reply-To: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 08:53:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
Message-ID: <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So this was a case of "too much explanations make the explanation much
harder to follow".

I tend to enjoy your pull request explanations, but this one was just
*way* too much.

Please try to make the point you are making a bit more salient, so
that it's a lot easier to follow.

On Mon, 24 Jul 2023 at 08:01, Christian Brauner <brauner@kernel.org> wrote:
>
>     [..] the
> file_count(file) greater than one optimization was already broken and
> that concurrent read/write/getdents/seek calls are possible in the
> regular system call api.
>
> The pidfd_getfd() system call allows a caller with ptrace_may_access()
> abilities on another process to steal a file descriptor from this
> process.

I think the above is all you need to actually explain the problem and
boil down the cause of the bug, and it means that the reader doesn't
have to wade through a lot of other verbiage to figure it out.

>         if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
> -               if (file_count(file) > 1) {
> -                       v |= FDPUT_POS_UNLOCK;
> -                       mutex_lock(&file->f_pos_lock);
> -               }
> +               v |= FDPUT_POS_UNLOCK;
> +               mutex_lock(&file->f_pos_lock);
>         }

Ho humm. The patch is obviously correct.

At the same time this is actually very annoying, because I played this
very issue with the plain /proc/<pid>/fd/<xyz> interface long long
ago, where it would just re-use the 'struct file' directly, and it was
such a sh*t-show that I know it's much better to actually open a new
file descriptor.

I'm not sure that "share actual 'struct file' ever was part of a
mainline kernel". I remember having it, but it was a "last century"
kind of thing.

The /proc interface hack was actually somewhat useful exactly because
you'd see the file position change, but it really caused problems.

The fact that pidfd_getfd() re-introduced that garbage and I never
realized this just annoys me no end.

And sadly, the man-page makes it very explicit that it's this broken
kind of "share the whole file, file offset and all". Damn damn damn.

Is it too late to just fix pidfd_getfd() to duplicate the 'struct
file', and act like a new open, and act like /proc/<pid>/fd/<xyz>?

Because honestly, having been there before, I'm pretty convinced that
the real bug here is pidfd_getfd.

I wonder if we could make pidfd_getfd() at least duplicate the struct
file for directories. Those are the things that absolutely *require*
atomic file positions.

Argh.

I wonder if this also screws up our garbage collection logic. It too
ends up having some requirements for a reliable file_count().

                Linus
