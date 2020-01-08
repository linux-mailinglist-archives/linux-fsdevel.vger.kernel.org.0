Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5DB1348D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgAHRIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 12:08:44 -0500
Received: from verein.lst.de ([213.95.11.211]:50298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgAHRIo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:08:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B094668BFE; Wed,  8 Jan 2020 18:08:40 +0100 (CET)
Date:   Wed, 8 Jan 2020 18:08:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com
Subject: Re: [PATCH v9 01/13] exfat: add in-memory and on-disk structures
 and headers
Message-ID: <20200108170840.GB13388@lst.de>
References: <20200102082036.29643-1-namjae.jeon@samsung.com> <CGME20200102082400epcas1p4cd0ad14967bd8d231fc0efcede8bd99c@epcas1p4.samsung.com> <20200102082036.29643-2-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102082036.29643-2-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:20:24PM +0800, Namjae Jeon wrote:
> This adds in-memory and on-disk structures and headers.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>

This looks good modulo a few cosmetic nitpicks below.

Reviewed-by: Christoph Hellwig <hch@lst.de>

> --- /dev/null
> +++ b/fs/exfat/exfat_fs.h
> @@ -0,0 +1,569 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#ifndef _EXFAT_H
> +#define _EXFAT_H

This should probably be _EXFAT_FS_H to match the actual file name.

> +
> +#include <linux/fs.h>
> +#include <linux/ratelimit.h>
> +
> +#define EXFAT_SUPER_MAGIC       (0x2011BAB0UL)

No need for the braces.

> +/*
> + * exfat common MACRO
> + */

Not sure this comment is all that helpful.

> +#define CLUSTER_32(x)			((unsigned int)((x) & 0xFFFFFFFFU))

This could just use lower_32_bits().

> +#define EXFAT_BAD_CLUSTER		(0xFFFFFFF7U)
> +#define EXFAT_FREE_CLUSTER		(0)
> +/* Cluster 0, 1 are reserved, the first cluster is 2 in the cluster heap. */
> +#define EXFAT_RESERVED_CLUSTERS		(2)
> +#define EXFAT_FIRST_CLUSTER		(2)

No need for the braces.

> +/* type values */
> +#define TYPE_UNUSED		0x0000
> +#define TYPE_DELETED		0x0001
> +#define TYPE_INVALID		0x0002
> +#define TYPE_CRITICAL_PRI	0x0100
> +#define TYPE_BITMAP		0x0101
> +#define TYPE_UPCASE		0x0102
> +#define TYPE_VOLUME		0x0103
> +#define TYPE_DIR		0x0104
> +#define TYPE_FILE		0x011F
> +#define TYPE_CRITICAL_SEC	0x0200
> +#define TYPE_STREAM		0x0201
> +#define TYPE_EXTEND		0x0202
> +#define TYPE_ACL		0x0203
> +#define TYPE_BENIGN_PRI		0x0400
> +#define TYPE_GUID		0x0401
> +#define TYPE_PADDING		0x0402
> +#define TYPE_ACLTAB		0x0403
> +#define TYPE_BENIGN_SEC		0x0800
> +#define TYPE_ALL		0x0FFF

Shouldn't this go into exfat_raw.h?  Maybe check if a few other
values should as well if they define an on-disk format.

> +static inline sector_t exfat_cluster_to_sector(struct exfat_sb_info *sbi,
> +		unsigned int clus)
> +{
> +	return ((clus - EXFAT_RESERVED_CLUSTERS) << sbi->sect_per_clus_bits)
> +		+ sbi->data_start_sector;

Nitpick: normally we put the operators at the of the previous line in
Linux code.

> +#define EXFAT_DELETE		~(0x80)

The braces would more useful outside the ~.

> +#define file_num_ext			dentry.file.num_ext
> +#define file_checksum			dentry.file.checksum
> +#define file_attr			dentry.file.attr
> +#define file_create_time		dentry.file.create_time
> +#define file_create_date		dentry.file.create_date
> +#define file_modify_time		dentry.file.modify_time
> +#define file_modify_date		dentry.file.modify_date
> +#define file_access_time		dentry.file.access_time
> +#define file_access_date		dentry.file.access_date
> +#define file_create_time_ms		dentry.file.create_time_ms
> +#define file_modify_time_ms		dentry.file.modify_time_ms
> +#define file_create_tz			dentry.file.create_tz
> +#define file_modify_tz			dentry.file.modify_tz
> +#define file_access_tz			dentry.file.access_tz
> +#define stream_flags			dentry.stream.flags
> +#define stream_name_len			dentry.stream.name_len
> +#define stream_name_hash		dentry.stream.name_hash
> +#define stream_start_clu		dentry.stream.start_clu
> +#define stream_valid_size		dentry.stream.valid_size
> +#define stream_size			dentry.stream.size
> +#define name_flags			dentry.name.flags
> +#define name_unicode			dentry.name.unicode_0_14
> +#define bitmap_flags			dentry.bitmap.flags
> +#define bitmap_start_clu		dentry.bitmap.start_clu
> +#define bitmap_size			dentry.bitmap.size
> +#define upcase_start_clu		dentry.upcase.start_clu
> +#define upcase_size			dentry.upcase.size
> +#define upcase_checksum			dentry.upcase.checksum

Personally I don't find these defines very helpful - directly seeing
the field name makes the code much easier to read.
