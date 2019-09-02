Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E96A5ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfIBPqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:46:01 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:54408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfIBPqA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:46:00 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 63347F3EFAF56709ABD5;
        Mon,  2 Sep 2019 23:25:44 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 23:25:44 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 23:25:43 +0800
Date:   Mon, 2 Sep 2019 23:24:52 +0800
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
Message-ID: <20190902152451.GC179615@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190902125109.GA9826@infradead.org>
 <20190902144303.GF2664@architecture4>
 <20190902151910.GA14009@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902151910.GA14009@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 08:19:10AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 10:43:04PM +0800, Gao Xiang wrote:
> > Hi Christoph,
> > > > ...
> > > >  24         __le32 features;        /* (aka. feature_compat) */
> > > > ...
> > > >  38         __le32 requirements;    /* (aka. feature_incompat) */
> > > > ...
> > > >  41 };
> > > 
> > > This is only cosmetic, why not stick to feature_compat and
> > > feature_incompat?
> > 
> > Okay, will fix. (however, in my mind, I'm some confused why
> > "features" could be incompatible...)
> 
> The feature is incompatible if it requires changes to the driver.
> An easy to understand historic example is that ext3 originally did not
> have the file types in the directory entry.  Adding them means old
> file system drivers can not read a file system with this new feature,
> so an incompat flag has to be added.

Got it.

> 
> > > > > > +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> > > > > > +	memcpy(sbi->volume_name, layout->volume_name,
> > > > > > +	       sizeof(layout->volume_name));
> > > > > 
> > > > > s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
> > > > > if it is le it should be a guid_t).
> > > > 
> > > > For this case, I have no idea how to deal with...
> > > > I have little knowledge about this uuid stuff, so I just copied
> > > > from f2fs... (Could be no urgent of this field...)
> > > 
> > > Who fills out this field in the on-disk format and how?
> > 
> > mkfs.erofs, but this field leaves 0 for now. Is that reasonable?
> > (using libuuid can generate it easily...)
> 
> If the filed is always zero for now please don't fill it out.  If you
> decide it is worth adding the uuid eventually please add a compat
> feature flag that you have a valid uuid and only fill out the field
> if the file system actualy has a valid uuid.

Okay. Will do that then (as a note here).

Thanks,
Gao Xiang

