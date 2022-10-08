Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBC5F85F8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 17:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJHPyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 11:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJHPyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:54:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B94BA42;
        Sat,  8 Oct 2022 08:54:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BF05B80B8D;
        Sat,  8 Oct 2022 15:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE36CC433D7;
        Sat,  8 Oct 2022 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665244444;
        bh=JhMfZk51VW3GUR1Bbpx85loUpVTgUFKQcGFEvOqFk6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tvrnc2Nh/7UQg/D8G88W7CUyPSXt5EpETjtvV/Xnm46+sHdS10NBbHf+UskK8Is4u
         MbTCMVXG64txRU+rvv7rmjXaxesFVzGnPszj0EtHxyPyd0GxtpxcFPRAWMjG8tACDn
         5r2KHWa5dh0Jjl1gr8CqDk97Uh9FjA6XfutrlNYwfl4oVSTOD7pAMgz6IL6er93MPF
         Ii1nxhMx2xJE3BUDYOz84JuMq2l2gyYgW/IWzbZhljwNJt9UdlorXq2Aac/lEkpFPP
         /nR62KiTBwZxSc7bbbvGiWdiEe4oVH7bG5NzSMcOemR9WLUSOAQJ8uF8C/8VGB3Emn
         zmGzO11TW27cg==
Received: by mail-lf1-f42.google.com with SMTP id b1so6127947lfs.7;
        Sat, 08 Oct 2022 08:54:03 -0700 (PDT)
X-Gm-Message-State: ACrzQf0wxCcvqutrst/rIHScQSc/swQ07O23hzRM5ou7inSllgi0MKU1
        XhCXtaG5cOY0YJX48/bfkJv1YV3GW/b4dNDt8kg=
X-Google-Smtp-Source: AMsMyM6Sjd7+P1DokMJKyGXbcgBPIP3Im99eZH8LdXDR1brI+9MQOeWO5r5wOD+rI7kI3uSNP5Zd7ZZgfNCxYY++W3E=
X-Received: by 2002:a19:c20b:0:b0:4a2:40e5:78b1 with SMTP id
 l11-20020a19c20b000000b004a240e578b1mr3620836lfc.228.1665244441956; Sat, 08
 Oct 2022 08:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-6-gpiccoli@igalia.com>
 <202210061634.758D083D5@keescook> <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
 <202210071234.D289C8C@keescook> <11e03e8d-7711-330d-e0d4-808ef9acec3a@igalia.com>
In-Reply-To: <11e03e8d-7711-330d-e0d4-808ef9acec3a@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 8 Oct 2022 17:53:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHSSSZ59tihHDNDamczxFCRH8NHzT-eKaZ7xNyqVXW1Hw@mail.gmail.com>
Message-ID: <CAMj1kXHSSSZ59tihHDNDamczxFCRH8NHzT-eKaZ7xNyqVXW1Hw@mail.gmail.com>
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

On Sat, 8 Oct 2022 at 16:14, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 07/10/2022 16:37, Kees Cook wrote:
> > On Fri, Oct 07, 2022 at 10:47:01AM +0200, Ard Biesheuvel wrote:
> >> [...]
> >> Isn't this the stuff we want to move into the crypto API?
> >
> > It is, yes. Guilherme, for background:
> > https://lore.kernel.org/linux-crypto/20180802215118.17752-1-keescook@chromium.org/
> >
>
> Thanks a bunch Kees / Ard for pointing me that!
>
> But I'm confused with regards to the state of this conversion: the
> patches seem to be quite mature and work fine, but at the same time,
> they focus in what Herbert consider a deprecated/old API, so they were
> never merged right?
>
> The proposal from Ard (to move to crypto scomp/acomp) allow to rework
> the zbufsize worst case thing and wire it on such new API, correct? Do
> you intend to do that Kees?
>
> At the same time, I feel it is still valid to avoid these bunch of
> implicit conversions on pstore, as this patch proposes - what do you all
> think?
>
> I could rework this one on top of Ard's acomp migration while we don't
> have an official zbufsize API for on crypto scomp - and once we have,
> it'd be just a matter of removing the zbufsize functions of pstore and
> make use of the new API, which shouldn't be affected by this implicit
> conversion fix.
>

So one thing I don't understand about these changes is why we need
them in the first place.

The zbufsize routines are all worst case routines, which means each
one of those will return a value that exceeds the size parameter.

We only use compression for dmesg, which compresses quite well. If it
doesn't compress well, there is probably something wrong with the
input data, so preserving it may not be as critical. And if
compressing the data makes it bigger, can't we just omit the
compression for that particular record?

In summary, while adding zbufsize to the crypto API seems a reasonable
thing to do, I don't see why we'd want to make use of it in pstore -
can't we just use the decompressed size as the worst case compressed
size for all algorithms, and skip the compression if it doesn't fit?

Or am I missing something here?
