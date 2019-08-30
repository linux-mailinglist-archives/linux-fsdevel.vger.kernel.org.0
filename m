Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29825A3CD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfH3RQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 13:16:03 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:46432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbfH3RQD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:16:03 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 6DF902A22AA429166DF2;
        Sat, 31 Aug 2019 01:16:00 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 31 Aug 2019 01:15:59 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 31 Aug 2019 01:15:59 +0800
Date:   Sat, 31 Aug 2019 01:15:11 +0800
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
Message-ID: <20190830171510.GC107220@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190829105048.GB64893@architecture4>
 <20190830163910.GB29603@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830163910.GB29603@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Fri, Aug 30, 2019 at 09:39:10AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 29, 2019 at 06:50:48PM +0800, Gao Xiang wrote:
> > > Please use an erofs_ prefix for all your functions.
> > 
> > It is already a static function, I have no idea what is wrong here.
> 
> Which part of all wasn't clear?  Have you looked at the prefixes for
> most functions in the various other big filesystems?

I will add erofs prefix to free_inode as you said.

At least, all non-prefix functions in erofs are all static functions,
it won't pollute namespace... I will add "erofs_" to other meaningful
callbacks...And as you can see...

cifs/cifsfs.c
1303:cifs_init_inodecache(void)
1509:   rc = cifs_init_inodecache();

hpfs/super.c
254:static int init_inodecache(void)
771:    int err = init_inodecache();

minix/inode.c
84:static int __init init_inodecache(void)
665:    int err = init_inodecache();

isofs/inode.c
88:static int __init init_inodecache(void)
1580:   int err = init_inodecache();

bfs/inode.c
261:static int __init init_inodecache(void)
468:    int err = init_inodecache();

ext4/super.c
1144:static int __init init_inodecache(void)
6115:   err = init_inodecache();

reiserfs/super.c
666:static int __init init_inodecache(void)
2606:   ret = init_inodecache();

squashfs/super.c
406:static int __init init_inodecache(void)
430:    int err = init_inodecache();

udf/super.c
177:static int __init init_inodecache(void)
232:    err = init_inodecache();

qnx4/inode.c
358:static int init_inodecache(void)
399:    err = init_inodecache();

ufs/super.c
1463:static int __init init_inodecache(void)
1517:   int err = init_inodecache();

qnx6/inode.c
618:static int init_inodecache(void)
659:    err = init_inodecache();

f2fs/super.c
3540:static int __init init_inodecache(void)
3572:   err = init_inodecache();


> 
> > > > +	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
> > > > +	if (is_inode_fast_symlink(inode))
> > > > +		kfree(inode->i_link);
> > > 
> > > is_inode_fast_symlink only shows up in a later patch.  And really
> > > obsfucates the check here in the only caller as you can just do an
> > > unconditional kfree here - i_link will be NULL except for the case
> > > where you explicitly set it.
> > 
> > I cannot fully understand your point (sorry about my English),
> > I will reply you about this later.
> 
> With that I mean that you should:
> 
>  1) remove is_inode_fast_symlink and just opencode it in the few places
>     using it
>  2) remove the check in this place entirely as it is not needed
>  3) remove the comment quoted above as it is more confusing than not
>     having the comment

Got it, thanks!

> 
> > > Is there any good reasons to use buffer heads like this in new code
> > > vs directly using bios?
> > 
> > This page can save in bdev page cache, it contains not only the erofs
> > superblock so it can be fetched in page cache later.
> 
> If you want it in the page cache why not use read_mapping_page or similar?

It's reasonable, I will change as you suggested.
(The difference is whether it has some buffer_head to the sb page or not...)

> 
> > > > +/* set up default EROFS parameters */
> > > > +static void default_options(struct erofs_sb_info *sbi)
> > > > +{
> > > > +}
> > > 
> > > No need to add an empty function.
> > 
> > Later patch will fill this function.
> 
> Please only add the function in the patch actually adding the
> functionality.

That was my fault when spilting patches...considering
it's an >7KLOC filesystem (maybe spilting the whole xfs or
ext4 properly is more harder)... Anyway, that is my fault.

> 
> > > > +}
> > > 
> > > Why is this needed?  You can just free your sb privatte information in
> > > ->put_super and wire up kill_block_super as the ->kill_sb method
> > > directly.
> > 
> > See Al's comments,
> > https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk/
> 
> With that code it makes sense.  In this paticular patch it does not.
> So please add it only when actually needed.

Same as above...

Thanks,
Gao Xiang

