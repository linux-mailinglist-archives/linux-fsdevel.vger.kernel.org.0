Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F961E26F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 14:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKFNrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 08:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiKFNrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:47:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBF1026
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Nov 2022 05:47:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u24so13789631edd.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Nov 2022 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cc3Cob2HMpA+4FuJJhkFj8IUBM4Qig1zRJRYFxaKeQ=;
        b=i+XtjvGSXRuumvaCFDiGQ3DTX1a6VYta2aAmDaYwPeZV47m/TFpCpgYNvrvc+oviIc
         2v6YOarLLUwNPaNXG8Sd8zzObAmDR3OuSwflTqP3Pi8wYUPLcRb3qpcUcNX3H5lME1AO
         2YX5341IlxRbenFdpH4Es5tSBqMgLe5DoNd2yUivWgB74w6B/haOqesq+5VOdo/V8l0Z
         J5446eY1lR+EavB5zej6PEfU9yVi3zznqcqVDLX2a5oVf8Uxq2EwI4Gueh7id3f/7H+d
         CNeqE3CEhAj7plFdnJ2OGxgnsWRc1lh0bEV7f3aBeHpEOhnPUIus1TymFzzJW/HePhtD
         olPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Cc3Cob2HMpA+4FuJJhkFj8IUBM4Qig1zRJRYFxaKeQ=;
        b=v15YwNHIKGQMGJkBmyyZF5I91eWxsSIOvl/5yi9JHA4fW/sGZFDMFjqxf9ciwvnlzq
         6BA6RH9PtIDcUEV6Eav7dsFWVKE8ioGN0JANdXzeLd0NM+1+KGjFYuPBjuK1f7SmWfb5
         7HaU7nlr6au9Da04+T6GLK5XcFU7cSUpGMH5PLOCYmSipIS3AVC20FfkJWU2KvpaSNvh
         GjwggGlwC0XAGx1bwgyLdPZd6Sh1rPoHgBwdRLMWbiU058WvsF6IRx696pI0fB5Ng2y3
         A3tMkEwAKG5NEwbFXv/Dk4IueSsXuoIMsQ56jB0H2+zJu59LCXPdggxSY2jX+WJMzyc/
         tiPw==
X-Gm-Message-State: ACrzQf2/Viz5AVUC6AzJl7ghcTPQ0XB/0BPVjU4wEeFPHHumeYuZlRqC
        y6vjWVS2Yox1MqOvb9A9CxDE+Ngu1N9seDkKDWjbgw==
X-Google-Smtp-Source: AMsMyM48U0SeoynJS9XayTwbS33kzjYHL5TJWZzzOCIZ/D3eTcq7XZQc+SJqFkFx2x40ydFcGhc0xE5HaNQArM9a8qE=
X-Received: by 2002:a50:eb83:0:b0:462:a2ac:8623 with SMTP id
 y3-20020a50eb83000000b00462a2ac8623mr45311356edr.360.1667742423783; Sun, 06
 Nov 2022 05:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20221105025342.3130038-1-pasha.tatashin@soleen.com> <Y2YuDfQbAwtLRLq4@debian.me>
In-Reply-To: <Y2YuDfQbAwtLRLq4@debian.me>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Sun, 6 Nov 2022 08:46:26 -0500
Message-ID: <CA+CK2bB2wz1c0kt0gegZ-MGnYBjbcdh3H-qo15R-egqt8pvquA@mail.gmail.com>
Subject: Re: [PATCH] mm: anonymous shared memory naming
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, hughd@google.com,
        hannes@cmpxchg.org, david@redhat.com, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 5, 2022 at 5:34 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Sat, Nov 05, 2022 at 02:53:42AM +0000, Pasha Tatashin wrote:
> > Since:
> > commit 9a10064f5625 ("mm: add a field to store names for private anonymous
> > memory")
> >
> > We can set names for private anonymous memory but not for shared
> > anonymous memory. However, naming shared anonymous memory just as
> > useful for tracking purposes.
> >
>
> Who are "we"?
>
> Instead, say "Since commit <commit>, name for private anonymous memory,
> but not shared anonymous, can be set".

Thanks will update.

>
> > @@ -431,8 +431,10 @@ is not associated with a file:
> >   [stack]                    the stack of the main process
> >   [vdso]                     the "virtual dynamic shared object",
> >                              the kernel system call handler
> > - [anon:<name>]              an anonymous mapping that has been
> > + [anon:<name>]              a private anonymous mapping that has been
> >                              named by userspace
> > + path [anon_shmem:<name>]   an anonymous shared memory mapping that has
> > +                            been named by userspace
> >   =============              ====================================
> >
>
> The table above triggers Sphinx warning:
>
> Documentation/filesystems/proc.rst:436: WARNING: Malformed table.
> Text in column margin in table line 8.
>
> =============              ====================================
> [heap]                     the heap of the program
> [stack]                    the stack of the main process
> [vdso]                     the "virtual dynamic shared object",
>                            the kernel system call handler
> [anon:<name>]              a private anonymous mapping that has been
>                            named by userspace
> path [anon_shmem:<name>]   an anonymous shared memory mapping that has
>                            been named by userspace
> =============              ====================================
>
> I have applied the fixup:
>
> ---- >8 ----
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 8f1e68460da5cd..3f17b4ef307fe4 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -426,7 +426,7 @@ with the memory region, as the case would be with BSS (uninitialized data).
>  The "pathname" shows the name associated file for this mapping.  If the mapping
>  is not associated with a file:
>
> - =============              ====================================
> + ========================   ===========================================
>   [heap]                     the heap of the program
>   [stack]                    the stack of the main process
>   [vdso]                     the "virtual dynamic shared object",
> @@ -435,7 +435,7 @@ is not associated with a file:
>                              named by userspace
>   path [anon_shmem:<name>]   an anonymous shared memory mapping that has
>                              been named by userspace
> - =============              ====================================
> + ========================   ===========================================
>
>   or if empty, the mapping is anonymous.
>
>
> Thanks.

Great, thank you.

Pasha

>
> --
> An old man doll... just what I always wanted! - Clara
