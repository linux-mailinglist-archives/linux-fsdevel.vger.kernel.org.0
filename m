Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA3D376A76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 21:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhEGTHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhEGTHw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 15:07:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBAEC061761
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 May 2021 12:06:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w15so12856685ljo.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gh0B3WSFNAOfleCfnt2flKLSf30MwVsP2ZwOKpp82cg=;
        b=L9XM6lPCsR5SHe/yUVKrYoqK1Ves/gBOL1CWHPlhDT+6bNo/qx0S6DRRVt7dEXa0h1
         GWWo0lgKavlZBY9zlJFVG83v3PUZHzdMPeVfe7bgYAKX+03k2WBamuthGdgpFjkORL/G
         xWCFEYTl+e9SaO/+8AS0mz4kTkGvCpeLoQwBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gh0B3WSFNAOfleCfnt2flKLSf30MwVsP2ZwOKpp82cg=;
        b=hgnWvulCBMu4j/V8oHEwQSRi3U1RGVYhy57KwORg8em7iKaZ8BHxGo9OiS4FslbFmw
         wiFgxqp6g77ifsPHmrU+eUIK2vlvmpa8HxORSyijmSeh9O+Op4dsLSAdWQTT4YC/ZjJj
         T0KuxUJabE2DeONKp6cAlis6BjPXOOX9LHzpHy4p7aXh5IOjrHPFS9TJwFhu7ypPdGHm
         T5LSHKkcJauZwSx+JKJJXZdwhbzot9VjWtud9OMQ4LpZ2drWS85fR/YEurkiqBtj+cbR
         nK1oarAxIEC4wKwShVSJtTq5tBufzMODRE4UuqiVAvgWxJmTaAO9gVOaytcbJXJmFGVg
         WWTg==
X-Gm-Message-State: AOAM533QvW588t3RjQ4EqZCg7nJWyGHtnIioA0I2aAq30fR8M9m1Icli
        mUT7APdR5tNyxFnaptOI75c/3NhgUSsNvs7eJB8=
X-Google-Smtp-Source: ABdhPJz7lKuqjpGHxJB2ckTPmHsha8DMfeN10L3WA3vZ9CWeCezVfvhyMb/vNvECMslj50XCGzl5zA==
X-Received: by 2002:a2e:7010:: with SMTP id l16mr9044988ljc.41.1620414409456;
        Fri, 07 May 2021 12:06:49 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id b30sm1155859ljf.93.2021.05.07.12.06.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 12:06:48 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v5so12855833ljg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 12:06:48 -0700 (PDT)
X-Received: by 2002:a05:651c:3de:: with SMTP id f30mr8768618ljp.251.1620414408470;
 Fri, 07 May 2021 12:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com> <202105071116.638258236E@keescook>
In-Reply-To: <202105071116.638258236E@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 May 2021 12:06:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVMtMPRMMX9W_B7JhVTyRzVoH71Xw8TbtYjThaoCzJ=A@mail.gmail.com>
Message-ID: <CAHk-=whVMtMPRMMX9W_B7JhVTyRzVoH71Xw8TbtYjThaoCzJ=A@mail.gmail.com>
Subject: Re: splice() from /dev/zero to a pipe does not work (5.9+)
To:     Kees Cook <keescook@chromium.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 7, 2021 at 11:21 AM Kees Cook <keescook@chromium.org> wrote:
>
> So the question is likely, "do we want this for /dev/zero?"

Well, /dev/zero should at least be safe, and I guess it's actually
interesting from a performance testing standpoint (ie useful for some
kind of "what is the overhead of the splice code with no data copy").

So I'll happily take a sane patch for /dev/zero, although I think it
probably only makes sense if it's made to use the zero page explicitly
(ie exactly for that "no data copy testing" case).

So very much *not* using generic_file_splice_read(), even if that
might be the one-liner.

/dev/zero should probably also use the (already existing)
splice_write_null() function for the .splice_write case.

Anybody willing to look into this? My gu feel is that it *should* be easy to do.

That said - looking at the current 'pipe_zero()', it uses
'push_pipe()' to actually allocation regular pages, and then clear
them.

Which is basically what a generic_file_splice_read() would do, and it
feels incredibly pointless and stupid to me.

I *think* we should be able to just do something like

    len = size;
    while (len > 0) {
        struct pipe_buffer *buf;
        unsigned int tail = pipe->tail;
        unsigned int head = pipe->head;
        unsigned int mask = pipe->ring_size - 1;

        if (pipe_full(head, tail, pipe->max_usage))
            break;
        buf = &pipe->bufs[iter_head & p_mask];
        buf->ops = &zero_pipe_buf_ops;
        buf->page = ZERO_PAGE(0);
        buf->offset = 0;
        buf->len = min_t(ssize_t, len, PAGE_SIZE);
        len -= buf->len;
        pipe->head = head+1;
    }
    return size - len;

but honestly, I haven't thought a lot about it.

Al? This is another of those "right up your alley" things.

Maybe it's not worth it, and just using generic_file_splice_read() is
the way to go, but I do get the feeling that if we are splicing
/dev/null, the whole _point_ of it is about benchmarking, not "make it
work".

            Linus
