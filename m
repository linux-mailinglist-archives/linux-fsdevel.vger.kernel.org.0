Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7966A703
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 00:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAMXZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 18:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjAMXZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:25:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D7C6719A;
        Fri, 13 Jan 2023 15:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62707B82278;
        Fri, 13 Jan 2023 23:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE949C43392;
        Fri, 13 Jan 2023 23:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673652338;
        bh=qVbsd05KHLBi1A1+RbPFk566wcNZkDulba+8c+3hkj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lkqvn5tWFHlQ1g1zeASqiqPqpVLLfb7NI47LYm8e0HaA97hOuaTrQHMdecL65a5nu
         kz/sbvYcMIUEDXHsSCpRRK8wnno16ARVe2DLHhidqVu0ScSl6AskyZaOYxj9ODjOwP
         UyoK2ydCSoA8eUdS1/O7BT3GUQ3wGrc/9ptKJscR6XnE4tveeHwlpGO+XVD/8xVcjU
         eeICahu97ChW949649TXRwc0WN7arLTxyEScTAABdzso9BUtaP7FrDOPArjqOu1srN
         Bk9jw/n0tTz02C/X4+0KOv0LM0yyrOlZfu02uwbIFtUMw3G6gy6/Hq9YBVpkVrcGGS
         WtG9wdpYuWZLA==
Received: by mail-lf1-f42.google.com with SMTP id j17so35208817lfr.3;
        Fri, 13 Jan 2023 15:25:38 -0800 (PST)
X-Gm-Message-State: AFqh2krvOUYQ3n2xkLDv2aA44HacwH7cTCSqR9Mxe5673phNOAxri5KP
        8DvwGn4OTb/0L3nhln3N7y2WL+A5XW363ILu+WA=
X-Google-Smtp-Source: AMrXdXsiVcvp4M0sdC7uvlVrEchvlWch7gsiC5oLxJ7MUg+sdhbvU1pVuoSujQ7D12h8RonWIO1ypm2Vdq0KlsYUOC4=
X-Received: by 2002:a05:6512:3d93:b0:4b8:9001:a694 with SMTP id
 k19-20020a0565123d9300b004b89001a694mr3999732lfv.426.1673652336888; Fri, 13
 Jan 2023 15:25:36 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
In-Reply-To: <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 14 Jan 2023 00:25:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com>
Message-ID: <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com>
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs cpu_relax)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 13 Jan 2023 at 22:06, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hello Ard!
>
> > Can I take that as an ack on [0]? The EFI subsystem has evolved
> > substantially over the years, and there is really no way to do any
> > IA64 testing beyond build testing, so from that perspective, dropping
> > it entirely would be welcomed.
>
> ia64 is regularly tested in Debian and Gentoo [1][2].
>
> Debian's ia64 porterbox yttrium runs a recent kernel without issues:
>
> root@yttrium:~# uname -a
> Linux yttrium 5.19.0-2-mckinley #1 SMP Debian 5.19.11-1 (2022-09-24) ia64 GNU/Linux
> root@yttrium:~#
>
> root@yttrium:~# journalctl -b|head -n10
> Nov 14 14:46:10 yttrium kernel: Linux version 5.19.0-2-mckinley (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-6) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP Debian 5.19.11-1 (2022-09-24)
> Nov 14 14:46:10 yttrium kernel: efi: EFI v2.10 by HP
> Nov 14 14:46:10 yttrium kernel: efi: SALsystab=0xdfdd63a18 ESI=0xdfdd63f18 ACPI 2.0=0x3d3c4014 HCDP=0xdffff8798 SMBIOS=0x3d368000
> Nov 14 14:46:10 yttrium kernel: PCDP: v3 at 0xdffff8798
> Nov 14 14:46:10 yttrium kernel: earlycon: uart8250 at I/O port 0x4000 (options '115200n8')
> Nov 14 14:46:10 yttrium kernel: printk: bootconsole [uart8250] enabled
> Nov 14 14:46:10 yttrium kernel: ACPI: Early table checksum verification disabled
> Nov 14 14:46:10 yttrium kernel: ACPI: RSDP 0x000000003D3C4014 000024 (v02 HP    )
> Nov 14 14:46:10 yttrium kernel: ACPI: XSDT 0x000000003D3C4580 000124 (v01 HP     RX2800-2 00000001      01000013)
> Nov 14 14:46:10 yttrium kernel: ACPI: FACP 0x000000003D3BE000 0000F4 (v03 HP     RX2800-2 00000001 HP   00000001)
> root@yttrium:~#
>
> Same applies to the buildds:
>
> root@lifshitz:~# uname -a
> Linux lifshitz 6.0.0-4-mckinley #1 SMP Debian 6.0.8-1 (2022-11-11) ia64 GNU/Linux
> root@lifshitz:~#
>
> root@lenz:~# uname -a
> Linux lenz 6.0.0-4-mckinley #1 SMP Debian 6.0.8-1 (2022-11-11) ia64 GNU/Linux
> root@lenz:~#
>
> EFI works fine as well using the latest version of GRUB2.
>
> Thanks,
> Adrian
>
> > [1] https://cdimage.debian.org/cdimage/ports/snapshots/
> > [2] https://mirror.yandex.ru/gentoo-distfiles//releases/ia64/autobuilds/

Thanks for reporting back. I (mis)read the debian ports page [3],
which mentions Debian 7 as the highest Debian version that supports
IA64, and so I assumed that support had been dropped from Debian.

However, if only a handful of people want to keep this port alive for
reasons of nostalgia, it is obviously obsolete, and we should ask
ourselves whether it is reasonable to expect Linux contributors to
keep spending time on this.

Does the Debian ia64 port have any users? Or is the system that builds
the packages the only one that consumes them?


[3] https://www.debian.org/ports/ia64/
