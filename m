Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8B116CDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 13:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfLIMHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 07:07:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44280 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIMHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:07:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so15266144lji.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 04:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUMXKfJVPrK1wZS1yT34IzDVyZ77NOt+yOK4qyUPbQ8=;
        b=my/1cWAmp1UyLQdmThCwkOdpv58xfPWNzFI6iueKQh0X6ZMN77+lMfqnsndlUOROau
         3/Q0Ix9xfxPxtCgWuSGc9Z4/R4Xc902wOM4YpDPcsY70XYBu4+6/6uRQjX0xxhnNyJ2x
         mfVxG+vUQ5Dk0SxHs3nzKroI2dzcUMc8KvcuJSgrzt7Cde9otAW4SVTgoHSxgjsO7uDo
         4setnpmBQIkK535wn3eug1ol4MKQyQQ3SJvwM2Npx7QK8fPNKE1p8RBy2UxTFIxmIOMX
         irsh4IfugaGnJlymT+zi7o9OC5jZovP8DCS+1PeyNgUQq94kmsj8SdElqW3mU8ZdQ/es
         0rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUMXKfJVPrK1wZS1yT34IzDVyZ77NOt+yOK4qyUPbQ8=;
        b=kgmNaYSmkmfLB0xi9VBsq6jVBh33b1bEb0q2IroF9OUyBxvI2U3tVDdL2pk8ZmSEXC
         RoXbB/mpalzS28g/yxnwHVPPQd+I5zf7iWtNhQVkEKC+iTHjjbHppzE8cDoLWtrem+bG
         ApgDv44P56b683HqFlpTz3Fuax4KU6jWjszy9Y2WQlCW/py6ADqzy1lDWykqqWXd02f7
         LZ8whn/ePQi/g0Q67GBUw0OMn0QgHm8ysbo/ABtHmaBlw95hLdAHucQ95qi6673C+3JR
         /8Ii8nHJx0dLRC2lCwxNI//NwvvHXWh3aVwfa5q9z4M5WWzkXK9hH2k+Yf07N9g5lhh5
         tlzw==
X-Gm-Message-State: APjAAAUZe5BkSjHV+7ZBLYdX5Rebs2YqMfgzhczU4pz3GXD7hRKAMHq2
        lTR88+msZz7esk7kcXM5dploWw==
X-Google-Smtp-Source: APXvYqxcOmYFBcwRXlrD56q14xo7hSiPlxuO6QnGghpcerYZmx0crcTPkME2R4cFWi8fUfiz3f7JNw==
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr16693230ljj.130.1575893250356;
        Mon, 09 Dec 2019 04:07:30 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id s2sm10922946lji.33.2019.12.09.04.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 04:07:29 -0800 (PST)
Message-ID: <5d673a46538fe38243e8b934a7a4bb84440686e0.camel@dubeyko.com>
Subject: Re: [PATCH v6 07/13] exfat: add bitmap operations
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Date:   Mon, 09 Dec 2019 15:07:29 +0300
In-Reply-To: <20191209065149.2230-8-namjae.jeon@samsung.com>
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
         <CGME20191209065501epcas1p267d7a2c08e4893ba86694f39c63405f9@epcas1p2.samsung.com>
         <20191209065149.2230-8-namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-09 at 01:51 -0500, Namjae Jeon wrote:
