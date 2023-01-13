Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9F66A4BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 22:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjAMVGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 16:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjAMVGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:06:07 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7941A7E;
        Fri, 13 Jan 2023 13:06:05 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pGRFJ-003iiV-Uf; Fri, 13 Jan 2023 22:05:53 +0100
Received: from dynamic-078-054-173-160.78.54.pool.telefonica.de ([78.54.173.160] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pGRFJ-000YOn-O5; Fri, 13 Jan 2023 22:05:53 +0100
Message-ID: <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
Date:   Fri, 13 Jan 2023 22:05:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
In-Reply-To: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
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
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 78.54.173.160
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ard!

> Can I take that as an ack on [0]? The EFI subsystem has evolved
> substantially over the years, and there is really no way to do any
> IA64 testing beyond build testing, so from that perspective, dropping
> it entirely would be welcomed.

ia64 is regularly tested in Debian and Gentoo [1][2].

Debian's ia64 porterbox yttrium runs a recent kernel without issues:

root@yttrium:~# uname -a
Linux yttrium 5.19.0-2-mckinley #1 SMP Debian 5.19.11-1 (2022-09-24) ia64 GNU/Linux
root@yttrium:~#

root@yttrium:~# journalctl -b|head -n10
Nov 14 14:46:10 yttrium kernel: Linux version 5.19.0-2-mckinley (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-6) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP Debian 5.19.11-1 (2022-09-24)
Nov 14 14:46:10 yttrium kernel: efi: EFI v2.10 by HP
Nov 14 14:46:10 yttrium kernel: efi: SALsystab=0xdfdd63a18 ESI=0xdfdd63f18 ACPI 2.0=0x3d3c4014 HCDP=0xdffff8798 SMBIOS=0x3d368000
Nov 14 14:46:10 yttrium kernel: PCDP: v3 at 0xdffff8798
Nov 14 14:46:10 yttrium kernel: earlycon: uart8250 at I/O port 0x4000 (options '115200n8')
Nov 14 14:46:10 yttrium kernel: printk: bootconsole [uart8250] enabled
Nov 14 14:46:10 yttrium kernel: ACPI: Early table checksum verification disabled
Nov 14 14:46:10 yttrium kernel: ACPI: RSDP 0x000000003D3C4014 000024 (v02 HP    )
Nov 14 14:46:10 yttrium kernel: ACPI: XSDT 0x000000003D3C4580 000124 (v01 HP     RX2800-2 00000001      01000013)
Nov 14 14:46:10 yttrium kernel: ACPI: FACP 0x000000003D3BE000 0000F4 (v03 HP     RX2800-2 00000001 HP   00000001)
root@yttrium:~#

Same applies to the buildds:

root@lifshitz:~# uname -a
Linux lifshitz 6.0.0-4-mckinley #1 SMP Debian 6.0.8-1 (2022-11-11) ia64 GNU/Linux
root@lifshitz:~#

root@lenz:~# uname -a
Linux lenz 6.0.0-4-mckinley #1 SMP Debian 6.0.8-1 (2022-11-11) ia64 GNU/Linux
root@lenz:~#

EFI works fine as well using the latest version of GRUB2.

Thanks,
Adrian

> [1] https://cdimage.debian.org/cdimage/ports/snapshots/
> [2] https://mirror.yandex.ru/gentoo-distfiles//releases/ia64/autobuilds/
