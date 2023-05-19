Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B8709E91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 19:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjESRwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 13:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjESRwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 13:52:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A21D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 10:52:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5112cae8d82so1442942a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684518732; x=1687110732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGnYbqcZG6G5Zygfq9ya1FX/PrdFw/7KpC0G/WDYb3g=;
        b=Z7+2Z0SwekJBmitpO0/klgXdMWkrFUcPqaC7OxG+6x6dHQBALurrrlHgHtqS3u19BB
         MgRGGliLZVZPdzexbxqedcQvwPJyiV1uBGWDoC1146UJxexe34/ktC+ouJsofuPlKXWw
         U4SeMIIAPxOv5q7CaoKBAYr9G7UVkbXXKg5hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518732; x=1687110732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGnYbqcZG6G5Zygfq9ya1FX/PrdFw/7KpC0G/WDYb3g=;
        b=E0u8iJxO0OZxj74GKDNQq9L+AzYvZZBHIA2dT+NW0fkw3WJuyy4OqbOZbiS77aILrx
         iRxy4b7eYiTn+XOtlAokkL5dLHPtUUQOFeWzsPKSVZGQIO/IGnwlnUWD1Ptn6UjVXnPO
         RW3CMC6a+NY3++Sa4vr8523sKHKJIzyEPve9IOBEBIvTCiYNzrH+SNknEXWAVrSksBUZ
         LbdPyp5sdSJzSbZIIj0rY4Wsx5kPEMRQWUayuju+YEQKb5f8ewgGNSXjOf22r0FsLQ5h
         bV7Wwd8TjXR+aoAJ18Ypc9CMuidz/sG5GagYvTjwq2r63AcgOEZ+dCDF4ZDG8sWHmguk
         V1rQ==
X-Gm-Message-State: AC+VfDw7noL3ePQ3tGH5SBZBdokP4BkaOWgAUpX02fI/2Anyg+C+Vmvx
        OVn7g5Ys4WmBlWIxgVZ/Scc069G3Ldpfc1NLC60fAE2v
X-Google-Smtp-Source: ACHHUZ5OdnVsuVD/GvLLHPnluwAEKQmU2z7Z85CdZsG2xblLy5PRkd7w8eMcgvaCjL1lNAiDZ3VEfQ==
X-Received: by 2002:a17:907:970c:b0:96a:c15b:2b83 with SMTP id jg12-20020a170907970c00b0096ac15b2b83mr3141207ejc.54.1684518732503;
        Fri, 19 May 2023 10:52:12 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id cd6-20020a170906b34600b0094f3d700868sm2546912ejb.80.2023.05.19.10.52.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:52:11 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so5206922a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 10:52:11 -0700 (PDT)
X-Received: by 2002:a05:6402:b11:b0:508:41df:b276 with SMTP id
 bm17-20020a0564020b1100b0050841dfb276mr2186732edb.22.1684518731037; Fri, 19
 May 2023 10:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner> <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner> <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner> <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
 <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com> <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
In-Reply-To: <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 10:51:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=win2x_KORa1CJTaX0VrBy9ug_GXNwPpcPXVQbedHSYhsg@mail.gmail.com>
Message-ID: <CAHk-=win2x_KORa1CJTaX0VrBy9ug_GXNwPpcPXVQbedHSYhsg@mail.gmail.com>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Thu, May 18, 2023 at 9:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> My point that the kernel can help here.
> Since folks don't like sysctl to control FD assignment how about somethin=
g like this:

No. Really.

The only thing that needs to happen is that people need to *know* that
fd's 0/1/2 are not at all special.

The thing is, it's even *traditional* to do something like

        close(0);
        close(1);
        close(2);

and fork() twice (exiting the first child after the second fork).
Usually you'd also make sure to re-set umask, and do a setsid() to
make sure you're not part of the controlling terminal any more.

Now, some people would then redirect /dev/null to those file
descriptors, but not always: file descriptors used to be a fairly
limited resource. So people would *want* to use all the file
descriptors they could for whatever server connections they
implemented. Including, very much, fd 0.

So really. There is not a way in hell we will *EVER* consider fd 0 to
be special. It isn't, it never has been, and it never shall be.

Instead, just spread the word that fd 0 isn't special.

The fact that you think that some completely broken C++ code was
"written with high quality", and you think that is an excuse for
garbage is just sad.

Those C++ libraries WERE INCREDIBLE CRAP. They were buggy garbage. And
no, they are in no way going to affect the kernel and make the kernel
do stupid and wrong things.

                    Linus
