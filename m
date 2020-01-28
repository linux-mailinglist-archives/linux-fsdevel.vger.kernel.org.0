Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD82D14BCDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgA1P3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 10:29:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41308 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgA1P3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:29:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SFPHgT186968;
        Tue, 28 Jan 2020 15:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=WKREm9GNdyHPTYI+kbYnItKrdQm6BQxz8RGHgWDEdBs=;
 b=SraNQwis3xFBm/dZOJrrrQ+xbi7eCLXwJMJehAus9po8wcNcz0r2GBo/eKXhMr+cm737
 FpbBmpisHvwGZBdKewx373fGocUvgR7Fj4CzoPX8YE6X5SEe0syC5mee2PTq5dPu+KJv
 X51M77rM4Q+yHvLk4pW6DoewB4LI2oqw7qFJxXSSOUp7xoW7gcqmdiE+LxOoRnfGALxF
 u1N3q0PdRqHc3aGhvtzekBQtcJQJbIkeTsQtZthJ7Sfni6pp3ulqeniDb92VgCZvzERA
 n4n9lDeqSadUW4W/TkraGFUkGrnzk1xnfk6SqgWiEbGvU4kLxMGckpW2JfKFdAz/7mHQ Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xrd3u71ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 15:28:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SFLOUN033729;
        Tue, 28 Jan 2020 15:28:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xta8hyhbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 15:28:37 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00SFSWX2029827;
        Tue, 28 Jan 2020 15:28:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 07:28:32 -0800
Date:   Tue, 28 Jan 2020 07:28:30 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [RFCv2 4/4] ext4: Move ext4_fiemap to use iomap infrastructure
Message-ID: <20200128152830.GA3673284@magnolia>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <0147a2923d339bdef5802dde8d5019d719f0d796.1580121790.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0147a2923d339bdef5802dde8d5019d719f0d796.1580121790.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 03:48:28PM +0530, Ritesh Harjani wrote:
> Since ext4 already defines necessary iomap_ops required to move to iomap
> for fiemap, so this patch makes those changes to use existing iomap_ops
> for ext4_fiemap and thus removes all unwanted code.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/extents.c | 279 +++++++---------------------------------------
>  fs/ext4/inline.c  |  41 -------
>  2 files changed, 38 insertions(+), 282 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0de548bb3c90..901caee2fcb1 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c

<snip> Just a cursory glance...

> @@ -5130,40 +4927,42 @@ static int ext4_xattr_fiemap(struct inode *inode,
>  				EXT4_I(inode)->i_extra_isize;
>  		physical += offset;
>  		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
> -		flags |= FIEMAP_EXTENT_DATA_INLINE;
>  		brelse(iloc.bh);
>  	} else { /* external block */
>  		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
>  		length = inode->i_sb->s_blocksize;
>  	}
>  
> -	if (physical)
> -		error = fiemap_fill_next_extent(fieinfo, 0, physical,
> -						length, flags);
> -	return (error < 0 ? error : 0);
> +	iomap->addr = physical;
> +	iomap->offset = 0;
> +	iomap->length = length;
> +	iomap->type = IOMAP_INLINE;
> +	iomap->flags = 0;

Er... external "ACL" blocks aren't IOMAP_INLINE.

--D
