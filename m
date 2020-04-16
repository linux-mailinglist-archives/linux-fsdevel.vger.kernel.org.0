Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA981AB5A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgDPBqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 21:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730833AbgDPBqu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:46:50 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007922064A;
        Thu, 16 Apr 2020 01:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587001610;
        bh=3qaMXDRSy4aZ7A0Y6FmluAI8ZxLwOV9hN7OGKQzNeD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gujmrzioui6GvZGXk0WvMxPAiJ+Ko8y7Y/QHbECTnNbOphAF8/T/Xdkh5yNcvzRrU
         2KpH04lY4ytMKe8XeCe3mrqI4m4ALOu4bvRw1/XY3lmsItIZAHEnWr2Xim3W4OF1W8
         ehjqi9wsm51q7dsaP1uoWhxhtDd5VLIKw8otHkJc=
Date:   Wed, 15 Apr 2020 18:46:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, npiggin@kernel.dk, zyan@redhat.com,
        hartleys@visionengravers.com, Yanxiaodan <yanxiaodan@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
Subject: Re: [PATCH] dcache: unlock inode->i_lock before goto restart tag in,
 d_prune_aliases
Message-ID: <20200416014648.GB816@sol.localdomain>
References: <c3a3d3d2-dad4-a4fe-014f-3f5eb3561524@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3a3d3d2-dad4-a4fe-014f-3f5eb3561524@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:20:33PM +0800, Zhiqiang Liu wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> coccicheck reports:
>   fs/dcache.c:1027:1-10: second lock on line 1027
> 
> In d_prune_aliases, before goto restart we should unlock
> inode->i_lock.
> 
> Fixes: 29355c3904e ("d_prune_alias(): just lock the parent and call __dentry_kill()")
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> ---
>  fs/dcache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b280e07e162b..1532ebe9d9ca 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1030,6 +1030,7 @@ void d_prune_aliases(struct inode *inode)
>  		if (!dentry->d_lockref.count) {
>  			struct dentry *parent = lock_parent(dentry);
>  			if (likely(!dentry->d_lockref.count)) {
> +				spin_unlock(&inode->i_lock);
>  				__dentry_kill(dentry);
>  				dput(parent);
>  				goto restart;
> -- 

Doesn't __dentry_kill() already do the unlock, via dentry_unlink_inode()?

- Eric
