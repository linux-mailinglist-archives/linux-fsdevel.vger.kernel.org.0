Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FE15F8663
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJHRxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 13:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiJHRxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 13:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342142ADD;
        Sat,  8 Oct 2022 10:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C703E60A56;
        Sat,  8 Oct 2022 17:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34691C43470;
        Sat,  8 Oct 2022 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665251582;
        bh=mYoYpCWpfYEMUoMrJw5rH8AVlmRmZhyXK9IrW26Y3dE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZuN2GEUcv9z1nCTJu4sZA7GDSl9tntmKfc43yrwpV56KUS2ZHhuwjPMeyk1jsFmIP
         kWNOhdG4RUnuPnbX3wJ0EbzYz+3GJWSHEvrsCvua3Y5WOgBZZN1N4sE6of3orHPxws
         6NuWsTcNiYHVLfVEFg28ZAsJ51+HIozx50XFaj7aOVqyCHOT8yYR4cdEDTr6Hy7TEN
         H7ti9Gwb55bb0eqw9mmTKvq5aQGxUymUddm8HmcTi66D3HOoAUWQdhDay4Gv2aUBFL
         d1mTouNgQbajacF836xjuVxdZ7x9Fi50MZhfdtBhgK1SWDFRbgB7rSJcEfRVn7athV
         dvCoEQ8dmKw/A==
Received: by mail-lf1-f51.google.com with SMTP id g1so11305151lfu.12;
        Sat, 08 Oct 2022 10:53:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf1T2FhpKxUhUigN8higpVtYOqIiU/71kqm2huWGJy7igg5GV5cS
        soCRbGUcepU4TxC2okNI+r5PbAQCg9wGo4tRGos=
X-Google-Smtp-Source: AMsMyM4lmJm8jD7Uism04wECTJ6G7FobX9Rs5gsE8x9eSUNU5+0cAvQYgbXIDGLkpYol2SPlcwALD3RzPek16PiUp2I=
X-Received: by 2002:a05:6512:314a:b0:4a2:d0b9:aa20 with SMTP id
 s10-20020a056512314a00b004a2d0b9aa20mr878824lfi.110.1665251579833; Sat, 08
 Oct 2022 10:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-6-gpiccoli@igalia.com>
 <202210061634.758D083D5@keescook> <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
 <202210071234.D289C8C@keescook> <11e03e8d-7711-330d-e0d4-808ef9acec3a@igalia.com>
 <CAMj1kXHSSSZ59tihHDNDamczxFCRH8NHzT-eKaZ7xNyqVXW1Hw@mail.gmail.com> <dbe57a5e-7486-649f-7093-6da6312a71ee@igalia.com>
In-Reply-To: <dbe57a5e-7486-649f-7093-6da6312a71ee@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 8 Oct 2022 19:52:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHjS+gywpoZ26_Bn76Z_5ohhtoD7ruH0bBYaAQzBY9tuw@mail.gmail.com>
Message-ID: <CAMj1kXHjS+gywpoZ26_Bn76Z_5ohhtoD7ruH0bBYaAQzBY9tuw@mail.gmail.com>
Subject: Re: [PATCH 5/8] pstore: Fix long-term implicit conversions in the
 compression routines
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 8 Oct 2022 at 18:04, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 08/10/2022 12:53, Ard Biesheuvel wrote:
> > [...]
> > So one thing I don't understand about these changes is why we need
> > them in the first place.
> >
> > The zbufsize routines are all worst case routines, which means each
> > one of those will return a value that exceeds the size parameter.
> >
> > We only use compression for dmesg, which compresses quite well. If it
> > doesn't compress well, there is probably something wrong with the
> > input data, so preserving it may not be as critical. And if
> > compressing the data makes it bigger, can't we just omit the
> > compression for that particular record?
> >
> > In summary, while adding zbufsize to the crypto API seems a reasonable
> > thing to do, I don't see why we'd want to make use of it in pstore -
> > can't we just use the decompressed size as the worst case compressed
> > size for all algorithms, and skip the compression if it doesn't fit?
> >
> > Or am I missing something here?
>
> In a way (and if I understand you correctly - please let me know if not)
> you are making lot of sense: why not just use the maximum size (which is
> the full decompressed size + header) as the worst case in pstore and
> skip these highly specialized routines that calculate the worst case for
> each algorithm, right?
>

Yes

> This is exactly what 842 (sw compress) is doing now. If that's
> interesting and Kees agrees, and if nobody else plans on doing that, I
> could work on it.
>
> Extra question (maybe silly on my side?): is it possible that
> _compressed_ data is bigger than the original one? Isn't there any
> "protection" on the compress APIs for that? In that case, it'd purely
> waste of time / CPU cycles heheh
>

No, this is the whole point of those helper routines, as far as I can
tell. Basically, if you put data that cannot be compressed losslessly
(e.g., a H264 video) through a lossless compression routine, the
resulting data will be bigger due to the overhead of the compression
metadata.

However, we are compressing ASCII text here, so using the uncompressed
size as an upper bound for the compressed size is reasonable for any
compression algorithm. And if dmesg output is not compressible, there
must be something seriously wrong with it.

So we could either just drop such input, or simply not bother
compressing it if doing so would only take up more space. Given the
low likelihood that we will ever hit this case, I'd say we just ignore
those.

Again, please correct me if I am missing something here (Kees?). Are
there cases where we compress data that may be compressed already?
