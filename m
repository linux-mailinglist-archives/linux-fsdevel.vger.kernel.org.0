Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506E1703D6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 21:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbjEOTNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbjEOTNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 15:13:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7D4D045
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 12:13:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96649b412easo1703444566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684178016; x=1686770016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF4yk0ERETjvIb26R/MqCsvUn8YCXMMrsGzNSIduxV4=;
        b=PKWLstv9L4X1CAYERxAzx1iVEmvir5hRNPp1+OFJ6eXsOsHoHPoVVz+sZPaUtfCpR7
         49MEGoAexn7sv0atN4XpnNl9jPndB2XisxmAPP4zY/KRQHC23zfFm1CPhcbVwzJEIsTr
         zuljLflX3oCfHt7+JGMvJAJorFesRMKqi3muQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178016; x=1686770016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF4yk0ERETjvIb26R/MqCsvUn8YCXMMrsGzNSIduxV4=;
        b=Ega0/2k3jf9bif8c1Nq8zh2uWTL6n+f1QyY1BLCAMbUWHA2xTZM4e4FDCq0dRPOhF4
         radggda7NkN0yjLTOGDFdbWGKVCSUFCzabm+q4kba76LwNQcDyhWqVQq1L8cMbJh/J+p
         UfAXk3oi5rotcaRWuAWsD1wrk+nS+NNHqCTmkiqKUZh5hyHHYx721iK16hp1Y3BoPPUe
         tRPWz87JVr/BV5uXgEVZxRUpSdFwscT53lKcgJWKBTeLkE1ZdqM36BHlS9aOg8p9ZwKx
         /V2DVlGRvvsO7Z4/naUSB/WJQtIBZ+Djazg3J9OTZdsALUIdFvz09cI/YKHkIAU0vlE+
         lJdQ==
X-Gm-Message-State: AC+VfDwyp/tw5M0Q01ooj+z3vii+eL5MrekC4ijHVFQ5fA7QROrgtaR8
        DswicKaQyqnH3d6RVbHOwEMzXMAstc5xPmO1UoD/WPeA
X-Google-Smtp-Source: ACHHUZ4VBXNvOmyYEv0/Eq1hwQCDZq/TnFCXBI2UR+L3JAwsrdlyDXPJQ2zYNnHdm4CSaqD83ZO/Fw==
X-Received: by 2002:a17:907:d1e:b0:965:66dd:78f8 with SMTP id gn30-20020a1709070d1e00b0096566dd78f8mr34081199ejc.56.1684178016162;
        Mon, 15 May 2023 12:13:36 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090660d400b00965ac8f8a3dsm10067648ejk.173.2023.05.15.12.13.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 12:13:35 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so19386578a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 12:13:35 -0700 (PDT)
X-Received: by 2002:a17:907:6d8e:b0:966:5c04:2c61 with SMTP id
 sb14-20020a1709076d8e00b009665c042c61mr26436664ejc.8.1684178015151; Mon, 15
 May 2023 12:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230420120409.602576-1-vsementsov@yandex-team.ru>
 <14af0872-a7c2-0aab-b21d-189af055f528@yandex-team.ru> <20230515-bekochen-ertrinken-ce677c8d9e6e@brauner>
 <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 15 May 2023 12:13:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
Message-ID: <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of O_RDWR
To:     Christian Brauner <brauner@kernel.org>
Cc:     Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 11:50=E2=80=AFAM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> It's strange, because the "O_WRONLY" -> "2" change that changes to a
> magic raw number is right next to changing "(unsigned short) 0x10" to
> "KERNEL_DS", so we're getting *rid* of a magic raw number there.

Oh, no, never mind. I see what is going on.

Back then, "open_namei()" didn't actually take O_RDWR style flags AT ALL.

The O_RDONLY flags are broken, because you cannot say "open with no
permissions", which we used internally. You have

 0 - read-only
 1 - write-only
 2 - read-write

but the internal code actually wants to match that up with the
read-write permission bits (FMODE_READ etc).

And then we've long had a special value for "open for special
accesses" (format etc), which (naturally) was 3.

So then the open code would do

        f->f_flags =3D flag =3D flags;
        f->f_mode =3D (flag+1) & O_ACCMODE;
        if (f->f_mode)
                flag++;

which means that "f_mode" now becomes that FMODE_READ | FMODE_WRITE
mask, and "flag" ends up being a translation from that O_RDWR space
(0/1/2/3) into the FMODE_READ/WRITE space (1/2/3/3, where "special"
required read-write permissions, and 0 was only used for symlinks).

We still have that, although the code looks different.

So back then, "open_namei()" took that FMODE_READ/WRITE flag as an
argument, and the  "O_WRONLY" -> "2" change is actually a bugfix and
makes sense. The O_WRONLY thing was wrong, because it was 1, which
actuall ymeant FMODE_READ.

And back then, we didn't *have* FMODE_READ and FMODE_WRITE.

So just writing it as "2" made sense, even if it was horrible. We
added FMODE_WRITE later, but never fixed up those core file writers.

So that 0.99pl10 commit from 1993 is actually correct, and the bug
happened *later*.

I think the real bug may have been in 2.2.4pre4 (February 16, 1999),
when this happened:

-       dentry =3D open_namei(corefile,O_CREAT | 2 | O_TRUNC | O_NOFOLLOW, =
0600);
...
+       file =3D filp_open(corefile,O_CREAT | 2 | O_TRUNC | O_NOFOLLOW, 060=
0);

without realizing that the "2" in open_namei() should have become a
O_WRONLY for filp_open().

So I think this explains it all.

Very understandable mistake after all.

                    Linus
