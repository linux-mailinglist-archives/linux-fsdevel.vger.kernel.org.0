Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D615C4F203B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 01:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiDDX3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 19:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiDDX3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:29:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9BC2B261
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 16:27:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b17so12492690lfv.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Apr 2022 16:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jx5P7yX3O5pX2LqkyeQfqU0tlbRjJjmmZeKsgU5FQa8=;
        b=X33eVsWc7Y7k1gT/g4zGwLZX8IMd0zDiGeq+SNK556d+FRB/nBPgAmF91Jc2ZewIkm
         ZVSXfO5pzStwMUuGMJ8Wv3wH7WLkU4AEEqTy2TzSWZE+Lyew31d9KVPVL8zsXNSVCGzB
         iZj8spgT2H19hxodlQ23EHu0IDi3xox/PKjik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jx5P7yX3O5pX2LqkyeQfqU0tlbRjJjmmZeKsgU5FQa8=;
        b=RgIycgWt9KYCwrLtAbT8NrBIEMhaPmOSdGWJPbtNO7rdQxjDhA/i+m4k5U6YJMNmLX
         vcKzsqTi4FsDc175gCY4qozPajLQ7oAtJSydNPfhAtZR0DWAeM6eqi5M+mJaOw1xfz8m
         Y2QQ2mYaOA6LVCONg7Uefy9YUJJICwoUEq9pv74BB48XIhYbAx/XK4Qx/k+LYyE3FiZH
         VMFK5EltJHjtek+2N23xgEVV2gbYlhKdSKRUiED3CGFleueV3QgDIdMBfhJAFBWogt4T
         /PXtxNp3V95NAGg99OmmH+mV+DbGBlqVJDb647QA1YToB/PJwG/gBEGBLrF2ZtJl/akh
         jl6w==
X-Gm-Message-State: AOAM531o/7afYpQmxAb0Q6IiD+LuNNL+BpRpFGBI60eA6Ty1HAWDrTl2
        Wsnqg2s4TBoQU2/00hIDxAF0OtVQaDNcw6B0irk=
X-Google-Smtp-Source: ABdhPJwwQ6oRQMe+P4sbz2RQV4uzunesKDO7LTZndHRNSlmoCv21cjJylwAC8Ys0kgPEUs0UNAHO0Q==
X-Received: by 2002:a05:6512:23a0:b0:44a:3458:7573 with SMTP id c32-20020a05651223a000b0044a34587573mr536965lfv.97.1649114824693;
        Mon, 04 Apr 2022 16:27:04 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m7-20020a2e8707000000b0024b085236easm1023415lji.77.2022.04.04.16.27.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 16:27:04 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id b21so9610355lfb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Apr 2022 16:27:02 -0700 (PDT)
X-Received: by 2002:a05:6512:2296:b0:44a:6aaf:b330 with SMTP id
 f22-20020a056512229600b0044a6aafb330mr496667lfu.531.1649114820779; Mon, 04
 Apr 2022 16:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net> <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
 <202204041451.CC4F6BF@keescook>
In-Reply-To: <202204041451.CC4F6BF@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 16:26:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
Message-ID: <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
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
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
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

On Mon, Apr 4, 2022 at 3:25 PM Kees Cook <keescook@chromium.org> wrote:
>
> Maybe. I defer to Micka=C3=ABl here, but my instinct is to avoid creating=
 an
> API that can be accidentally misused. I'd like this to be fd-only based,
> since that removes path name races. (e.g. trusted_for() required an fd.)

Some people want pathnames. Think things like just the PATH thing just
to find the right executable in the first place.

For things like that, races don't matter, because you're just trying
to find the right path to begin with.

> I think this already exists as AT_EACCESS? It was added with
> faccessat2() itself, if I'm reading the history correctly.

Yeah, I noticed myself, I just hadn't looked (and I don't do enough
user-space programming to be aware of if that way).

> >     (a) "what about suid bits that user space cannot react to"
>
> What do you mean here? Do you mean setid bits on the file itself?

Right.

Maybe we don't care.

Maybe we do.

Is the user-space loader going to honor them? Is it going to ignore
them? I don't know. And it actually interacts with things like
'nosuid', which the kernel does know about, and user space has a hard
time figuring out.

So if the point is "give me an interface so that I can do the same
thing a kernel execve() loader would do", then those sgid/suid bits
actually may be exactly the kind of thing that user space wants the
kernel to react to - should it ignore them, or should it do something
special when it sees that they are set?

I'm not saying that they *should* be something we care about. All I'm
saying is that I want that *discussion* to happen.

               Linus
