Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39A12256A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 08:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLQH2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 02:28:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:40812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfLQH2h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:28:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8EAEAC0C;
        Tue, 17 Dec 2019 07:28:34 +0000 (UTC)
Subject: Re: [PATCH 1/2] fs: New zonefs file system
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <20191212183816.102402-2-damien.lemoal@wdc.com>
 <c7f17b54-8f90-3dd3-98f7-cf540d70333d@suse.de>
 <BYAPR04MB5816D17D0A14D5651E37F700E7500@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <32e3418b-727e-3018-1b8a-0530608fb34d@suse.de>
Date:   Tue, 17 Dec 2019 08:28:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816D17D0A14D5651E37F700E7500@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/19 1:20 AM, Damien Le Moal wrote:
> On 2019/12/16 17:36, Hannes Reinecke wrote:
> [...]
>>> +static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>> +			      unsigned int flags, struct iomap *iomap,
>>> +			      struct iomap *srcmap)
>>> +{
>>> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
>>> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>>> +	loff_t max_isize = zi->i_max_size;
>>> +	loff_t isize;
>>> +
>>> +	/*
>>> +	 * For sequential zones, enforce direct IO writes. This is already
>>> +	 * checked when writes are issued, so warn about this here if we
>>> +	 * get buffered write to a sequential file inode.
>>> +	 */
>>> +	if (WARN_ON_ONCE(zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
>>> +			 (flags & IOMAP_WRITE) && !(flags & IOMAP_DIRECT)))
>>> +		return -EIO;
>>> +
>>> +	/*
>>> +	 * For all zones, all blocks are always mapped. For sequential zones,
>>> +	 * all blocks after the write pointer (inode size) are always unwritten.
>>> +	 */
>>> +	mutex_lock(&zi->i_truncate_mutex);
>>> +	isize = i_size_read(inode);
>>> +	if (offset >= isize) {
>>> +		length = min(length, max_isize - offset);
>>> +		if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
>>> +			iomap->type = IOMAP_MAPPED;
>>> +		else
>>> +			iomap->type = IOMAP_UNWRITTEN;
>>> +	} else {
>>> +		length = min(length, isize - offset);
>>> +		iomap->type = IOMAP_MAPPED;
>>> +	}
>>> +	mutex_unlock(&zi->i_truncate_mutex);
>>> +
>>> +	iomap->offset = offset & (~sbi->s_blocksize_mask);
>>> +	iomap->length = ((offset + length + sbi->s_blocksize_mask) &
>>> +			 (~sbi->s_blocksize_mask)) - iomap->offset;
>>> +	iomap->bdev = inode->i_sb->s_bdev;
>>> +	iomap->addr = (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct iomap_ops zonefs_iomap_ops = {
>>> +	.iomap_begin	= zonefs_iomap_begin,
>>> +};
>>> +
>> This probably shows my complete ignorance, but what is the effect on
>> enforcing the direct I/O writes on the pagecache?
>> IE what happens for buffered reads? Will the pages be invalidated when a
>> write has been issued?
> 
> Yes, a direct write issued to a file range that has cached pages result
> in these pages to be invalidated. But note that in the case of zonefs,
> this can happen only in the case of conventional zones. For sequential
> zones, this does not happen: reads can be buffered and cache pages but
> only for pages below the write pointer. And writes can only be issued at
> the write pointer. So there is never any possible overlap between
> buffered reads and direct writes.
> 
Oh, indeed, you are correct. That's indeed easy then.

>> Or do we simply rely on upper layers to ensure no concurrent buffered
>> and direct I/O is being made?
> 
> Nope. VFS, or the file system specific implementation, takes care of
> that. See generic_file_direct_write() and its call to
> invalidate_inode_pages2_range().
> 
Of course.
One could even say: not applicable, as it won't happen.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
