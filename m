Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0BF6F9340
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEFRKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 13:10:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FC31CFDD
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 10:10:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965d73eb65fso369050366b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683393046; x=1685985046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep2eFTjXkhewcCNr0bmXM2Y/3o4NieTjicG14F04RRo=;
        b=CGy8Ct67kPfMBD32CeTOeucyvnK79GBDaBmBGh6+HrniyxCmUbbvrSQCVsj+nnp4Aa
         nJHCOQfXFJJa9xSoLWsOzCTU9SMa7Rte7J+4VI5d7vExbWRPis/VuCHpEwv2ekXGS8Ru
         3riE/CpokxA1d9o0MqP5pZn2EM5CD9mkHBv1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683393046; x=1685985046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep2eFTjXkhewcCNr0bmXM2Y/3o4NieTjicG14F04RRo=;
        b=EmBdxqmVqZFXoO+Qg3zl1ReHoIqXMWYKWkQMqLe/DoUrpkR3mZYZO/2KH4klN2BDse
         9KVhLHtSsPkDrebJkKYNeIvwPjqZcfsyCLUGJUMWScq0EmuTUnDc1wt7X9EZa9ErQNeG
         CF866GBnfYqY6NWs4YN45I1KSF59qqhbxZORNoCsWLc1fwXoXZ1U92XtgfUa85au4pGC
         i/X3vapwQfibrZn6GkZLPNw3kWeJ43nDeQW+cVcMBEKzXwFwYAu1L+TnLmz/R/+n9mti
         /tYSSBPKoJRVOO3YaJsNck03thleWTlVOLm8JBRwSvan6sH3qp5JJ2L6ORbj/uJtf/Dm
         f8tw==
X-Gm-Message-State: AC+VfDzEh2e+0UtLVWZu0nBovKMoAs2TeaP15hDg8nsxabTsqn8la2ab
        P80S2MyejSGBg/Y5TrJ8VTjsYk7S+LkCN98LFMhCNw==
X-Google-Smtp-Source: ACHHUZ6GhbKZnyuMSD7aUaZ0oZz7b9fswnbExc6hu8ZtrwLClvXHoKNY5zCTLh9MDoJ9J3sQ+LSAUg==
X-Received: by 2002:a17:907:7ea2:b0:954:c085:56b3 with SMTP id qb34-20020a1709077ea200b00954c08556b3mr4870631ejc.53.1683393045846;
        Sat, 06 May 2023 10:10:45 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709066d0f00b0094f124a37c4sm2545478ejr.18.2023.05.06.10.10.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 10:10:44 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-94a342f7c4cso522548166b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 10:10:44 -0700 (PDT)
X-Received: by 2002:a17:907:3f90:b0:953:9899:d9c1 with SMTP id
 hr16-20020a1709073f9000b009539899d9c1mr5635228ejc.1.1683393044055; Sat, 06
 May 2023 10:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230506160415.2992089-1-willy@infradead.org> <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com> <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 10:10:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
Message-ID: <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
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

On Sat, May 6, 2023 at 10:04=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So scratch that patch suggestion of mine, but let's bring in some
> people involved with the original fpin code, and see if we can find
> some solution that honors that error case too.

.. in the meantime, I did end up applying your patch.

I still don't like the code around it, but let's fix the conversion
error and worry about the other issues later.

                  Linus
