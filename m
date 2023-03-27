Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B376CAE45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 21:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjC0TMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 15:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjC0TM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:12:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69140E9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:12:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so40535675edo.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679944329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QZgBvWtxIF9Se2Af5cpO0JcPA5QF8f/WHmJFYWM2TY=;
        b=iBQ4o7MwJk2hLUnlTWYs2xnM5yKFrnuGPAsn5LPeclE5u+LE0RxMK8AYP/Gnez1oWw
         Sf7teUkBOyxh0NYEMAfSofQcVBG2rE+89VhS2p035vD7C2/MobKRlqambIyC++MhIxjF
         At0z13QH1UjAIzdJEMiwQP304vD+aDwElLhvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QZgBvWtxIF9Se2Af5cpO0JcPA5QF8f/WHmJFYWM2TY=;
        b=u7bOV02s10lm8rLPEh5mH0JRVnuwlz3QH3Q7LYf5jam0io5d2YuN/gXsSR1tlDELyU
         qSwr82bcksLWR89EF+NZmjtmnMJnTXHvsyVF+NT8l3tLbs3C1qo2CsIFwzF0bbzIhWFc
         R2cV1/WxWkRN9M3J+5MROYCsD+iZUSauKZHX/HbWYLHEWnNpw0FGQCt6zkQ+Wo8azeU6
         XjomwkmAKEyLUlD6GX/kcGQbjrtw63dLRVg9fjlx3OjSIwHPFuHAoEMvDx/6i2sVv29c
         +RfGAxoSaoCBLn08gHMrisIvkD0krLQiWRPL5mYgcSXhevAVwEphT16T4yK/S5/67apN
         YdGQ==
X-Gm-Message-State: AO0yUKVVw8Zlf8MjFL3J8iRXjbTGbI0IbiE0YGjr1QQw65Uxf+u8JIl1
        qlmOXtZ0DdCQ3nliwWwz3LsbQMl4hTxXEvy8Eu3tlg==
X-Google-Smtp-Source: AK7set9SXaCToaU4kyiXQQaAk++Hxfqd05/iNa2vGzTWrq7wCKV4OrrBmUDVZCBJ/JucgCtkEKlEWQ==
X-Received: by 2002:a05:6402:c17:b0:4ac:d90e:92b with SMTP id co23-20020a0564020c1700b004acd90e092bmr21156213edb.10.1679944329101;
        Mon, 27 Mar 2023 12:12:09 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id p25-20020a50cd99000000b004bf76fdfdb3sm14881832edi.26.2023.03.27.12.12.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:12:08 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id w9so40498970edc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:12:08 -0700 (PDT)
X-Received: by 2002:a17:907:9870:b0:8b1:28f6:8ab3 with SMTP id
 ko16-20020a170907987000b008b128f68ab3mr6643753ejc.15.1679944328165; Mon, 27
 Mar 2023 12:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230327180449.87382-1-axboe@kernel.dk> <20230327180449.87382-2-axboe@kernel.dk>
 <CAHk-=wh4SOZ=kfxOe+pFvWFM4HHTAhXMwwcm3D_R6qR_m148Yw@mail.gmail.com> <2d33d8dc-ed1f-ed74-5cc5-040e321ac34f@kernel.dk>
In-Reply-To: <2d33d8dc-ed1f-ed74-5cc5-040e321ac34f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Mar 2023 12:11:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAJtbP0Y96rUhhLcKM4EqL7mMsVMnD4e4BbYK=GXpdCQ@mail.gmail.com>
Message-ID: <CAHk-=whAJtbP0Y96rUhhLcKM4EqL7mMsVMnD4e4BbYK=GXpdCQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs: make do_loop_readv_writev() deal with ITER_UBUF
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

On Mon, Mar 27, 2023 at 12:06=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> See Al's suggestion in the other thread, I like that a lot better as it
> avoids any potential wack-a-mole with potentially similar cases.

Ok, this is all the legacy "no iter_read/write" case, so that looks
fine to me too.

               Linus
