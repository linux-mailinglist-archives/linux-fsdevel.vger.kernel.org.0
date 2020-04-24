Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3485F1B7D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 19:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgDXRu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 13:50:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgDXRu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:50:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OHmomj134954;
        Fri, 24 Apr 2020 17:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=DWVlIf5mYZCVzyqUXeahD+T71Oe9wN0qoPC1nsa6ZEU=;
 b=Wic9SnakIOrdtXgbiLArQULRol0LPr4BC1E2yKdb57XexeCCHSYc75DC4qD3xg7MkLsX
 CRrdcr2Xu4KC3F84Aptrvmkdl5sTy3oeeJ6cZU2YnCheQeDE1F2P0Dt5s47FlKoekI7A
 q6341zQF2rQM8c+GAnKB5wYb1Y7LHYnHoY5jXqS5PCcQXN+3+AVu0scGUEfDDKy8QWY4
 p3iwMzFr35LXPY7YCpHiFwMN+SfdCvcJ5X4VAUKjkigUdZm86iPEX0VRLhthPRmf0ldA
 ahiv2E4yQCiGM3VdVC3YGBuZWJiEI2JInS+b2NVZQ9Pe3u4H9lisnygjhKLgVjVC1loG cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30ketdnq94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 17:50:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OHldRt078223;
        Fri, 24 Apr 2020 17:48:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30k7qxjw26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 17:48:19 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03OHmHI4016218;
        Fri, 24 Apr 2020 17:48:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 10:48:16 -0700
Date:   Fri, 24 Apr 2020 10:48:15 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: bmap: Remove the WARN and return the proper
 block address
Message-ID: <20200424174815.GF6733@magnolia>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e2e09c5d840458b4ace6f9b31429ceefd9c1df01.1587670914.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e09c5d840458b4ace6f9b31429ceefd9c1df01.1587670914.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240136
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:52:18PM +0530, Ritesh Harjani wrote:
> iomap_bmap() could be called from either of these two paths.
> Either when a user is calling an ioctl_fibmap() interface to get
> the block mapping address or by some filesystem via use of bmap()
> internal kernel API.
> bmap() kernel API is well equipped with handling of u64 addresses.
> 
> WARN condition in iomap_bmap_actor() was mainly added to warn all
> the fibmap users. But now that in previous patch we have directly added
> this WARN condition for all fibmap users and also made sure to return 0
> as block map address in case if addr > INT_MAX. 
> So we can now remove this logic from here.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/iomap/fiemap.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index bccf305ea9ce..d55e8f491a5e 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -117,10 +117,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  	if (iomap->type == IOMAP_MAPPED) {
>  		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
> -		if (addr > INT_MAX)
> -			WARN(1, "would truncate bmap result\n");

Frankly I would've combined these two patches to make it more obvious
that we're hoisting a FIBMAP constraint check from iomap into the ioctl
handler.

--D

> -		else
> -			*bno = addr;
> +		*bno = addr;
>  	}
>  	return 0;
>  }
> -- 
> 2.21.0
> 
