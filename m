Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C162950B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444615AbgJUQZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 12:25:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52626 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390908AbgJUQZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:25:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LGODWG152937;
        Wed, 21 Oct 2020 16:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=d3ckWHdveMySigHXiLucQZSgdA4gFXNzC2B9tGAIPAo=;
 b=MICm2Zu1pirl3epjh2xBAgDX5GmSCyCYCSGszeY6Gg2KLTyNitrkQnN+E83cXbPzIYfx
 tPMsO/NCJgusFCyhLJL/tXzT7DSNicVeYRxvLdXr5p+C4nNwSQQ0i+39f8RO+wXvGO9T
 8AEwagcwYYZG6iGBWOAI8b+KcsSAJnxIuwix8dQ+BlFkwZb3d0IhqT5ihfAcDgDgOGEI
 2+Tu8irINIvyy4+WfuZcYjX1dQVoTYvFURBEVzYwvlqOW86IIRkTtI76dgP+BlF5uY8z
 won7VsmsgC8Zm8ZC929ptfhYv3AeuIMLHAojCvQir1CCtIy9AZKlXRw1E1k9MAyEuLl7 Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34ak16htf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 16:25:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LGOwc7047879;
        Wed, 21 Oct 2020 16:25:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 348ahxs7ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 16:25:49 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09LGPm3j023051;
        Wed, 21 Oct 2020 16:25:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Oct 2020 09:25:48 -0700
Date:   Wed, 21 Oct 2020 09:25:47 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] iomap: zero cached page over unwritten extent on
 truncate page
Message-ID: <20201021162547.GL9832@magnolia>
References: <20201021133329.1337689-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021133329.1337689-1-bfoster@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210119
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 09:33:29AM -0400, Brian Foster wrote:
> iomap_truncate_page() relies on zero range and zero range
> unconditionally skips unwritten mappings. This is normally not a
> problem as most users synchronize in-core state to the underlying
> block mapping by flushing pagecache prior to calling into iomap.
> This is not the case for iomap_truncate_page(), however. XFS calls
> iomap_truncate_page() on truncate down before flushing the new EOF
> page of the file. This means that if the new EOF block is unwritten
> but covered by a dirty or writeback page (i.e. awaiting unwritten
> conversion after writeback), iomap fails to zero that page. The
> subsequent truncate_setsize() call does perform page zeroing, but
> doesn't dirty the page. Therefore if the new EOF page is written
> back after calling into iomap but before the pagecache truncate, the
> post-EOF zeroing is lost on page reclaim. This exposes stale
> post-EOF data on mapped reads.
> 
> Rework iomap_truncate_page() to check pagecache state before calling
> into iomap_apply() and use that info to determine whether we can
> safely skip zeroing unwritten extents. The filesystem has locked out
> concurrent I/O and mapped operations at this point but is not
> serialized against writeback, unwritten extent conversion (I/O
> completion) or page reclaim. Therefore if a page does not exist
> before we acquire the mapping, we can be certain that an unwritten
> extent cannot be converted before we return and thus it is safe to
> skip. If a page does exist over an unwritten block, it could be in
> the dirty or writeback states, convert the underlying mapping at any
> time, and thus should be explicitly written to avoid racing with
> writeback. Finally, since iomap_truncate_page() only targets the new
> EOF block and must now pass additional state to the actor, open code
> the zeroing actor instead of plumbing through zero range.
> 
> This does have the tradeoff that an existing clean page is dirtied
> and causes unwritten conversion, but this is analogous to historical
> behavior implemented by block_truncate_page(). This patch restores
> historical behavior to address the data exposure problem and leaves
> filtering out the clean page case for a separate patch.
> Fixes: 68a9f5e7007c ("xfs: implement iomap based buffered write path")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> v2:
> - Rework to check for cached page explicitly and avoid use of seek data.
> v1: https://lore.kernel.org/linux-fsdevel/20201012140350.950064-1-bfoster@redhat.com/

Has the reproducer listed in that email been turned into a fstest case
yet? :)

> 
>  fs/iomap/buffered-io.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..2cdfcff02307 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1000,17 +1000,56 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  }
>  EXPORT_SYMBOL_GPL(iomap_zero_range);
>  
> +struct iomap_trunc_priv {
> +	bool *did_zero;
> +	bool has_page;
> +};
> +
> +static loff_t
> +iomap_truncate_page_actor(struct inode *inode, loff_t pos, loff_t count,
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct iomap_trunc_priv	*priv = data;
> +	unsigned offset;
> +	int status;
> +
> +	if (srcmap->type == IOMAP_HOLE)
> +		return count;
> +	if (srcmap->type == IOMAP_UNWRITTEN && !priv->has_page)
> +		return count;
> +
> +	offset = offset_in_page(pos);
> +	if (IS_DAX(inode))
> +		status = dax_iomap_zero(pos, offset, count, iomap);
> +	else
> +		status = iomap_zero(inode, pos, offset, count, iomap, srcmap);
> +	if (status < 0)
> +		return status;
> +
> +	if (priv->did_zero)
> +		*priv->did_zero = true;
> +	return count;
> +}
> +
>  int
>  iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  		const struct iomap_ops *ops)
>  {
> +	struct iomap_trunc_priv priv = { .did_zero = did_zero };
>  	unsigned int blocksize = i_blocksize(inode);
>  	unsigned int off = pos & (blocksize - 1);
> +	loff_t ret;
>  
>  	/* Block boundary? Nothing to do */
>  	if (!off)
>  		return 0;
> -	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
> +
> +	priv.has_page = filemap_range_has_page(inode->i_mapping, pos, pos);

Er... shouldn't that second 'pos' be 'pos + blocksize - off - 1', like
the apply call below?  I guess it doesn't matter since we're only
interested in the page at pos, but the double usage of pos caught my
eye.

I also wonder, can you move this into the actor so that you can pass
*did_zero straight through without the two-item struct?

--D

> +	ret = iomap_apply(inode, pos, blocksize - off, IOMAP_ZERO, ops, &priv,
> +			  iomap_truncate_page_actor);
> +	if (ret <= 0)
> +		return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iomap_truncate_page);
>  
> -- 
> 2.25.4
> 
