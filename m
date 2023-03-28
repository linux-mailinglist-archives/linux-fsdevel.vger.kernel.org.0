Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99486CC9A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjC1RvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1RvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:51:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66335CDD2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:50:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so52955430edb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680025857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI2j61yMJdf7TnvRj6afVXARazuag284JZGLVkHrmP0=;
        b=LN0dotD8i4gIsy+r2eCiG0mN80eNBlHw8YGR/lk+YUv47bRoPOy3yYvLZmaisLBkTY
         OVAnuHCC0c8wCiWK1OlouE0q1kuqBkkkFyt2HnX7BbN8o8IWhUiWtMWVdEf5vgblMCaK
         53ngzENpTeHoEWbh+cMecjTybqHL3QzMdvS2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI2j61yMJdf7TnvRj6afVXARazuag284JZGLVkHrmP0=;
        b=suqU9T5iugG7UslBDPXJHA7dr8dBtJMeqYOay91Nzym9VE+oEVM2nqYEBpoHduuMNp
         wl9j5NvUKUUdE+JKqdo88nRQhtbTAbkFegjambC8SI3nTI4BJVBw0KfkVSmkFbsaqU8Q
         OEtyJjE/4f6jp3JPZ5heHCWM4YmpSk8z7E7RXcf6zqspPU6wBdNRr8GO9b3BBZIJXsq7
         KqIbY5YoK1VPXrJOZGdB025JQLLiqKPn9IzeEJYxg/OW/qxjxLsLZvI+IYEY5qAur0I9
         DGAkvuQ8vXsiGz9VPiYvUgAkS2P0YD7yhGF5Vr5LqA6414Ybuchy9aYBOFxUVBjI1ppI
         vS1Q==
X-Gm-Message-State: AAQBX9emeDM8al53x5jEOvFlloClnH8VeBGn57pCMOQd8uxj/i6KSc7s
        vILYiFCHxWfLUtu5C9DLEWIpIqpNWQJF5rGMIFVmKQ==
X-Google-Smtp-Source: AKy350ZMYYYyVq9hcHnltdpg97fMcySpWhCP/BIqUMTC5kZmufSse4U5KCF2KjYeybaavYmoCnibOg==
X-Received: by 2002:a17:907:6a11:b0:93e:5a85:ad3c with SMTP id rf17-20020a1709076a1100b0093e5a85ad3cmr16821528ejc.57.1680025857625;
        Tue, 28 Mar 2023 10:50:57 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id lm15-20020a170906980f00b008c76facbbf7sm15642960ejb.171.2023.03.28.10.50.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 10:50:57 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id r11so53051649edd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:50:56 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:931:6e39:3d0b with SMTP id
 ne10-20020a1709077b8a00b009316e393d0bmr8463575ejc.15.1680025856622; Tue, 28
 Mar 2023 10:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173613.555192-1-axboe@kernel.dk> <20230328173613.555192-5-axboe@kernel.dk>
In-Reply-To: <20230328173613.555192-5-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Mar 2023 10:50:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiy4UmtfcpMSWSWRGvS1XGkqsPhZkLzi+Cph18FPJzbQ@mail.gmail.com>
Message-ID: <CAHk-=whiy4UmtfcpMSWSWRGvS1XGkqsPhZkLzi+Cph18FPJzbQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] snd: make snd_map_bufs() deal with ITER_UBUF
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:36=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> @@ -3516,23 +3516,28 @@ static void __user **snd_map_bufs(struct snd_pcm_=
runtime *runtime,
>                                   struct iov_iter *iter,
>                                   snd_pcm_uframes_t *frames, int max_segs=
)
>  {
> +       int nr_segs =3D iovec_nr_user_vecs(iter);

This has a WARN_ON_ONCE() for !user_backed, but then..

>         void __user **bufs;
> +       struct iovec iov;
>         unsigned long i;
>
>         if (!iter->user_backed)
>                 return ERR_PTR(-EFAULT);

here the code tries to deal with it.

So I think the two should probably be switched around.

                 Linus
