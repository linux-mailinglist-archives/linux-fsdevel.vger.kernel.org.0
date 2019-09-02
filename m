Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75ACA5A67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbfIBPTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:19:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfIBPTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2EGoFqF4zos5OWv6WNlwPBiBbR4EbKkewLh/Q5wrwzg=; b=hg55rG0HzZ77yWw3lDcHMwEJH
        4h8tXaA10F6hxvy5EoMJeMlsFgva45iKJC3AS9g/Ap2If6wlb+9lOoQjF6RautWXs7fuH2KbLPGpN
        TokyPVRzEED9kDfKmX0u4MhmhuRBVRYt+Z3SxO5dLwR2lBE5cfOK80/paYacTHWmSW0sdGT1Na+S7
        7aF0pm3wH2AIQejEdf+A1hMOAsn/lirsJZGtZPGXN77GBmAO/1wDvwfOk84jnwhxPVK1KEgzMy3sG
        1aboGacoWyhc+tMzP691PSZ/lxTmBIA7WJAdPZghGGSWUKZNLU67+qXiJdEu+WBVcVmXLOES8qJf1
        UBT+u7T5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4o6o-0004hD-LX; Mon, 02 Sep 2019 15:19:10 +0000
Date:   Mon, 2 Sep 2019 08:19:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
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
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190902151910.GA14009@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190902125109.GA9826@infradead.org>
 <20190902144303.GF2664@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902144303.GF2664@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:43:04PM +0800, Gao Xiang wrote:
> Hi Christoph,
> > > ...
> > >  24         __le32 features;        /* (aka. feature_compat) */
> > > ...
> > >  38         __le32 requirements;    /* (aka. feature_incompat) */
> > > ...
> > >  41 };
> > 
> > This is only cosmetic, why not stick to feature_compat and
> > feature_incompat?
> 
> Okay, will fix. (however, in my mind, I'm some confused why
> "features" could be incompatible...)

The feature is incompatible if it requires changes to the driver.
An easy to understand historic example is that ext3 originally did not
have the file types in the directory entry.  Adding them means old
file system drivers can not read a file system with this new feature,
so an incompat flag has to be added.

> > > > > +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> > > > > +	memcpy(sbi->volume_name, layout->volume_name,
> > > > > +	       sizeof(layout->volume_name));
> > > > 
> > > > s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
> > > > if it is le it should be a guid_t).
> > > 
> > > For this case, I have no idea how to deal with...
> > > I have little knowledge about this uuid stuff, so I just copied
> > > from f2fs... (Could be no urgent of this field...)
> > 
> > Who fills out this field in the on-disk format and how?
> 
> mkfs.erofs, but this field leaves 0 for now. Is that reasonable?
> (using libuuid can generate it easily...)

If the filed is always zero for now please don't fill it out.  If you
decide it is worth adding the uuid eventually please add a compat
feature flag that you have a valid uuid and only fill out the field
if the file system actualy has a valid uuid.
