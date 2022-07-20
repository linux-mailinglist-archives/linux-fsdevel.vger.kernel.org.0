Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359F057B90E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbiGTO76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbiGTO75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:59:57 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B3A4A803;
        Wed, 20 Jul 2022 07:59:55 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KExZO2028200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 10:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658329179; bh=KSF83lZstAmug43iApgGVeq7jZsMA5ODUbTwisdWS1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EqRi8euWulOKBYECG8A1yV5X5wm+s9ddKTdIxifNznnXsgFuFWCRh5ve/hg8gKkxb
         lBRJGMfrm5t9JwaYSPniCyZTEygUk78LZIbC6XPrU1eiHPUySs5yOgX6xPnTbfrpK4
         XsWo8/re4y8ml01JfbAUr0tChzbaxfBlKLaUsSxbnzFqYXbV08P8kVW63UMYJHMdW1
         a324AKUNC4mO4aGjoDgu56RMpb9Xy+W9IDxZsVEGtTo8TT63w+HveeJlmEHLJ4Eqtk
         uWoilYdpNcKbg12gGimO4qejrk3XPFIQrL8f2K9903O9IVgO9HF7l2R6uAhHJQiYqe
         /yA/8K9KTsGNg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BC8F815C3EBF; Wed, 20 Jul 2022 10:59:35 -0400 (EDT)
Date:   Wed, 20 Jul 2022 10:59:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YtgYV8dR/OoKKN/s@mit.edu>
References: <20220719234131.235187-1-bongiojp@gmail.com>
 <Ytd0G0glVWdv+iaD@casper.infradead.org>
 <Ytd28d36kwdYWkVZ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytd28d36kwdYWkVZ@magnolia>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 08:30:57PM -0700, Darrick J. Wong wrote:
> 
> @len because some filesystems like vfat have volume identifiers that
> aren't actually UUIDs (they're u32)...

It's not just vfat.  Ntfs uses a 64-bit volume identifier, and we
still see both vfat and ntfs on modern-day laptops.  For example, on
my Samsung Galaxy Pro 360, purchased earlier this year and which uses
Secure UEFI boot to dual boot Windows and Debian Linux:

% sudo blkid
/dev/nvme0n1p7: UUID="915eb577-a05d-48ba-ad66-346e14908d19" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="3194abab-3fe6-4b59-960f-95806d27b1cd"
/dev/nvme0n1p5: LABEL="SAMSUNG_REC" UUID="0A64-BC1B" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="Basi" PARTUUID="441e92c9-d55b-40ec-4173-636c65706975"
/dev/nvme0n1p3: LABEL="Windows RE tools" BLOCK_SIZE="512" UUID="F49088359087FC7C" TYPE="ntfs" PARTLABEL="M-fM-%M-^WM-fM-^QM-.M-gM-^]M-/M-bM-^AM-3" PARTUUID="0cc7d7ec-6481-40b9-bf23-83b889f020e2"
/dev/nvme0n1p1: LABEL_FATBOOT="SYSTEM" LABEL="SYSTEM" UUID="345B-0F8C" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="EFI" PARTUUID="13bbf92c-8e02-41fb-93a4-9c4c8328d08a"
/dev/nvme0n1p8: UUID="929a1920-e84c-4797-98b1-2d719e64388f" TYPE="swap" PARTUUID="8d2aad9d-f7a9-47a1-8729-9de367d44696"
/dev/nvme0n1p6: BLOCK_SIZE="512" UUID="82A25B9DA25B950F" TYPE="ntfs" PARTUUID="89bfd94a-3c21-44df-9d6e-c2e66ae1a3ec"
/dev/nvme0n1p4: LABEL="SAMSUNG_REC2" BLOCK_SIZE="512" UUID="A24E62F14E62BDA3" TYPE="ntfs" PARTLABEL="M-fM-^UM-^RM-fM-=M-#M-fM-^UM-6M-gM-%M-2" PARTUUID="9cd299e0-4454-430a-9e96-54ccbf250ff8"

Also note that for better or worse, historically blkid has always
treeated the VFAT and NTFS volume id's as "UUID's", since they serve
the same purpose as UUID's on ext2/ext4/xfs file systems, and so
people may very well have /etc/fstab files which specify a volume by
their UUID:

# /boot/efi was on /dev/nvme0n1p1 during installation
UUID=345B-0F8C  /boot/efi       vfat    umask=0077      0       1

Perhaps a purist would have insisted that we have used "FSVOLID"
instead of "UUID" in blkid almost 20 years ago, in which case perhaps
these ioctl's would have been named FS_IOC_[GS]ETFSVOLID.  But at this
point, it's clearer if we stick with FS_IOC_GETUUID than to try to
introduce change the naming scheme at this point.

					- Ted
