Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F077A584E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfIBNnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 09:43:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfIBNnL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:43:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89671ADFB;
        Mon,  2 Sep 2019 13:43:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA0C1DA796; Mon,  2 Sep 2019 15:43:29 +0200 (CEST)
Date:   Mon, 2 Sep 2019 15:43:29 +0200
From:   David Sterba <dsterba@suse.cz>
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
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190902134329.GU2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gao Xiang <hsiangkao@aol.com>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
 <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 05:34:00PM +0800, Gao Xiang wrote:
> > > +static int read_inode(struct inode *inode, void *data)
> > > +{
> > > +	struct erofs_vnode *vi = EROFS_V(inode);
> > > +	struct erofs_inode_v1 *v1 = data;
> > > +	const unsigned int advise = le16_to_cpu(v1->i_advise);
> > > +	erofs_blk_t nblks = 0;
> > > +
> > > +	vi->datamode = __inode_data_mapping(advise);
> > 
> > What is the deal with these magic underscores here and various
> > other similar helpers?
> 
> Fixed in
> https://lore.kernel.org/linux-fsdevel/20190901055130.30572-17-hsiangkao@aol.com/
> 
> underscores means 'internal' in my thought, it seems somewhat
> some common practice of Linux kernel, or some recent discussions
> about it?... I didn't notice these discussions...

I know about a few valid uses of the underscores:

* pattern where the __underscored version does not do locking, while the other
  does
* similarly for atomic and non-atomic version
* macro that needs to manipulate the argument name (like glue some
  prefix, so the macro does not have underscores and is supposed to be
  used instead of the function with underscores that needs the full name
  of a variable/constant/..
* underscore function takes a few more parameters to further tune the
  behaviour, but most users are fine with the defaults and that is
  provided as a function without underscores
* in case you have just one function of the kind, don't use the underscores

I can lookup examples if you're interested or if the brief description
is not sufficient. The list covers what I've seen and used, but the list
may be incomplete.
