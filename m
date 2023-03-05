Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEA76AB1C1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 19:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCESnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 13:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCESnm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 13:43:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36369CDEF
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Mar 2023 10:43:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u9so30090540edd.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Mar 2023 10:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678041819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK/rrMwqyPmyu+qAqo29lnLv2pRkbjMCkopb9tAe0Bw=;
        b=duTuPzp2D/zLqgVNKR1UwpGZY7y61kGIfqzx2RtAzX6/JFrNTd150CamMdKfgR6U3A
         8nTLP+cGc0IOo2I1yYKUK3ncELNOisWgRewP45Ygop3/gKUliIKKvRDXIrTmtcslie8V
         iOm7DbbXU+oEM1ac7Alvr4BGlUip0a5vNeGxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678041819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK/rrMwqyPmyu+qAqo29lnLv2pRkbjMCkopb9tAe0Bw=;
        b=onvRQKj7EIZZJK8eTE5+bvbKlqxETi7v4BGwqc3GQhIT/3U729uzFhCgU3Eb2xPHql
         L3tRQfCArG4fSy3iqphzkZLNlpwpxvSTM7R9s/NxAZ0XJDUSUDw5myvpC+iniOpwTLWp
         4/Pmo9mYF6uuHwwpebXUYsmiTdl/z4ZQbQtUszdcdj2ODdlS7gORJaay/VclhFKRknH3
         /iOc3UHLsA2Yfj8OK1g6sx98wajtoBQX09MSWK6+vkBgjSLPhTPC84uBL3vRAYs0YVsy
         aT532Wdffcx8NWMojtcOk1+2zIRVJl8B4V4Yt3aBfmFMgTDXfVXX6b/lf9SlnhmItlGs
         YMyA==
X-Gm-Message-State: AO0yUKVIs5ShcDTCoPF9eBsWnQtQeqkNlD16XO64yhIR0MVHserLHMfB
        bkaepOAHVhy8T2XtCGNJ6CBU7JIyirwNtaETFiyxhQ==
X-Google-Smtp-Source: AK7set/Ndqy14Y/dXu1FDNjR4vhuuxg4KaAVhCkksf0+ftoouJI1P/g0IJBSr7jeuwBmS+3aRk5IKw==
X-Received: by 2002:a17:906:4911:b0:8b8:c04f:c5f9 with SMTP id b17-20020a170906491100b008b8c04fc5f9mr9089473ejq.73.1678041819354;
        Sun, 05 Mar 2023 10:43:39 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id kv22-20020a17090778d600b008dceec0fd4csm3501529ejc.73.2023.03.05.10.43.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 10:43:37 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id ay14so26312433edb.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Mar 2023 10:43:37 -0800 (PST)
X-Received: by 2002:a50:9f47:0:b0:4bc:13f5:68a5 with SMTP id
 b65-20020a509f47000000b004bc13f568a5mr4529109edf.5.1678041816888; Sun, 05 Mar
 2023 10:43:36 -0800 (PST)
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
 <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com>
 <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com>
 <CA+icZUUH-J3eh=PSEcaHRDtcKB9svA2Qct6RiOq_MFP_+KeBLQ@mail.gmail.com> <CAHk-=wgzNnvVwjoW0Ojn1V_BcEoYX=wydcMs-FTNV+7kJmfq=A@mail.gmail.com>
In-Reply-To: <CAHk-=wgzNnvVwjoW0Ojn1V_BcEoYX=wydcMs-FTNV+7kJmfq=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 10:43:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1evFSMjkpNgL-6p2Qx44nR9r0GK+1mPodous89czBfQ@mail.gmail.com>
Message-ID: <CAHk-=wg1evFSMjkpNgL-6p2Qx44nR9r0GK+1mPodous89czBfQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     sedat.dilek@gmail.com
Cc:     Yury Norov <yury.norov@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
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

On Sun, Mar 5, 2023 at 10:17=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There are a few main issues with MAXSMP:

It's probably worth noting that most architectures don't even support
MAXSMP at all.

Only x86-64 does.

For example, ia64 and sparc64, which both did techncially support a
lot of cores, just made "cpumask_t" huge, and had no support for the
whole "use a pointer to an indirect allocation".

That ends up meaning that you allocate those huge structures on the
stack or just make other structures enormous when they contain a CPU
mask, but it mostly works. It's a horrid, horrid model, though. But at
least ia64 had 64kB stacks anyway, and in the book of "bad engineering
decisions of Itanium", this is all just a footnote.

arm64 also has that "range 2 4096" for number of CPUs but defaults to
a much saner 256 cpus.

I suspect (and sincerely hope) that nobody actually tries to use an
arm64 build with that 4k cpu build. If/when arm64 actually does get up
to that 'thousands of cores" situation, they'll hopefully enable the
MAXSMP kind of indirection and off-stack cpu mask arrays.

So MAXSMP and the whole CPUMASK_OFFSTACK option is an architecture
choice, and you don't have to do it the way x86-64 does it. But the
x86 choice is likely the best tested and thought out by far.

For example, POWERPC technically supports CPUMASK_OFFSTACK too, but
really only in theory. On powerpc, you have

    config NR_CPUS
          range 2 8192 if SMP
          default "32" if PPC64

so while configuration the range is technically up to 8k CPUs, I doubt
people use that value very much. And we have

        select CPUMASK_OFFSTACK if NR_CPUS >=3D 8192

so it only uses that OFFSTACK one if you pick exactly 8192 CPUs (which
presumably nobody does in real life outside of build testing - it's
not the default, and I think most of the POWER range tops up in the
192 core range, eg E980 with 16 sockets of 12 cores each).

So I suspect that x86-64 is the *only* one to actually use this
widely, and I think distros have been *much* too eager to do so.

The fact that most distros default to

    CONFIG_MAXSMP=3Dy
    CONFIG_NR_CPUS=3D8192

seems pretty crazy, when I have a hard time finding anything with more
than 192 cores.  I'm sure they exist. But do they _really_ run
unmodified vendor kernels?

               Linus
