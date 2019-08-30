Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B636A3DE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfH3Sq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 14:46:59 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:42968 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbfH3Sq7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:46:59 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 6A8539DBA69EB7AA3A3A;
        Sat, 31 Aug 2019 02:46:56 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 31 Aug 2019 02:46:55 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 31 Aug 2019 02:46:54 +0800
Date:   Sat, 31 Aug 2019 02:46:06 +0800
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
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190830184606.GA175612@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
 <20190829115922.GG64893@architecture4>
 <20190830164205.GD29603@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830164205.GD29603@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Fri, Aug 30, 2019 at 09:42:05AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 29, 2019 at 07:59:22PM +0800, Gao Xiang wrote:
> > On Thu, Aug 29, 2019 at 03:24:26AM -0700, Christoph Hellwig wrote:
> > 
> > []
> > 
> > > 
> > > > +
> > > > +		/* fill last page if inline data is available */
> > > > +		err = fill_inline_data(inode, data, ofs);
> > > 
> > > Well, I think you should move the is_inode_flat_inline and
> > > (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) checks from that
> > > helper here, as otherwise you make everyone wonder why you'd always
> > > fill out the inline data.
> > 
> > Currently, fill_inline_data() only fills for fast symlink,
> > later we can fill any tail-end block (such as dir block)
> > for our requirements.
> 
> So change it when that later changes actually come in.  And even then
> having the checks outside the function is a lot more obvious.

Okay.

> 
> > And I think that is minor.
> 
> The problem is that each of these issues might appear minor on their
> own.  But combined a lot of the coding style choices lead to code that
> is more suitable an obsfucated code contest than the Linux kernel as
> trying to understand even just a few places requires jumping through
> tons of helpers with misleading names and spread over various files.
> 
> > The consideration is simply because iget_locked performs better
> > than iget5_locked.
> 
> In what benchmark do the differences show up?

In a word, no benchmark here, just because
"unsigned long on 32-bit platforms is 4 bytes."
but erofs nid is a 64-bit number.

iget_locked will do find_inode_fast (no callback at all)
rather than iget5_locked --> find_inode (test callback) ->
            inode_insert5(set callback) for each new inode.

For most 64-bit platforms, iget_locked is enough,
32-bit platforms become rare...

Thanks,
Gao Xiang