> This adds the implementation of bitmap operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/balloc.c | 272
> ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 272 insertions(+)
>  create mode 100644 fs/exfat/balloc.c
> 
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
> new file mode 100644
> index 000000000000..d7b70620e349
> --- /dev/null
> +++ b/fs/exfat/balloc.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/blkdev.h>
> +#include <linux/slab.h>
> +#include <linux/buffer_head.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +
> +static const unsigned char free_bit[] = {
> +	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0,
> 2,/*  0 ~  19*/
> +	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3,/*
> 20 ~  39*/
> +	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*
> 40 ~  59*/
> +	0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/*
> 60 ~  79*/
> +	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2,/*
> 80 ~  99*/
> +	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0,
> 3,/*100 ~ 119*/
> +	0, 1, 0, 2, 0, 1, 0, 7, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0,
> 2,/*120 ~ 139*/
> +	0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,
> 5,/*140 ~ 159*/
> +	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0,
> 2,/*160 ~ 179*/
> +	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0,
> 3,/*180 ~ 199*/
> +	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0,
> 2,/*200 ~ 219*/
> +	0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,
> 4,/*220 ~ 239*/
> +	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1,
> 0                /*240 ~ 254*/
> +};
> +
> +static const unsigned char used_bit[] = {
> +	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2,
> 3,/*  0 ~  19*/
> +	2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4,/*
> 20 ~  39*/
> +	2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5,/*
> 40 ~  59*/
> +	4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,/*
> 60 ~  79*/
> +	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4,/*
> 80 ~  99*/
> +	3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5,
> 6,/*100 ~ 119*/
> +	4, 5, 5, 6, 5, 6, 6, 7, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3,
> 4,/*120 ~ 139*/
> +	3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5,
> 6,/*140 ~ 159*/
> +	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4,
> 5,/*160 ~ 179*/
> +	4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 2, 3, 3, 4, 3, 4, 4,
> 5,/*180 ~ 199*/
> +	3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5,
> 6,/*200 ~ 219*/
> +	5, 6, 6, 7, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6,
> 7,/*220 ~ 239*/
> +	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7,
> 8             /*240 ~ 255*/
> +};
> +
> +/*
> + *  Allocation Bitmap Management Functions
> + */
> +static int exfat_allocate_bitmap(struct super_block *sb,
> +		struct exfat_dentry *ep)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	long long map_size;
> +	unsigned int i, need_map_size;
> +	sector_t sector;
> +
> +	sbi->map_clu = le32_to_cpu(ep->bitmap_start_clu);
> +	map_size = le64_to_cpu(ep->bitmap_size);
> +	need_map_size = (((sbi->num_clusters - BASE_CLUSTER) - 1) >> 3)
> + 1;

This code is slightly complicated. Why 3 was used here? Maybe it makes
sense to refactor this code and to make it more clear?

