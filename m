Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B0A4177
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 02:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfHaAzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 20:55:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3984 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728251AbfHaAzj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:55:39 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 6683374D304E71526AA5;
        Sat, 31 Aug 2019 08:55:36 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 31 Aug 2019 08:55:35 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 31 Aug 2019 08:55:35 +0800
Date:   Sat, 31 Aug 2019 08:54:46 +0800
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
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190831005446.GA233871@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190829105048.GB64893@architecture4>
 <20190830163910.GB29603@infradead.org>
 <20190830171510.GC107220@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830171510.GC107220@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Sat, Aug 31, 2019 at 01:15:10AM +0800, Gao Xiang wrote:

[]

> > 
> > > > > +	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
> > > > > +	if (is_inode_fast_symlink(inode))
> > > > > +		kfree(inode->i_link);
> > > > 
> > > > is_inode_fast_symlink only shows up in a later patch.  And really
> > > > obsfucates the check here in the only caller as you can just do an
> > > > unconditional kfree here - i_link will be NULL except for the case
> > > > where you explicitly set it.
> > > 
> > > I cannot fully understand your point (sorry about my English),
> > > I will reply you about this later.
> > 
> > With that I mean that you should:
> > 
> >  1) remove is_inode_fast_symlink and just opencode it in the few places
> >     using it
> >  2) remove the check in this place entirely as it is not needed

Add some words about this suggestion since I'm addressing this place, it
seems it could not (or I am not sure at least) be freed unconditionally

	union {
		struct pipe_inode_info	*i_pipe;
		struct block_device	*i_bdev;
		struct cdev		*i_cdev;
		char			*i_link;
		unsigned		i_dir_seq;
	};

while I saw what shmem did, it seems that they handle as follows:
3636 static void shmem_free_in_core_inode(struct inode *inode)
3637 {
3638         if (S_ISLNK(inode->i_mode))
3639                 kfree(inode->i_link);
3640         kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
3641 }

I think that would be some check on it to get it is a symlink (for
i_dir_seq it seems unsafe).... I think the original check is ok but
I will opencode it instead.

Thanks,
Gao Xiang

