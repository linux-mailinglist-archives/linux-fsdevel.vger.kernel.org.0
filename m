Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70E8470CFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 23:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbhLJWWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 17:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJWWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:22:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E765C061746
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Dec 2021 14:18:31 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so33401145edb.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Dec 2021 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cg9eQLIFJh+c6PyNxKtwuoKrLTzGB9EH7kdUWu2F1Zk=;
        b=fjIKNDYtImPkvWhc4Gzi5Y6kMJ6cnfwQ/RiqfRI3cJHc25v1vy7IG2bDsPj2nuZIGT
         51kR6CzBU9d3pc//4CNDX/22b5STyxSY/wCTyZFr3DIT4TWnZdcmUvdF0IU0AIQesRdy
         hdx1nxWmkamQyMD1PEbF6tpMVytL5ULQW17oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cg9eQLIFJh+c6PyNxKtwuoKrLTzGB9EH7kdUWu2F1Zk=;
        b=Ef/ir5FeOmdbpSIweMqlpX66Ljs265WgBgTuGwFj/rWR9wqmw6L3gm6rtPzyMdbp3i
         31fiLpgdCfHtYefbyBPef/e1lmVCSD7qvYHh/cFxwkeYj5/Gj1HQaSxkxQVJvXbIyV8R
         PZXJNj79Fg4jz0PM4eqMNbyr8VwQKEiqIGshZi2LpJWgjgj0ztiIMu9KrBrohpzYUQV8
         qVb3jRMgXN7l+2YKADMgilLm6NyCpqGnX+CqZQcR64V5Qd3esp2mq0N76TblLVq6MNmY
         +Z2jwYwOLGdMPaSN8DKyYE4lzJTLTIE/Vgf9m6V9zmMs5jpLDP+WtxpNzSy77mWf0MgH
         ZJyA==
X-Gm-Message-State: AOAM530xSzn2SPa3GWONA2yjljXIkbl0dgxhIF8O28Porm/cH5n2771y
        0EVXsbQ1e2CoPKXdC4KeSLMwVaBb6szJuQFqfBM=
X-Google-Smtp-Source: ABdhPJzHUjHNa574Won6cJU80ehUz64WkuqHMdoeHbvAFlfyVLaT8BJ15kvI473StWKfVBwbYIQYEA==
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr27677091ejf.341.1639174709830;
        Fri, 10 Dec 2021 14:18:29 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id sb19sm2129432ejc.120.2021.12.10.14.18.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 14:18:29 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id c4so17248008wrd.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Dec 2021 14:18:28 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr15756314wra.281.1639174708611;
 Fri, 10 Dec 2021 14:18:28 -0800 (PST)
MIME-Version: 1.0
References: <YbOdV8CPbyPAF234@sol.localdomain>
In-Reply-To: <YbOdV8CPbyPAF234@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 14:18:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5X0iQ7dDY1joBj0eoZ65rbMb4-v0ewirN1teY8VD=8A@mail.gmail.com>
Message-ID: <CAHk-=wh5X0iQ7dDY1joBj0eoZ65rbMb4-v0ewirN1teY8VD=8A@mail.gmail.com>
Subject: Re: [GIT PULL] aio poll fixes for 5.16-rc5
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:33 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This has been tested with the libaio test suite, as well as with test
> programs I wrote that reproduce the first two bugs.  I am sending this
> pull request myself as no one seems to be maintaining this code.

Pulled.

The "nobody really maintains or cares about epoll/aio" makes me wonder
if we should just remove the "if EXPERT" from the config options we
have on them, and start encouraging people to perhaps not even build
that code any more?

Because I'm sure we have users of it, but maybe they are few enough
that saying "don't enable this feature unless you need it" is the
right thing to do...

               Linus
