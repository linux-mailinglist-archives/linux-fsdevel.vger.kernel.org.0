Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC00B15AF72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 19:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBLSLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 13:11:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SDGebcBZHID8LpZZbm6nPP5pL+pTi5Gy+oz6oeMbB30=; b=iUEJucP8cWJa828U4KRd5B2hjX
        oYsvvmKJYefqo4Ex57Z/KDJoeVzEDBKNdi++O+PTkUglx/znZAFfffQcf/Luds9L8CDvqSIw6h1Ll
        K6LPt+UMf0FposzjUf/1hjGM5VYePEXYvbfYTiZCxIC5c7YSk7PSKBKwbrSnzkfIH4PDdUf+ZYQyc
        jCVdL4K7V1V2VvekXtm0Y2muHnLXqeJFzKBl6kG8H51ukWc45W92mQ/zj/mbwTiFfsxIm6Jy1WBUL
        GYORC5FHmsTCxyhQfq7wGrtBq37H3S3eReGek5GUfFa5aFz+Rru8o1zlAKWNdBcv6llsZTy6pHzFo
        dZYUeXyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1wTx-0002VF-0G; Wed, 12 Feb 2020 18:11:29 +0000
Date:   Wed, 12 Feb 2020 10:11:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>, linux-xfs@vger.kernel.org,
        libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200212181128.GA31394@infradead.org>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212161604.GP6870@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 08:16:04AM -0800, Darrick J. Wong wrote:
> xfs_setattr_nonsize calls posix_acl_chmod which returns EOPNOTSUPP
> because the xfs symlink inode_operations do not include a ->set_acl
> pointer.
> 
> I /think/ that posix_acl_chmod code exists to enforce that the file mode
> reflects any acl that might be set on the inode, but in this case the
> inode is a symbolic link.
> 
> I don't remember off the top of my head if ACLs are supposed to apply to
> symlinks, but what do you think about adding get_acl/set_acl pointers to
> xfs_symlink_inode_operations and xfs_inline_symlink_inode_operations ?

Symlinks don't have permissions or ACLs, so adding them makes no
sense.

xfs doesn't seem all that different from the other file systems,
so I suspect you'll also see it with other on-disk file systems.
We probably need a check high up in the chmod and co code to reject
the operation early for O_PATH file descriptors pointing to symlinks.
