Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75BA3C3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfH3QkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:40:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfH3QkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AT7c8Uf6oRKSCvH0T7rxwpH4EoIuzd5Fl8xv/gJGnw4=; b=XKxQMKVi9kAdTU+vbb0Unuz1w
        1OC04HlMkxRWKs69JYntBAUF4Vq2rS9l2rajiJty/VLSOfmjDMy+0igRW96PttjZ1sVU4ZpTv/387
        URunnMETnkxIuM82Rxm4Ch3c6EgKekyOk6PUM01SL5x0M70Gwdlqg/fz3lOS1cSnIsj0jJQEAQopu
        LkT2Rihs462KZRs+vsR+k/TmnMtkm28eZgXiXoUJwS2Ll1xhYkJN1fpn+44WyZolCVtFv+DYTc6JK
        F7IsP1hyzpQH9I9Ix7oOpfg+bKAuiOZusNnDVQsLRBCmrqavz6liyImmftILLHQIWu8d4n01QmuYH
        J05OeGxHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jwb-0002a3-O7; Fri, 30 Aug 2019 16:40:13 +0000
Date:   Fri, 30 Aug 2019 09:40:13 -0700
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
Subject: Re: [PATCH v6 04/24] erofs: add raw address_space operations
Message-ID: <20190830164013.GC29603@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-5-gaoxiang25@huawei.com>
 <20190829101721.GD20598@infradead.org>
 <20190829114610.GF64893@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829114610.GF64893@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 07:46:11PM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Thu, Aug 29, 2019 at 03:17:21AM -0700, Christoph Hellwig wrote:
> > The actual address_space operations seem to largely duplicate
> > the iomap versions.  Please use those instead.  Also I don't think
> > any new file system should write up ->bmap these days.
> 
> iomap doesn't support tail-end packing inline data till now,
> I think Chao and I told you and Andreas before [1].
> 
> Since EROFS keeps a self-contained driver for now, we will use
> iomap if it supports tail-end packing inline data later.

Well, so work with the maintainers to enhance the core kernel.  That
is how Linux development works.  We've added various iomap enhancements
for gfs in the last merge windows, and we've added more for the brand
new zonefs file system we plan to merge for 5.4.
