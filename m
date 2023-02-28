Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203166A60AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 21:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjB1Ut3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 15:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjB1UtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:49:25 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ABC34F70
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 12:49:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cy6so45429811edb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 12:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677617356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtXAIoXvfiyUjZh/JqW45RZBaGUEv0yeFwHGzzsBvFc=;
        b=BqPLg4e0P5XceC6DuLMXjbNjtwfFBQZUvrIzJKKJ2YILg/egsIgykSSGRRHoMXgd93
         s4z6+PCjGm1hOpODiIf4nM12zkW8nFvL6ib8hT2DiU21goJ3EgqqP86tS9h8M5yGgr4V
         B5l3f8JhoRMXC+EwxCFI0HM3NNC6HC+BT/SfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677617356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtXAIoXvfiyUjZh/JqW45RZBaGUEv0yeFwHGzzsBvFc=;
        b=geq359iIWIL7JjH3d8deT1re8Kl9TnHgS+2SSYd9J7n8X/kM/PwC8hhOpjKQT/tRhK
         2JrmSp4hhkJdRBEQ0Tk7XIg5Dv1GE2aOSh87+c05+VvtfBnjWEvW2cG2v7bqwmVv3MCL
         bBCnONO2RDrJykpaZ6zGixCB/EpB6SHwE4qEmTX3bnmX8iSjV3I+Or4gYoTDn+S14oFz
         0gLYCeFgheNnMXN5mgOMAd37napBduPvr4quY2t27D4Kf9OPqLwuNC2PNjyMKRF/6S4v
         QZSEbY0uNlzesxqnoap1f83HJ0ms6SnXde+ZwYMZe6sw2j73j/bMMbrLrqKX+YsP8AfK
         4/zQ==
X-Gm-Message-State: AO0yUKVZ2g3lNrAOIskAiNwUDE4uAUB9d69masllnbxqxsosWQMgfAet
        BT2c6d5nD0oSHKP7eiMWdpYlZtjwwuMnKgAGe28=
X-Google-Smtp-Source: AK7set+1RObEJSPaESrZk+3kjq/bGbbsHza/c3atzeLHmN94nOSKxVT07PJZ3mBfY6ypoz74FG9gjA==
X-Received: by 2002:a17:906:58d0:b0:8b1:3467:d71b with SMTP id e16-20020a17090658d000b008b13467d71bmr6701704ejs.48.1677617356276;
        Tue, 28 Feb 2023 12:49:16 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906578200b008b11ba87bf4sm4859122ejq.209.2023.02.28.12.49.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 12:49:15 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id f13so45413141edz.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 12:49:15 -0800 (PST)
X-Received: by 2002:a05:6402:500b:b0:4af:70a5:5609 with SMTP id
 p11-20020a056402500b00b004af70a55609mr3449762eda.1.1677617354960; Tue, 28 Feb
 2023 12:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
In-Reply-To: <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 12:48:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
Message-ID: <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
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

On Tue, Feb 28, 2023 at 11:39=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This actually looks sane enough that I might even boot it. Call me crazy.

LOL.

I had to go through the patch with a find comb, because everything
worked except for some reason network name resolution failed:
systemd-resolved got a permission error on

    Failed to listen on UDP socket 127.0.0.53:53: Permission denied

Spot the insufficient fixup in my cut-and-paste capget() patch:

  kdata[0].effective   =3D pE.val;
        kdata[1].effective   =3D pE.val >> 32;
  kdata[0].permitted   =3D pP.val;
        kdata[1].permitted   =3D pP.val >> 32;
  kdata[0].inheritable =3D pI.val;
        kdata[0].inheritable =3D pI.val >> 32;

Oops.

But with that fixed, that patch actually does seem to work.

             Linus
