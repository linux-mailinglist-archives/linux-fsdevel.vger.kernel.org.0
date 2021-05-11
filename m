Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6137B2D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 01:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEKX6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 19:58:31 -0400
Received: from sandeen.net ([63.231.237.45]:50760 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhEKX6a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 19:58:30 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 437FD479AE8;
        Tue, 11 May 2021 18:57:05 -0500 (CDT)
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        'Namjae Jeon' <linkinjeon@kernel.org>
Cc:     'linux-fsdevel' <linux-fsdevel@vger.kernel.org>,
        'Pavel Reichl' <preichl@redhat.com>,
        chritophe.vu-brugier@seagate.com,
        'Hyeoncheol Lee' <hyc.lee@gmail.com>
References: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
 <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
 <CGME20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2@epcas1p3.samsung.com>
 <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net>
 <001201d746c0$cc8da8e0$65a8faa0$@samsung.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: problem with exfat on 4k logical sector devices
Message-ID: <b3015dc1-07a9-0c14-857a-9562a9007fb6@sandeen.net>
Date:   Tue, 11 May 2021 18:57:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <001201d746c0$cc8da8e0$65a8faa0$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 6:53 PM, Namjae Jeon wrote:

>> One other thing that I ran across is that fsck seems to validate an image against the sector size of
>> the device hosting the image rather than the sector size found in the boot sector, which seems like
>> another issue that will come up:
>>
>> # fsck/fsck.exfat /dev/sdb
>> exfatprogs version : 1.1.1
>> /dev/sdb: clean. directories 1, files 0
>>
>> # dd if=/dev/sdb of=test.img
>> 524288+0 records in
>> 524288+0 records out
>> 268435456 bytes (268 MB) copied, 1.27619 s, 210 MB/s
>>
>> # fsck.exfat test.img
>> exfatprogs version : 1.1.1
>> checksum of boot region is not correct. 0, but expected 0x3ee721 boot region is corrupted. try to
>> restore the region from backup. Fix (y/N)? n
>>
>> Right now the utilities seem to assume that the device they're pointed at is always a block device,
>> and image files are problematic.
> Okay, Will fix it.

Right now I have a hack like this.

1) don't validate the in-image sector size against the host device size
(maybe should only skip this check if it's not a bdev? Or is it OK to have
a 4k sector size fs on a 512 device? Probably?)

2) populate the "bd" sector size information from the values read from the image.

It feels a bit messy, but it works so far. I guess the messiness stems from
assuming that we always have a "bd" block device.

-Eric

diff --git a/dump/dump.c b/dump/dump.c
index 85d5101..30ec8cb 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -100,6 +100,9 @@ static int exfat_show_ondisk_all_info(struct exfat_blk_dev *bd)
 		goto free_ppbr;
 	}
 
+	bd->sector_size_bits = pbsx->sect_size_bits;
+	bd->sector_size = 1 << pbsx->sect_size_bits;
+
 	if (pbsx->sect_per_clus_bits > 25 - pbsx->sect_size_bits) {
 		exfat_err("bogus sectors bits per cluster : %u\n",
 				pbsx->sect_per_clus_bits);
@@ -107,13 +110,6 @@ static int exfat_show_ondisk_all_info(struct exfat_blk_dev *bd)
 		goto free_ppbr;
 	}
 
-	if (bd->sector_size != 1 << pbsx->sect_size_bits) {
-		exfat_err("bogus sector size : %u (sector size bits : %u)\n",
-				bd->sector_size, pbsx->sect_size_bits);
-		ret = -EINVAL;
-		goto free_ppbr;
-	}
-
 	clu_offset = le32_to_cpu(pbsx->clu_offset);
 	total_clus = le32_to_cpu(pbsx->clu_count);
 	root_clu = le32_to_cpu(pbsx->root_cluster);
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 747a771..5ea8278 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -682,6 +682,9 @@ static int read_boot_region(struct exfat_blk_dev *bd, struct pbr **pbr,
 		goto err;
 	}
 
+	bd->sector_size_bits = bs->bsx.sect_size_bits;
+	bd->sector_size = 1 << bs->bsx.sect_size_bits;
+
 	ret = boot_region_checksum(bd, bs_offset);
 	if (ret < 0)
 		goto err;


