Return-Path: <linux-fsdevel+bounces-26873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3C95C553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2756E1C23E05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97F95381E;
	Fri, 23 Aug 2024 06:20:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78324AEF6;
	Fri, 23 Aug 2024 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394012; cv=none; b=gwHGiEzD/9FyAB/xtpKE1Pl39aAzkB25FhfKGEue5okwRSs2ez/wJWA4Uzb0ss6ETdzEjdHMKwJ2z5IElzRIJ+3OUbcI6AFaz85SWY4ZxaLF9aCHiGxOWsm0rpCzrwkZZ6yXONOt+HVn9bsqxE5JqjyXSYGjPy5znZkuUv+Ie4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394012; c=relaxed/simple;
	bh=ULRbx2jnc4yTbYjPxK7xDHYGjcHglRvCqTTaxx9Ufjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIv40NJLNNl9xJ5HI9Rwz8F2seGrxT/2y0HOGDaufqHIsclMjSp9q0thVWvi1XycKfyX2xvUr7QVRxmSPQqR7aOFnGNIMDPB9Gi9P2VC3+he195MEnubyKRmcHE7yAqp/BUusvqoOoj7HRRcmZCqJjv6NuvGW/UrgU7aJLHq9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqqYd0XlNzQqNt;
	Fri, 23 Aug 2024 14:15:17 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 2715C180106;
	Fri, 23 Aug 2024 14:20:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 14:20:00 +0800
From: yangyun <yangyun50@huawei.com>
To: <jefflexu@linux.alibaba.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lixiaokeng@huawei.com>, <miklos@szeredi.hu>, <yangyun50@huawei.com>
Subject: Re: [PATCH] fuse: add fast path for fuse_range_is_writeback
Date: Fri, 23 Aug 2024 14:19:13 +0800
Message-ID: <20240823061913.3921169-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <8e235c73-faac-4cb7-bc6a-e1eea5075cbe@linux.alibaba.com>
References: <8e235c73-faac-4cb7-bc6a-e1eea5075cbe@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100024.china.huawei.com (7.221.188.41)

Sorry for the late reply.

On Wed, Aug 14, 2024 at 05:56:06PM +0800, Jingbo Xu wrote:
> 
> 
> On 8/14/24 5:36 PM, yangyun wrote:
> > In some cases, the fi->writepages may be empty. And there is no need
> > to check fi->writepages with spin_lock, which may have an impact on
> > performance due to lock contention. For example, in scenarios where
> > multiple readers read the same file without any writers, or where
> > the page cache is not enabled.
> > 
> > Also remove the outdated comment since commit 6b2fb79963fb ("fuse:
> > optimize writepages search") has optimize the situation by replacing
> > list with rb-tree.
> > 
> > Signed-off-by: yangyun <yangyun50@huawei.com>
> > ---
> >  fs/fuse/file.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index f39456c65ed7..59c911b61000 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -448,9 +448,6 @@ static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
> >  
> >  /*
> >   * Check if any page in a range is under writeback
> > - *
> > - * This is currently done by walking the list of writepage requests
> > - * for the inode, which can be pretty inefficient.
> >   */
> >  static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
> >  				   pgoff_t idx_to)
> > @@ -458,6 +455,9 @@ static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
> >  	struct fuse_inode *fi = get_fuse_inode(inode);
> >  	bool found;
> >  
> > +	if (RB_EMPTY_ROOT(&fi->writepages))
> > +		return false;
> 
> fi->lock is held when inserting wpa into fi->writepages rbtree (see
> fuse_writepage_add()).  I doubt if there is race condition when checking
> if fi->writepages rbtree is empty without fi->lock held.

The code can make sure that there are no race conditions because:
1. For O_DIRECT and FOPEN_DIRECT_IO with fc->direct_io_allow_mmap, the `filemap_write_and_wait_range` before can make the insert operation to be happend before the check operation.
2. For other cases, there are no pagecache operaions so the fi->writepages is always empty.

In my usercase, the fi->writepages is usually empty but the spin_lock associated with it contributes a great impact on the performace of my filesystem due to lock contention. So optimize it.
> 
> -- 
> Thanks,
> Jingbo

