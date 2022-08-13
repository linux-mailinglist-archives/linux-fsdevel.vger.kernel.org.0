Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AB591AA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiHMNg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 09:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiHMNg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:36:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1FFB7C1;
        Sat, 13 Aug 2022 06:36:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z2so4362545edc.1;
        Sat, 13 Aug 2022 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AKVBfO32rmZq1r8Xc6WkO9jk42SoifdEhyas0O7uhTs=;
        b=UdYffYR5Uny5GwXXCuOgQYee354sCFqcXWa8z7kGVw5IRH/AsBzPh3vXxLy4J9F18F
         +WT6wBUCx2Vtmirlt3mJ+Q2rMV2lujZ+TcoXk0LVC1fsy/JcHD8V3Yx+WVx1nWJ6cnFf
         78v+kx7JV0b5Luaz5QjVH7z+PC9tYnreYMHc2flMcZvlHaYGNdv4LOnXZlCvuhM2AUhr
         Fl4ES1oH9dUPEdbDnf5aGteXKSb+dHbqcbPOkmfDkeTJ/kdccMspkmqU9QMBJmFZNU8W
         SpxOBWj7oeWuysx7qEvgQsMeolLYfFZjUq5UCJhlOjpngmGLWOHteJSwUvNUZ3lPisw3
         HclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AKVBfO32rmZq1r8Xc6WkO9jk42SoifdEhyas0O7uhTs=;
        b=1let7A/Sdl1bAt/8H8MK3vAQNkh0DPJi9kNuSNOcq8fHkOkYsUP1WI4QY0ysi9CtIx
         z5ECxwUZT/L1W68o+UGS0VA8V6SkTKztw/8GjRR7mVpy6PVQ2BupP9xs2Bu2w0Za5gqK
         QKguhXF9RCXAAXFHddoQX4mUceKbPTQMtzt/vUhsN1nC4Q/N+jTAzW8uJwFL/UJfML1u
         52Ea1HWhVDpFnRzFJEaXPMaNEs6ImDCHJv9bwDqQN13Wd3mjiULVP6g/QAP2+KFKUKwi
         v4arIKe8YTQdUitsDgPCIkHZ5UNR+xpSl9NieN74f0aZfCdN0zurXfQET5Svtzyvv/Tg
         O0Jg==
X-Gm-Message-State: ACgBeo3RNc1FabayiOs8QIVbqUs2LMC0aPKz4FcE25vhsdu813xGYQlh
        GGwzIe6cRhanUN0ddkNvH9o=
X-Google-Smtp-Source: AA6agR6YHmhuU6n1HU6pRDZIWiUpUQGG2w90iwTEUs1ezspDX/TPu4VgLorkbgMHhQ4p/0u7Tm1uRg==
X-Received: by 2002:aa7:c9c2:0:b0:440:b458:9403 with SMTP id i2-20020aa7c9c2000000b00440b4589403mr7604816edt.132.1660397816004;
        Sat, 13 Aug 2022 06:36:56 -0700 (PDT)
Received: from opensuse.localnet (host-79-53-105-123.retail.telecomitalia.it. [79.53.105.123])
        by smtp.gmail.com with ESMTPSA id w22-20020a17090633d600b0072b33e91f96sm1875765eja.190.2022.08.13.06.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 06:36:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] fs: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Sat, 13 Aug 2022 15:36:53 +0200
Message-ID: <8143586.NyiUUSuA9g@opensuse>
In-Reply-To: <20220803182856.28246-1-fmdefrancesco@gmail.com>
References: <20220803182856.28246-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=C3=AC 3 agosto 2022 20:28:56 CEST Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and are still valid.
>=20
> Since the use of kmap_local_page() in exec.c is safe, it should be
> preferred everywhere in exec.c.
>=20
> As said, since kmap_local_page() can be also called from atomic context,
> and since remove_arg_zero() doesn't (and shouldn't ever) rely on an
> implicit preempt_disable(), this function can also safely replace
> kmap_atomic().
>=20
> Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> fs/exec.c.
>=20
> Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> with HIGHMEM64GB enabled.
>=20
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> v1->v2: Added more information to the commit log to address some
> objections expressed by Eric W. Biederman[1] in reply to v1. No changes
> have been made to the code. Forwarded a tag from Ira Weiny (thanks!).
>=20
> [1]
> https://lore.kernel.org/lkml/8735fmqcfz.fsf@email.froward.int.ebiederm.or=
g/
>
>  fs/exec.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20

Hi Kees,

After that thread about the report from Syzbot, and the subsequent discussi=
on,=20
I noticed that you didn't yet take this other patch for exec.c.

I suppose that the two patches would better go out together. So I'm writing=
=20
for sending a gentle ping.

As I said, no changes have been made to the code with respect to v1 (which =
I=20
submitted in June). However, later I thought that adding more information=20
might have helped reviewers and maintainers to better understand the why of=
=20
this patch.

Thanks,

=46abio
=20



