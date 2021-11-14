Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6145444F8B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 16:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhKNPfY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 10:35:24 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:41707 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhKNPfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 10:35:22 -0500
Received: by mail-qt1-f171.google.com with SMTP id v22so8624201qtx.8;
        Sun, 14 Nov 2021 07:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AMLZNNJz4rzWLCa/Dr8r4qa1Ugz4YCnUFphJhYJFFBo=;
        b=h8JC+cpOWUV61DB69v/irqexcwn9GjdjZZamjMoSlK2d2yG1aj/Ax2RDNwwPBvASnc
         oiln3tPjYF3OY6aUTLRZt2COz8dtJVNd1zBsGBKGUlGJ+mcgJnA/cPiDeerE7vyiVFoH
         /Xf2rK5Gb6GTuBmEAcQLC7YUzXkWPsvmKJOWubLTUrjHzYeDcAHqDJtB0nTb9BLi27kN
         1BehmHai7AgwUReyAft+3IEVMgATqoLdwlqL2k0WwYKKQsVEWuTQRUoqdJDB3FRXgz3w
         cYOoPgflxAUvRNU+gbqSeK4V+x4wyLrE4KZ+TU7G2uhos+VSliYiGoCX3R9pNQh6dLSw
         bUMQ==
X-Gm-Message-State: AOAM531YoGIod1lHdAHD4URZYUiRvk8CwoLfE7U/mRGGwneXBz6ZL3ex
        3ubVpOEzo3+zMT7wNfnj6d10XcbV938Urw==
X-Google-Smtp-Source: ABdhPJwCOVMPnq/6z1XAeFrFPgSLeFso+55WQ4PVZd+YwnQ5rXkJYXSNTPZtABcfDtFASUu5enBjkg==
X-Received: by 2002:a05:622a:551:: with SMTP id m17mr29426403qtx.98.1636903945060;
        Sun, 14 Nov 2021 07:32:25 -0800 (PST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id w11sm6691355qta.50.2021.11.14.07.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 07:32:24 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id i13so9685186qvm.1;
        Sun, 14 Nov 2021 07:32:24 -0800 (PST)
X-Received: by 2002:a05:6122:20a7:: with SMTP id i39mr47085557vkd.15.1636903933687;
 Sun, 14 Nov 2021 07:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20211110190626.257017-1-mic@digikod.net> <20211110190626.257017-2-mic@digikod.net>
 <8a22a3c2-468c-e96c-6516-22a0f029aa34@gmail.com> <5312f022-96ea-5555-8d17-4e60a33cf8f8@digikod.net>
 <34779736-e875-c3e0-75d5-0f0a55d729aa@gmail.com>
In-Reply-To: <34779736-e875-c3e0-75d5-0f0a55d729aa@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 14 Nov 2021 16:32:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXj8fHDq-eFd41GJ4oNwGD5sxhPx82izNwKxE_=x8dqEA@mail.gmail.com>
Message-ID: <CAMuHMdXj8fHDq-eFd41GJ4oNwGD5sxhPx82izNwKxE_=x8dqEA@mail.gmail.com>
Subject: Re: [PATCH v16 1/3] fs: Add trusted_for(2) syscall implementation and
 related sysctl
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alejandro,

On Sat, Nov 13, 2021 at 8:56 PM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
> On 11/13/21 14:02, Mickaël Salaün wrote:
> >> TL;DR:
> >>
> >> ISO C specifies that for the following code:
> >>
> >>      enum foo {BAR};
> >>
> >>      enum foo foobar;
> >>
> >> typeof(foo)    shall be int
> >> typeof(foobar) is implementation-defined
> >
> > I tested with some version of GCC (from 4.9 to 11) and clang (10 and 11)
> > with different optimizations and the related sizes are at least the same
> > as for the int type.
>
> GCC has -fshort-enums to make enum types be as short as possible.  I
> expected -Os to turn this on, since it saves space, but it doesn't.

Changing optimization level must not change the ABI, else debugging
would become even more of a nightmare.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
