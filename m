Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A05F7A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJGPHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 11:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJGPG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AF1102500;
        Fri,  7 Oct 2022 08:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B8561CEB;
        Fri,  7 Oct 2022 15:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDA1C433D7;
        Fri,  7 Oct 2022 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665155217;
        bh=IN+0DhFSUK/4ORNgGRuJj2lCVEnl1xihbqgCujXi5G4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pC4QCIoQ+N6IKtk4PcB3/Kk7lzz/cRkmUPon0xWkVlXw17+EowJJtuXUUYQTk+aDC
         fC+WqtLKd/bG9Cy+UUJSEyKisKFQtPSD0NTEDBYYVHqujccGYLHtVZHTM+LF4ZN7Cs
         XnLu0czD8+Y/XnippbHhr5u8b80eTYkCElbUGWGM09hwlg0c97VAlZxHv5QKh17c9O
         1H5aIJ7G+TgL+5aFYrjY7vBetQeM+0iQ/1+HxIq0mKCSGIvoGCtZDuJZCAw5CgZoYI
         HQwJNJpbD0l0f+/UAo7LTAZV1KS7qljNb+AaFNHpDhvhYATW0YUnHI/W9+AHYpL1T1
         jWoAKsOc4Z2XQ==
Received: by mail-lf1-f48.google.com with SMTP id r14so7733856lfm.2;
        Fri, 07 Oct 2022 08:06:57 -0700 (PDT)
X-Gm-Message-State: ACrzQf1cyT7I4gzqP0U2Ky4GMyqoZGp6ykiyAmRcKQ6Z1chjXD2MjCe+
        bnV3slCWPpBndHhIeTfbVqpamta7uRgO6gOwPso=
X-Google-Smtp-Source: AMsMyM7tD3oOF++5UtXKt3rRY/6vcQkaJ6df4pftKRuh41V23hdLuIH9MNAK/WNLzPrW3/DPzpOV1TNLrc4nluEzUBY=
X-Received: by 2002:a19:c20b:0:b0:4a2:40e5:78b1 with SMTP id
 l11-20020a19c20b000000b004a240e578b1mr2034056lfc.228.1665155215821; Fri, 07
 Oct 2022 08:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-9-gpiccoli@igalia.com>
 <202210061614.8AA746094A@keescook> <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
 <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com> <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com>
 <2a341c4d-763e-cfa4-0537-93451d8614fa@igalia.com>
In-Reply-To: <2a341c4d-763e-cfa4-0537-93451d8614fa@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 7 Oct 2022 17:06:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE6aObn7hGneGMMiJ-ss7YaiYDFL+HqktYt2WMUpZnFjQ@mail.gmail.com>
Message-ID: <CAMj1kXE6aObn7hGneGMMiJ-ss7YaiYDFL+HqktYt2WMUpZnFjQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] efi: pstore: Add module parameter for setting the
 record size
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Oct 2022 at 15:46, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 07/10/2022 10:19, Ard Biesheuvel wrote:
> > [...]
> >
> > OVMF has
> >
> > OvmfPkg/OvmfPkgX64.dsc:
> > gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000
> > OvmfPkg/OvmfPkgX64.dsc:
> > gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x8400
> >
> > where the first one is without secure boot and the second with secure boot.
> >
> > Interestingly, the default is
> >
> > gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x400
> >
> > so this is probably where this 1k number comes from. So perhaps it is
> > better to leave it at 1k after all :-(
> >
>
> Oh darn...
>
> So, let's stick with 1024 then? If so, no need for re-submitting right?

Well, I did spot this oddity

        efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
        if (!efi_pstore_info.buf)
                return -ENOMEM;

       efi_pstore_info.bufsize = 1024;

So that hardcoded 4096 looks odd, but at least it is larger than the
default 1024. So what happens if you increase the record size to >
4096?
