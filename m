Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B54750A3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGLN7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGLN7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:59:52 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653C10C7;
        Wed, 12 Jul 2023 06:59:51 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-796d78b3f68so2290875241.0;
        Wed, 12 Jul 2023 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689170390; x=1691762390;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=la7xD6v4M8WAlisTF+ijLkx9gxv01PJflmUjfs8N44g=;
        b=hkoJF0iT6tOtmhignEwpFUrvcXpQp1ZyK84MCiIoBdRwnVbfaHNecu4NOA0STWpU1x
         w+w7h3/jaODj4pP/JiS5oJgfcAoQoqLfmJ6PpI9inys63dr1nJLaZR5hT28K7/Ppaje+
         pWHa7VmkmCAIch7XAScY1HBcY8jGCanzoQqejRDuL92noz5pw8zEJlfIGDOzQBH9iNTy
         jTlfbnfnztn086ToOzEBcEcInVXsuXmyMckjdLslg2ao/BAhf+UP34oi/vYhwNQ/nKyc
         2AsVP107fqXnuqVem9M8R6SfUhomZhMbImcEz2w/HedgT1HHMWzURVQPIqotU30Ap6Fv
         1s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170390; x=1691762390;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=la7xD6v4M8WAlisTF+ijLkx9gxv01PJflmUjfs8N44g=;
        b=Ze0Txo4aWy7gc25Yl8CJVRMBAZu/n4wkz9vq8apfDAMkHE7wTrfqU0mtUA5OMFrbW4
         A71cXfEXHyjNyhmLiiJrEFmGvsK9ptAoaJGcl7ah9bj0Mw94sQEBpqVuO26gjPyMvLbA
         GVSseLZcoPKuO5OlvamiKPSNJ69/VHZ6Tji34sHr3KbGzKnDNBz/Jen1V9w3t4CA+Qdy
         345CMILH5keZbaLQ67L1QHNZUlO4CxiGta3dSv8Pg0yu8qA69eop8Wq5cqyzwn3pM/Ds
         trDDIPb/PDmAS3TpP42LqzQMr3H1XcZZAvB+L3iVwuuxd9S3QBwY9vB0eyEOgPnvR5+N
         DlyA==
X-Gm-Message-State: ABy/qLb/W1y4A0RAYwCmtLhRJQsTjcbbS8TKaq1GSebKnlaN5lO9tCmU
        ryFJRApsy8WsFCGOwV8ong81pp3sZMmCNIsV8KfS8mc+ndNitA==
X-Google-Smtp-Source: APBJJlGHb8UgulGcSBJwSnFIW+aaN70f7DUA4/cb5cVFlzfQncuxlS8VeWHSjG/YwqF+isRC3pXWJkI44UVXWoEWq/Q=
X-Received: by 2002:a67:eb15:0:b0:443:4302:b24b with SMTP id
 a21-20020a67eb15000000b004434302b24bmr8424550vso.11.1689170390207; Wed, 12
 Jul 2023 06:59:50 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 12 Jul 2023 19:29:39 +0530
Message-ID: <CAOuPNLizjBp_8ceKq=RLznXdsHD-+N55RoPh_D7_Mpkg7M-BwQ@mail.gmail.com>
Subject: MTD: Lots of mtdblock warnings on bootup logs
To:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel@kvack.org, ezequiel@collabora.com,
        Miquel Raynal <miquel.raynal@bootlin.com>, bjorn@mork.no
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We are getting below warning messages in dmesg logs on a NAND device
for every raw partition.
Kernel: 5.15 ; arm64 ; NAND + ubi + squashfs
We have some RAW partitions and one UBI partition (with ubifs/squashfs volumes).

We are seeing large numbers of these logs on the serial console that
impact the boot time.
[....]
[    9.667240][    T9] Creating 58 MTD partitions on "1c98000.nand":
[....]
[   39.975707][  T519] mtdblock: MTD device 'uefi_a' is NAND, please
consider using UBI block devices instead.
[   39.975707][  T519] mtdblock: MTD device 'uefi_b' is NAND, please
consider using UBI block devices instead.
[....]

This was added as part of this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/mtd/mtdblock.c?h=v5.15.120&id=f41c9418c5898c01634675150696da290fb86796
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/mtd/mtdblock.c?h=v5.15.120&id=e07403a8c6be01857ff75060b2df9a1aa8320fe5

I think this warning was decided after my last year's discussion about
mtdblock vs ubiblock for squashfs.

But these are raw NAND partitions and not mounted by us.

What is the exact meaning of these warnings ?

We have both these configs enabled:
CONFIG_MTD_BLOCK=y
CONFIG_MTD_UBI_BLOCK=y

Through this warning, are we telling that only one of the above config
should be enabled ?
And the recommendation is to use ubi_block and disable mtd_block ?

We are already using ubiblock for mounting squashfs volumes.
But how to get rid of these warnings for raw NAND partitions ?

Is there a way to avoid or we are missing something which we are not aware of?


Thanks,
Pintu
