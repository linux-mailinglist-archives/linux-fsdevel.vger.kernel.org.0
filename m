Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7A5F7578
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 10:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJGIrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 04:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGIrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D127AC06A5;
        Fri,  7 Oct 2022 01:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E0BD61C2C;
        Fri,  7 Oct 2022 08:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FF5C433D6;
        Fri,  7 Oct 2022 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665132434;
        bh=CexMwlju7j9Hr220YinEzGfyerDp9Vht+B+CwEPwGPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r3ElgUbJXwjTd5ttdVUDmAIS9/UYQuyEWtOMV3/oq/ZhQHJvEZyKuGOti4QriAjeA
         DOTt8gzpxp0LdaWrT1/Or0D/rDfMvGqit+dsb4TIyNm7M1UONBE8DeC81SSw2qgknn
         mFHDnmzmKojOnxZLWwRmu85uKnazwm7fH30FfKnaN2ie2OHMOWPZj1QqTWTwbLWLuI
         8+mUtbY7aOO9BR+RvFz4rI/EKsyeflHxy6P1wC5kNnjhI1NublOU9ul7ydtlFvoehn
         fS+nHu3UmskArGXgVbg04yV+QN0dGES0l8SRNKbwiPhY0iK/2qLkzdBf8f40Dz9P7W
         YnRz42/Dww4Eg==
Received: by mail-lj1-f173.google.com with SMTP id bs18so4942973ljb.1;
        Fri, 07 Oct 2022 01:47:14 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ckorfgLN8CohFOM+/m6KVBeD090LXgUIRXzOrUOD1UQM7v3FI
        2mIc4tvp1k1Ko6h8ArWsF71GWtDT9tsnvAs4xac=
X-Google-Smtp-Source: AMsMyM7K1TiYjW8k7ATngkkqHRC3dpRaYUFzTaZ/0l1PKgeSsV+MKwh53+n3P6cRpaiApTKoiL7oGfL3nwq9sBu+Cfw=
X-Received: by 2002:a05:651c:239c:b0:26d:94b8:781d with SMTP id
 bk28-20020a05651c239c00b0026d94b8781dmr1175964ljb.189.1665132432842; Fri, 07
 Oct 2022 01:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-6-gpiccoli@igalia.com>
 <202210061634.758D083D5@keescook>
In-Reply-To: <202210061634.758D083D5@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 7 Oct 2022 10:47:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
Message-ID: <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] pstore: Fix long-term implicit conversions in the
 compression routines
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Oct 2022 at 01:36, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 06, 2022 at 07:42:09PM -0300, Guilherme G. Piccoli wrote:
> > The pstore infrastructure is capable of compressing collected logs,
> > relying for that in many compression "libraries" present on kernel.
> > Happens that the (de)compression code in pstore performs many
> > implicit conversions from unsigned int/size_t to int, and vice-versa.
> > Specially in the compress buffer size calculation, we notice that
> > even the libs are not consistent, some of them return int, most of
> > them unsigned int and others rely on preprocessor calculation.
> >
> > Here is an attempt to make it consistent: since we're talking
> > about buffer sizes, let's go with unsigned types, since negative
> > sizes don't make sense.
>
> Thanks for this! I want to go through this more carefully, but I'm a fan
> of the clean-up. I'd also like to get Ard's compression refactor landed
> again, and then do this on top of it.
>

Isn't this the stuff we want to move into the crypto API?
