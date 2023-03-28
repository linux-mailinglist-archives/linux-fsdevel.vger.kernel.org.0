Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B806CCCCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 00:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjC1WGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 18:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjC1WGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:06:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1461BFE
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:06:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i5so55833493eda.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680041181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6X1gaSjcd/OPJc5YxcrIHG+oIFT5xfmwVSAaxclDfE=;
        b=GTH7CqD8UgqPILImsxDUAt/BNdW2L5RiMQIaPOtrbNOKQ793UEec9kppopO2GAsl02
         TUpQspCE10j3kcTY+T1Naux/Vwiq01hVa4hUTQvkKyiuErRMcV6turCH414tPb/vHoEe
         YR905Gx75ae5S6GP+7Co5bUJdTQVmWkay9hpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6X1gaSjcd/OPJc5YxcrIHG+oIFT5xfmwVSAaxclDfE=;
        b=vSi978dQt6Ervr4LaPrEmDXLzgYjAIyZg64uW5/vZKzp4suFL3eVvhfjSRkDKrKNRe
         93Pg2kGGO0AK0OCaUWbh9brGKx3dLZ8b+IhQZQ8CNuJ4NuGW58w9vgoW5N79g2MLcF4W
         p+qcWB4MbYDktd+nZxWMRSu9g72HPYWOhH4/+FV5Ol+WZfHqHcTir43PgPjPD7mkvi/H
         zrWaWwQGA942A/xpZ2PFnHsWQOED2WbQ6Ffy+TEYLX1fFcSTS1zoj3LLznMVh6ibkpQY
         8UnycHYKXZASimAgzs87paA6jfR3h1NNl18axo5dNUQTh3im68Dz9CVDH5RfFWiaGFJk
         evhA==
X-Gm-Message-State: AAQBX9flRE1ZZCMBA0jQtyNsQiRNFfFdtdS/wBVyXX7rZhSZ7qswY2AM
        g5aPrO5OOTRITw+t1UluT9y/2jJc3NV2wafxys8stQ==
X-Google-Smtp-Source: AKy350YUtECRwMiHxN8oX0WzmGFUZR/NNhd3YNk1Kg/Mv/NPJ2fuP+BKRjQ7yncO57GdxQXzb3r9Sg==
X-Received: by 2002:a17:907:7ea6:b0:944:18ef:c970 with SMTP id qb38-20020a1709077ea600b0094418efc970mr13945705ejc.32.1680041180761;
        Tue, 28 Mar 2023 15:06:20 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id be1-20020a1709070a4100b009447277c2aasm3207453ejc.39.2023.03.28.15.06.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 15:06:20 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id i5so55833219eda.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:06:20 -0700 (PDT)
X-Received: by 2002:a50:a6d1:0:b0:4fb:4a9f:eb95 with SMTP id
 f17-20020a50a6d1000000b004fb4a9feb95mr8881233edc.2.1680041179844; Tue, 28 Mar
 2023 15:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173613.555192-1-axboe@kernel.dk> <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com> <20230328203803.GN3390869@ZenIV>
In-Reply-To: <20230328203803.GN3390869@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Mar 2023 15:06:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLdEWoYeudhXf-V=e8am6Xrp1f8yqa8PkRoEMfK+Dmyg@mail.gmail.com>
Message-ID: <CAHk-=whLdEWoYeudhXf-V=e8am6Xrp1f8yqa8PkRoEMfK+Dmyg@mail.gmail.com>
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF iov_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org
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

On Tue, Mar 28, 2023 at 1:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> ... and all that, er, cleverness - for the sake of a single piece of shit
> driver for piece of shit hardware *and* equally beautiful ABI.

Now, I wish we didn't have any of those 'walk the iov{} array', but
sadly we do, and it's not just a single case.

It's also that pcm_native.c case, it's the qib rdma driver.

So if we didn't have people walking the iov[] array, I'd hate to add this.

But considering that we *do* have people walking the iov[] array, I'd
rather unify the two user-mode cases than have them do the whole "do
two different things for the ITER_UBUF vs ITER_IOV case".

> Is it really worth bothering with?  And if anyone has doubts about the
> inturdprize kwality of the ABI in question, I suggest taking a look at
> hfi1_user_sdma_process_request() - that's where the horrors are.

Yes. I started out my email to Jens by suggesting that instead of
passing down the iov[] pointer, he should just pass down the iter
instead.

And then I looked at that code and went "yeah, no way do I want to touch it=
".

Which then got me to that "could we at least *unify* these two cases".

                    Linus
