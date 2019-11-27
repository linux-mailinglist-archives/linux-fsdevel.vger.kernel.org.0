Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC3010B2C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfK0Pwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 10:52:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38300 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0Pwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:52:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARFi6ak075759;
        Wed, 27 Nov 2019 15:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=H+/wgbi6zpbbhzBcnf3ZgXVMUMhhbOupxJKtToXxUKY=;
 b=Kg0k/vAlSe8xFiAPHV3p230uhEAIhD+RfNy3L2xMgLeJjWzANRMgYHEoE0Ep3N7qUiEj
 vcF15VBYr8vifEfZfiVr6t7u8ViSjjCg7FNvuwZfLuggXSVyPGlhSN6JUTfYB83peZvJ
 2Uo59BKL0j0vX1rUEJqlR/o/pNlsdkvaPc0SHw+2iWbYlZWmF6wiaTespaEP5ykBV9AG
 ImLwc8stIz9ZL95hlZuIpbBT4NAPPaz+UgI3qRiVr/uxeOf58bY1exPNLO2+wgw9Fc9C
 Rl8vZBiL+t0XTNoRZlRlrnqJqMZNYYPP0oHZxwuNG+rB9l114hLMSs0+hA/EVvczaecf TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wewdrecda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 15:52:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARFdTWt031310;
        Wed, 27 Nov 2019 15:50:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wgvhccg37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 15:50:05 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xARFnumk003050;
        Wed, 27 Nov 2019 15:49:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Nov 2019 07:49:56 -0800
Date:   Wed, 27 Nov 2019 07:49:54 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] fs: Fix page_mkwrite off-by-one errors
Message-ID: <20191127154954.GT6219@magnolia>
References: <20191127151811.9229-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127151811.9229-1-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911270137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911270137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 04:18:11PM +0100, Andreas Gruenbacher wrote:
> Fix a check in block_page_mkwrite meant to determine whether an offset
> is within the inode size.  This error has spread to several filesystems
> and to iomap_page_mkwrite, so fix those instances as well.

Seeing how this has gotten screwed up at least six times in the kernel,
maybe we need a static inline helper to do this for us?

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

The iomap part looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(I might just extract the iomap part and put it in the iomap tree if
someone doesn't merge this one before I get to it...)

--D

> 
> ---
> 
> This patch has a trivial conflict with commit "iomap: Fix overflow in
> iomap_page_mkwrite" in Darrick's iomap pull request for 5.5:
> 
>   https://lore.kernel.org/lkml/20191125190907.GN6219@magnolia/
> ---
>  fs/buffer.c            | 2 +-
>  fs/ceph/addr.c         | 2 +-
>  fs/ext4/inode.c        | 2 +-
>  fs/f2fs/file.c         | 2 +-
>  fs/iomap/buffered-io.c | 2 +-
>  fs/ubifs/file.c        | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 86a38b979323..152d391858d4 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2465,7 +2465,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>  	lock_page(page);
>  	size = i_size_read(inode);
>  	if ((page->mapping != inode->i_mapping) ||
> -	    (page_offset(page) > size)) {
> +	    (page_offset(page) >= size)) {
>  		/* We overload EFAULT to mean page got truncated */
>  		ret = -EFAULT;
>  		goto out_unlock;
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 7ab616601141..9fa0729ece41 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>  	do {
>  		lock_page(page);
>  
> -		if ((off > size) || (page->mapping != inode->i_mapping)) {
> +		if ((off >= size) || (page->mapping != inode->i_mapping)) {
>  			unlock_page(page);
>  			ret = VM_FAULT_NOPAGE;
>  			break;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..6dd4efe2fb63 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6224,7 +6224,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  	lock_page(page);
>  	size = i_size_read(inode);
>  	/* Page got truncated from under us? */
> -	if (page->mapping != mapping || page_offset(page) > size) {
> +	if (page->mapping != mapping || page_offset(page) >= size) {
>  		unlock_page(page);
>  		ret = VM_FAULT_NOPAGE;
>  		goto out;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 29bc0a542759..3436be01af45 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -71,7 +71,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	down_read(&F2FS_I(inode)->i_mmap_sem);
>  	lock_page(page);
>  	if (unlikely(page->mapping != inode->i_mapping ||
> -			page_offset(page) > i_size_read(inode) ||
> +			page_offset(page) >= i_size_read(inode) ||
>  			!PageUptodate(page))) {
>  		unlock_page(page);
>  		err = -EFAULT;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e25901ae3ff4..d454dbab5133 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1041,7 +1041,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  	lock_page(page);
>  	size = i_size_read(inode);
>  	if ((page->mapping != inode->i_mapping) ||
> -	    (page_offset(page) > size)) {
> +	    (page_offset(page) >= size)) {
>  		/* We overload EFAULT to mean page got truncated */
>  		ret = -EFAULT;
>  		goto out_unlock;
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index cd52585c8f4f..ca0148ec77e6 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1564,7 +1564,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  	lock_page(page);
>  	if (unlikely(page->mapping != inode->i_mapping ||
> -		     page_offset(page) > i_size_read(inode))) {
> +		     page_offset(page) >= i_size_read(inode))) {
>  		/* Page got truncated out from underneath us */
>  		goto sigbus;
>  	}
> -- 
> 2.20.1
> 
