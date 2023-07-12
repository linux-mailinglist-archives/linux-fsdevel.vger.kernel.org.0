Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335B5750AB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGLOWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 10:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGLOWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:22:20 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD615E70;
        Wed, 12 Jul 2023 07:22:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4370EC0004;
        Wed, 12 Jul 2023 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9jnw+toN9EeY6OX+EqtUPKBA1qAOSWPjY0T6FQGzUo=;
        b=Sml7oRqc9FZlkoUmkEJGPnsbtSld3wIs8bdyNwNO3A/p6Zm7gkJBa7lHYIzKDTXSzcAARU
        ezXwOKvNUdJ2OsegmyMWUq5uQJp/8JNcPfa2C0a6EWyLPOgAqRZcoHLifgKaQKmP1kPTiR
        A8TcFoz8RlLmzNWYSZdy2odLYy3wOU9WAFZli+wv9NpuZlXnVQjg0Xtgn+Xc1gheECOSwq
        4lytmkfg1bNObDxe0OmV7z2koGH5cgQlQu+wvmetH5o9t8Gl7mTi2Zdug3fdTPVUGfheTq
        Om2IKD9N1Q2cyqygFCsCeQtmnVXY4SnXgF7nWDxctmesF5T+Lh/maatPyz5j8g==
Date:   Wed, 12 Jul 2023 16:22:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel@kvack.org, ezequiel@collabora.com, bjorn@mork.no
Subject: Re: MTD: Lots of mtdblock warnings on bootup logs
Message-ID: <20230712162213.79bc889c@xps-13>
In-Reply-To: <CAOuPNLizjBp_8ceKq=RLznXdsHD-+N55RoPh_D7_Mpkg7M-BwQ@mail.gmail.com>
References: <CAOuPNLizjBp_8ceKq=RLznXdsHD-+N55RoPh_D7_Mpkg7M-BwQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pintu,

pintu.ping@gmail.com wrote on Wed, 12 Jul 2023 19:29:39 +0530:

> Hi,
>=20
> We are getting below warning messages in dmesg logs on a NAND device
> for every raw partition.
> Kernel: 5.15 ; arm64 ; NAND + ubi + squashfs
> We have some RAW partitions and one UBI partition (with ubifs/squashfs vo=
lumes).
>=20
> We are seeing large numbers of these logs on the serial console that
> impact the boot time.
> [....]
> [    9.667240][    T9] Creating 58 MTD partitions on "1c98000.nand":
> [....]
> [   39.975707][  T519] mtdblock: MTD device 'uefi_a' is NAND, please
> consider using UBI block devices instead.
> [   39.975707][  T519] mtdblock: MTD device 'uefi_b' is NAND, please
> consider using UBI block devices instead.
> [....]
>=20
> This was added as part of this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/mtd/mtdblock.c?h=3Dv5.15.120&id=3Df41c9418c5898c01634675150696da290f=
b86796
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/mtd/mtdblock.c?h=3Dv5.15.120&id=3De07403a8c6be01857ff75060b2df9a1aa8=
320fe5
>=20
> I think this warning was decided after my last year's discussion about
> mtdblock vs ubiblock for squashfs.
>=20
> But these are raw NAND partitions and not mounted by us.
>=20
> What is the exact meaning of these warnings ?

mtdblock is legacy, ubiblock is better (on NAND devices).

> We have both these configs enabled:
> CONFIG_MTD_BLOCK=3Dy
> CONFIG_MTD_UBI_BLOCK=3Dy
>=20
> Through this warning, are we telling that only one of the above config
> should be enabled ?

If you don't need both, then yes.

> And the recommendation is to use ubi_block and disable mtd_block ?

Yes.

> We are already using ubiblock for mounting squashfs volumes.
> But how to get rid of these warnings for raw NAND partitions ?
>=20
> Is there a way to avoid or we are missing something which we are not awar=
e of?
>=20

In theory the warning should only appear if you open the device (IOW,
only if you use it). For this to happen, you need:
96a3295c351d ("mtdblock: warn if opened on NAND")
This commit was maybe not backported to stable kernels, you can send it
to stable@vger.kernel.org in order to ask for that. I also see that the
mtdblock_ro path was not corrected, maybe that's also a problem in your
case? Same, you can adapt the above patch and send it upstream.

Thanks,
Miqu=C3=A8l
