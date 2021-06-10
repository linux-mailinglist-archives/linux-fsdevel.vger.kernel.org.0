Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB7D3A2D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 15:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFJNyb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 09:54:31 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:52316 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhFJNyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:54:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 48A4C6108195;
        Thu, 10 Jun 2021 15:52:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mdb_2wIHQ5WY; Thu, 10 Jun 2021 15:52:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DB88961081AE;
        Thu, 10 Jun 2021 15:52:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZFDMESNVU0ar; Thu, 10 Jun 2021 15:52:32 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id B7A756108195;
        Thu, 10 Jun 2021 15:52:32 +0200 (CEST)
Date:   Thu, 10 Jun 2021 15:52:32 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Message-ID: <361047717.98543.1623333152629.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLhPiVgi5Q343VP-p7vwBtA1-A5jt8Ow4_2eF4ZwsiA+eQ@mail.gmail.com>
References: <CAOuPNLiRDZ9M4n3uh=i6FpHXoVEWMHpt0At8YaydrOM=LvSvdg@mail.gmail.com> <295072107.94766.1623262940865.JavaMail.zimbra@nod.at> <CAOuPNLhPiVgi5Q343VP-p7vwBtA1-A5jt8Ow4_2eF4ZwsiA+eQ@mail.gmail.com>
Subject: Re: qemu: arm: mounting ubifs using nandsim on busybox
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: qemu: arm: mounting ubifs using nandsim on busybox
Thread-Index: FCBZQEPb3fuCAU5mJvWAQ23NQZd17Q==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pintu,

----- Ursprüngliche Mail -----
> Von: "Pintu Agarwal" <pintu.ping@gmail.com>
>> nandsim works as expected. It creates a new and *erased* NAND for you.
>> So you have no UBI volumes. Therfore UBIFS cannot be mounted.
>> I suggest creating a tiny initramfs that creates UBI volumes before mounting
>> UBIFS on
>> one of the freshly created (and empty) volumes.
>>
> oh sorry I forgot to mention this.
> I am able to create and update volumes manually after booting the
> system with initramfs.
> {{{
> Creating rootfs volume:
> mknod /dev/ubi0 c 250 0
> mknod /dev/ubi0_0 c 250 1
> ubiattach /dev/ubi_ctrl -m 2
> ubimkvol /dev/ubi0 -N rootfs -m
> ubiupdatevol /dev/ubi0_0 ubifs-rootfs.img
> mount -t ubifs ubi0:rootfs ubi-root/
> }}}
> 
> But I wanted to do all these automatically during boot time itself.
> Also I wanted to use ubinize.cfg as is from the original system and
> simulate everything using qemu and nadsim (if possible)
> So I thought it must be possible by setting some parameters in qemu such as:
> mtdparts=nand:,
> -device nand,chip_id=0x39,drive=mtd0,
> -drive if=mtd,file=./ubi-boot.img,id=mtd0,
> anything else ?

Well, this has nothing to do with nandsim.
If qemu can emulate a NAND chip (plus a controller) all you need is a driver on the Linux side.

Thanks,
//richrd
