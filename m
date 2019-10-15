Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCEAD7E57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfJOSBb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:01:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46472 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOSBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:01:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmctP077103;
        Tue, 15 Oct 2019 18:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=o4PHRISe+vUADIFJwhtL70wqMiMYtcEjMEZ1FRwGxrg=;
 b=SzDjBz+6RhmaQ7DS+C4xMjAzWZaWC22S2KOLhiRkQ2oJQjLgF4AqkJOTMqXqOa1aCmP3
 CjMfG56zcCHYzh5LaaupRg8bFoUTa+vUmmXhWJ1J+pp6bIyJgtoZqi+DyXS+e2h/S6dS
 dIPwwJrxzXc7aDoFQ0ZfJuUfzK0cmxUsUwULj0FdviGNEv0rvbu5kc10KOQR/etH8Br3
 r9sJM97Olr8Wc4JFkjPWVRNA+r532xEPoz/eO+ZXSEWmEfPk52qVFmNoYAmxppURJl7B
 AYycbB/DiKg+y3DRCrTKHeQ4mWsR7RiUh+UMXPEYPKzHhRJds9vxIfB+lu4X168TGvla 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vk6sqhu7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:01:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmFlP048830;
        Tue, 15 Oct 2019 18:01:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vnf7rnnk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:01:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9FI1LK4013097;
        Tue, 15 Oct 2019 18:01:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 11:01:20 -0700
Date:   Tue, 15 Oct 2019 11:01:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] xfs: set IOMAP_F_NEW more carefully
Message-ID: <20191015180119.GQ13108@magnolia>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154345.13052-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:43:35PM +0200, Christoph Hellwig wrote:
> Don't set IOMAP_F_NEW if we COW over and existing allocated range, as

"..over an existing..."

> these aren't strictly new allocations.  This is required to be able to
> use IOMAP_F_NEW to zero newly allocated blocks, which is required for
> the iomap code to fully support file systems that don't do delayed
> allocations or use unwritten extents.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than that,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iomap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 54c9ec7ad337..c0a492353826 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -707,9 +707,12 @@ xfs_file_iomap_begin_delay(
>  	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
>  	 * them out if the write happens to fail.
>  	 */
> -	iomap_flags |= IOMAP_F_NEW;
> -	trace_xfs_iomap_alloc(ip, offset, count, whichfork,
> -			whichfork == XFS_DATA_FORK ? &imap : &cmap);
> +	if (whichfork == XFS_DATA_FORK) {
> +		iomap_flags |= IOMAP_F_NEW;
> +		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
> +	} else {
> +		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
> +	}
>  done:
>  	if (whichfork == XFS_COW_FORK) {
>  		if (imap.br_startoff > offset_fsb) {
> -- 
> 2.20.1
> 
