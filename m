Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7245F95BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfHTJvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 05:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfHTJvZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:51:25 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 882EE22CF7;
        Tue, 20 Aug 2019 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566294684;
        bh=K8sJJxvvQKJl8QWVEqPaTDFCFZYjha7QbbMLOeXPdr0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JCTVilkLtjMxPIUYr5HeBTQrzW68s+3jJ+9gXUohRnN7k1WBZ8mJrUKi10fRmqwnK
         s1F1eZIqCwofauy6ozMJQgUYs4EK1MQ9pvitZT8lS1JNq372YojVinHVCAggYt8T1x
         BBBa8l+5n90TkzXSdDoO+GXS2ajz9gEu2HAn1xGc=
Message-ID: <25478fb3102ecebe09297948dcbb666c22845de1.camel@kernel.org>
Subject: Re: [PATCH] locks: fix a memory leak bug
From:   Jeff Layton <jlayton@kernel.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 20 Aug 2019 05:51:22 -0400
In-Reply-To: <1566258454-7684-1-git-send-email-wenwen@cs.uga.edu>
References: <1566258454-7684-1-git-send-email-wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-08-19 at 18:47 -0500, Wenwen Wang wrote:
> In __break_lease(), the file lock 'new_fl' is allocated in lease_alloc().
> However, it is not deallocated in the following execution if
> smp_load_acquire() fails, leading to a memory leak bug. To fix this issue,
> free 'new_fl' before returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  fs/locks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 686eae2..5993b2a 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1592,7 +1592,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  	ctx = smp_load_acquire(&inode->i_flctx);
>  	if (!ctx) {
>  		WARN_ON_ONCE(1);
> -		return error;
> +		goto free_lock;
>  	}
>  
>  	percpu_down_read(&file_rwsem);
> @@ -1672,6 +1672,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
>  	locks_dispose_list(&dispose);
> +free_lock:
>  	locks_free_lock(new_fl);
>  	return error;
>  }

Good catch! Merged for v5.4. Let me know if you think this needs to go
in earlier and/or to stable kernels.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

