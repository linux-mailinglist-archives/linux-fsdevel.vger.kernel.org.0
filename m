Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130F43D186D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhGUUNz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 16:13:55 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44328 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhGUUNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:13:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4FA38606BA4F;
        Wed, 21 Jul 2021 22:54:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OeNpA8TbCsvM; Wed, 21 Jul 2021 22:54:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 88A0960A59D3;
        Wed, 21 Jul 2021 22:54:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JgBGLF30wa6X; Wed, 21 Jul 2021 22:54:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 55876606BA4F;
        Wed, 21 Jul 2021 22:54:28 +0200 (CEST)
Date:   Wed, 21 Jul 2021 22:54:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Message-ID: <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com> <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at> <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com> <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at> <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com> <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF90 (Linux)/8.8.12_GA_3809)
Thread-Topic: How to get actual image size from MTD partition
Thread-Index: BowgerheV9p1zguM4N2pUdD/cVsfMg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
>> But let me advertise ubiblock a second time.
> Sorry, I could not understand about the ubiblock request. Is it
> possible to elaborate little more ?
> We are already using squashfs on top of our UBI volumes (including
> rootfs mounting).
> This is the kernel command line we pass:
> rootfstype=squashfs root=/dev/mtdblock44 ubi.mtd=40,0,30
> And CONFIG_MTD_UBI_BLOCK=y is already enabled in our kernel.
> Do we need to do something different for ubiblock ?

From that command line I understand that you are *not* using squashfs on top of UBI.
You use mtdblock. ubiblock is a mechanism to turn an UBI volume into a read-only
block device.
See: http://www.linux-mtd.infradead.org/doc/ubi.html#L_ubiblock

>> If you place your squashfs on a UBI static volume, UBI knows the exact length
>> and you can checksum it
>> more easily.
> Yes, we use squashfs on UBI volumes, but our volume type is still dynamic.
> Also, you said, UBI knows the exact length, you mean the whole image length ?
> How can we get this length at runtime ?

You need a static volume for that. If you update a static volume the length is
known by UBI.

> Also, how can we get the checksum of the entire UBI volume content
> (ignoring the erased/empty/bad block content) ?

Just read from the volume. /dev/ubiX_Y.

> Or, you mean to say, the whole checksum logic is in-built inside the
> UBI layer and users don't need to worry about the integrity at all ?

Static volumes have a crc32 checksum over the whole content.
Of course this offers no cryptographic integrity.
See: http://www.linux-mtd.infradead.org/doc/ubi.html#L_overview

Thanks,
//richard
