Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B295764364
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjG0B0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 21:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjG0B0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDE196;
        Wed, 26 Jul 2023 18:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC2061CED;
        Thu, 27 Jul 2023 01:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0239C433C8;
        Thu, 27 Jul 2023 01:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690421173;
        bh=if7mzj0ehLrHlgt0FgMdKCzlq6hqghMUjN16hVUhVM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ar7csIzQfRs9zXZqq0NCp1cuwNpYNmhrdE2AH8tqnXWLoyvzcFgU0qHMhiKQYpHa+
         +CaOIRsVu46Sb2dLfYX9TXHvAo/e2MXs3LAEkUmKVsdnSBOYCRtjxE/FGjVXtr10Tf
         6creTx5kKdaOSgCq2IPka5Hsq1+vks0wibV+Unyi5dkYIbkcIdPHbscqbaQBCnvhc5
         1E/LgntaOerIjuPPwkuOoOjRPONuTJk4031afPIY/2vSml+7LB2txsRVN614k9AfZl
         wCzentE2XxjsemndmXKVrkx9BqjIpiQ7aHjl2J7V1wkgklxbqfg0gvPOcHrMvEv8uQ
         ESvg3+eRgw/QQ==
Date:   Wed, 26 Jul 2023 18:26:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] fstests: add helper to canonicalize devices used to
 enable persistent disks
Message-ID: <20230727012613.GD11377@frogsfrogsfrogs>
References: <20230720061727.2363548-1-mcgrof@kernel.org>
 <20230725081307.xydlwjdl4lq3ts3m@zlang-mailbox>
 <20230725155439.GF11340@frogsfrogsfrogs>
 <20230726044132.GA30264@mit.edu>
 <ZMFJp5OZN3vnT/yI@bombadil.infradead.org>
 <20230727011330.GE30264@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727011330.GE30264@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:13:30PM -0400, Theodore Ts'o wrote:
> On Wed, Jul 26, 2023 at 09:28:23AM -0700, Luis Chamberlain wrote:
> > > I'm a little confused.  Where are these "sanity checks" enforced?
> > > I've been using
> > > 
> > > SCRATCH_DEV=/dev/mapper/xt-vdc
> > > 
> > > where /dev/mapper/xt-vdc is a symlink to /dev/dm-4 (or some such)
> > > without any problems.  So I don't quite understand why we need to
> > > canonicalize devices?
> > 
> > That might work, but try using /dev/disk/by-id/ stuff, that'll bust. So
> > to keep existing expecations by fstests, it's needed.
> 
> What goes wrong, and why?  /dev/disk/by-id/<disk-id> is a symlink,
> just like /dev/mapper/<vg>-<lv> is a symlink.
> 
> What am I missing?

# mkfs.xfs -f /dev/sda
# mount /dev/sda /mnt
# TEST_DIR=/mnt TEST_DEV=/dev/sda FSTYP=xfs ./check generic/110
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 flax-mtr01 6.5.0-rc3-djwx #rc3 SMP PREEMPT_DYNAMIC Wed Jul 26 14:26:48 PDT 2023

generic/110        2s
Ran: generic/110
Passed all 1 tests

versus:

# TEST_DIR=/mnt TEST_DEV=/dev/disk/by-id/scsi-0QEMU_RAMDISK_drive-scsi0-0-0-0 FSTYP=xfs ./check generic/110
mount: /mnt: /dev/sda already mounted on /mnt.
common/rc: retrying test device mount with external set
mount: /mnt: /dev/sda already mounted on /mnt.
common/rc: could not mount /dev/disk/by-id/scsi-0QEMU_RAMDISK_drive-scsi0-0-0-0 on /mnt
# umount /mnt
# TEST_DIR=/mnt TEST_DEV=/dev/disk/by-id/scsi-0QEMU_RAMDISK_drive-scsi0-0-0-0 FSTYP=xfs ./check generic/110
TEST_DEV=/dev/disk/by-id/scsi-0QEMU_RAMDISK_drive-scsi0-0-0-0 is mounted but not on TEST_DIR=/mnt - aborting
Already mounted result:
/dev/sda /mnt

(This is not really how I run fstests, it's just the minimum example.)

--D

> Thanks,
> 
> 						- Ted
> 
