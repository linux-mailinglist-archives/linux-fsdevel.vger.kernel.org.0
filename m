Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E740B6C1D9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 18:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCTRU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjCTRT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:19:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410C302A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 10:15:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so49598928ede.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679332486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVgWDorTw0IdLkGaMvMMy9AFx6YqJaCeHBK8myDlk6A=;
        b=LNTsMFMKBvMA2ZP8wKOgyI12oeeGouuCP8xwrFlIhEg2bQLwgJCIW7w2zMnFL2IqxV
         4UbKzNEjlvA6XXyFET7M9s76aZOU2ek76GGNIDnuVgjmj6OtTr5Glj5OFQVZjJxgSAT1
         gpqp8Q2AlN69zGPAxyv6n3wvCqkslTTvJCdOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVgWDorTw0IdLkGaMvMMy9AFx6YqJaCeHBK8myDlk6A=;
        b=fmArmPiocrSfmST7Hejpgszn3AWTk7ixY88ysDuF6d+yCX42WDpeCiTSmfS7PTCBq+
         XCM5XxSzQqX8ff3O1jvf/BjNUYXxjZ0A7h1O25XEf62JYhBOtSengi7A5SqztN3/cwMb
         lKuTpvL6jl+CMrHBgMB8s2lhFqvXTyn3hyfJxVbnBJeVaKL9PnJCKrrYKPLsaP1T5bhD
         a97/xwoimjpTMDQb/c4PTtyyLIIVSuz0Qq/YGw4dB+e9NFWpwAflDOfOB1yP1g2UunEQ
         090RkSHrNgLFgaVVGTmDuWC+NEJbi35gvev9UOl/eOAts9Loone4zWmyoO1FRsbzzc5a
         F3XQ==
X-Gm-Message-State: AO0yUKW75gsaiB7GfoWyNOGLbMrcnREm5HXvkYrhD4FrTf45mOWf+0fe
        TB3jvlL7cK8QrrOcJ7nL9JxVjjB5Cdtb2bJw8WPd5ZJI
X-Google-Smtp-Source: AK7set9tBBWxcAo9HUwfHGBDbhtTdy/P2iVvYuKgtupeE0Zw1PyF21WxBEx2wV2kDdSUMwyczhq3+A==
X-Received: by 2002:a17:906:5013:b0:92f:ab75:1605 with SMTP id s19-20020a170906501300b0092fab751605mr9120962ejj.73.1679332486540;
        Mon, 20 Mar 2023 10:14:46 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id ia9-20020a170907a06900b00932b3e2c015sm3760310ejc.51.2023.03.20.10.14.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:14:46 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id h8so49598636ede.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 10:14:45 -0700 (PDT)
X-Received: by 2002:a17:907:6e28:b0:933:f6e8:26d9 with SMTP id
 sd40-20020a1709076e2800b00933f6e826d9mr2790573ejc.15.1679332485637; Mon, 20
 Mar 2023 10:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com> <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
In-Reply-To: <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 10:14:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
Message-ID: <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Christian Brauner <brauner@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Mar 20, 2023 at 4:52=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> So before we continue down that road should we maybe treat this as a
> chance to fix the old bug? Because this behavior of returning -ENOTDIR
> has existed ever since v5.7 now. Since that time we had three LTS
> releases all returning ENOTDIR even if the file was created.

Ack.

I think considering that the return value has been broken for so long,
I think we can pretty much assume that there are no actual users of
it, and we might as well clean up the semantics properly.

Willing to send that patch in and we'll get it tested in the crucible
of the real world?

                Linus
