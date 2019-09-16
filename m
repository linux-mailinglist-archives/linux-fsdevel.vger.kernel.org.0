Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2AB4398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 23:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbfIPVyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 17:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfIPVyM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:54:12 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A51214AF;
        Mon, 16 Sep 2019 21:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568670851;
        bh=6j5WhVgjInJOr0ho8fpMq2MPbXYIDm0KWcjNsMe56Cg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T4sE6H/P5KnK5jTkaOmVDS0J25KJkjgHKka5z0moMcxu7bmMFURyH3Pc+Rx+IlxOl
         isV/eexTtij0TLGUtnU2+YkuvBZOCPySqVw6mYW9rxIeItgJET18j2dexIMzzb7tHP
         s1LBT0+sYzDKAr1kGUA4lnHWHshwPGm+72xOc0p8=
Message-ID: <f31f5497156456e838280b32cf5a11e6c889ccdb.camel@kernel.org>
Subject: Re: [PATCH 1/1] vfs: Really check for inode ptr in lookup_fast
From:   Jeff Layton <jlayton@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>, viro@zeniv.linux.org.uk
Cc:     hsiangkao@aol.com, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, wugyuan@cn.ibm.com
Date:   Mon, 16 Sep 2019 17:54:09 -0400
In-Reply-To: <20190906135621.16410-1-riteshh@linux.ibm.com>
References: <20190906135621.16410-1-riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-09-06 at 19:26 +0530, Ritesh Harjani wrote:
> d_is_negative can race with d_instantiate_new()
> -> __d_set_inode_and_type().
> For e.g. in use cases where Thread-1 is creating
> symlink (doing d_instantiate_new()) & Thread-2 is doing
> cat of that symlink while doing lookup_fast (via REF-walk-
> one such case is, when ->permission returns -ECHILD).
> 
> During this race if __d_set_and_inode_type() does out-of-order
> execution and set the dentry->d_flags before setting
> dentry->inode, then it can result into following kernel panic.
> 
> This change fixes the issue by directly checking for inode.
> 
> E.g. kernel panic, since inode was NULL.
> trailing_symlink() -> may_follow_link() -> inode->i_uid.
> Issue signature:-
>   [NIP  : trailing_symlink+80]
>   [LR   : trailing_symlink+1092]
>   #4 [c00000198069bb70] trailing_symlink at c0000000004bae60  (unreliable)
>   #5 [c00000198069bc00] path_openat at c0000000004bdd14
>   #6 [c00000198069bc90] do_filp_open at c0000000004c0274
>   #7 [c00000198069bdb0] do_sys_open at c00000000049b248
>   #8 [c00000198069be30] system_call at c00000000000b388
> 
> Sequence of events:-
> Thread-2(Comm: ln) 	       Thread-1(Comm: cat)
> 
> 	                dentry = __d_lookup() //nonRCU
> 
> __d_set_and_inode_type() (Out-of-order execution)
>     flags = READ_ONCE(dentry->d_flags);
>     flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
>     flags |= type_flags;
>     WRITE_ONCE(dentry->d_flags, flags);
> 
> 	                if (unlikely(d_is_negative()) // fails
> 	                       {}
> 	                // since d_flags is already updated in
> 	                // Thread-2 in parallel but inode
> 	                // not yet set.
> 	                // d_is_negative returns false
> 
> 	                *inode = d_backing_inode(path->dentry);
> 	                // means inode is still NULL
> 
>     dentry->d_inode = inode;
> 
> 	                trailing_symlink()
> 	                    may_follow_link()
> 	                        inode = nd->link_inode;
> 	                        // nd->link_inode = NULL
> 	                        //Then it crashes while
> 	                        //doing inode->i_uid
> 
> Reported-by: Guang Yuan Wu <wugyuan@cn.ibm.com>
> Tested-by: Guang Yuan Wu <wugyuan@cn.ibm.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/namei.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 209c51a5226c..b5867fe988e0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1623,7 +1623,21 @@ static int lookup_fast(struct nameidata *nd,
>  		dput(dentry);
>  		return status;
>  	}
> -	if (unlikely(d_is_negative(dentry))) {
> +
> +	/*
> +	 * Caution: d_is_negative() can race with
> +	 * __d_set_inode_and_type().
> +	 * For e.g. in use cases where Thread-1 is creating
> +	 * symlink (doing d_instantiate_new()) & Thread-2 is doing
> +	 * cat of that symlink and falling here (via Ref-walk) while
> +	 * doing lookup_fast (one such case is when ->permission
> +	 * returns -ECHILD).
> +	 * Now if __d_set_inode_and_type() does out-of-order execution
> +	 * i.e. it first sets the dentry->d_flags & then dentry->inode
> +	 * then it can result into inode being NULL, causing panic later.
> +	 * Hence directly check if inode is NULL here.
> +	 */
> +	if (unlikely(d_really_is_negative(dentry))) {
>  		dput(dentry);
>  		return -ENOENT;
>  	}

Looks reasonable to me. The only alternative I see is to put the
barriers back in there (which still might not be a bad idea), but this
should at least address this race.

Acked-by: Jeff Layton <jlayton@kernel.org>

