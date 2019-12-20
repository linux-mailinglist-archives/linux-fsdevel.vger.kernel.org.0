Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D11283E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLTVdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 16:33:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46858 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfLTVdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:33:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBKLOUxZ080420;
        Fri, 20 Dec 2019 21:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=O5eLQJ2IQaAuC0h1sPo9EP7FE00qk/3elCIpmX0WCE0=;
 b=M1U/ouxhaOiM+6v6EvH8oATdFdToWd9fT+1TCH0BLj6Aacno9p0DXI4sWhGUlkXlaoIr
 gQsXv9GWGwRHXIL2q4CR3dRzUXxcj6vuxRx47UUDghgGxMQx15FMvFkpWC1eL2XUSEAt
 rc9qkK6G3oNHh2YwwEa4gLEhNcdZmXCR8YtlMZkDwjRDsvjEmVt6q0Dvpl30tpQaMxgq
 9qz5dvVq5HW6KXJNwGfv9KBGlE7p1//ZDtSfXiUYktT87Qg6iE0RLbDK2kkkewLyBWTV
 Uv0rlrf0QtDHVnC+l4efSZ797eQMpi7YWbsUWDRPQOJpoRK9XCBY87QJ0zaN4Ih8WHY0 UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2x0ag18371-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 21:32:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBKLNmMw027475;
        Fri, 20 Dec 2019 21:30:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2x0vc4kdfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 21:30:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBKLUss8021912;
        Fri, 20 Dec 2019 21:30:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Dec 2019 13:30:53 -0800
Date:   Fri, 20 Dec 2019 13:30:52 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20191220213052.GB7476@magnolia>
References: <20191220024936.GA380394@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220024936.GA380394@chrisdown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9477 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9477 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200164
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 02:49:36AM +0000, Chris Down wrote:
> In Facebook production we are seeing heavy inode number wraparounds on
> tmpfs. On affected tiers, in excess of 10% of hosts show multiple files
> with different content and the same inode number, with some servers even
> having as many as 150 duplicated inode numbers with differing file
> content.
> 
> This causes actual, tangible problems in production. For example, we
> have complaints from those working on remote caches that their
> application is reporting cache corruptions because it uses (device,
> inodenum) to establish the identity of a particular cache object, but

...but you cannot delete the (dev, inum) tuple from the cache index when
you remove a cache object??

> because it's not unique any more, the application refuses to continue
> and reports cache corruption. Even worse, sometimes applications may not
> even detect the corruption but may continue anyway, causing phantom and
> hard to debug behaviour.
> 
> In general, userspace applications expect that (device, inodenum) should
> be enough to be uniquely point to one inode, which seems fair enough.

Except that it's not.  (dev, inum, generation) uniquely points to an
instance of an inode from creation to the last unlink.

--D

> This patch changes get_next_ino to use up to min(sizeof(ino_t), 8) bytes
> to reduce the likelihood of wraparound. On architectures with 32-bit
> ino_t the problem is, at least, not made any worse than it is right now.
> 
> I noted the concern in the comment above about 32-bit applications on a
> 64-bit kernel with 32-bit wide ino_t in userspace, as documented by Jeff
> in the commit message for 866b04fc, but these applications are going to
> get EOVERFLOW on filesystems with non-volatile inode numbers anyway,
> since those will likely be 64-bit. Concerns about that seem slimmer
> compared to the disadvantages this presents for known, real users of
> this functionality on platforms with a 64-bit ino_t.
> 
> Other approaches I've considered:
> 
> - Use an IDA. If this is a problem for users with 32-bit ino_t as well,
>   this seems a feasible approach. For now this change is non-intrusive
>   enough, though, and doesn't make the situation any worse for them than
>   present at least.
> - Look for other approaches in userspace. I think this is less
>   feasible -- users do need to have a way to reliably determine inode
>   identity, and the risk of wraparound with a 2^32-sized counter is
>   pretty high, quite clearly manifesting in production for workloads
>   which make heavy use of tmpfs.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Reported-by: Phyllipe Medeiros <phyllipe@fb.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com
> ---
>  fs/inode.c         | 29 ++++++++++++++++++-----------
>  include/linux/fs.h |  2 +-
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index aff2b5831168..8193c17e2d16 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -870,26 +870,33 @@ static struct inode *find_inode_fast(struct super_block *sb,
>   * This does not significantly increase overflow rate because every CPU can
>   * consume at most LAST_INO_BATCH-1 unused inode numbers. So there is
>   * NR_CPUS*(LAST_INO_BATCH-1) wastage. At 4096 and 1024, this is ~0.1% of the
> - * 2^32 range, and is a worst-case. Even a 50% wastage would only increase
> - * overflow rate by 2x, which does not seem too significant.
> + * 2^32 range (for 32-bit ino_t), and is a worst-case. Even a 50% wastage would
> + * only increase overflow rate by 2x, which does not seem too significant. With
> + * a 64-bit ino_t, overflow in general is fairly hard to achieve.
>   *
> - * On a 32bit, non LFS stat() call, glibc will generate an EOVERFLOW
> - * error if st_ino won't fit in target struct field. Use 32bit counter
> - * here to attempt to avoid that.
> + * Care should be taken not to overflow when at all possible, since generally
> + * userspace depends on (device, inodenum) being reliably unique.
>   */
>  #define LAST_INO_BATCH 1024
> -static DEFINE_PER_CPU(unsigned int, last_ino);
> +static DEFINE_PER_CPU(ino_t, last_ino);
>  
> -unsigned int get_next_ino(void)
> +ino_t get_next_ino(void)
>  {
> -	unsigned int *p = &get_cpu_var(last_ino);
> -	unsigned int res = *p;
> +	ino_t *p = &get_cpu_var(last_ino);
> +	ino_t res = *p;
>  
>  #ifdef CONFIG_SMP
>  	if (unlikely((res & (LAST_INO_BATCH-1)) == 0)) {
> -		static atomic_t shared_last_ino;
> -		int next = atomic_add_return(LAST_INO_BATCH, &shared_last_ino);
> +		static atomic64_t shared_last_ino;
> +		u64 next = atomic64_add_return(LAST_INO_BATCH,
> +					       &shared_last_ino);
>  
> +		/*
> +		 * This might get truncated if ino_t is 32-bit, and so be more
> +		 * susceptible to wrap around than on environments where ino_t
> +		 * is 64-bit, but that's really no worse than always encoding
> +		 * `res` as unsigned int.
> +		 */
>  		res = next - LAST_INO_BATCH;
>  	}
>  #endif
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 190c45039359..ca1a04334c9e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3052,7 +3052,7 @@ static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
>  #endif
>  extern void unlock_new_inode(struct inode *);
>  extern void discard_new_inode(struct inode *);
> -extern unsigned int get_next_ino(void);
> +extern ino_t get_next_ino(void);
>  extern void evict_inodes(struct super_block *sb);
>  
>  extern void __iget(struct inode * inode);
> -- 
> 2.24.1
> 
