Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740934E2257
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 09:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbiCUImk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiCUImj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:42:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E2A1451
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 01:41:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so28311038ejc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1TcUGL3Yr9pbZUIUf4urzAZZW+X+3X2guZDA8VSc8A=;
        b=doxelnDMfXbB5iuIRK4hrnslkGX8BBTvxzAkb0q9tNJFa34Y3jqcWcfHpVibc9cfiJ
         Lk3kupzHwyhzogtJ8ePTN72QZOettBzmKjpDw16KezAFhFYdc3WfdA8OP1ZDFtBcuSMZ
         I2a8XVg4a9eRpDMpV128X0Nq+arrNVtHg4/Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1TcUGL3Yr9pbZUIUf4urzAZZW+X+3X2guZDA8VSc8A=;
        b=PGTF0uvZaPR21hn/pPo+aS/ry/3tesBLuucH1e9zQXwYUT8Woz5Q61XJnAzcpf5832
         llkjTLM3OGdOfFtYRTUsohH9zGDfIks72ARISg3of/sz1Ezi7PpPMPfVxOrwOttNVVPk
         HdGTSVCFDHlnZdo2dycBgBZpCPQZv82eU6czz5v63nz1DSCdBFmzonYwdyq+YmCziSk+
         e0QGuYWNzLJUIMsRLy4u4528zIIRgm0dSBi6jePhH0+W6T0UgA9o5n06ZxmD2rxDfdEa
         sw3Y+pPIAcN/4AlmbBQkmMy44Pk88t5IcVsgP29VpCnqcFTXY5yJOhBF7oJ6af34n9U1
         8eHQ==
X-Gm-Message-State: AOAM533x5vxtNOnYGT2vUF1ot16chSkrKBCRKO5xnorB2Ls/nHpu7PC5
        ZH7jjIqYrt0OFycZWDwonKiX+R8CxPK5YghHjpasFg==
X-Google-Smtp-Source: ABdhPJy2lA62e8/yWwcG+98dZn7ToA9GNqRjH90QGk+nz/876LNhUqYCp2yX6ujlNu1Aaufl2Zr0QeGUdZqMPBJUzHQ=
X-Received: by 2002:a17:906:280b:b0:6ce:f3c7:688f with SMTP id
 r11-20020a170906280b00b006cef3c7688fmr19757403ejc.468.1647852068103; Mon, 21
 Mar 2022 01:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220318171405.2728855-1-cmllamas@google.com> <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
 <Yjfd1+k83U+meSbi@google.com>
In-Reply-To: <Yjfd1+k83U+meSbi@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Mar 2022 09:40:56 +0100
Message-ID: <CAJfpeguoFHgG9Jm3hVqWnta3DB6toPRp_vD3EK74y90Aj3w+8Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Mar 2022 at 03:07, Carlos Llamas <cmllamas@google.com> wrote:
>
> On Fri, Mar 18, 2022 at 08:24:55PM +0100, Miklos Szeredi wrote:
> > On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
> > >
> > > Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> > > <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> > > all the definitions in this header to use the correct type. Previous
> > > discussion of this topic can be found here:
> > >
> > >   https://lkml.org/lkml/2019/6/5/18
> >
> > This is effectively a revert of these two commits:
> >
> > 4c82456eeb4d ("fuse: fix type definitions in uapi header")
> > 7e98d53086d1 ("Synchronize fuse header with one used in library")
> >
> > And so we've gone full circle and back to having to modify the header
> > to be usable in the cross platform library...
> >
> > And also made lots of churn for what reason exactly?
>
> There are currently only two uapi headers making use of C99 types and
> one is <linux/fuse.h>. This approach results in different typedefs being
> selected when compiling for userspace vs the kernel.

Why is this a problem if the size of the resulting types is the same?

Thanks,
Miklos
