Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA83251C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 17:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYPt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 11:49:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56476 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYPt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:49:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PFnGss080059;
        Tue, 25 Aug 2020 15:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=v7dNRcRYGEALCJgrdeZDSk7Asl0U1t5EaYpaMbmd+jw=;
 b=VFKTIto/K1AZDGGWTXKb6nV4CtUpzVYK2AkLk5Yp2+62iM6vbaEdzTXKBSIGPIVLlyE0
 UpxlE1nB3LWpmXiDZUpCslTQYLdjUlNJXLYz5gpLn921JyHpYeMCEHiGXUi8KByFg9pO
 OhHCwA4iTGsYesQaRuFNs6fhZ7yI4k4+iheh65OVRJkLZvLyRSDTMZUm5fuK7y5FnPH6
 H/S+H5xJsfyQb0K7gvbY0V9om8NxCbYUqgcN3XiJ4qGPgl4wxv68ChzTex6o/Qz0+aXe
 5pnAOILeMW0C6CZiRKtfz68VKWh/akIGtvhwNCgjfl+e9X7qCdwuJIW+/gsbnxaUhIb/ OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6tsvkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 15:49:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PFemqV095486;
        Tue, 25 Aug 2020 15:49:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 333r9k20hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 15:49:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PFnZFl017227;
        Tue, 25 Aug 2020 15:49:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 08:49:35 -0700
Date:   Tue, 25 Aug 2020 08:49:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Yuxuan Shui <yshuiv7@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
Message-ID: <20200825154933.GF6090@magnolia>
References: <20200505183608.10280-1-yshuiv7@gmail.com>
 <20200505193049.GC5694@magnolia>
 <20200825123650.3AA34AE045@d06av26.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825123650.3AA34AE045@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=2 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 06:06:49PM +0530, Ritesh Harjani wrote:
> 
> 
> On 5/6/20 1:00 AM, Darrick J. Wong wrote:
> > On Tue, May 05, 2020 at 07:36:08PM +0100, Yuxuan Shui wrote:
> > > commit ac58e4fb03f9d111d733a4ad379d06eef3a24705 moved ext4_bmap from
> > > generic_block_bmap to iomap_bmap, this introduced a regression which
> > > prevents some user from using previously working swapfiles. The kernel
> > > will complain about holes while there is none.
> > > 
> > > What is happening here is that the swapfile has unwritten mappings,
> > > which is rejected by iomap_bmap, but was accepted by ext4_get_block.
> > 
> > ...which is why ext4 ought to use iomap_swapfile_activate.
> 
> I tested this patch (diff below), which seems to be working fine for me
> for straight forward use case of swapon/swapoff on ext4.
> Could you give it a try?
> 
> <log showing ext4_iomap_swap_activate path kicking in>
> swapon  1283 [000]   438.651028:     250000 cpu-clock:pppH:
> 	ffffffff817f7f56 percpu_counter_add_batch+0x26 (/boot/vmlinux)
> 	ffffffff813a61d0 ext4_es_lookup_extent+0x1d0 (/boot/vmlinux)
> 	ffffffff813b8095 ext4_map_blocks+0x65 (/boot/vmlinux)
> 	ffffffff813b8d4b ext4_iomap_begin_report+0x10b (/boot/vmlinux)
> 	ffffffff81367f58 iomap_apply+0xa8 (/boot/vmlinux)
> 	ffffffff8136d1c3 iomap_swapfile_activate+0xb3 (/boot/vmlinux)
> 	ffffffff813b51a5 ext4_iomap_swap_activate+0x15 (/boot/vmlinux)
> 	ffffffff812a3a27 __do_sys_swapon+0xb37 (/boot/vmlinux)
> 	ffffffff812a40f6 __x64_sys_swapon+0x16 (/boot/vmlinux)
> 	ffffffff820b760a do_syscall_64+0x5a (/boot/vmlinux)
> 	ffffffff8220007c entry_SYSCALL_64+0x7c (/boot/vmlinux)
> 	    7ffff7de68bb swapon+0xb (/usr/lib/x86_64-linux-gnu/libc-2.30.so)
> 	66706177732f756d [unknown] ([unknown])
> 
> <shows that swapfile(which I setup using fallocate) has some used bytes>
> $ swapon -s
> Filename                                Type            Size    Used
> Priority
> /home/qemu/swapfile-test                file            2097148 42312   -2
> 
> 
> @Jan/Ted/Darrick,
> 
> I am not that familiar with how swap subsystem works.
> So, is there anything else you feel is required apart from below changes
> for supporting swap_activate via iomap? I did test both swapon/swapoff
> and see that swap is getting used up on ext4 with delalloc mount opt.
> 
> As I see from code, iomap_swapfile_activate is mainly looking for
> extent mapping information of that file to pass to swap subsystem.
> And IIUC, "ext4_iomap_report_ops" is meant exactly for that.
> Same as how we use it in ext4_fiemap().

<nod> The swap code doesn't even care about the file offsets, it just
wants the physical mappings, and it only wants to find real and
unwritten mappings (i.e. no holes, delalloc, or shared extents).

So ... I think it's ok to use the same iomap ops as fiemap.

FWIW the xfs version uses xfs_read_iomap_ops for reads, readahead,
fiemap, and swapfiles, so this is ... probably fine, especially if it
passes the swap group fstests. :)

--D

> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6eae17758ece..1e390157541d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3614,6 +3614,13 @@ static int ext4_set_page_dirty(struct page *page)
>  	return __set_page_dirty_buffers(page);
>  }
> 
> +static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
> +				    struct file *file, sector_t *span)
> +{
> +	return iomap_swapfile_activate(sis, file, span,
> +				       &ext4_iomap_report_ops);
> +}
> +
>  static const struct address_space_operations ext4_aops = {
>  	.readpage		= ext4_readpage,
>  	.readahead		= ext4_readahead,
> @@ -3629,6 +3636,7 @@ static const struct address_space_operations ext4_aops
> = {
>  	.migratepage		= buffer_migrate_page,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_page	= generic_error_remove_page,
> +	.swap_activate 		= ext4_iomap_swap_activate,
>  };
> 
>  static const struct address_space_operations ext4_journalled_aops = {
> @@ -3645,6 +3653,7 @@ static const struct address_space_operations
> ext4_journalled_aops = {
>  	.direct_IO		= noop_direct_IO,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_page	= generic_error_remove_page,
> +	.swap_activate 		= ext4_iomap_swap_activate,
>  };
> 
>  static const struct address_space_operations ext4_da_aops = {
> @@ -3662,6 +3671,7 @@ static const struct address_space_operations
> ext4_da_aops = {
>  	.migratepage		= buffer_migrate_page,
>  	.is_partially_uptodate  = block_is_partially_uptodate,
>  	.error_remove_page	= generic_error_remove_page,
> +	.swap_activate 		= ext4_iomap_swap_activate,
>  };
> 
>  static const struct address_space_operations ext4_dax_aops = {
> @@ -3670,6 +3680,7 @@ static const struct address_space_operations
> ext4_dax_aops = {
>  	.set_page_dirty		= noop_set_page_dirty,
>  	.bmap			= ext4_bmap,
>  	.invalidatepage		= noop_invalidatepage,
> +	.swap_activate 		= ext4_iomap_swap_activate,
>  };
> 
>  void ext4_set_aops(struct inode *inode)
