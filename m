Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C86A881C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjCBRwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 12:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCBRwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:52:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89006367E4
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 09:52:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s26so180379edw.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677779528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5aFcQHv0N7yL7akZl+srFSiIjdpFMlk0jHiL9q2NCU=;
        b=Yz5bhsmVuZx95YTDUruQTp6mTsZyYhuE1lMUFFy/pKD+RX6SogR05vubbt+HxWjdDE
         IvTVVsWeduYUFLKhs+IztWWPBov3usXv0Knix/ILwKSadtsj188J814a/ioUXOyqDsWA
         +iHR4Q/7QRYUctBQq2aom1+ZgCtQEkFLRtL9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677779528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5aFcQHv0N7yL7akZl+srFSiIjdpFMlk0jHiL9q2NCU=;
        b=oQjJv3HmH5pdjir79jU/h3tqUNDB/Zuv85iYNF/857t09rw4hpHfGg7GlOUfUnwvuf
         KSyEgLxWydug30jNY8zNZZrmul3OH5WXdgOAzlHFqbO7JG1hjU1cN8fNSG3x7UVfJOo4
         vzVP2mQ+hBAemD8d37lUqNIzRovEAydTCNbXShmxndMUvcOIwj1xFY/Kf3MQ8V/rLIS9
         KhkFABrvqIFatQ+BpwBhUWAKN9jwh/l6NXNdhLQfB09E5970qZf0m6DeaBOW5xUDaatJ
         EV5a5TLxfqE64+MIgy0fYP+uy/6wt5pidUtFoFefzrzmOSSGpok0gbJqzpoqJ40B1NBy
         vj4Q==
X-Gm-Message-State: AO0yUKVXc6v2mUbmXSdihuMjoLmCWmy8FO0fuhVIAU4WM6hjJT25U4qj
        qJel8ifKAp7wSdQpjcHPDrrJTt3F7xi5UmfqkFI=
X-Google-Smtp-Source: AK7set90dc8TRZShGpqxJWr/88cQHA6qwXlZbfxP57nLsFiskS7TgJJoDHIGe/3MlfjsqxvFF9wasg==
X-Received: by 2002:a17:906:7704:b0:8f8:b3a6:cc6b with SMTP id q4-20020a170906770400b008f8b3a6cc6bmr10475762ejm.58.1677779528361;
        Thu, 02 Mar 2023 09:52:08 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id z13-20020a50eb4d000000b004c0b58f088esm148159edp.10.2023.03.02.09.52.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 09:52:06 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id d30so341569eda.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 09:52:06 -0800 (PST)
X-Received: by 2002:a17:906:2ec8:b0:877:747e:f076 with SMTP id
 s8-20020a1709062ec800b00877747ef076mr5367831eji.0.1677779526028; Thu, 02 Mar
 2023 09:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com> <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
In-Reply-To: <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2023 09:51:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
Message-ID: <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 2, 2023 at 12:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Fwiw, as long as you, Al, and others are fine with it and I'm aware of
> it I'm happy to pick up more stuff like this. I've done it before and
> have worked in this area so I'm happy to help with some of the load.

Yeah, that would work. We've actually had discussions of vfs
maintenance in general.

In this case it really wasn't an issue, with this being just two
fairly straightforward patches for code that I was familiar with.

              Linus
