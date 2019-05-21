Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0014425633
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 18:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfEUQyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 12:54:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48530 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfEUQyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 12:54:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LGmok1004822;
        Tue, 21 May 2019 16:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Pz6BufVarPJg8ICI5ViYb3JygWozLK3xsIvX2++usjc=;
 b=YDWuZZyvqldL74IykiKin4/zl4iLSTQrI05qhcS8lNtW56kwcy4m8+x1g97nKr6bYVMp
 +cm+SxMUZAmPhDjHbfIPn/IUZW+cBwkJzae6WuRPrhzlguSIJrkBPXazAIqRJZxxpQ3L
 OnvjtU4h4ZdozFgYMyyqQ4XR4Rnu+5xksVUDyaSrzE1JzgP5trlmn7owztbp+LVqp+70
 7qwzCD3IAuUyp9wYrQd3iUgwh1X20b55f78DheMuM486PNmvpIhpDfAYnkJsXWn3rSoR
 REt15auisiKhhXBmghahKf0fVJFWDmUKT6SVgAOjjoMvzvAgjsGA3ccEWvH8MGvSLjLI 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2sjapqep03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 16:54:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LGpWNW173928;
        Tue, 21 May 2019 16:52:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2sks1yadjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 16:52:04 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LGq0ja019690;
        Tue, 21 May 2019 16:52:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 16:52:00 +0000
Date:   Tue, 21 May 2019 09:51:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190521165158.GB5125@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-5-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210103
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210103
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:26:35PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> The IOMAP_DAX_COW is a iomap type which performs copy of
> edges of data while performing a write if start/end are
> not page aligned. The source address is expected in
> iomap->inline_data.
> 
> dax_copy_edges() is a helper functions performs a copy from
> one part of the device to another for data not page aligned.
> If iomap->inline_data is NULL, it memset's the area to zero.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/dax.c              | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/iomap.h |  1 +
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index e5e54da1715f..610bfa861a28 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1084,6 +1084,42 @@ int __dax_zero_page_range(struct block_device *bdev,
>  }
>  EXPORT_SYMBOL_GPL(__dax_zero_page_range);
>  
> +/*
> + * dax_copy_edges - Copies the part of the pages not included in
> + * 		    the write, but required for CoW because
> + * 		    offset/offset+length are not page aligned.
> + */
> +static int dax_copy_edges(struct inode *inode, loff_t pos, loff_t length,
> +			   struct iomap *iomap, void *daddr)
> +{
> +	unsigned offset = pos & (PAGE_SIZE - 1);
> +	loff_t end = pos + length;
> +	loff_t pg_end = round_up(end, PAGE_SIZE);
> +	void *saddr = iomap->inline_data;
> +	int ret = 0;
> +	/*
> +	 * Copy the first part of the page
> +	 * Note: we pass offset as length
> +	 */
> +	if (offset) {
> +		if (saddr)
> +			ret = memcpy_mcsafe(daddr, saddr, offset);
> +		else
> +			memset(daddr, 0, offset);
> +	}
> +
> +	/* Copy the last part of the range */
> +	if (end < pg_end) {
> +		if (saddr)
> +			ret = memcpy_mcsafe(daddr + offset + length,
> +			       saddr + offset + length,	pg_end - end);
> +		else
> +			memset(daddr + offset + length, 0,
> +					pg_end - end);
> +	}
> +	return ret;
> +}
> +
>  static loff_t
>  dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap)
> @@ -1105,9 +1141,11 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			return iov_iter_zero(min(length, end - pos), iter);
>  	}
>  
> -	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> +	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED
> +			 && iomap->type != IOMAP_DAX_COW))

I reiterate (from V3) that the && goes on the previous line...

	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
			 iomap->type != IOMAP_DAX_COW))

>  		return -EIO;
>  
> +
>  	/*
>  	 * Write can allocate block for an area which has a hole page mapped
>  	 * into page tables. We have to tear down these mappings so that data
> @@ -1144,6 +1182,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			break;
>  		}
>  
> +		if (iomap->type == IOMAP_DAX_COW) {
> +			ret = dax_copy_edges(inode, pos, length, iomap, kaddr);
> +			if (ret)
> +				break;
> +		}
> +
>  		map_len = PFN_PHYS(map_len);
>  		kaddr += offset;
>  		map_len -= offset;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0fefb5455bda..6e885c5a38a3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -25,6 +25,7 @@ struct vm_fault;
>  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
>  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
>  #define IOMAP_INLINE	0x05	/* data inline in the inode */

> +#define IOMAP_DAX_COW	0x06

DAX isn't going to be the only scenario where we need a way to
communicate to iomap actors the need to implement copy on write.

XFS also uses struct iomap to hand out file leases to clients.  The
lease code /currently/ doesn't support files with shared blocks (because
the only user is pNFS) but one could easily imagine a future where some
client wants to lease a file with shared blocks, in which case XFS will
want to convey the COW details to the lessee.

> +/* Copy data pointed by inline_data before write*/

A month ago during the V3 patchset review, I wrote (possibly in an other
thread, sorry) about something that I'm putting my foot down about now
for the V4 patchset, which is the {re,ab}use of @inline_data for the
data source address.

We cannot use @inline_data to convey the source address.  @inline_data
(so far) is used to point to the in-memory representation of the storage
described by @addr.  For data writes, @addr is the location of the write
on disk and @inline_data is the location of the write in memory.

Reusing @inline_data here to point to the location of the source data in
memory is a totally different thing and will likely result in confusion.
On a practical level, this also means that we cannot support the case of
COW && INLINE because the type codes collide and so would the users of
@inline_data.  This isn't required *right now*, but if you had a pmem
filesystem that stages inode updates in memory and flips a pointer to
commit changes then the ->iomap_begin function will need to convey two
pointers at once.

So this brings us back to Dave's suggestion during the V1 patchset
review that instead of adding more iomap flags/types and overloading
fields, we simply pass two struct iomaps into ->iomap_begin:

 - Change iomap_apply() to "struct iomap iomap[2] = 0;" and pass
   &iomap[0] into the ->iomap_begin and ->iomap_end functions.  The
   first iomap will be filled in with the destination for the write (as
   all implementations do now), and the second iomap can be filled in
   with the source information for a COW operation.

 - If the ->iomap_begin implementation decides that COW is necessary for
   the requested operation, then it should fill out that second iomap
   with information about the extent that the actor must copied before
   returning.  The second iomap's offset and length must match the
   first.  If COW isn't necessary, the ->iomap_begin implementation
   ignores it, and the second iomap retains type == 0 (i.e. invalid
   mapping).

Proceeding along these lines will (AFAICT) still allow you to enable all
the btrfs functionality in the rest of this patchset while making the
task of wiring up XFS fairly simple.  No overloaded fields and no new
flags.

This is how I'd like to see this patchset should proceed to V5.  Does
that make sense?

--D

>  
>  /*
>   * Flags for all iomap mappings:
> -- 
> 2.16.4
> 
