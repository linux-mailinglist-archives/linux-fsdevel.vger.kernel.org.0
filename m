Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9372A5AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 01:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgKDAUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 19:20:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49872 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgKDATH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 19:19:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A40FaN5060116;
        Wed, 4 Nov 2020 00:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7hUDYRpsXu46TjngoTvSnMN4yqPdTeP5uHwwB7BavbE=;
 b=OrVv8I9Yspubwr7AiajLRW0ib1TIbQwKf7G77W3iriD81NxD8H7Uilc046FwTdhLiXtN
 YGaMFUrmsC1W1tgZUMtFD0+/GJhN+5i4Ou5+YF3PUv7PE6LOv+YsGxjfFidMEOY5VO8h
 jyhJfALgS3/03Jwxv9dZYhttkNvXSVvbxX+RMa7slrln8GXqyaXLo65LKS0NPvQTH8Dg
 K+b/0soX44BwrpkdLqSMrLu0+hFLVKejTnbGA/4R2pEg8Iiii06JWmHXPhc7ezNk2bWm
 uVJrN0OV++Gt3aK/SEMwjXEJMGJw/mtPzRpYCUzBiR3ku2Sg9tv9ZzA9AIWdV7D+RD1t HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34hhvcc83f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 04 Nov 2020 00:18:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A40AheC061992;
        Wed, 4 Nov 2020 00:16:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34hw0ecc4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Nov 2020 00:16:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A40GoIE029847;
        Wed, 4 Nov 2020 00:16:50 GMT
Received: from localhost (/10.159.234.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Nov 2020 16:16:50 -0800
Date:   Tue, 3 Nov 2020 16:16:49 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, hch@infradead.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 resend 2/2] xfs: avoid transaction reservation
 recursion
Message-ID: <20201104001649.GN7123@magnolia>
References: <20201103131754.94949-1-laoar.shao@gmail.com>
 <20201103131754.94949-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103131754.94949-3-laoar.shao@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=5
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040000
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:17:54PM +0800, Yafang Shao wrote:
> PF_FSTRANS which is used to avoid transaction reservation recursion, is
> dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> means to avoid filesystem reclaim recursion. That change is subtle.
> Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> PF_MEMALLOC_NOFS is not proper.
> Below comment is quoted from Dave,
> > It wasn't for memory allocation recursion protection in XFS - it was for
> > transaction reservation recursion protection by something trying to flush
> > data pages while holding a transaction reservation. Doing
> > this could deadlock the journal because the existing reservation
> > could prevent the nested reservation for being able to reserve space
> > in the journal and that is a self-deadlock vector.
> > IOWs, this check is not protecting against memory reclaim recursion
> > bugs at all (that's the previous check [1]). This check is
> > protecting against the filesystem calling writepages directly from a
> > context where it can self-deadlock.
> > So what we are seeing here is that the PF_FSTRANS ->
> > PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> > about what type of error this check was protecting against.
> 
> As a result, we should reintroduce PF_FSTRANS. As current->journal_info
> isn't used in XFS, we can reuse it to indicate whehter the task is in
> fstrans or not, Per Willy. To achieve that, four new helpers are introduce
> in this patch, per Dave:
> - xfs_trans_context_set()
>   Used in xfs_trans_alloc()
> - xfs_trans_context_clear()
>   Used in xfs_trans_commit() and xfs_trans_cancel()
> - xfs_trans_context_update()
>   Used in xfs_trans_roll()
> - xfs_trans_context_active()
>   To check whehter current is in fs transcation or not
> [1]. Below check is to avoid memory reclaim recursion.
> if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
>         PF_MEMALLOC))
>         goto redirty;
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Urrrrk, I found some problems with this patch while testing.  xfs/141
blows up with:

XFS: Assertion failed: current->journal_info == tp, file:
fs/xfs/xfs_trans.h, line: 289

The call trace is very garbled, but I think it is:

+[ 1815.870749]  __xfs_trans_commit+0x4df/0x680 [xfs]
+[ 1815.871342]  xfs_symlink+0x5ec/0xac0 [xfs]
+[ 1815.871834]  ? lock_release+0x20d/0x450
+[ 1815.872280]  ? get_cached_acl+0x32/0x250
+[ 1815.872847]  xfs_vn_symlink+0x8d/0x1b0 [xfs]
+[ 1815.873742]  vfs_symlink+0xc7/0x150
+[ 1815.874356]  do_symlinkat+0x83/0x110
+[ 1815.874788]  do_syscall_64+0x31/0x40
+[ 1815.875204]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
+[ 1815.875781] RIP: 0033:0x7f2317fc6d7b


> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index c94e71f..b272d07 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -153,8 +153,6 @@
>  	int			error = 0;
>  	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
>  
> -	/* Mark this thread as being in a transaction */
> -	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
>  
>  	/*
>  	 * Attempt to reserve the needed disk blocks by decrementing
> @@ -163,10 +161,8 @@
>  	 */
>  	if (blocks > 0) {
>  		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> -		if (error != 0) {
> -			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +		if (error != 0)
>  			return -ENOSPC;
> -		}
>  		tp->t_blk_res += blocks;
>  	}
>  
> @@ -241,8 +237,6 @@
>  		tp->t_blk_res = 0;
>  	}
>  
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> -
>  	return error;
>  }
>  
> @@ -284,6 +278,8 @@
>  	INIT_LIST_HEAD(&tp->t_dfops);
>  	tp->t_firstblock = NULLFSBLOCK;
>  
> +	/* Mark this thread as being in a transaction */
> +	xfs_trans_context_set(tp);
>  	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
>  	if (error) {
>  		xfs_trans_cancel(tp);

You're missing a xfs_trans_context_clear() call here.

> @@ -878,7 +874,8 @@
>  
>  	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
>  
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	if (!regrant)
> +		xfs_trans_context_clear(tp);
>  	xfs_trans_free(tp);
>  
>  	/*
> @@ -910,7 +907,8 @@
>  			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
>  		tp->t_ticket = NULL;
>  	}
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +
> +	xfs_trans_context_clear(tp);
>  	xfs_trans_free_items(tp, !!error);
>  	xfs_trans_free(tp);
>  
> @@ -971,7 +969,7 @@
>  	}
>  
>  	/* mark this thread as no longer being in a transaction */
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_clear(tp);
>  
>  	xfs_trans_free_items(tp, dirty);
>  	xfs_trans_free(tp);
> @@ -1013,6 +1011,7 @@
>  	if (error)
>  		return error;
>  
> +	xfs_trans_context_update(trans, *tpp);

Two bugs here: First, xfs_trans_commit freed @trans, which means that
the assertion commits a UAF error.  Second, if the transaction is
synchronous and the xfs_log_force_lsn at the bottom of
__xfs_trans_commit fails, we'll abort everything without clearing
current->journal_info or restoring the memalloc flags.

Personally I think you should just clear the context from xfs_trans_free
if current->journal_info points to the transaction being freed.  I
/think/ you could fix this with the attached patch; what do you think?

--D

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index b272d0767c87..09ae5c181299 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -67,6 +67,11 @@ xfs_trans_free(
 	xfs_extent_busy_sort(&tp->t_busy);
 	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
 
+	/* Detach the transaction from this thread. */
+	ASSERT(current->journal_info != NULL);
+	if (current->journal_info == tp)
+		xfs_trans_context_clear(tp);
+
 	trace_xfs_trans_free(tp, _RET_IP_);
 	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
 		sb_end_intwrite(tp->t_mountp->m_super);
@@ -119,7 +124,11 @@ xfs_trans_dup(
 
 	ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
 	tp->t_rtx_res = tp->t_rtx_res_used;
+
+	/* Associate the new transaction with this thread. */
+	ASSERT(current->journal_info == tp);
 	ntp->t_pflags = tp->t_pflags;
+	current->journal_info = ntp;
 
 	/* move deferred ops over to the new tp */
 	xfs_defer_move(ntp, tp);
@@ -874,8 +883,6 @@ __xfs_trans_commit(
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	if (!regrant)
-		xfs_trans_context_clear(tp);
 	xfs_trans_free(tp);
 
 	/*
@@ -908,7 +915,6 @@ __xfs_trans_commit(
 		tp->t_ticket = NULL;
 	}
 
-	xfs_trans_context_clear(tp);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -968,9 +974,6 @@ xfs_trans_cancel(
 		tp->t_ticket = NULL;
 	}
 
-	/* mark this thread as no longer being in a transaction */
-	xfs_trans_context_clear(tp);
-
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
 }
@@ -1011,7 +1014,6 @@ xfs_trans_roll(
 	if (error)
 		return error;
 
-	xfs_trans_context_update(trans, *tpp);
 	/*
 	 * Reserve space in the log for the next transaction.
 	 * This also pushes items in the "AIL", the list of logged items,
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index c4877afcb8b9..ceb530bf5c4b 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -276,13 +276,6 @@ xfs_trans_context_set(struct xfs_trans *tp)
 	tp->t_pflags = memalloc_nofs_save();
 }
 
-static inline void
-xfs_trans_context_update(struct xfs_trans *old, struct xfs_trans *new)
-{
-	ASSERT(current->journal_info == old);
-	current->journal_info = new;
-}
-
 static inline void
 xfs_trans_context_clear(struct xfs_trans *tp)
 {
