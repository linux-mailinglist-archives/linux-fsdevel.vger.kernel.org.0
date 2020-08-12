Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA12425D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHLHIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 03:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgHLHIa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:08:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A96662053B;
        Wed, 12 Aug 2020 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597216110;
        bh=iscE9GItSI35Y8APIrUEV6sr2YREeGnyX+/eG4Y/b0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=db1n1k9zj+UKi6t4tEK382BilUYHjepA61MeoqswndA6OfBN/naZ+BOZb2r8QPtyU
         9UgcRbwlbBz2jIqkBWs0nkwnOiKBKsH9vk0c5EIOdvq2EnBeVxB73PvN0vENvzwqLe
         M7exJjEqveOeP/cQTbPsMqdbuOyTpULHQI/Ikpzw=
Date:   Wed, 12 Aug 2020 09:08:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer
 dereference in hfs_find_init()
Message-ID: <20200812070827.GA1304640@kroah.com>
References: <20200812065556.869508-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812065556.869508-1-yepeilin.cs@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:55:56AM -0400, Peilin Ye wrote:
> Prevent hfs_find_init() from dereferencing `tree` as NULL.
> 
> Reported-and-tested-by: syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
>  fs/hfs/bfind.c     | 3 +++
>  fs/hfsplus/bfind.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index 4af318fbda77..880b7ea2c0fc 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
>  {
>  	void *ptr;
>  
> +	if (!tree)
> +		return -EINVAL;
> +
>  	fd->tree = tree;
>  	fd->bnode = NULL;
>  	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index ca2ba8c9f82e..85bef3e44d7a 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
>  {
>  	void *ptr;
>  
> +	if (!tree)
> +		return -EINVAL;
> +

How can tree ever be NULL in these calls?  Shouldn't that be fixed as
the root problem here?

thanks,

greg k-h
