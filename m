Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2C4F4D25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581580AbiDEXkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457627AbiDEQUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:20:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A5193D3
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 09:18:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so24113059lfg.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FELPvFz/6oaJHsU4oc1kXTcQ26iC0/VrCF/XPlp17+4=;
        b=XJkkA3b9tMj2Oywq65L1XLPGe9r4EWP4QonCvPcAvNQC7lH+KZKOjbWEjEmxm1w9l6
         GTCCy3sUV5mOUios3pbc+w2xyA02qNafDjyGesSqpIRyz7QCRPbAT4MAOjeJ/i8sDPPr
         JM8yRVTKDHALD8dV/vRION3fkiPh4VLXV0D9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FELPvFz/6oaJHsU4oc1kXTcQ26iC0/VrCF/XPlp17+4=;
        b=Wi3ckpPJB3OpHfnEr84xrQEfK3l/8XyWyS2mF1mA60rZZ0xW1cvdRMRZAoH1GvQx22
         NjkQzjmwvi+XQi/Y7gBw5yApqQfAO9/9iWk5EChjgw6iOA8lr0n1dNOUVNyvjTYtQ3mr
         a1hX6rjc6EfNP8HA+GrvcmMT2Wpo2KgkoaZ2+ZDzhPRm96pLA0yMDmUnhaWJ8NqNqEBZ
         pM0nGH3YCsTf6GKYD9QpNMoFlw38zjOg+iEHayNZjJD3JIa7XB/3hZ1LaxOYYmng5lXd
         ZFuC/dFi6MziMD7pqnSwlvo1+mNwc6/DxB6LJINAgDwEhaQTL3BCwMJUtB1hc9jGEgVY
         7w+Q==
X-Gm-Message-State: AOAM531KGf/SGtN90feunRXQUgDhDVCrDcnGlwvJn3iB1D/qFLOkcB53
        P5qdNk7HO9ZdGXA6sVu71LjBFCCwg8uz/2vVh9s=
X-Google-Smtp-Source: ABdhPJy2UD80FkBfxZltxpfFGiuRml9UWExRKQdRLqvjoG4rn40enTYsF4uM/Xia69pgfoA7E7LeQQ==
X-Received: by 2002:a05:6512:2245:b0:44a:9971:de44 with SMTP id i5-20020a056512224500b0044a9971de44mr3178790lfu.564.1649175484551;
        Tue, 05 Apr 2022 09:18:04 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j4-20020a05651231c400b0044ac20061ecsm1546645lfe.128.2022.04.05.09.18.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 09:18:02 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q68so5750452ljb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 09:18:01 -0700 (PDT)
X-Received: by 2002:a2e:9794:0:b0:249:8488:7dbd with SMTP id
 y20-20020a2e9794000000b0024984887dbdmr2641943lji.176.1649175481210; Tue, 05
 Apr 2022 09:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net> <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
 <202204041451.CC4F6BF@keescook> <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
 <7e8d9f8a-f119-6d1a-7861-0493dc513aa7@digikod.net>
In-Reply-To: <7e8d9f8a-f119-6d1a-7861-0493dc513aa7@digikod.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Apr 2022 09:17:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPGNLyzeBMWdQu+kUdQLHQugznwY7CvWjmvNW47D5sog@mail.gmail.com>
Message-ID: <CAHk-=wjPGNLyzeBMWdQu+kUdQLHQugznwY7CvWjmvNW47D5sog@mail.gmail.com>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 5, 2022 at 9:08 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> I think we don't. I think the only corner case that could be different
> is for files that are executable, SUID and non-readable. In this case it
> wouldn't matter because userspace could not read the file, which is
> required for interpretation/execution. Anyway, S[GU]ID bits in scripts
> are just ignored by execve and we want to follow the same semantic.

So I just want to bring up the possibility that somebody wants to just
implement execve() in user space for some reason - not just "script
interpreter".

It's *doable*.

Don't ask me if it's sane or useful, but people have done insane
things before. Things like "emulate other operating systems in user
space" etc

Such a user can trivially see the suid/sgid bit on the file (just do
fstat() on it), but wouldn't necessarily see if that file is then in a
mount that is mounted nosuid.

Now, I think the right thing to do is to just say "we don't support
it", but I do think it should perhaps be mentioned somewhere
explicitly.

Particularly since I can well imagine that a security policy might
have some "no, I don't allow suid exec" and return an actual error for
it, and then the access() call would fail for that case.

(Ok, so the security policies would look at the actual bprm data on a
real exec, not the inode executable, so that's kind of made up and
theoretical, but I just want this issue to be mentioned somewhere so
that people are aware that the "it's the same basic file checking that
execve does, but a _real_ execve might then have _other_ issues going
on, including suid bits etc")

               Linus
