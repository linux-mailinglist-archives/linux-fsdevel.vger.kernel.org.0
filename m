Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2E83DFAC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 06:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhHDEwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 00:52:45 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52533 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhHDEwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 00:52:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Uhw5or2_1628052749;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Uhw5or2_1628052749)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 12:52:31 +0800
Date:   Wed, 4 Aug 2021 12:52:29 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Tao Ma <boyu.mt@taobao.com>
Subject: Re: [PATCH v2 1/3] erofs: iomap support for non-tailpacking DIO
Message-ID: <YQodDac58Uta4ZtR@B-P7TQMD6M-0146.local>
Mail-Followup-To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>, Tao Ma <boyu.mt@taobao.com>
References: <20210730194625.93856-1-hsiangkao@linux.alibaba.com>
 <20210730194625.93856-2-hsiangkao@linux.alibaba.com>
 <e79e3261-e582-e848-b550-c0c3163d9af4@kernel.org>
 <YQoX62zRERGX9BGB@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQoX62zRERGX9BGB@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 04, 2021 at 12:30:35PM +0800, Gao Xiang wrote:
> Hi Chao,
> 
> On Wed, Aug 04, 2021 at 10:57:08AM +0800, Chao Yu wrote:
> > On 2021/7/31 3:46, Gao Xiang wrote:
> 
> ...
> 
> > >   }
> > > +static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > > +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> > > +{
> > > +	int ret;
> > > +	struct erofs_map_blocks map;
> > > +
> > > +	map.m_la = offset;
> > > +	map.m_llen = length;
> > > +
> > > +	ret = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	iomap->bdev = inode->i_sb->s_bdev;
> > > +	iomap->offset = map.m_la;
> > > +	iomap->length = map.m_llen;
> > > +	iomap->flags = 0;
> > > +
> > > +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> > > +		iomap->type = IOMAP_HOLE;
> > > +		iomap->addr = IOMAP_NULL_ADDR;
> > > +		if (!iomap->length)
> > > +			iomap->length = length;
> > 
> > This only happens for the case offset exceeds isize?
> 
> Thanks for the review.
> 
> Yeah, this is a convention (length 0 with !EROFS_MAP_MAPPED) for post-EOF
> in erofs_map_blocks_flatmode(), need to follow iomap rule as well.
> 
> > 
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* that shouldn't happen for now */
> > > +	if (map.m_flags & EROFS_MAP_META) {
> > > +		DBG_BUGON(1);
> > > +		return -ENOTBLK;
> > > +	}
> > > +	iomap->type = IOMAP_MAPPED;
> > > +	iomap->addr = map.m_pa;
> > > +	return 0;
> > > +}
> > > +
> > > +const struct iomap_ops erofs_iomap_ops = {
> > > +	.iomap_begin = erofs_iomap_begin,
> > > +};
> > > +
> > > +static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +	loff_t align = iocb->ki_pos | iov_iter_count(to) |
> > > +		iov_iter_alignment(to);
> > > +	struct block_device *bdev = inode->i_sb->s_bdev;
> > > +	unsigned int blksize_mask;
> > > +
> > > +	if (bdev)
> > > +		blksize_mask = (1 << ilog2(bdev_logical_block_size(bdev))) - 1;
> > > +	else
> > > +		blksize_mask = (1 << inode->i_blkbits) - 1;
> > > +
> > > +	if (align & blksize_mask)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * Temporarily fall back tail-packing inline to buffered I/O instead
> > > +	 * since tail-packing inline support relies on an iomap core update.
> > > +	 */
> > > +	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE &&
> > > +	    iocb->ki_pos + iov_iter_count(to) >
> > > +			rounddown(inode->i_size, EROFS_BLKSIZ))
> > > +		return 1;
> > > +	return 0;
> > > +}
> > > +
> > > +static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > > +{
> > > +	/* no need taking (shared) inode lock since it's a ro filesystem */
> > > +	if (!iov_iter_count(to))
> > > +		return 0;
> > > +
> > > +	if (iocb->ki_flags & IOCB_DIRECT) {
> > > +		int err = erofs_prepare_dio(iocb, to);
> > > +
> > > +		if (!err)
> > > +			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> > > +					    NULL, 0);
> > > +		if (err < 0)
> > > +			return err;
> > > +		/*
> > > +		 * Fallback to buffered I/O if the operation being performed on
> > > +		 * the inode is not supported by direct I/O. The IOCB_DIRECT
> > > +		 * flag needs to be cleared here in order to ensure that the
> > > +		 * direct I/O path within generic_file_read_iter() is not
> > > +		 * taken.
> > > +		 */
> > > +		iocb->ki_flags &= ~IOCB_DIRECT;
> > > +	}
> > > +	return generic_file_read_iter(iocb, to);
> > 
> > It looks it's fine to call filemap_read() directly since above codes have
> > covered DIO case, then we don't need to change iocb->ki_flags flag, it's
> > minor though.
> 
> Yeah, we could use filemap_read() here instead. yet IMO, it might be
> better to drop IOCB_DIRECT too to keep iocb consistent with the real
> semantics (even it's not used internally.)

After checking the other users of filemap_read(), I'm fine to leave
IOCB_DIRECT as-is. Will update.

Thanks,
Gao Xiang
