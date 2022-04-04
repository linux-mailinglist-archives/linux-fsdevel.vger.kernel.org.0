Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD13B4F1B48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379576AbiDDVT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380056AbiDDSts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:49:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CEF30F7F
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 11:47:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 5so19053608lfp.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Apr 2022 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gE1myDBwoMMXv/sqmeeTtdtKANbFnGzqW1O8e9pC9SM=;
        b=Yw1ZNqApekZ8AeL0PldgD9VjhOHOy85q4fAqhpYMwGIKsvyjwUgV3+tfYqgx/Hct6n
         jD5U2/G9z45ZzVG+RK48MiJA/vGEl6/n1PrVgO3E4okVxoNB71vm3JXzkpG1pNnI8dPy
         LprtMmSxkZJ8rgeVf8rwgvz2/P8kEtbmNFRow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gE1myDBwoMMXv/sqmeeTtdtKANbFnGzqW1O8e9pC9SM=;
        b=4D2yBJxqZHlcIBMeXOlMUrRyGjzrFCZXkV1lwmJve6Ln6Agb+uicWtObVCGG9WDCOR
         C4slvAtEKJT9Dodxq6UmshYJ77g9lTkC/6Ci1wc/QjNMjOAKHel7PkpM3K3y7MRhlJ+t
         hSbZnLBPzulw0WNkZpTPB1HZ/5hdPRFrSpNC1Sy/u+H/UgqCenQseNSP4RKL3FVHjkLP
         weFyHnkpFVXdzq+XxU1mIY9QstGnjdYfq5m+xVwTqWPTDDwjFFHjjirRccfR4N+Rq+z0
         QZkheF2QUCJWPkLA9GMWlN+A4xbhwoy/2CivgAGas+98HUPPGTiPox5BXXNGv3nUAxUe
         NESw==
X-Gm-Message-State: AOAM531HxXd6ZH8MQUMEcQ1VsIqgvhYjWYwQi8iyJqsHlvNLZHv2iiPa
        ziyIjZ6j3w5mKe/43cyV30uMVm+APKLbcRHH
X-Google-Smtp-Source: ABdhPJzFDxe6GlkmhLmQ4t3yTzoa5uSVxQkig4De9QIbudE5emu0ovgDVmI6ytUC1WOO7CLyxrs1sg==
X-Received: by 2002:a05:6512:2292:b0:44a:43b4:4687 with SMTP id f18-20020a056512229200b0044a43b44687mr579611lfu.450.1649098067437;
        Mon, 04 Apr 2022 11:47:47 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k19-20020a056512331300b0044a8470fe29sm1224783lfe.19.2022.04.04.11.47.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 11:47:46 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id m12so2437884ljp.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Apr 2022 11:47:45 -0700 (PDT)
X-Received: by 2002:a2e:a790:0:b0:249:906a:c6f1 with SMTP id
 c16-20020a2ea790000000b00249906ac6f1mr638041ljf.164.1649098065631; Mon, 04
 Apr 2022 11:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
In-Reply-To: <202204041130.F649632@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 11:47:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
Message-ID: <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
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
        LSM List <linux-security-module@vger.kernel.org>
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

On Mon, Apr 4, 2022 at 11:40 AM Kees Cook <keescook@chromium.org> wrote:
>
> It looks like this didn't get pulled for -rc1 even though it was sent
> during the merge window and has been in -next for a while. It would be
> really nice to get this landed since userspace can't make any forward
> progress without the kernel support.

Honestly, I need a *lot* better reasoning for random new non-standard
system calls than this had.

And this kind of "completely random interface with no semantics except
for random 'future flags'" I will not pull even *with* good reasoning.

I already told Micka=C3=ABl in private that I wouldn't pull this.

Honestly, we have a *horrible* history with non-standard system calls,
and that's been true even for well-designed stuff that actually
matters, that people asked for.

Something  like this, which adds one very special system call and
where the whole thing is designed for "let's add something random
later because we don't even know what we want" is right out.

What the system call seems to actually *want* is basically a new flag
to access() (and faccessat()). One that is very close to what X_OK
already is.

But that wasn't how it was sold.

So no. No way will this ever get merged, and whoever came up with that
disgusting "trusted_for()" (for WHAT? WHO TRUSTS? WHY?) should look
themselves in the mirror.

If you add a new X_OK variant to access(), maybe that could fly.

                Linus
