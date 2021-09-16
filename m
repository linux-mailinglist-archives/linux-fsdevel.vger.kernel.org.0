Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00B640D517
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhIPIxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 04:53:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38535 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235160AbhIPIxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:53:24 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AufBqI6LU8EL9jBDaFE+RqpQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC9gDIrhjdUyWJLWmyOPviNNjCme9olaou09kMA78TUzoNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+BzvuRGuK59yAkhPjWHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfpOKZfSbj4aR/yGWDKRMA2c5GAEgoPIEw9PxwBGZ?=
 =?us-ascii?q?U//0EbjsKa3irmOOyxKOTS+9inM0vIcDneoQFtRlIwTjfS/RgXpHHR6TD4MRw3?=
 =?us-ascii?q?TEsi8QIFvHbD+IVayVoahvoYBBVPFoTTpUkk4+AgGfzcjhdgFaUvrYspWzSyhF?=
 =?us-ascii?q?hlrTgLrL9eteKbcFOggCUqwru5Wv+Bh0FJdq30iee/zSgi4fnmSL9RZJXGqa0+?=
 =?us-ascii?q?+BnhHWNyWEJTh4bT122pb++kEHWc9ZeLVEEvykjt64/8GS1QdTnGR61uniJulg?=
 =?us-ascii?q?bQdU4O+k77hydj7ra+C6HCWUeCD1MctorsIkxXzNC/kGIhdTBFzFpsaPTTXOb6?=
 =?us-ascii?q?6fSqim9fzUWRVLuzwdsoRAtuoGl+d9syEmUCIsLLUJ8tfWtcRmY/txAhHJWa20?=
 =?us-ascii?q?vsPM2?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8IRmZaqc17xjsK0rwAU8fX8aV5pOeYIsimQD?=
 =?us-ascii?q?101hICG9E/b5qynAppkmPHPP4gr5O0tApTnjAsa9qBrnnPYf3WB4B8bAYOCMgg?=
 =?us-ascii?q?eVxe9Zg7ff/w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.85,297,1624291200"; 
   d="scan'208";a="114564648"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2021 16:52:02 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 917834D0DC6E;
        Thu, 16 Sep 2021 16:52:01 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 16:51:51 +0800
Received: from [127.0.0.1] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Sep 2021 16:51:50 +0800
Subject: Re: [PATCH v9 7/8] xfs: support CoW in fsdax mode
To:     Christoph Hellwig <hch@lst.de>
CC:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-8-ruansy.fnst@fujitsu.com>
 <20210916062357.GD13306@lst.de>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <dfa28f5e-cecb-65c4-23e1-a63ef646d2b0@fujitsu.com>
Date:   Thu, 16 Sep 2021 16:51:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916062357.GD13306@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: 917834D0DC6E.A1C30
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/9/16 14:23, Christoph Hellwig wrote:
> On Wed, Sep 15, 2021 at 06:45:00PM +0800, Shiyang Ruan wrote:
>> +static int
>> +xfs_dax_write_iomap_end(
>> +	struct inode 		*inode,
>> +	loff_t 			pos,
>> +	loff_t 			length,
>> +	ssize_t 		written,
>> +	unsigned 		flags,
>> +	struct iomap 		*iomap)
>> +{
>> +	struct xfs_inode	*ip = XFS_I(inode);
>> +	/*
>> +	 * Usually we use @written to indicate whether the operation was
>> +	 * successful.  But it is always positive or zero.  The CoW needs the
>> +	 * actual error code from actor().  So, get it from
>> +	 * iomap_iter->processed.
>> +	 */
>> +	const struct iomap_iter *iter =
>> +				container_of(iomap, typeof(*iter), iomap);
>> +
>> +	if (!xfs_is_cow_inode(ip))
>> +		return 0;
>> +
>> +	if (iter->processed <= 0) {
>> +		xfs_reflink_cancel_cow_range(ip, pos, length, true);
>> +		return 0;
>> +	}
>> +
>> +	return xfs_reflink_end_cow(ip, pos, iter->processed);
> 
> Didn't we come to the conflusion last time that we don't actually
> need to poke into the iomap_iter here as the written argument is equal
> to iter->processed if it is > 0:
> 
> 	if (iter->iomap.length && ops->iomap_end) {
> 		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
> 				iter->processed > 0 ? iter->processed : 0,
> 				iter->flags, &iter->iomap);
> 		..
> 
> So should be able to just do:
> 
> static int
> xfs_dax_write_iomap_end(
> 	struct inode 		*inode,
> 	loff_t 			pos,
> 	loff_t 			length,
> 	ssize_t 		written,
> 	unsigned 		flags,
> 	struct iomap 		*iomap)
> {
> 	struct xfs_inode	*ip = XFS_I(inode);
> 
> 	if (!xfs_is_cow_inode(ip))
> 		return 0;
> 
> 	if (!written) {
> 		xfs_reflink_cancel_cow_range(ip, pos, length, true);
> 		return 0;
> 	}
> 
> 	return xfs_reflink_end_cow(ip, pos, written);
> }
> 

I see.  Thanks for your guidance.


--
Ruan


