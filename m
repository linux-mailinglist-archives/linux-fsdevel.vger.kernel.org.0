Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D446C82F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 00:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbhLGX2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 18:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhLGX2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:28:20 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E0C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 15:24:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so1958055edd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZHabsPUc23xUEp/km7HooDqnp/1KyBKhA9+Ose3GXw=;
        b=DvnwlWEkpneQi1XlSO3gBPxLD70iikmgjVN61w8yUvn34PBCune25Jj9mW9XNgFL4q
         un4+G4P2SmN1djB/dNEp7ybFulczA6mZmTtM/H80MUvsu1Ga3PzhvFuSc1Dk+D+hQ15/
         db+sVtRBcfzEfAnFuUgbgivW8aOWBdK5sEbbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZHabsPUc23xUEp/km7HooDqnp/1KyBKhA9+Ose3GXw=;
        b=JCn3SNvRCvT2k6RYPyALHArajJsp0Y4WbOr6bzglVOqB7JaLYHnQjzPuOJd4JIELUP
         vqeo7GRuJwfevVAC1lVOTabFjUYV5BOlatWcizMv5TLUJo+2AEFIPuHQPp5IGarGvThi
         xiFM2zlN8XJIMANfZBUyWqPKixcwy37cYgYvu47fGjwtcXGQojP1C3XQb2XUBuwg7y9M
         TnkamLbku2qnSBX7xAXWcF7DEp99oQWjjYmkVyZohN1i69X+PdqDOeILzWyF8x9+Kdnp
         Z8MdAmHgGPe/aHF80UhjfBDLW2I/PMcBG8hN0r0/Sd6/lMzaDBrV2kExFCPTXGNwhxy6
         QYXg==
X-Gm-Message-State: AOAM531AQVAjkEtG5W59/cimdzOKs3IPhFQJUZuPSNgOQ40JyFZZecnl
        RAnZF68aiiHjF7c3LCgEzko9q9EybmR0XH8Yw18=
X-Google-Smtp-Source: ABdhPJz+hFwmHhd54CItMfqsbMflbVZaHcORokEuTsB4zJEFXOhBRNvh3s3fFmItRq3x1Cf9kH/ldw==
X-Received: by 2002:a05:6402:1292:: with SMTP id w18mr13718655edv.46.1638919487955;
        Tue, 07 Dec 2021 15:24:47 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id f17sm742545edq.39.2021.12.07.15.24.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 15:24:47 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id q3so898542wru.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 15:24:47 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr55762662wrn.318.1638919487065;
 Tue, 07 Dec 2021 15:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20211207095726.169766-1-ebiggers@kernel.org>
In-Reply-To: <20211207095726.169766-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 15:24:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXM77BfA6gZTYzpP_7nWw3Mdjfr8pid_TLAqsk-p0wOQ@mail.gmail.com>
Message-ID: <CAHk-=wjXM77BfA6gZTYzpP_7nWw3Mdjfr8pid_TLAqsk-p0wOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] aio: fix use-after-free and missing wakeups
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 7, 2021 at 1:59 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Careful review is appreciated;

I dunno about "careful", but looks sane to me.

> Note, it looks like io_uring has the same bugs as aio poll.  I haven't
> tried to fix io_uring.

Jens?

                Linus
