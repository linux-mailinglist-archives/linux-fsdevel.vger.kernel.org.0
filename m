Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC481B0780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDTLgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTLgT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:36:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BEB206D4;
        Mon, 20 Apr 2020 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587382578;
        bh=Ttxo4ShYqlkWnXjbFggOt9MCuzR3OQsdnOZ8YyHwteQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZyvrt/ONGuKXMLNymKIUlRFlsD0HNaWXlOnui9JnS6bIFEmXyZHqV9GuDgieyS0v
         cBo2FFAnsC1Vg0yjQU9nqQkBIvr/BkDhEd2KFbun69AzJA8kv+9wGz43GHneF/LMr1
         uryFwmhZ3w/t3ulsRV3irbD2gs6+mTw3FD/x9+cM=
Date:   Mon, 20 Apr 2020 13:36:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] blk-debugfs: upgrade warns to BUG_ON() if
 directory is already found
Message-ID: <20200420113616.GA3906674@kroah.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419194529.4872-7-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 07:45:25PM +0000, Luis Chamberlain wrote:
> Now that we have moved release_queue from being asynchronous to
> synchronous, and fixed how we use the debugfs directory with blktrace
> we should no longer have expected races with device removal/addition
> and other operations with the debugfs directory.
> 
> If races do happen however, we want to be informed of *how* this races
> happens rather than dealing with a debugfs splat, so upgrading this to a
> BUG_ON() should capture better information about how this can happen
> in the future.
> 
> This is specially true these days with funky reproducers in userspace
> for which we have no access to, but only a bug splat.
> 
> Note that on addition the gendisk kobject is used as the parent for the
> request_queue kobject, and upon removal, now that request_queue removal
> is synchronous, blk_unregister_queue() is called prior to the gendisk
> device_del(). This means we expect to see a sysfs clash first now prior
> to running into a race with the debugfs dentry; so this bug would be
> considered highly unlikely.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/blk-debugfs.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> index d84038bce0a5..761318dcbf40 100644
> --- a/block/blk-debugfs.c
> +++ b/block/blk-debugfs.c
> @@ -19,16 +19,8 @@ void blk_debugfs_register(void)
>  
>  int __must_check blk_queue_debugfs_register(struct request_queue *q)
>  {
> -	struct dentry *dir = NULL;
> -
>  	/* This can happen if we have a bug in the lower layers */
> -	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> -	if (dir) {
> -		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> -			kobject_name(q->kobj.parent));
> -		dput(dir);
> -		return -EALREADY;
> -	}
> +	BUG_ON(debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root));

So you are willing to crash the whole kernel and throw all of
userspace's data away if this happens?

Ick, no, don't do that, handle the issue correctly and move on.

As proof you shouldn't be doing this, that BUG_ON will trigger if
debugfs is not enabled, which might be a bit mean for all users of those
kernels :(

Hard NAK from me, sorry.

greg k-h
