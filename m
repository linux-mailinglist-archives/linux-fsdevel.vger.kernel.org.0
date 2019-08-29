Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086C7A15E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfH2KZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 06:25:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfH2KZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2+CihOn1ngbaXeMiWDZKT9pHBOLXEG5xdssh2kdm+FU=; b=bOFsHPhysKyAq5Gk7Q+fYHwPG
        iIQh3sbehCzj0y6PhFfTvp0pxAies6r61lOhRpVgZFqpYU0tVuks3QRfD3w/P1ReFRdy1NHICjQIl
        H9PIKfxeTt0owWTegVbv7eKZ+k9+pxGOkVmcXB9mj7Y7obaXREYDY6tBtNOGDF2QWGC5PV4nOivWW
        RLNyP7iov5cz6Y6dr9AnnWUuYsVyZtHyfqKXb5daSGwhX8UeLoqHFtwAkA20OkYz2kuExCC/qZl9T
        9fxqPbUktLqeJ9dyGSAeIrQexg3y6XhSrvysYYtUg0IE1It6mQxA/aqGEQXz8csfXdYWu1ijAOe09
        2U5M+blcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Hbz-0007WE-RG; Thu, 29 Aug 2019 10:25:03 +0000
Date:   Thu, 29 Aug 2019 03:25:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Subject: Re: [PATCH v6 06/24] erofs: support special inode
Message-ID: <20190829102503.GF20598@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-7-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802125347.166018-7-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:53:29PM +0800, Gao Xiang wrote:
> This patch adds to support special inode, such as
> block dev, char, socket, pipe inode.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  fs/erofs/inode.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index b6ea997bc4ae..637bf6e4de44 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -34,7 +34,16 @@ static int read_inode(struct inode *inode, void *data)
>  		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
>  
>  		inode->i_mode = le16_to_cpu(v2->i_mode);
> -		vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
> +		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> +		    S_ISLNK(inode->i_mode))
> +			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
> +		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> +			inode->i_rdev =
> +				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
> +		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
> +			inode->i_rdev = 0;
> +		else
> +			return -EIO;

Please use a switch statement when dealing with the file modes to
make everything easier to read.
