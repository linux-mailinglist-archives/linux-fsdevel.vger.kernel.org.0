Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36BF6EDA92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 05:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjDYDQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 23:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjDYDQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:16:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C273C526A
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 20:16:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-957dbae98b4so504092266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 20:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682392607; x=1684984607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSjgMY+DyvB/swR/rl3aNZWeXlCNC1lanA+DhHihDgQ=;
        b=Hm231pF1ImaxHSu6kdB6NMu9bkMEEMxQXlnXGyEookQdaWIAFJdR2rSWaN6Nm7jDdk
         O7ZczarSzMzgbauRFpbMgZ7DGdX70z52FoRnkUioET98kYcrezjo7TLWzqwXsc3PdalV
         7SqQGH4k/bt9lBrPdVb6BVnBPYscEgo8Ecvkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682392607; x=1684984607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSjgMY+DyvB/swR/rl3aNZWeXlCNC1lanA+DhHihDgQ=;
        b=VDVN/vR4Q8FVOTYN/MNzE2+PIpUMuLW0OlLfVzYgbzZL3G0PvvmGi7Ae6KsKckTmbq
         vOoPzUbLbgXIIeR4Z9FQo/5sSEXwk+91X/9F/Vtex+4TqWGoSQK0IsQVuSb9skdblg0N
         axxQw9E1VPw51gQX4rr1AwDNQiLLV7/HFRBovAQ3YNWHScpFbb9GbePinTrFwACEbkXn
         vXPzriXoDUcLvnn0pi8Uzuz2pjjbOVCcM2YYq/wSj6ujMkn6LD5CaKFbfUS56ChayI4l
         wuho4dyC7GY9Z7+vrn1oHb5U93AEP8XtF5kJZVvkzuy0CowEdXcYuQ61fxaceNKgnAQD
         sTag==
X-Gm-Message-State: AAQBX9fNRgSRWs6c98iT/S3dX+HYsF9BxUO5akoSVCews0OgPqvkcl8U
        rm17WHXG5hdkIzMOhHq+lpYbeHsxGUUM8EEkQHPULvn1
X-Google-Smtp-Source: AKy350YsUjT3PN1AiC3n4QrLvWoaw3QoVJjhU0L7TxVM+4n9FDB8scrdkP7I37fUHzEvJGY1xI+3fg==
X-Received: by 2002:a17:906:b088:b0:94e:98da:ef97 with SMTP id x8-20020a170906b08800b0094e98daef97mr11153353ejy.27.1682392607555;
        Mon, 24 Apr 2023 20:16:47 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7c44f000000b00504a356b149sm5274729edr.25.2023.04.24.20.16.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 20:16:46 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-506bf4cbecbso7696356a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 20:16:46 -0700 (PDT)
X-Received: by 2002:aa7:d511:0:b0:4fa:8aa4:8d8b with SMTP id
 y17-20020aa7d511000000b004fa8aa48d8bmr11822454edq.7.1682392606254; Mon, 24
 Apr 2023 20:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk> <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk> <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
In-Reply-To: <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 20:16:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
Message-ID: <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 3:45=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Something like this. Not tested yet, but wanted to get your feedback
> early to avoid issues down the line.

Ok, that try_cmpxchg() loop looks odd, but I guess it's the right thing to =
do.

That said, you should move the

        old_fmode =3D READ_ONCE(file->f_mode);

to outside the loop, because try_cmpxchg() will then update
'old_fmode' to the proper value and it should *not* be done again.

I also suspect that the READ_ONCE() itself is entirely superfluous,
because that is very much a value that we should let the compiler
optimize to *not* have to access more than it needs to.

So if the compiler had an earlier copy of that value, it should just
use it, rather than us forcing it to read it again.

But I suspect in this case it makes no real difference to code
generation. There's nothing else around it that uses f_mode, afaik,
and the try_cmpxchg() will reload it properly to fix any possible
races up.

The READ_ONCE() would possibly make more sense if we actually expected
that FMODE_NOWAIT bit to change more than once, but then we'd
presuably have some ordering rule and it should be a
smp_load_acquire() or whatever.

As it is, if we ever see it clear, we don't care any more, and the
real value consistency guarantee is in the try_cmpxchg itself. There
are no possible races ot mis-readings that could matter.

So I think it could/should just be something like

    void pipe_clear_nowait(struct file *file)
    {
        fmode_t fmode =3D file->f_mode;
        do {
            if (!(fmode & FMODE_NOWAIT))
                break;
        } while (!try_cmpxchg(&file->f_mode, &fmode, fmode & ~FMODE_NOWAIT)=
);
    }

which sadly generates that big constant just because FMODE_NOWAIT is
up in the high bits and with the 'try_cmpxchg()', the compiler has no
choice but to get the full 32-bit value anyway.

               Linus
