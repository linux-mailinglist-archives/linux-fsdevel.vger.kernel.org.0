Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE89A5683
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfIBMpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:45:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbfIBMpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8e5pl/cUyEaSaTIP0gVix4kLe1LPGSDBfLiK5Z6oMK4=; b=ZVUGTMspxfe3xQHunBefXYA5b
        RRbaGgX6OxaI5bD/kap+hgR/IMcivPmetVVU0OUh7XfX/onX4ou9VeUjDQzoj7QsZuFRnisygmRMR
        6aSRZqCeGTIR7HBudutdMooyrGcPpR0hkheR6CyDRkG5dnHP0PPWBnPiut+u+ir5xS3zAUTvIKeMp
        9kadYDIyHlr8crmhMNQf+xk98sFwL/p9FMNGUL465OFDk2tte+kQXPCeD4kLiTtAJCrJKcZsmRYhZ
        uS4+zLv9VrGHCAGQSoOHn9VVeP/qV/SEF74aqb+LcB7q27YkoFsxkDnZqLUWMBKzyYIaO02PDTHcf
        rwwT6O0Pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lhx-00028u-J6; Mon, 02 Sep 2019 12:45:21 +0000
Date:   Mon, 2 Sep 2019 05:45:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190902124521.GA22153@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190901075240.GA2938@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901075240.GA2938@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 03:54:11PM +0800, Gao Xiang wrote:
> It could be better has a name though, because 1) erofs.mkfs uses this
> definition explicitly, and we keep this on-disk definition erofs_fs.h
> file up with erofs-utils.
> 
> 2) For kernel use, first we have,
>    datamode < EROFS_INODE_LAYOUT_MAX; and
>    !erofs_inode_is_data_compressed, so there are only two mode here,
>         1) EROFS_INODE_FLAT_INLINE,
>         2) EROFS_INODE_FLAT_PLAIN
>    if its datamode isn't EROFS_INODE_FLAT_INLINE (tail-end block packing),
>    it should be EROFS_INODE_FLAT_PLAIN.
> 
>    The detailed logic in erofs_read_inode and
>    erofs_map_blocks_flatmode....

Ok.  At least the explicit numbering makes this a little more obvious
now.  What seems fairly odd is that there are only various places that
check for some inode layouts/formats but nothing that does a switch
over all of them.

> > why are we adding a legacy field to a brand new file system?
> 
> The difference is just EROFS_INODE_FLAT_COMPRESSION_LEGACY doesn't
> have z_erofs_map_header, so it only supports default (4k clustersize)
> fixed-sized output compression rather than per-file setting, nothing
> special at all...

It still seems odd to add a legacy field to a brand new file system.

> > structures, as that keeps it clear in everyones mind what needs to
> > stay persistent and what can be chenged easily.
> 
> All fields in this file are on-disk representation by design
> (no logic for in-memory presentation).

Ok, make sense.    Maybe add a note to the top of the file comment
that this is the on-disk format.

One little oddity is that erofs_inode_is_data_compressed is here, while
is_inode_flat_inline is in internal.h.  There are arguments for either
place, but I'd suggest to keep the related macros together.
