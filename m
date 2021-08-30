Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ECF3FBCC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 21:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhH3TN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 15:13:26 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:20359 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhH3TNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:13:24 -0400
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DA682240003;
        Mon, 30 Aug 2021 19:12:25 +0000 (UTC)
Date:   Mon, 30 Aug 2021 21:12:24 +0200
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
Message-ID: <20210830211224.76391708@windsurf>
In-Reply-To: <CAOuPNLhTidgLNWUbtUgdESYcKcE1C4SOdzKeQVhFGQvEoc0QEg@mail.gmail.com>
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
        <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
        <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
        <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
        <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
        <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
        <20210830185541.715f6a39@windsurf>
        <CAOuPNLhTidgLNWUbtUgdESYcKcE1C4SOdzKeQVhFGQvEoc0QEg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, 30 Aug 2021 23:48:40 +0530
Pintu Agarwal <pintu.ping@gmail.com> wrote:

> ohh that means we already have a working reference.
> If possible can you share the details, even 4.19 or higher will be
> also a good reference.
> 
> > > Or, another option is to use the new concept from 5.1 kernel that is:
> > > dm-mod.create = ?  
> > How are you doing it today without dm-mod.create ?  
> I think in 4.14 we don't have dm-mod.create right ?

No, but you can backport it easily. Back at
http://lists.infradead.org/pipermail/openwrt-devel/2019-November/025967.html
I provided backports of this feature to OpenWrt, for the 4.14 and 4.19
kernels.

> Here is our kernel command line:
> 
> [    0.000000] Kernel command line: ro rootwait
> console=ttyMSM0,115200,n8 ....  verity="95384 11923
> 16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3 12026
> " rootfstype=squashfs ubi.mtd=40,0,30 ubi.block=0,0 root=/dev/dm-0
> .... init=/sbin/init root=/dev/dm-0 dm="rootfs none ro,0 95384 verity
> 1 /dev/ubiblock0_0 /dev/mtdblock53 4096 4096 11923 8 sha256
> 16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3
> aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
> restart_on_corruption ignore_zero_blocks use_fec_from_device
> /dev/mtdblock53 fec_roots 2 fec_blocks 12026 fec_start 12026" ...

I don't see how this can work without the dm-mod.create feature. Are
you sure the verity= and dm= kernel arguments exist?

Best regards,

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
