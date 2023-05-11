Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45646FF5AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 17:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbjEKPRz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbjEKPRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 11:17:54 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280D81BE9;
        Thu, 11 May 2023 08:17:53 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso9857608e87.3;
        Thu, 11 May 2023 08:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683818269; x=1686410269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeLJUnaY4RpSv7Fr2RyuafyTEGCbWOy7/KdXYyNynDE=;
        b=ge1gtwjXlKoKZXr/qIp5om/sZLzkRVaPZoKEd+n/64npGC8ZAgJXmeZVOU9dCKyBrL
         qRdx47yk2qLkmuRxh7eGifrT9eaVecmor5q11BXhaJ2bvcs2dcUrTtB9J2UrAnUaSrfr
         YbUKSyF/XomYjC09/9GV50LGxkwISrvHUx6/n18DsSSDmqjum5v0TifpJ89ok5HERmi/
         5VCFJLvV/eF7sI3GJkM3A9B+TgJyqP23zpjIZ3VTvmZ83MlALpNi2IbddO5v7j0sbKYM
         kx6ftYs353keXixBF8zPyAKnbpK9wYbU/CCJqYSUuLCJ5Nfo/fOSGrm2u/PAwjoHCy7t
         14EQ==
X-Gm-Message-State: AC+VfDw3E+dBcf13s+NtbICSOnmyeQnwg/5pHUe0fxHRj9igKjkPYGNK
        Usk7crOITmi4b4Fvx/ms8naUz7SDKeB2elkP
X-Google-Smtp-Source: ACHHUZ7AtAYYjTZZBBifPPhnRdvlQJmGftR5qufjOvI46W5MJZJ2S/CxxxUalX7TfpD2oh6B80cmDg==
X-Received: by 2002:ac2:5930:0:b0:4e9:74a8:134c with SMTP id v16-20020ac25930000000b004e974a8134cmr2779767lfi.43.1683818268565;
        Thu, 11 May 2023 08:17:48 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o21-20020ac24355000000b004dda87ecae3sm1125543lfl.246.2023.05.11.08.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 08:17:47 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f2676d62a2so1729691e87.0;
        Thu, 11 May 2023 08:17:46 -0700 (PDT)
X-Received: by 2002:ac2:4c13:0:b0:4f2:22bf:fe98 with SMTP id
 t19-20020ac24c13000000b004f222bffe98mr2776652lfq.37.1683818265953; Thu, 11
 May 2023 08:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230511150802.737477-1-cgzones@googlemail.com>
In-Reply-To: <20230511150802.737477-1-cgzones@googlemail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 17:17:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVa69s3g0z6qgayzNx=jT6Ko2RNeZehru0SbzYH8VwkfQ@mail.gmail.com>
Message-ID: <CAMuHMdVa69s3g0z6qgayzNx=jT6Ko2RNeZehru0SbzYH8VwkfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] fs/xattr: add *at family syscalls
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, audit@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Thu, May 11, 2023 at 5:10 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
> Add the four syscalls setxattrat(), getxattrat(), listxattrat() and
> removexattrat().  Those can be used to operate on extended attributes,
> especially security related ones, either relative to a pinned directory
> or on a file descriptor without read access, avoiding a
> /proc/<pid>/fd/<fd> detour, requiring a mounted procfs.
>
> One use case will be setfiles(8) setting SELinux file contexts
> ("security.selinux") without race conditions.
>
> Add XATTR flags to the private namespace of AT_* flags.
>
> Use the do_{name}at() pattern from fs/open.c.
>
> Use a single flag parameter for extended attribute flags (currently
> XATTR_CREATE and XATTR_REPLACE) and *at() flags to not exceed six
> syscall arguments in setxattrat().
>
> Previous approach ("f*xattr: allow O_PATH descriptors"): https://lore.kernel.org/all/20220607153139.35588-1-cgzones@googlemail.com/
> v1 discussion: https://lore.kernel.org/all/20220830152858.14866-2-cgzones@googlemail.com/
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Thanks for your patch!

The syscall numbers conflict with those used in "[PATCH] cachestat:
wire up cachestat for other architectures", so this needs some
synchronization.
https://lore.kernel.org/linux-sh/20230510195806.2902878-1-nphamcs@gmail.com

>  arch/m68k/kernel/syscalls/syscall.tbl       |   4 +

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
