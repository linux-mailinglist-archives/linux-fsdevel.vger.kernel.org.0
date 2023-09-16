Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262E97A2BFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 02:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjIPAak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 20:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbjIPAaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:30:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AE81BF4
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:27:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a9d6b98845so827196366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694824056; x=1695428856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8Y6H+CGjrqtUwepfVg3ZapOU4tcqDJDh2TjsLFPfcI=;
        b=TcQG2Kb/Ip8PZWX2Cc3dnN58Lcb4fXG4xyYDtQTu/rKnLSdEkxpVSyDC/bSmfyG4iB
         ByiFLo9h+G356gxS9zNIYHVdUfDVD3r1NbBN918JCGUk/xkk4Nf0LzCw5g0+PMkU3TvU
         NVOh5inKCcyUTVoqS7mOSOg/iy2LR2HjB52xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824056; x=1695428856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8Y6H+CGjrqtUwepfVg3ZapOU4tcqDJDh2TjsLFPfcI=;
        b=gRijMLhw/tgWeKXpG9nzn7/3+SKEGUpY4MDf4MKKKUYZ41iZNFXrpPqQEN27oLIUDs
         Zg4wU9Kmt+lriwpnXmHSoDayjf9QVWU53aM6a41AxuKsLwCRTnx0EsVOwJ4wtLf/Kiiu
         fljTKO2p81v265o29aI6J2hYdGS/Yqyn9EUMGAwWgHyRWDvbe1/d7ACalCMqib2IvW5/
         9zlrVp6KCk2U2wif//rye5g/3hOZZHXwdaVDpTvUbIO6moTcd+Asi1bZ21dLRpuCP/Yk
         lhVq2Jv94XsL6QT3MrfYMe4Uf10govQEl/E9Wz9TUoLQoCs336+1mE9rAWID86hTOOuq
         7lTw==
X-Gm-Message-State: AOJu0YzSiw1FlQiorTPVcYfub0Su7cX062CDUDAXJGhM0HRrNAESpMV7
        auZUpG2W9RtdhH6xtRnHHTn9ghk31lpUu8beuD5zd0lA
X-Google-Smtp-Source: AGHT+IF8bjjzj5azjzRcByVRbeAxiBmUzALZLBzxQYvctAcdQxTJyqW1eihoJQUm2mJPESXFOei02Q==
X-Received: by 2002:a17:906:314b:b0:9ad:e0fb:6edf with SMTP id e11-20020a170906314b00b009ade0fb6edfmr2613314eje.7.1694824056244;
        Fri, 15 Sep 2023 17:27:36 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906359a00b009875a6d28b0sm3013593ejb.51.2023.09.15.17.27.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:27:35 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8066117a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:27:35 -0700 (PDT)
X-Received: by 2002:a17:907:80a:b0:9a9:405b:26d1 with SMTP id
 wv10-20020a170907080a00b009a9405b26d1mr8271589ejb.5.1694824054952; Fri, 15
 Sep 2023 17:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
In-Reply-To: <20230915183707.2707298-9-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:27:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
Message-ID: <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> +       "1:     ldl_l %0,%4\n"
> +       "       xor %0,%3,%0\n"
> +       "       xor %0,%3,%2\n"
> +       "       stl_c %0,%1\n"

What an odd thing to do.

Why don't you just save the old value? That double xor looks all kinds
of strange, and is a data dependency for no good reason that I can
see.

Why isn't this "ldl_l + mov %0,%2 + xor + stl_c" instead?

Not that I think alpha matters, but since I was looking through the
series, this just made me go "Whaa?"

                Linus
