Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE86CF3C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjC2TxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjC2TxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:53:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF9768A
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:52:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so67899215edd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680119555; x=1682711555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30eVBROcdu2WE3rj07MSmmxiJXw/4ZaQYzimVAMKm0s=;
        b=STsSREFRZ1cmGP60kh1cKrSBOj/D5lXp0wIs3W+A8F/BPRNT/K7hbYn35+IfyMO5B+
         76l13dxQzGptAGcq1iHIVkTZCPF6ovewROZRm6D8Yl4LSqOK8UPYYd+7OEBCQSay+gOW
         JYLJ66ItGW3SE/mxIsIq706mTRYjvMJGIqFjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119555; x=1682711555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30eVBROcdu2WE3rj07MSmmxiJXw/4ZaQYzimVAMKm0s=;
        b=h+XfqK3Ysxme2+mc6kiK8tQVvyk4L2duYa8H4E5V3LNHnAPTrq5fv8HtI4mUmdsz9H
         WdWADg+yHftZiUFmdEwCPIhbl3+TPodS7BGsHLiT0Isp3cRHaPStDTZjMptM4B0vDY2T
         24kTpOnNu4QJDKNUjYEhG5lcL2eG7p574R8ColyqjmjV8q4nhkX2rtc72KQRxinAKk2y
         P84wnd5PRAdO8PpL9ULZ8FDGAJ9BYwNRTg8gzroFGH0MohHWHpjvRUH4hXPMav63/1TS
         kJxDPQny6bmqWMoP/7kymSVNlCu4H8+9xLcZQVfsnhmejHNPGNQEnv8x7a7pept+3q1D
         ZDKQ==
X-Gm-Message-State: AAQBX9dOElEmzQLIfrREPgQtuaVvcmZzfUUF6FjH5NHhDPLGjpu9L5wS
        OTFGb/UAiGcvz8gBku9RVAOEp9+8/AvpmNi0/XuWkjtO
X-Google-Smtp-Source: AKy350b4j5OdWXd8b1iMCkq/SZA5TyjC9UyiZLijP1MLZ0ckAqxX6NJfEU9+IUQItrhztHPUQd6xgQ==
X-Received: by 2002:a17:906:25d1:b0:8b1:3131:76e9 with SMTP id n17-20020a17090625d100b008b1313176e9mr21154705ejb.46.1680119555517;
        Wed, 29 Mar 2023 12:52:35 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060e8900b0093313f4fc3csm15686971ejf.70.2023.03.29.12.52.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:52:35 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id b20so67923254edd.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:52:34 -0700 (PDT)
X-Received: by 2002:a50:a6d1:0:b0:4fa:794a:c0cc with SMTP id
 f17-20020a50a6d1000000b004fa794ac0ccmr10846305edc.2.1680119554578; Wed, 29
 Mar 2023 12:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230329184055.1307648-1-axboe@kernel.dk> <20230329184055.1307648-7-axboe@kernel.dk>
 <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
 <554cd099-aa7f-361a-2397-515f7a9f7191@kernel.dk> <a0911019-9eb9-bf2a-783d-fe5b5d8a9ec0@kernel.dk>
 <f12452c7-0bab-3b5d-024c-6ab76672068f@kernel.dk>
In-Reply-To: <f12452c7-0bab-3b5d-024c-6ab76672068f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 12:52:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4J1+Ses2rY0xBhWxyfTDNW+H_ujpcwngKG5tp0y_Fxw@mail.gmail.com>
Message-ID: <CAHk-=wg4J1+Ses2rY0xBhWxyfTDNW+H_ujpcwngKG5tp0y_Fxw@mail.gmail.com>
Subject: Re: [PATCH 06/11] iov_iter: overlay struct iovec and ubuf/len
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

On Wed, Mar 29, 2023 at 12:49=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> We can get rid of these if we convert the iov_iter initializers to
> just assign the members rather than the copy+zero fill. The automatic
> zero fill is nice though, in terms of sanity.

The automatic zero fill is good, but I think it should be fixed by
just not making that

        const struct iovec __ubuf_iovec;

member be the first member of a union.

The way union initializers work is that if they aren't named, they are
for the first member.

So I *think* the reason you get that warning is literally just because
the __ubuf_iovec member is first in that union, and moving it down to
below the other struct will just fix things.

                   Linus
