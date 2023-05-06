Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360F06F9360
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 19:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEFRey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 13:34:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5334DCD
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 10:34:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso5352837a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683394490; x=1685986490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkfiFO2TAu8U9TzXRHy7r3/97lK8Wf22UerAhikqYj0=;
        b=IB8OZDsKqukrdCqerhCFBXPVfcEzoh7yZOTKsB1J9ymovJScitXh/cuXnG3j0KG2pC
         yRzx7KlbRzmBE25HCjCRffs4XW6VLsP74bOCCqUlnJmdUEVWsNnvZhTKpew0VdjbrNHI
         g13+tSbQXFwIeqORrjq8RXOnUaPkCSn3whIq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683394490; x=1685986490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkfiFO2TAu8U9TzXRHy7r3/97lK8Wf22UerAhikqYj0=;
        b=Y1tJNXhKngBWNx8X7D1Zs9Vgu7Xz+/0E+hbkiJLS1DUhhZ4pUIS982Rjlo5Vq1yOYM
         wxovzAu6Flx4HHTjad+zUmpFsaAJT3MUpIm8+zRGPQI6RK73G1T1eXPY+ZYBWQZu+9/g
         +ir/YGi8TXQ9sXwy8lKNoPXAf0kgFxfHnq8ecs04qA27EtvJvSJdqbv2vN7HA/PJyyHw
         3YSZd+ImvcstYRWt03Ne6WkW12dP406/aNm9t0UWzpan0SjazvnTf+/4yksg0ecazRnh
         KwKORjizYn49RpSgyjA4d2O5Dv4yV8cNZ60rLMaKpXPAEP3DY3c3UVKWI4inPxTKb9eu
         a/kQ==
X-Gm-Message-State: AC+VfDw7r0VRaehs+IyDUpx5ACpOtg8uFwo6cn6xvie+ycaCPzZdE4Ay
        ZuwBT38JaeiQtiOTC1H7Tm5WRA3dBjnQW8jMMoI+Ag==
X-Google-Smtp-Source: ACHHUZ60Vf0z8tuWYsvz+xp2MT1orTqrELFXivrKSQdeUDfydZaBTbuuh1gi0E45iokcgXuALJKhRg==
X-Received: by 2002:a17:906:6a0e:b0:959:c6ba:4317 with SMTP id qw14-20020a1709066a0e00b00959c6ba4317mr4883882ejc.48.1683394490669;
        Sat, 06 May 2023 10:34:50 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id ka7-20020a170907990700b00947ed087a2csm2545110ejc.154.2023.05.06.10.34.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 10:34:49 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-965f7bdab6bso292154466b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 10:34:49 -0700 (PDT)
X-Received: by 2002:a17:907:360c:b0:94a:845c:3528 with SMTP id
 bk12-20020a170907360c00b0094a845c3528mr4237253ejc.45.1683394488588; Sat, 06
 May 2023 10:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230506160415.2992089-1-willy@infradead.org> <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com> <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
In-Reply-To: <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 10:34:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com>
Message-ID: <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 6, 2023 at 10:10=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. in the meantime, I did end up applying your patch.

Final (?) note on this: I not only applied your patch, but went
looking for any other missed cases.

And found one in fs/nfs/dir.c, which like ext4 had grown a new use of
__filemap_get_folio().

But unlike ext4 it hadn't been caught in linux-next (or I had just
missed it) and so I hadn't caught it in my merge either.

I hope that's the last one.

I grepped for all these __filemap_get_folio() cases when I did the MM
merge that brought in that change (and did the ext4 merge fixup), but
then the nfs pull happened later and I didn't think to check for new
cases...

A current grep seems to say that it's all good. But we had all missed
the second check in filemap_fault(), so...

                   Linus
