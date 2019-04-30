Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED7FCD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbfD3P05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:26:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfD3P05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:26:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UFOXkW110533;
        Tue, 30 Apr 2019 15:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GP7BtA84ivQNMdsMKZBYVXe+9V8f4N3iqEFhAXP+9sU=;
 b=ux2QZJeZOV2RwfeCOt5Fwitbzg65YB8PWWvqo9Gr3+uBYd8grAQ1RMoW2rlaXtTH/O41
 zB3a+7FNt5/wiSJCTceiIFJIEULrchwFxJwyStBfhrRszrF0cx9zHgUVb6n9+uAkkG4r
 5RutasAnvK9RuB0rKnNV60OyDWD4m6hhpXx8H20HTSVBRNnbYKzigBx3HeFFpnb/k12s
 g3dqpNChdgl72zsXUT5F3GxpvMlkMRNM5J9YuDcX3ctkOI0YENEr9dkRtF3oOQEj81cw
 0n5n85my190UTUHLg8SmvHDHJvFHcyNlBU9XleRytWhmploJFcJX4vBvDzn6gMrnjnKg EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s5j5u207g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 15:26:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UFOkof124244;
        Tue, 30 Apr 2019 15:26:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2s4ew1aach-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 15:26:28 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UFQRom010154;
        Tue, 30 Apr 2019 15:26:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 08:26:27 -0700
Date:   Tue, 30 Apr 2019 08:26:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 4/5] iomap: Add a page_prepare callback
Message-ID: <20190430152625.GE5200@magnolia>
References: <20190429220934.10415-1-agruenba@redhat.com>
 <20190429220934.10415-5-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429220934.10415-5-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300095
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300095
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:09:33AM +0200, Andreas Gruenbacher wrote:
> Move the page_done callback into a separate iomap_page_ops structure and
> add a page_prepare calback to be called before the next page is written
> to.  In gfs2, we'll want to start a transaction in page_prepare and end
> it in page_done.  Other filesystems that implement data journaling will
> require the same kind of mechanism.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks fine, assuming you've done the appropriate QA/testing on the gfs2
side. :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/gfs2/bmap.c        | 15 ++++++++++-----
>  fs/iomap.c            | 36 ++++++++++++++++++++++++++----------
>  include/linux/iomap.h | 22 +++++++++++++++++-----
>  3 files changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 5da4ca9041c0..aa014725f84a 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -991,15 +991,20 @@ static void gfs2_write_unlock(struct inode *inode)
>  	gfs2_glock_dq_uninit(&ip->i_gh);
>  }
>  
> -static void gfs2_iomap_journaled_page_done(struct inode *inode, loff_t pos,
> -				unsigned copied, struct page *page,
> -				struct iomap *iomap)
> +static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
> +				 unsigned copied, struct page *page,
> +				 struct iomap *iomap)
>  {
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  
> -	gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
> +	if (page)
> +		gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
>  }
>  
> +static const struct iomap_page_ops gfs2_iomap_page_ops = {
> +	.page_done = gfs2_iomap_page_done,
> +};
> +
>  static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
>  				  loff_t length, unsigned flags,
>  				  struct iomap *iomap,
> @@ -1077,7 +1082,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
>  		}
>  	}
>  	if (!gfs2_is_stuffed(ip) && gfs2_is_jdata(ip))
> -		iomap->page_done = gfs2_iomap_journaled_page_done;
> +		iomap->page_ops = &gfs2_iomap_page_ops;
>  	return 0;
>  
>  out_trans_end:
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 62e3461704ce..a3ffc83134ee 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -665,6 +665,7 @@ static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		struct page **pagep, struct iomap *iomap)
>  {
> +	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	pgoff_t index = pos >> PAGE_SHIFT;
>  	struct page *page;
>  	int status = 0;
> @@ -674,9 +675,17 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
>  
> +	if (page_ops && page_ops->page_prepare) {
> +		status = page_ops->page_prepare(inode, pos, len, iomap);
> +		if (status)
> +			return status;
> +	}
> +
>  	page = grab_cache_page_write_begin(inode->i_mapping, index, flags);
> -	if (!page)
> -		return -ENOMEM;
> +	if (!page) {
> +		status = -ENOMEM;
> +		goto out_no_page;
> +	}
>  
>  	if (iomap->type == IOMAP_INLINE)
>  		iomap_read_inline_data(inode, page, iomap);
> @@ -684,15 +693,21 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
>  	else
>  		status = __iomap_write_begin(inode, pos, len, page, iomap);
> -	if (unlikely(status)) {
> -		unlock_page(page);
> -		put_page(page);
> -		page = NULL;
>  
> -		iomap_write_failed(inode, pos, len);
> -	}
> +	if (unlikely(status))
> +		goto out_unlock;
>  
>  	*pagep = page;
> +	return 0;
> +
> +out_unlock:
> +	unlock_page(page);
> +	put_page(page);
> +	iomap_write_failed(inode, pos, len);
> +
> +out_no_page:
> +	if (page_ops && page_ops->page_done)
> +		page_ops->page_done(inode, pos, 0, NULL, iomap);
>  	return status;
>  }
>  
> @@ -766,6 +781,7 @@ static int
>  iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  		unsigned copied, struct page *page, struct iomap *iomap)
>  {
> +	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	int ret;
>  
>  	if (iomap->type == IOMAP_INLINE) {
> @@ -778,8 +794,8 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	}
>  
>  	__generic_write_end(inode, pos, ret, page);
> -	if (iomap->page_done)
> -		iomap->page_done(inode, pos, copied, page, iomap);
> +	if (page_ops && page_ops->page_done)
> +		page_ops->page_done(inode, pos, copied, page, iomap);
>  	put_page(page);
>  
>  	if (ret < len)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0fefb5455bda..2103b94cb1bf 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -53,6 +53,8 @@ struct vm_fault;
>   */
>  #define IOMAP_NULL_ADDR -1ULL	/* addr is not valid */
>  
> +struct iomap_page_ops;
> +
>  struct iomap {
>  	u64			addr; /* disk offset of mapping, bytes */
>  	loff_t			offset;	/* file offset of mapping, bytes */
> @@ -63,12 +65,22 @@ struct iomap {
>  	struct dax_device	*dax_dev; /* dax_dev for dax operations */
>  	void			*inline_data;
>  	void			*private; /* filesystem private */
> +	const struct iomap_page_ops *page_ops;
> +};
>  
> -	/*
> -	 * Called when finished processing a page in the mapping returned in
> -	 * this iomap.  At least for now this is only supported in the buffered
> -	 * write path.
> -	 */
> +/*
> + * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
> + * and page_done will be called for each page written to.  This only applies to
> + * buffered writes as unbuffered writes will not typically have pages
> + * associated with them.
> + *
> + * When page_prepare succeeds, page_done will always be called to do any
> + * cleanup work necessary.  In that page_done call, @page will be NULL if the
> + * associated page could not be obtained.
> + */
> +struct iomap_page_ops {
> +	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len,
> +			struct iomap *iomap);
>  	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
>  			struct page *page, struct iomap *iomap);
>  };
> -- 
> 2.20.1
> 
