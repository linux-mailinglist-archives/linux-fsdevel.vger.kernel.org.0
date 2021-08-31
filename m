Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA163FC250
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 08:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbhHaFzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 01:55:11 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52368 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbhHaFzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 01:55:11 -0400
Received: from jlbec by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKwgn-00HUpL-Nm; Tue, 31 Aug 2021 05:52:06 +0000
Date:   Tue, 31 Aug 2021 05:52:05 +0000
From:   Joel Becker <jlbec@evilplan.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] configfs: return -ENAMETOOLONG earlier in
 configfs_lookup
Message-ID: <YS3DhWLIge5br/Kg@zeniv-ca.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210825064906.1694233-1-hch@lst.de>
 <20210825064906.1694233-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825064906.1694233-2-hch@lst.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Acked-by: Joel Becker <jlbec@evilplan.org>

On Wed, Aug 25, 2021 at 08:49:03AM +0200, Christoph Hellwig wrote:
> Just like most other file systems: get the simple checks out of the
> way first.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/configfs/dir.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index ac5e0c0e9181..cf08bbde55f3 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -456,6 +456,9 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  	int found = 0;
>  	int err;
>  
> +	if (dentry->d_name.len > NAME_MAX)
> +		return ERR_PTR(-ENAMETOOLONG);
> +
>  	/*
>  	 * Fake invisibility if dir belongs to a group/default groups hierarchy
>  	 * being attached
> @@ -486,8 +489,6 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  		 * If it doesn't exist and it isn't a NOT_PINNED item,
>  		 * it must be negative.
>  		 */
> -		if (dentry->d_name.len > NAME_MAX)
> -			return ERR_PTR(-ENAMETOOLONG);
>  		d_add(dentry, NULL);
>  		return NULL;
>  	}
> -- 
> 2.30.2
> 

-- 
