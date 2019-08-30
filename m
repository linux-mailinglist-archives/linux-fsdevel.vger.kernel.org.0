Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB20A3C29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfH3QjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:39:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfH3QjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7hicMWakuRgs2TegBlYfwBT8iDprxzvg2SB2m6q1kQA=; b=Rw7TDZKu0oaHU45vECHr0BFIb
        QCsALEEmmqL6rPuPL/LqiIl68Hknd4ElB/B166cyi03n5AYPEP585r85yRxsXQlGrftxyqJLVT8kY
        oRdwaT7wD8Ho9SgDQ1/Y2TgrPgEocQPCGElTwPJ5cOtRQ8Y/6pD6y4/B3j6nh6lkNcvchE+l1mkhR
        hRKYJtKpSy2gGiNJCMIbnDF7tS6LfuVSauP6kIaz1gPpANUw+xYUPe0Cda6+eBd/31Riixe9Pc+8d
        GGOCuDkCQkPBO9ka4u10YGEG3XHCnlJ44NCL7WPiMEPGMSbeIgSRUTO1xa2Ww78gWyhWxluJjW6+U
        ECqizR7OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jva-0001L9-Az; Fri, 30 Aug 2019 16:39:10 +0000
Date:   Fri, 30 Aug 2019 09:39:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190830163910.GB29603@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190829105048.GB64893@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829105048.GB64893@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 06:50:48PM +0800, Gao Xiang wrote:
> > Please use an erofs_ prefix for all your functions.
> 
> It is already a static function, I have no idea what is wrong here.

Which part of all wasn't clear?  Have you looked at the prefixes for
most functions in the various other big filesystems?

> > > +	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
> > > +	if (is_inode_fast_symlink(inode))
> > > +		kfree(inode->i_link);
> > 
> > is_inode_fast_symlink only shows up in a later patch.  And really
> > obsfucates the check here in the only caller as you can just do an
> > unconditional kfree here - i_link will be NULL except for the case
> > where you explicitly set it.
> 
> I cannot fully understand your point (sorry about my English),
> I will reply you about this later.

With that I mean that you should:

 1) remove is_inode_fast_symlink and just opencode it in the few places
    using it
 2) remove the check in this place entirely as it is not needed
 3) remove the comment quoted above as it is more confusing than not
    having the comment

> > Is there any good reasons to use buffer heads like this in new code
> > vs directly using bios?
> 
> This page can save in bdev page cache, it contains not only the erofs
> superblock so it can be fetched in page cache later.

If you want it in the page cache why not use read_mapping_page or similar?

> > > +/* set up default EROFS parameters */
> > > +static void default_options(struct erofs_sb_info *sbi)
> > > +{
> > > +}
> > 
> > No need to add an empty function.
> 
> Later patch will fill this function.

Please only add the function in the patch actually adding the
functionality.

> > > +}
> > 
> > Why is this needed?  You can just free your sb privatte information in
> > ->put_super and wire up kill_block_super as the ->kill_sb method
> > directly.
> 
> See Al's comments,
> https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk/

With that code it makes sense.  In this paticular patch it does not.
So please add it only when actually needed.
