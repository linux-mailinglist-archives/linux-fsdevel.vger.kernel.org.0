Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449F2A59AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfIBOoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 10:44:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4405 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfIBOoL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:44:11 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 58F3A420F300ACFA4260;
        Mon,  2 Sep 2019 22:43:56 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 22:43:55 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 22:43:55 +0800
Date:   Mon, 2 Sep 2019 22:43:04 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190902144303.GF2664@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190902125109.GA9826@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902125109.GA9826@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 05:51:09AM -0700, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 04:54:55PM +0800, Gao Xiang wrote:
> > No modification at this... (some comments already right here...)
> 
> >  20 /* 128-byte erofs on-disk super block */
> >  21 struct erofs_super_block {
> > ...
> >  24         __le32 features;        /* (aka. feature_compat) */
> > ...
> >  38         __le32 requirements;    /* (aka. feature_incompat) */
> > ...
> >  41 };
> 
> This is only cosmetic, why not stick to feature_compat and
> feature_incompat?

Okay, will fix. (however, in my mind, I'm some confused why
"features" could be incompatible...)

> 
> > > > +	bh = sb_bread(sb, 0);
> > > 
> > > Is there any good reasons to use buffer heads like this in new code
> > > vs directly using bios?
> > 
> > As you said, I want it in the page cache.
> > 
> > The reason "why not use read_mapping_page or similar?" is simply
> > read_mapping_page -> .readpage -> (for bdev inode) block_read_full_page
> >  -> create_page_buffers anyway...
> > 
> > sb_bread haven't obsoleted... It has similar function though...
> 
> With the different that it keeps you isolated from the buffer_head
> internals.  This seems to be your only direct use of buffer heads,
> which while not deprecated are a bit of an ugly step child.  So if
> you can easily avoid creating a buffer_head dependency in a new
> filesystem I think you should avoid it.

OK, let's use read_mapping_page instead.

> 
> > > > +	sbi->build_time = le64_to_cpu(layout->build_time);
> > > > +	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
> > > > +
> > > > +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> > > > +	memcpy(sbi->volume_name, layout->volume_name,
> > > > +	       sizeof(layout->volume_name));
> > > 
> > > s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
> > > if it is le it should be a guid_t).
> > 
> > For this case, I have no idea how to deal with...
> > I have little knowledge about this uuid stuff, so I just copied
> > from f2fs... (Could be no urgent of this field...)
> 
> Who fills out this field in the on-disk format and how?

mkfs.erofs, but this field leaves 0 for now. Is that reasonable?
(using libuuid can generate it easily...)

> 
> > The background is Al's comments in erofs v2....
> > (which simplify erofs_fill_super logic)
> > https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk/
> > 
> > with a specific notation...
> > https://lore.kernel.org/r/20190721040547.GF17978@ZenIV.linux.org.uk/
> > 
> > "
> > > OTOH, for the case of NULL ->s_root ->put_super() won't be called
> > > at all, so in that case you need it directly in ->kill_sb().
> > "
> 
> Yes.  Although none of that is relevant for this initial version,
> just after more features are added.

This patch uses it actually... since no failure path in erofs_fill_super()
and s_root will be filled nearly at the end of the function...

Thanks,
Gao Xiang



