Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA0F85FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 02:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKLBW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 20:22:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57026 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLBW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:22:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1JTn4192249;
        Tue, 12 Nov 2019 01:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=lt7kkzcvr2Zm1WF2FX3Ksi0MjcHQEjcfJJDJewsWcYI=;
 b=lfF3K+xvXBRLhyzLBdNEzLgWiDXdCo5FUt/15WHATTk/4qf5I+/lhhYXKuGLEkm9B1PN
 3pZvv5XkvrJ5z0yII2YehD4yLk0tXPyazpdHM4+j61lIlFKLp8v7x+mbpFxpIr5viMkQ
 B2l/HId1bpd27on/Eo643KO3VuuW2JP2kaA9OuvvaXgBCkJYQIjwD/+wFAOgaSxbLzQy
 lVgd5ejB+QAgki41orPc8rKFs9FcFHmylS/jI44E1P95vRpGDFWmSTfPZIzBXn8S7ovZ
 vNTi8KShws8rLkwXpFU/AvWqJRkU6b7kbQOmZ1Q+6zIy0xospzde6AalavXAP0YjvDzE yA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w5ndq1jmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:20:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1JTJM180457;
        Tue, 12 Nov 2019 01:20:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w67kmu553-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:20:42 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAC1KdN4027423;
        Tue, 12 Nov 2019 01:20:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Nov 2019 17:20:39 -0800
Date:   Mon, 11 Nov 2019 17:20:37 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] fs: Clean up mapping variable
Message-ID: <20191112012037.GU6219@magnolia>
References: <20191112003452.4756-1-ira.weiny@intel.com>
 <20191112003452.4756-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112003452.4756-2-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120009
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:34:51PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The mapping variable is not directly used in these functions.  Just
> remove the additional variable.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/f2fs/data.c      | 3 +--
>  fs/iomap/swapfile.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ba3bcf4c7889..3c7777bfae17 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3146,8 +3146,7 @@ int f2fs_migrate_page(struct address_space *mapping,
>  /* Copied from generic_swapfile_activate() to check any holes */
>  static int check_swap_activate(struct file *swap_file, unsigned int max)
>  {
> -	struct address_space *mapping = swap_file->f_mapping;
> -	struct inode *inode = mapping->host;
> +	struct inode *inode = swap_file->f_mapping->host;
>  	unsigned blocks_per_page;
>  	unsigned long page_no;
>  	unsigned blkbits;
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index a648dbf6991e..80571add0180 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -140,8 +140,7 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  		.sis = sis,
>  		.lowest_ppage = (sector_t)-1ULL,
>  	};
> -	struct address_space *mapping = swap_file->f_mapping;
> -	struct inode *inode = mapping->host;
> +	struct inode *inode = swap_file->f_mapping->host;

For the iomap part,

Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  	loff_t pos = 0;
>  	loff_t len = ALIGN_DOWN(i_size_read(inode), PAGE_SIZE);
>  	loff_t ret;
> -- 
> 2.20.1
> 
