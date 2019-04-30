Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A60DFCB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfD3PYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:24:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57784 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3PYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:24:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UFL2xB106914;
        Tue, 30 Apr 2019 15:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UL8akE2341IVNeapyyvljzXu78o4iHQf73fw4k3T+ck=;
 b=VOiSvB1TwdwOo69mSHaxccRH1E6odKRb5cOsUUsQj440V3vY4aZGKv421ikURYdOycP1
 ct3/4rP7d0MUlAPcv4YPSgnSqVLLsTHp1efDmDWRoFHN/TbyVl7Nx8S6xEkgreOgl3Mo
 FJ03P711Q1Gil53/qs5cTp+moK6EjU1Vzzysc7tTx80vgeITZFT2h4iyFuk4fNrnJHNo
 lhaUY6LbzNyNyD+zEmynqFtKpGHzGPJfop9VidTOC647tGPs/KyejCRNHHdIgbIzPsnz
 uqbGuXFgAxL5Gx6w4FxjbB04SSgXNUw8XtxiLYA2+NWWktTQSjF5AmCZRZ8rJPpPQVWT RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s5j5u1ynh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 15:23:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UFNC3A118995;
        Tue, 30 Apr 2019 15:23:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2s4ew1a8qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 15:23:28 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UFNRcM008288;
        Tue, 30 Apr 2019 15:23:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 08:23:26 -0700
Date:   Tue, 30 Apr 2019 08:23:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 3/5] iomap: Fix use-after-free error in page_done
 callback
Message-ID: <20190430152325.GD5200@magnolia>
References: <20190429220934.10415-1-agruenba@redhat.com>
 <20190429220934.10415-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429220934.10415-4-agruenba@redhat.com>
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
 definitions=main-1904300094
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:09:32AM +0200, Andreas Gruenbacher wrote:
> In iomap_write_end, we're not holding a page reference anymore when
> calling the page_done callback, but the callback needs that reference to
> access the page.  To fix that, move the put_page call in
> __generic_write_end into the callers of __generic_write_end.  Then, in
> iomap_write_end, put the page after calling the page_done callback.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Fixes: 63899c6f8851 ("iomap: add a page_done callback")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/buffer.c | 2 +-
>  fs/iomap.c  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index e0d4c6a5e2d2..0faa41fb4c88 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2104,7 +2104,6 @@ void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
>  	}
>  
>  	unlock_page(page);
> -	put_page(page);
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(inode, old_size, pos);
> @@ -2160,6 +2159,7 @@ int generic_write_end(struct file *file, struct address_space *mapping,
>  {
>  	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
>  	__generic_write_end(mapping->host, pos, copied, page);
> +	put_page(page);
>  	return copied;
>  }
>  EXPORT_SYMBOL(generic_write_end);
> diff --git a/fs/iomap.c b/fs/iomap.c
> index f8c9722d1a97..62e3461704ce 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -780,6 +780,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	__generic_write_end(inode, pos, ret, page);
>  	if (iomap->page_done)
>  		iomap->page_done(inode, pos, copied, page, iomap);
> +	put_page(page);
>  
>  	if (ret < len)
>  		iomap_write_failed(inode, pos, len);
> -- 
> 2.20.1
> 
