Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698FBA3C49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfH3QmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:42:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfH3QmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zT6Sffc7p6dXxr/DqLVZuPlm0esCLyE+d/3ikz+/jqI=; b=Nb5baDLHs6tOVMnZ2y1xUxHzs
        MhSwjOCDGxy8BvtXnOfjEW35qlNWyTbB5J8UoRl4zzLn+YSkRG+J46vsn972X8NpB8I7gKz1i1ZcD
        Bi2JWKJq4ZUANCc0oWI11+X0jE7gzpS3IFc1UfQGoD9Mk+ov4ZRJqRweV6Ek2FRGvomWDP7hd3ryu
        oaPu2QpDsqEh4GwblDsXtaPgKEHbndclLqmmnGyF5+5JhqE/2wMWTx6zkz1YCrd3bEALL5KVNQKUQ
        WpHREdtO/JtxBC5fHQ2repjFQJhEBNYaFxOJln6YisDqgjlMrFlhxRGO4FqgfssIOHIyKIy5OFC+0
        f9lySr1Cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jyP-0002rX-Ku; Fri, 30 Aug 2019 16:42:05 +0000
Date:   Fri, 30 Aug 2019 09:42:05 -0700
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
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190830164205.GD29603@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
 <20190829115922.GG64893@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829115922.GG64893@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 07:59:22PM +0800, Gao Xiang wrote:
> On Thu, Aug 29, 2019 at 03:24:26AM -0700, Christoph Hellwig wrote:
> 
> []
> 
> > 
> > > +
> > > +		/* fill last page if inline data is available */
> > > +		err = fill_inline_data(inode, data, ofs);
> > 
> > Well, I think you should move the is_inode_flat_inline and
> > (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) checks from that
> > helper here, as otherwise you make everyone wonder why you'd always
> > fill out the inline data.
> 
> Currently, fill_inline_data() only fills for fast symlink,
> later we can fill any tail-end block (such as dir block)
> for our requirements.

So change it when that later changes actually come in.  And even then
having the checks outside the function is a lot more obvious.

> And I think that is minor.

The problem is that each of these issues might appear minor on their
own.  But combined a lot of the coding style choices lead to code that
is more suitable an obsfucated code contest than the Linux kernel as
trying to understand even just a few places requires jumping through
tons of helpers with misleading names and spread over various files.

> The consideration is simply because iget_locked performs better
> than iget5_locked.

In what benchmark do the differences show up?
