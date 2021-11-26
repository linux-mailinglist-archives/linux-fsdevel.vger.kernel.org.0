Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884DE45EA07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359810AbhKZJPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:15:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbhKZJNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:13:20 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 706EF1FD37;
        Fri, 26 Nov 2021 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637917807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpmiuQDntOm8Lz6C0/YW5KKh0GvIedoqL55Y+rluSTg=;
        b=G4NhSfadFPAoQXYvpwS8GvrLKTSEe4nzw2hhbBze0rZ0lewtdC4/UbEr9yLpKCl2fLQV6I
        1H4xqPmQQbDR9vy8b3sStpQ8fdsCPD2+xxFQpkOFIANxpnJ3YwAAN1t4/flb41zEzF3Eeo
        Ah5e55bJJfKWZpmcW07C9rD1G52/DpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637917807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpmiuQDntOm8Lz6C0/YW5KKh0GvIedoqL55Y+rluSTg=;
        b=NB2ZHjBZl1jJXxa1UXM8FdG4z18qkM0Y+VJJURrVyw+V2Q55BJn+zv9M3udFHF/zVfrvIZ
        5ZiBHC3DDL9t0dAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 34638A3B88;
        Fri, 26 Nov 2021 09:10:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1FF871E11F3; Fri, 26 Nov 2021 10:10:07 +0100 (CET)
Date:   Fri, 26 Nov 2021 10:10:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH V6 2/7] ovl: mark overlayfs inode dirty when it has
 upper
Message-ID: <20211126091007.GB13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-3-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122030038.1938875-3-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 11:00:33, Chengguang Xu wrote:
> From: Chengguang Xu <charliecgxu@tencent.com>
> 
> We simply mark overlayfs inode dirty when it has upper,
> it's much simpler than mark dirtiness on modification.
> 
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
> ---
>  fs/overlayfs/inode.c | 4 +++-
>  fs/overlayfs/util.c  | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 1f36158c7dbe..027ffc0a2539 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -778,8 +778,10 @@ void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
>  {
>  	struct inode *realinode;
>  
> -	if (oip->upperdentry)
> +	if (oip->upperdentry) {
>  		OVL_I(inode)->__upperdentry = oip->upperdentry;
> +		mark_inode_dirty(inode);
> +	}
>  	if (oip->lowerpath && oip->lowerpath->dentry)
>  		OVL_I(inode)->lower = igrab(d_inode(oip->lowerpath->dentry));
>  	if (oip->lowerdata)

Hum, does this get called only for inodes with upper inode existing? I
suppose we do not need to track inodes that were not copied up because they
cannot be dirty? I'm sorry, my knowledge of overlayfs is rather limited so
I may be missing something basic.



								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
