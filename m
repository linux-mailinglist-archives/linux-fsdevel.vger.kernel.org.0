Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356FE6F1DF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjD1S1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbjD1S1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:27:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698AC3AB6
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 11:26:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-95f4c5cb755so21493866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682706418; x=1685298418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MqD98UQcwdygRnwlRdXPaInX1Ic0ElwE1KiswWqRhQ=;
        b=hG5/I7/Lfbz9x4pcGKSatCk8xgTy5AZJfcHDWuoH/v0/fVGSJStCtjoGsPKpW923KR
         nPq4j1gP9Ifia/MDYccqWpyw0Q3UWudTw2FT0bXscIW7sNKMSt1H/1IoLh0ontxPHxZG
         ShBVktwwXo0VfLTDOYlPLEqrHCFWLTJbZtXmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682706418; x=1685298418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MqD98UQcwdygRnwlRdXPaInX1Ic0ElwE1KiswWqRhQ=;
        b=Bf3D/I2rPfuxf1mgCXNDUtN+P58G88FTCvrVMczynevHxY4qUO6nX7Xsu/tv41u6JU
         L8DaMr4pAbIgdg9PEaj64mblu8Y4Kzky1JYQyVUwOpMdgLwKTSEkIDrNsDhIz1tVBqI6
         lspk9Pzqusd4EfJmShREH3by4EWI15U/Ha9QK5vxkx4RyAOmFmiCqwo4KQVxi+d4No0J
         4mvP0kgEvpRAeptGKHGnGg4OrFzYHo0UzJklPID6kBFbpzc4YVGOVn6UypdAksqaMiYT
         8TnBWNfipnipgGGttYeFGu6ce3g3bZmTTvGsQ5USU6QJABGPYMsEv3Y+m35VJtOZoz2Q
         pXOQ==
X-Gm-Message-State: AC+VfDxY4yCniZoYTlNKzLIro2BMZK1uuAhfySz6N8QBV2oKeJoipiRp
        SnFyAxX4W0kNgZ13ufpM3/v9drzcdJetyj3z5XqObg==
X-Google-Smtp-Source: ACHHUZ6SW4UACpfJsfOnbJSQ+2rVtN0W+cCtdmgLjtTjlw/Lks0zF8ps35MWVkPWYpbGONojP2AGeg==
X-Received: by 2002:a17:907:7b93:b0:958:4870:8d09 with SMTP id ne19-20020a1709077b9300b0095848708d09mr6129837ejc.37.1682706417775;
        Fri, 28 Apr 2023 11:26:57 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id op4-20020a170906bce400b0094f39379230sm11527220ejb.163.2023.04.28.11.26.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 11:26:56 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-94f6c285d92so17113966b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 11:26:56 -0700 (PDT)
X-Received: by 2002:a17:907:629b:b0:95e:e0fa:f724 with SMTP id
 nd27-20020a170907629b00b0095ee0faf724mr6523145ejc.39.1682706416181; Fri, 28
 Apr 2023 11:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV> <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <CAHk-=wjpBq2D97ih_AA0D7+KJ8ihT6WW_cn1BQc43wVgUioH2w@mail.gmail.com> <eb05bc4e50464579a60b80ddfd596a6a@AcuMS.aculab.com>
In-Reply-To: <eb05bc4e50464579a60b80ddfd596a6a@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 11:26:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdwStxVMiqQAKMJdYEF+mrxgqxvj1rFgbRw-9Rptavsg@mail.gmail.com>
Message-ID: <CAHk-=whdwStxVMiqQAKMJdYEF+mrxgqxvj1rFgbRw-9Rptavsg@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd updates
To:     David Laight <David.Laight@aculab.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 1:40=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> It is definitely architecture dependant.
> x86-64 and arm-64 will return two 64bit values in registers.
> x86-32 and arm-32 return two 32bit values on stack.

Yes, but I think the "return value in two registers" is the generic
thing. At least gcc has very special code to deal with a two-register
return value.

And yes, those registers will then obviously be different sizes on
different architectures, but a tuple like a '(ptr,fd)' thing will fit
regardless.

We very much do depend on this kind of pattern generating reasonable
code in some parts of the kernel.

               Linus
