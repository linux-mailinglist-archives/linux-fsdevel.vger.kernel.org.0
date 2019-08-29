Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870FBA1630
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfH2Kdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 06:33:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbfH2Kdq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:33:46 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 34D39B8182DEA8EBA187;
        Thu, 29 Aug 2019 18:33:41 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 18:33:40 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 29 Aug 2019 18:33:39 +0800
Date:   Thu, 29 Aug 2019 18:32:53 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, "Pavel Machek" <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190829103252.GA64893@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829095954.GB20598@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Thu, Aug 29, 2019 at 02:59:54AM -0700, Christoph Hellwig wrote:
> > --- /dev/null
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -0,0 +1,316 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> > +/*
> > + * linux/fs/erofs/erofs_fs.h
> 
> Please remove the pointless file names in the comment headers.

Already removed in the latest version.

> 
> > +struct erofs_super_block {
> > +/*  0 */__le32 magic;           /* in the little endian */
> > +/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > +/*  8 */__le32 features;        /* (aka. feature_compat) */
> > +/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> 
> Please remove all the byte offset comments.  That is something that can
> easily be checked with gdb or pahole.

I have no idea the actual issue here.
It will help all developpers better add fields or calculate
these offsets in their mind, and with care.

Rather than they didn't run "gdb" or "pahole" and change it by mistake.

> 
> > +/* 64 */__u8 volume_name[16];   /* volume name */
> > +/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
> > +
> > +/* 84 */__u8 reserved2[44];
> > +} __packed;                     /* 128 bytes */
> 
> Please don't add __packed.  In this case I think you don't need it
> (but double check with pahole), but even if you would need it using
> proper padding fields and making sure all fields are naturally aligned
> will give you much better code generation on architectures that don't
> support native unaligned access.

If you can see more, all on-disk fields in EROFS are naturally aligned,
I can remove all of these as you like, but I think that is not very urgent.

> 
> > +/*
> > + * erofs inode data mapping:
> > + * 0 - inode plain without inline data A:
> > + * inode, [xattrs], ... | ... | no-holed data
> > + * 1 - inode VLE compression B (legacy):
> > + * inode, [xattrs], extents ... | ...
> > + * 2 - inode plain with inline data C:
> > + * inode, [xattrs], last_inline_data, ... | ... | no-holed data
> > + * 3 - inode compression D:
> > + * inode, [xattrs], map_header, extents ... | ...
> > + * 4~7 - reserved
> > + */
> > +enum {
> > +	EROFS_INODE_FLAT_PLAIN,
> 
> This one doesn't actually seem to be used.

It could be better has a name though, because erofs.mkfs uses it,
and we keep this on-disk file up with erofs-utils.

> 
> > +	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
> 
> why are we adding a legacy field to a brand new file system?

the difference is just EROFS_INODE_FLAT_COMPRESSION_LEGACY doesn't have
z_erofs_map_header, nothing special at all.

> 
> > +	EROFS_INODE_FLAT_INLINE,
> > +	EROFS_INODE_FLAT_COMPRESSION,
> > +	EROFS_INODE_LAYOUT_MAX
> 
> It seems like these come from the on-disk format, in which case they
> should have explicit values assigned to them.
> 
> Btw, I think it generally helps file system implementation quality
> if you use a separate header for the on-disk structures vs in-memory
> structures, as that keeps it clear in everyones mind what needs to
> stay persistent and what can be chenged easily.

All fields in this file are on-disk representation.

> 
> > +static bool erofs_inode_is_data_compressed(unsigned int datamode)
> > +{
> > +	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
> > +		return true;
> > +	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
> > +}
> 
> This looks like a really obsfucated way to write:
> 
> 	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
> 		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;

It depends on the personal choise, if you like, I will change into your form.

> 
> > +/* 28 */__le32 i_reserved2;
> > +} __packed;
> 
> Sane comment as above.
> 
> > +
> > +/* 32 bytes on-disk inode */
> > +#define EROFS_INODE_LAYOUT_V1   0
> > +/* 64 bytes on-disk inode */
> > +#define EROFS_INODE_LAYOUT_V2   1
> > +
> > +struct erofs_inode_v2 {
> > +/*  0 */__le16 i_advise;
> 
> Why do we have two inode version in a newly added file system?

v2 is an exhanced on-disk inode form, it has 64 bytes,
v1 is more compacted one, which is already suitable
for Android use case of course.

There is no new and old, both are used for the current EROFS.

> 
> > +#define ondisk_xattr_ibody_size(count)	({\
> > +	u32 __count = le16_to_cpu(count); \
> > +	((__count) == 0) ? 0 : \
> > +	sizeof(struct erofs_xattr_ibody_header) + \
> > +		sizeof(__u32) * ((__count) - 1); })
> 
> This would be much more readable as a function.
> 
> > +#define EROFS_XATTR_ENTRY_SIZE(entry) EROFS_XATTR_ALIGN( \
> > +	sizeof(struct erofs_xattr_entry) + \
> > +	(entry)->e_name_len + le16_to_cpu((entry)->e_value_size))
> 
> Same here.

Personal tendency, because we are working in a dedicated team rather than
an individual person.

But I can fix as you like.

> 
> > +/* available compression algorithm types */
> > +enum {
> > +	Z_EROFS_COMPRESSION_LZ4,
> > +	Z_EROFS_COMPRESSION_MAX
> > +};
> 
> Seems like an on-disk value again that should use explicitly assigned
> numbers.

I can fix it up as you like but I still cannot get
what is critical issues here.

Thanks,
Gao Xiang


