Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD8405F1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 23:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhIIV5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 17:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhIIV5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:57:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579CAC061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 14:56:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h16so6534531lfk.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejWm8B/glYYqr7Ut7PcEudaL6VmbufqHAGAhWo5Kdl4=;
        b=QzDfqeQbem+HgggMOmfEKjqrh0fskzFB66iccfpr64IPDJ+YBb29MeGgV9yydjXjfV
         uwpYl3J/o1HL4+UGAqjNXVMYDRLD4ZfE8Ka6sMs2w2M1E6LyAuU+2l2HrieK8M7/PLN3
         UjWQUBYDsU/0X+0gfeFc0Jz7k1zzLopyyoc9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejWm8B/glYYqr7Ut7PcEudaL6VmbufqHAGAhWo5Kdl4=;
        b=mriuvbCyzzbHgDau4tTCjyPNn+C3DJabS/qODYMgsxroknOh/zdjBVMQV/mo7yLXtf
         tDTN74MyBKwbOlI8SbQ5xIkNT+UAb7NCmI5BP3sZalAPcsxdem3OEbLxN45mmL9Y+bpc
         gcSLJiZEtt6B6HZ05CUG0hC/2Gj0BKru1wvcee7JaCRfs4F7O0cCe6+eZM7b4tgKedtY
         lXs3jGlhL2VdqMfReLzSvIbQqxoO7MYhjl/YQPC+A19+HWbk8E7z4c76rQj3RDFoYIpP
         W6ZJvJZ4h21pRfPy+49rECNVJDX574RGk/ZIU0I6k0NkYCRa85+sKfiX8gthrxLaFKQV
         1vuQ==
X-Gm-Message-State: AOAM533DrrI0DYtXtbbS7klX3qPjGWi4Ye3GXkX3TUYW+WEoku8rB/Oa
        rB6kF/uEFenPeuKybet7bXADRhzAncR6ry2a3jY=
X-Google-Smtp-Source: ABdhPJwvC6YKPxuG09+G7c9hJ8Z0ixGAABSTa9pDOw9eAO+13NSjWgy3sfQxevilGKX9zPn9Ru9cqA==
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr1463822lfp.2.1631224596438;
        Thu, 09 Sep 2021 14:56:36 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g31sm113913lfv.43.2021.09.09.14.56.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 14:56:36 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id n2so6636211lfk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 14:56:35 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr1463054lfb.141.1631224594865;
 Thu, 09 Sep 2021 14:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk> <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk> <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
In-Reply-To: <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 14:56:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
Message-ID: <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 9, 2021 at 2:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> OK, one that I immediately found is just doing O_DIRECT to a block
> device or file on XFS. As pages are mapped and added, the iov_iter is
> advanced. If we then go and submit and get -EAGAIN, for example, then we
> return with what we mapped already consumed.

Ok, that's annoying but understandable. Dave points to a commit that
removes one of the EAGAIN cases, but apparently not some others.

I do kind of wonder if you can't have the exact same case when *some*
of the IO succeeds, though.

IOW, can't we have  that

        ret = io_iter_do_read(req, iter);

return partial success - and if XFS does that "update iovec on
failure", I could easily see that same code - or something else -
having done the exact same thing.

Put another way: if the iovec isn't guaranteed to be coherent when an
actual error occurs, then why would it be guaranteed to be coherent
with a partial success value?

Because in most cases - I'd argue pretty much all - those "partial
success" cases are *exactly* the same as the error cases, it's just
that we had a loop and one or more iterations succeeded before it hit
the error case.

Hmm?

            Linus
