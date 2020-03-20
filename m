Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484C218DA85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 22:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTVrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 17:47:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTVrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:47:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KLcxNS168671;
        Fri, 20 Mar 2020 21:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qM54fWWCd+43qqChF84AavPBvF9WpmsvniM7Bgc+KYQ=;
 b=SUh950dV5x/ldjdmAL+VwLFlGbgZTM0Y3FiRihnOga7jvI3+TXWV5cjnAY1fhanCRgOK
 vB6bvduFVLBE69oU3UImCi9GiUZkzn37mYXbYJnPPD+aYZ5qwLfv/3PAVmorL0uic5HW
 WzqZ7+KrdPDudlQm+hOoWyslPAfpjJoRYQFJD8iQlmJRnvjc5k3auDiOWRYt6kyRWbmp
 r5Q7G/55En7wNlV239hEv0MJge+JdI2Zusx1HB+pfV+qnJX8m0XOcOjFT3FK/rlqb4Xe
 IT8wpL398F1e7UZU53YbiokoguCwDKqGGGYrNZv0KyEovyyh82KhdIZdty+F02GvTOl4 iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yrq7mfu61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 21:46:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KLMoUp042338;
        Fri, 20 Mar 2020 21:46:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ys8tyuba0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 21:46:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02KLkvvL002107;
        Fri, 20 Mar 2020 21:46:57 GMT
Received: from localhost (/10.159.129.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 14:46:57 -0700
Date:   Fri, 20 Mar 2020 14:46:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] iomap: Submit the BIO at the end of each extent
Message-ID: <20200320214654.GC6812@magnolia>
References: <20200320144014.3276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320144014.3276-1-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200085
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:40:14AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By definition, an extent covers a range of consecutive blocks, so
> it would be quite rare to be able to just add pages to the BIO from
> a previous range.  The only case we can think of is a mapped extent
> followed by a hole extent, followed by another mapped extent which has
> been allocated immediately after the first extent.  We believe this to
> be an unlikely layout for a filesystem to choose and, since the queue
> is plugged, those two BIOs would be merged by the block layer.
> 
> The reason we care is that ext2/ext4 choose to lay out blocks 0-11
> consecutively, followed by the indirect block, and we want to merge those
> two BIOs.  If we don't submit the data BIO before asking the filesystem
> for the next extent, then the indirect BIO will be submitted first,
> and waited for, leading to inefficient I/O patterns.  Buffer heads solve
> this with the BH_boundary flag, but iomap doesn't need that as long as
> we submit the bio here.

Hmm, I just received the following stack trace while running generic/418
on a v5 filesystem with 1k blocks:

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 alder-mtr01 5.6.0-rc4-djw #rc4 SMP PREEMPT Fri Mar 13 14:48:13 PDT 2020
MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1, -b size=1024, /dev/sdd
MOUNT_OPTIONS -- -o usrquota,grpquota,prjquota, /dev/sdd /opt

(Note that it seems to do this even with MKFS_OPTIONS='-m crc=0' and
empty MOUNT_OPTIONS.)

