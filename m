Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56AE3FBA73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhH3Q5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 12:57:01 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:37631 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhH3Q5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:57:01 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 3C85AC655E;
        Mon, 30 Aug 2021 16:56:06 +0000 (UTC)
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A31E1FF809;
        Mon, 30 Aug 2021 16:55:42 +0000 (UTC)
Date:   Mon, 30 Aug 2021 18:55:41 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, Sami Tolvanen <samitolvanen@google.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting
 issue
Message-ID: <20210830185541.715f6a39@windsurf>
In-Reply-To: <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
        <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
        <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
        <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
        <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
        <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, 30 Aug 2021 21:55:19 +0530
Pintu Agarwal <pintu.ping@gmail.com> wrote:

> Sorry for coming back to this again..
> Unfortunately, none of the options is working for us with squashfs
> (bootloader, initramfs).
> initramfs have different kinds of challenges because of the partition
> size issue.
> So, our preferred option is still the bootloader command line approach..
> 
> Is there a proven and working solution of dm-verity with squashfs ?
> If yes, please share some references.
> 
> The current problem with squashfs is that we could not append the
> verity-metadata to squashfs, so we store it on a separate volume and
> access it.

Here, it definitely worked to append the hash tree to the squashfs
image and store them in the same partition.

> By specifying it like : /dev/mtdblock53
> 
> Then we get the error like this:
> {
> [    4.950276] device-mapper: init: attempting early device configuration.
> [    4.957577] device-mapper: init: adding target '0 95384 verity 1
> /dev/ubiblock0_0 /dev/mtdblock53 4096 4096 11923 8 sha256
> 16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3
> aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
> restart_on_corruption ignore_zero_blocks use_fec_from_device
> /dev/mtdblock53 fec_roots 2 fec_blocks 12026 fec_start 12026'
> [    4.975283] device-mapper: verity: sha256 using implementation
> "sha256-generic"
> [    4.998728] device-mapper: init: dm-0 is ready

Could you show the full kernel command line ?

> Do you see any other problem here with dm-verity cmdline or with squashfs ?
> 
> Is squashfs ever proved to be working with dm-verity on higher kernel version ?
> Currently our kernel version is 4.14.

I confirm we used squashfs on dm-verity successfully. For sure on 4.19,
perhaps on older kernels as well.

> Or, another option is to use the new concept from 5.1 kernel that is:
> dm-mod.create = ?

How are you doing it today without dm-mod.create ?

Again, please give your complete kernel command line.

Best regards,

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
