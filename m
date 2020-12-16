Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576BC2DC294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 15:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgLPO6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 09:58:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPO6d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:58:33 -0500
Message-ID: <132c8c1e1ab82f5a640ff1ede6bb844885d46e68.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608130671;
        bh=/OzdEeXeJRy4jnSYvNZJxQbC754muYVKP9z9+2YkQZE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=q+sAk0Fv6WsEXIH7XefS5bwS182CqOIjGTNe/FrkpQx7/vM7VlmCCHCtCctLKx9yg
         7QzAY7jXdNYCJ6kJcq+mpPac87qc4rrPD24qBAVy2yIco1v0RkRMqBFKwSp982HdCM
         dAR4hQbDWea7Ss+7/McCNWRghO2l7sIBSPr6RcBTxCcX/q72B59nngg5AtmSd7bebd
         qCMKaSZOzpmWDhXJ9SQr2AuIEDK7kdh9l+PIa5VR/CJQCXHr0X8IIMBRdyaIj9SEWh
         2L0ricJyJtLbMTYpf1I5MHy1FZ9naoPAlcd0iLnog4JvUMDHq1uSqilFZxn1cxTxD9
         2K/euMMKzHfKQ==
Subject: Re: [PATCH] vfs, syncfs: Do not ignore return code from ->sync_fs()
From:   Jeff Layton <jlayton@kernel.org>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, miklos@szeredi.hu, amir73il@gmail.com,
        willy@infradead.org, jack@suse.cz, sargun@sargun.me
Date:   Wed, 16 Dec 2020 09:57:49 -0500
In-Reply-To: <20201216143802.GA10550@redhat.com>
References: <20201216143802.GA10550@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-12-16 at 09:38 -0500, Vivek Goyal wrote:
> I see that current implementation of __sync_filesystem() ignores the
> return code from ->sync_fs(). I am not sure why that's the case.
> 
> Ignoring ->sync_fs() return code is problematic for overlayfs where
> it can return error if sync_filesystem() on upper super block failed.
> That error will simply be lost and sycnfs(overlay_fd), will get
> success (despite the fact it failed).
> 
> I am assuming that we want to continue to call __sync_blockdev()
> despite the fact that there have been errors reported from
> ->sync_fs(). So I wrote this simple patch which captures the
> error from ->sync_fs() but continues to call __sync_blockdev()
> and returns error from sync_fs() if there is one.
> 
> There might be some very good reasons to not capture ->sync_fs()
> return code, I don't know. Hence thought of proposing this patch.
> Atleast I will get to know the reason. I still need to figure
> a way out how to propagate overlay sync_fs() errors to user
> space.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/sync.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> Index: redhat-linux/fs/sync.c
> ===================================================================
> --- redhat-linux.orig/fs/sync.c	2020-12-16 09:15:49.831565653 -0500
> +++ redhat-linux/fs/sync.c	2020-12-16 09:23:42.499853207 -0500
> @@ -30,14 +30,18 @@
>   */
>  static int __sync_filesystem(struct super_block *sb, int wait)
>  {
> +	int ret, ret2;
> +
>  	if (wait)
>  		sync_inodes_sb(sb);
>  	else
>  		writeback_inodes_sb(sb, WB_REASON_SYNC);
>  
> 
>  	if (sb->s_op->sync_fs)
> -		sb->s_op->sync_fs(sb, wait);
> -	return __sync_blockdev(sb->s_bdev, wait);
> +		ret = sb->s_op->sync_fs(sb, wait);
> +	ret2 = __sync_blockdev(sb->s_bdev, wait);
> +
> +	return ret ? ret : ret2;
>  }
>  
> 
>  /*
> 

I posted a patchset that took a similar approach a couple of years ago,
and we decided not to go with it [1].

While it's not ideal to ignore the error here, I think this is likely to
break stuff. What may be better is to just make sync_fs void return, so
people don't think that returned errors there mean anything.

[1]: https://lore.kernel.org/linux-fsdevel/20180518123415.28181-1-jlayton@kernel.org/
-- 
Jeff Layton <jlayton@kernel.org>