[   32.931667] XFS (sdd): Mounting V5 Filesystem
[   32.940193] XFS (sdd): Ending clean mount
[   32.941350] XFS (sdd): Quotacheck needed: Please wait.
[   32.970724] XFS (sdd): Quotacheck: Done.
[   32.972550] xfs filesystem being mounted at /opt supports timestamps until 2038 (0x7fffffff)
[   32.985191] XFS (sdd): Unmounting Filesystem
[   33.162426] XFS (sde): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[   33.273185] XFS (sde): Unmounting Filesystem
[   33.517957] XFS (sde): Mounting V5 Filesystem
[   33.526176] XFS (sde): Ending clean mount
[   33.527439] XFS (sde): Quotacheck needed: Please wait.
[   33.566117] XFS (sde): Quotacheck: Done.
[   33.569427] xfs filesystem being mounted at /mnt supports timestamps until 2038 (0x7fffffff)
[   33.656942] run fstests generic/418 at 2020-03-20 14:42:29
[   36.332268] BUG: kernel NULL pointer dereference, address: 0000000000000060
[   36.334254] #PF: supervisor read access in kernel mode
[   36.334849] #PF: error_code(0x0000) - not-present page
[   36.335461] PGD 0 P4D 0 
[   36.335779] Oops: 0000 [#1] PREEMPT SMP
[   36.336246] CPU: 2 PID: 5144 Comm: dio-invalidate- Not tainted 5.6.0-rc4-djw #rc4
[   36.337078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
[   36.338069] RIP: 0010:iomap_readpage_actor+0x2ea/0x3c0
[   36.338671] Code: 43 10 8b 54 24 24 48 c7 40 38 80 bc 2f 81 48 8b 7b 10 e9 00 ff ff ff 31 c0 48 85 ed 0f 85 c9 fe ff ff 49 8b 46 18 48 8b 2c 24 <8b> 48 60 48 81 c5 ff 0f 00 00 48 c1 ed 0c 81 e1 c0 0c 00 00 e9 12
[   36.340705] RSP: 0018:ffffc90004ebb968 EFLAGS: 00010246
[   36.341309] RAX: 0000000000000000 RBX: ffffc90004ebbb30 RCX: 000000000000000a
[   36.342105] RDX: 0000000000000400 RSI: 0000000000000003 RDI: 0000000000000000
[   36.342909] RBP: 0000000000000400 R08: ffffc90004ebb988 R09: ffffc90004ebb98c
[   36.343710] R10: 0000000000001000 R11: 0000000000000400 R12: ffffc90004ebba50
[   36.344505] R13: 0000000000000086 R14: ffffea0001cd2400 R15: 0000000000000c00
[   36.345246] FS:  00007f892894c740(0000) GS:ffff88807e000000(0000) knlGS:0000000000000000
[   36.346087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.346696] CR2: 0000000000000060 CR3: 0000000078753005 CR4: 00000000001606a0
[   36.347445] Call Trace:
[   36.347734]  iomap_readpages_actor+0x1e3/0x250
[   36.348699]  iomap_apply+0x12c/0x4e3
[   36.349097]  ? iomap_readpage_actor+0x3c0/0x3c0
[   36.349593]  ? prep_new_page+0x3f/0x100
[   36.350022]  ? iomap_readpage_actor+0x3c0/0x3c0
[   36.350519]  iomap_readpages+0xc7/0x2b0
[   36.350938]  ? iomap_readpage_actor+0x3c0/0x3c0
[   36.351438]  read_pages+0x6e/0x1a0
[   36.351824]  __do_page_cache_readahead+0x1c3/0x1e0
[   36.352343]  ondemand_readahead+0x210/0x4b0
[   36.352797]  generic_file_read_iter+0x871/0xcd0
[   36.353365]  ? xfs_file_buffered_aio_read+0x54/0x170 [xfs]
[   36.353982]  xfs_file_buffered_aio_read+0x5f/0x170 [xfs]
[   36.354591]  xfs_file_read_iter+0xea/0x2a0 [xfs]
[   36.355139]  ? xfs_file_write_iter+0xf2/0x1d0 [xfs]
[   36.355668]  new_sync_read+0x12d/0x1d0
[   36.356085]  vfs_read+0xa6/0x180
[   36.356454]  ksys_pread64+0x64/0xa0
[   36.356841]  do_syscall_64+0x50/0x1a0
[   36.357252]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   36.357792] RIP: 0033:0x7f8928524f64
[   36.358189] Code: 15 61 80 20 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 8b 05 aa c4 20 00 49 89 ca 85 c0 75 13 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5c f3 c3 66 90 41 55 41 54 49 89 cd 55 53 49
[   36.360053] RSP: 002b:00007fffc7893b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
[   36.360841] RAX: ffffffffffffffda RBX: 0000000000000400 RCX: 00007f8928524f64
[   36.361594] RDX: 0000000000000400 RSI: 00005593e3c23000 RDI: 0000000000000003
[   36.362344] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
[   36.363075] R10: 0000000000000000 R11: 0000000000000246 R12: 00005593e3c23000
[   36.363817] R13: 0000000000000000 R14: 00005593e3c25000 R15: 0000000000000400
[   36.364569] Modules linked in: xfs libcrc32c ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip_set_hash_ip ip_set_hash_net xt_tcpudp xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables nfsv4 af_packet
[   36.366966] Dumping ftrace buffer:
[   36.367351]    (ftrace buffer empty)
[   36.367742] CR2: 0000000000000060
[   36.369050] ---[ end trace d599586d1259866c ]---
[   36.369884] RIP: 0010:iomap_readpage_actor+0x2ea/0x3c0
[   36.370694] Code: 43 10 8b 54 24 24 48 c7 40 38 80 bc 2f 81 48 8b 7b 10 e9 00 ff ff ff 31 c0 48 85 ed 0f 85 c9 fe ff ff 49 8b 46 18 48 8b 2c 24 <8b> 48 60 48 81 c5 ff 0f 00 00 48 c1 ed 0c 81 e1 c0 0c 00 00 e9 12
[   36.373022] RSP: 0018:ffffc90004ebb968 EFLAGS: 00010246
[   36.373615] RAX: 0000000000000000 RBX: ffffc90004ebbb30 RCX: 000000000000000a
[   36.374362] RDX: 0000000000000400 RSI: 0000000000000003 RDI: 0000000000000000
[   36.375100] RBP: 0000000000000400 R08: ffffc90004ebb988 R09: ffffc90004ebb98c
[   36.375833] R10: 0000000000001000 R11: 0000000000000400 R12: ffffc90004ebba50
[   36.376577] R13: 0000000000000086 R14: ffffea0001cd2400 R15: 0000000000000c00
[   36.377322] FS:  00007f892894c740(0000) GS:ffff88807e000000(0000) knlGS:0000000000000000
[   36.378190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.378795] CR2: 0000000000000060 CR3: 0000000078753005 CR4: 00000000001606a0

I'll email back if I find anything else but since this is the second
Friday in a row of getting STOP SHIP bugs dropped in my lap at 2pm, I
doubt I'm going to manage much.

--D

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f080f542911b..417115bfaf6b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -420,6 +420,16 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  				ctx, iomap, srcmap);
>  	}
>  
> +	/*
> +	 * Submitting the bio here leads to better I/O patterns for
> +	 * filesystems which need to do metadata reads to find the
> +	 * next extent.
> +	 */
> +	if (ctx->bio) {
> +		submit_bio(ctx->bio);
> +		ctx->bio = NULL;
> +	}
> +
>  	return done;
>  }
>  
> @@ -449,8 +459,6 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  	}
>  	ret = 0;
>  done:
> -	if (ctx.bio)
> -		submit_bio(ctx.bio);
>  	if (ctx.cur_page) {
>  		if (!ctx.cur_page_in_bio)
>  			unlock_page(ctx.cur_page);
> -- 
> 2.25.1
> 