> +	if (need_map_size != map_size) {
> +		exfat_msg(sb, KERN_ERR,
> +				"bogus allocation bitmap size(need :
> %u, cur : %lld)",
> +				need_map_size, map_size);
> +		/*
> +		 * Only allowed when bogus allocation
> +		 * bitmap size is large
> +		 */
> +		if (need_map_size > map_size)
> +			return -EIO;
> +	}
> +	sbi->map_sectors = ((need_map_size - 1) >>
> +			(sb->s_blocksize_bits)) + 1;
> +	sbi->vol_amap = kmalloc_array(sbi->map_sectors,
> +				sizeof(struct buffer_head *),
> GFP_KERNEL);
> +	if (!sbi->vol_amap)
> +		return -ENOMEM;
> +
> +	sector = exfat_cluster_to_sector(sbi, sbi->map_clu);
> +	for (i = 0; i < sbi->map_sectors; i++) {
> +		sbi->vol_amap[i] = sb_bread(sb, sector + i);
> +		if (!sbi->vol_amap[i]) {
> +			/* release all buffers and free vol_amap */
> +			int j = 0;
> +
> +			while (j < i)
> +				brelse(sbi->vol_amap[j++]);
> +
> +			kfree(sbi->vol_amap);
> +			sbi->vol_amap = NULL;
> +			return -EIO;
> +		}
> +	}
> +
> +	sbi->pbr_bh = NULL;
> +	return 0;
> +}
> +
> +int exfat_load_bitmap(struct super_block *sb)
> +{
> +	unsigned int i, type;
> +	struct exfat_chain clu;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	exfat_chain_set(&clu, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
> +
> +	while (clu.dir != EOF_CLUSTER) {
> +		for (i = 0; i < sbi->dentries_per_clu; i++) {
> +			struct exfat_dentry *ep;
> +			struct buffer_head *bh;
> +
> +			ep = exfat_get_dentry(sb, &clu, i, &bh, NULL);
> +			if (!ep)
> +				return -EIO;
> +
> +			type = exfat_get_entry_type(ep);
> +			if (type == TYPE_UNUSED)
> +				break;
> +			if (type != TYPE_BITMAP)
> +				continue;
> +			if (ep->bitmap_flags == 0x0) {
> +				int err;
> +
> +				err = exfat_allocate_bitmap(sb, ep);
> +				brelse(bh);
> +				return err;
> +			}
> +			brelse(bh);
> +		}
> +
> +		if (exfat_get_next_cluster(sb, &clu.dir))
> +			return -EIO;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +void exfat_free_bitmap(struct super_block *sb)
> +{
> +	int i;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	brelse(sbi->pbr_bh);
> +
> +	for (i = 0; i < sbi->map_sectors; i++)
> +		__brelse(sbi->vol_amap[i]);
> +
> +	kfree(sbi->vol_amap);
> +	sbi->vol_amap = NULL;
> +}
> +
> +/*
> + * If the value of "clu" is 0, it means cluster 2 which is the first
> cluster of
> + * the cluster heap.
> + */
> +int exfat_set_bitmap(struct inode *inode, unsigned int clu)
> +{
> +	int i, b;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	i = clu >> (sb->s_blocksize_bits + 3);
> +	b = clu & ((sb->s_blocksize << 3) - 1);

This code looks like the dark magic. I believe it makes sense to
introduce some constant for 3 here.

> +
> +	set_bit_le(b, sbi->vol_amap[i]->b_data);
> +	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
> +	return 0;
> +}
> +
> +/*
> + * If the value of "clu" is 0, it means cluster 2 which is the first
> cluster of
> + * the cluster heap.
> + */
> +void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
> +{
> +	int i, b;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_mount_options *opts = &sbi->options;
> +
> +	i = clu >> (sb->s_blocksize_bits + 3);
> +	b = clu & ((sb->s_blocksize << 3) - 1);
> +

Ditto.

> +	clear_bit_le(b, sbi->vol_amap[i]->b_data);
> +	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
> +
> +	if (opts->discard) {
> +		int ret_discard;
> +
> +		ret_discard = sb_issue_discard(sb,
> +				exfat_cluster_to_sector(sbi, clu + 2),
> +				(1 << sbi->sect_per_clus_bits),
> GFP_NOFS, 0);

Why clu + 2? It's unclear, frankly speaking.

> +
> +		if (ret_discard == -EOPNOTSUPP) {
> +			exfat_msg(sb, KERN_ERR,
> +				"discard not supported by device,
> disabling");
> +			opts->discard = 0;
> +		}
> +	}
> +}
> +
> +/*
> + * If the value of "clu" is 0, it means cluster 2 which is the first
> cluster of
> + * the cluster heap.
> + */
> +unsigned int exfat_test_bitmap(struct super_block *sb, unsigned int
> clu)
> +{
> +	unsigned int i, map_i, map_b;
> +	unsigned int clu_base, clu_free;
> +	unsigned char k, clu_mask;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	clu_base = (clu & ~(0x7)) + 2;
> +	clu_mask = (1 << (clu - clu_base + 2)) - 1;
> +

What does 0x7 mean here? Why clu - clu_base + 2? Maybe it need to
introduce some constants and to add some comments?

> +	map_i = clu >> (sb->s_blocksize_bits + 3);
> +	map_b = (clu >> 3) & (unsigned int)(sb->s_blocksize - 1);
> +

Ditto.

> +	for (i = 2; i < sbi->num_clusters; i += 8) {


Why we start from 2 and add 8? Maybe introduce some constants?

> +		k = *(sbi->vol_amap[map_i]->b_data + map_b);
> +		if (clu_mask > 0) {
> +			k |= clu_mask;
> +			clu_mask = 0;
> +		}
> +		if (k < 0xFF) {
> +			clu_free = clu_base + free_bit[k];
> +			if (clu_free < sbi->num_clusters)
> +				return clu_free;
> +		}
> +		clu_base += 8;

Ditto.

> +
> +		if (++map_b >= sb->s_blocksize ||
> +		    clu_base >= sbi->num_clusters) {
> +			if (++map_i >= sbi->map_sectors) {
> +				clu_base = 2;
> +				map_i = 0;
> +			}
> +			map_b = 0;
> +		}
> +	}
> +
> +	return EOF_CLUSTER;
> +}
> +
> +int exfat_count_used_clusters(struct super_block *sb, unsigned int
> *ret_count)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	unsigned int count = 0;
> +	unsigned int i, map_i = 0, map_b = 0;
> +	unsigned int total_clus = sbi->num_clusters - 2;
> +	unsigned int last_mask = total_clus & 7;

Ditto.

> +	unsigned char clu_bits;
> +	const unsigned char last_bit_mask[] = {0, 0b00000001,
> 0b00000011,
> +		0b00000111, 0b00001111, 0b00011111, 0b00111111,
> 0b01111111};
> +
> +	total_clus &= ~last_mask;
> +	for (i = 0; i < total_clus; i += 8) {

Ditto.

Thanks,
Viacheslav Dubeyko.

> +		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
> +		count += used_bit[clu_bits];
> +		if (++map_b >= (unsigned int)sb->s_blocksize) {
> +			map_i++;
> +			map_b = 0;
> +		}
> +	}
> +
> +	if (last_mask) {
> +		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
> +		clu_bits &= last_bit_mask[last_mask];
> +		count += used_bit[clu_bits];
> +	}
> +
> +	*ret_count = count;
> +	return 0;
> +}

