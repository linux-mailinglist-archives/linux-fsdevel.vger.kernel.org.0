Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1B6AAD8C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 00:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCDXxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 18:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDXxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 18:53:02 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02DCDDE
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 15:52:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f13so24464348edz.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 15:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677973977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElKyCAEjKYln0Oxdnu5/kmS5Su22bI0nBFZvKG/ppQ=;
        b=ZlN04JLpuXtpTEZpiRm5Xbl39yBXWMkWGL1gjrmf7l2CsXs/fiLOpG/rnrjoiQfZU9
         LiGo3mlKapi96NO11zvw/TrxdWEt2Bzqq8B7wDyD57Kib2hZ970aXjo+lumAVq6ZDUM/
         we4CwP2nVHdPEYGyAYp4e0XRAGIRl3nf2Hz5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677973977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MElKyCAEjKYln0Oxdnu5/kmS5Su22bI0nBFZvKG/ppQ=;
        b=ehgYC459KTw6MCiyUL7AMle6E3Dg+gW65FJse5ATRm/j5pWTnuVW4Sus8hGNMN/VHD
         aMVvFuOwuAACPbpliJ/kn/N9sZrlGqrJRNzX37SQqcNauGXRbvemR/CLICUXxLlDltvc
         7A2GH5RtdoNtMwBQnytflw4vKYt86u3jy1p+E9GeHKOnbA0P+Ozq1MRoqHicjHE+Hob1
         8R0ZStQ1gRs0x9teBacO8VgeWV1rvtX35nKPns6CVmrXAd5r7oCdw0AqLbm+X1vvYDH6
         hd/s78a1G9rDqRJiK10NwjN6kCtZzmjqVfittJq4i8H1iUH2ir3nqedSL1KSvwLeG+P1
         ibVQ==
X-Gm-Message-State: AO0yUKXueMZ13YCUtEPmaoBJ5noiKYW7S4G2YmG7IgG+qKJnGWCrR/+4
        9jrKLRsHOmkMZYuu6141lfl5kYUJmrxetdKCsyA+Xg==
X-Google-Smtp-Source: AK7set/zdHm0ivmEvqNXscHZ+odkD9cMoNjovi6TnhbZ7p4QF8uqLgcf2c68v1UPHSsuPRFFPm7Iww==
X-Received: by 2002:aa7:d153:0:b0:4ad:f811:e267 with SMTP id r19-20020aa7d153000000b004adf811e267mr10213089edo.12.1677973977446;
        Sat, 04 Mar 2023 15:52:57 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id u23-20020a50c057000000b004c19f1891fasm2993142edd.59.2023.03.04.15.52.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 15:52:56 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id s11so24442420edy.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 15:52:56 -0800 (PST)
X-Received: by 2002:a50:8711:0:b0:4bb:d098:2138 with SMTP id
 i17-20020a508711000000b004bbd0982138mr3409593edb.5.1677973976346; Sat, 04 Mar
 2023 15:52:56 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop> <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
 <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com> <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com>
In-Reply-To: <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 15:52:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTO-VwB2ARhL9jg1k63L26YR0sfnpOKaGsEi=Va5zVtQ@mail.gmail.com>
Message-ID: <CAHk-=whTO-VwB2ARhL9jg1k63L26YR0sfnpOKaGsEi=Va5zVtQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
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

On Sat, Mar 4, 2023 at 3:08=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, this particular patch at least boots for me for my normal
> config. Not that I've run any extensive tests, but I'm writing this
> email while running this patch, so ..

Hmm. I enabled the KUNIT tests, and used an odd CONFIG_NR_CPUS to test
this a bit more.

So in my situation, I have 64 threads, and so nr_cpu_ids is 64, and
CONFIG_NR_CPUS is 150.

Then one cpumask KUNIT test fails with

     # test_cpumask_weight: EXPECTATION FAILED at lib/cpumask_kunit.c:70
                  Expected ((unsigned int)150) =3D=3D cpumask_weight(&mask_=
all), but
                      ((unsigned int)150) =3D=3D 150 (0x96)
                      cpumask_weight(&mask_all) =3D=3D 64 (0x40)
              &mask_all contains CPUs 0-63

but I think that's actually a KUNIT test bug.

The KUNIT test there is

        KUNIT_EXPECT_EQ_MSG(test, nr_cpumask_bits,
cpumask_weight(&mask_all), MASK_MSG(&mask_all));

and it should *not* expect the cpumask weight to be nr_cpumask_bits,
it should expect it to be nr_cpu_ids.

That only matters now that nr_cpumask_bits isn't the same as nr_cpu_ids./

Anyway, I still think that patch of mine is fine, and I think this
test failure only ends up being about the test, not the patch.

            Linus
