Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F13FC24E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 08:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhHaFyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 01:54:55 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52354 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhHaFyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 01:54:55 -0400
Received: from jlbec by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKwgU-00HUp2-OY; Tue, 31 Aug 2021 05:51:47 +0000
Date:   Tue, 31 Aug 2021 05:51:46 +0000
From:   Joel Becker <jlbec@evilplan.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] configfs: simplify the configfs_dirent_is_ready
Message-ID: <YS3Dcl9gV3x+ANFH@zeniv-ca.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210825064906.1694233-1-hch@lst.de>
 <20210825064906.1694233-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825064906.1694233-3-hch@lst.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Acked-by: Joel Becker <jlbec@evilplan.org>

On Wed, Aug 25, 2021 at 08:49:04AM +0200, Christoph Hellwig wrote:
> Return the error directly instead of using a goto.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/configfs/dir.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index cf08bbde55f3..5d58569f0eea 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -467,9 +467,8 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  	 * not complete their initialization, since the dentries of the
>  	 * attributes won't be instantiated.
>  	 */
> -	err = -ENOENT;
>  	if (!configfs_dirent_is_ready(parent_sd))
> -		goto out;
> +		return ERR_PTR(-ENOENT);
>  
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
>  		if (sd->s_type & CONFIGFS_NOT_PINNED) {
> @@ -493,7 +492,6 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  		return NULL;
>  	}
>  
> -out:
>  	return ERR_PTR(err);
>  }
>  
> -- 
> 2.30.2
> 

-- 
