Return-Path: <linux-fsdevel+bounces-3174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C0F7F09EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 01:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C051C208CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 00:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3681D;
	Mon, 20 Nov 2023 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhCBljmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09B2D8
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 16:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700438859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0HwlUBIKi8AxmT+jPxDm+CA7zvxaqBOU3FfDgppoBI=;
	b=MhCBljmQoyzsP+mtjNovBV5UFlXZoJ1XCcKc7BcdxVR8l4tJEsXFtsu2QjBxfLNoQHzOx7
	wDnzuDfuxUQdZX3YPQXiiPzMqin5gS1xwYzvc6tP/A8DWx3xolp1bTbHhjkHhUB0WkyZDq
	DtxpIclytRJHr5DYlR2Nc2J1HMMSrXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399--Dg16P62M1aGyx2XBnuDrg-1; Sun, 19 Nov 2023 19:07:36 -0500
X-MC-Unique: -Dg16P62M1aGyx2XBnuDrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF816811E7E;
	Mon, 20 Nov 2023 00:07:35 +0000 (UTC)
Received: from redhat.com (unknown [10.22.9.219])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2940D1C060AE;
	Mon, 20 Nov 2023 00:07:35 +0000 (UTC)
Date: Sun, 19 Nov 2023 18:07:33 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Bill O'Donnell <billodo@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] autofs: add: new_inode check in autofs_fill_super()
Message-ID: <ZVqjRWcd4sBpooFW@redhat.com>
References: <20231119225319.331156-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119225319.331156-1-raven@themaw.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Mon, Nov 20, 2023 at 06:53:19AM +0800, Ian Kent wrote:
> Add missing NULL check of root_inode in autofs_fill_super().
> 
> While we are at it simplify the logic by taking advantage of the VFS
> cleanup procedures and get rid of the goto error handling, as suggested
> by Al Viro.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Bill O'Donnell <billodo@redhat.com>
> Reported-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  fs/autofs/inode.c | 59 ++++++++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index a5083d447a62..6ecf68536240 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -311,7 +311,6 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>  	struct inode *root_inode;
>  	struct dentry *root;
>  	struct autofs_info *ino;
> -	int ret = -ENOMEM;
>  
>  	pr_debug("starting up, sbi = %p\n", sbi);
>  
> @@ -328,56 +327,42 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>  	 */
>  	ino = autofs_new_ino(sbi);
>  	if (!ino)
> -		goto fail;
> +		return -ENOMEM;
>  
>  	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> -	root_inode->i_uid = ctx->uid;
> -	root_inode->i_gid = ctx->gid;
> -
> -	root = d_make_root(root_inode);
> -	if (!root)
> -		goto fail_ino;
> -
> -	root->d_fsdata = ino;
> +	if (root_inode) {
> +		root_inode->i_uid = ctx->uid;
> +		root_inode->i_gid = ctx->gid;
> +		root_inode->i_fop = &autofs_root_operations;
> +		root_inode->i_op = &autofs_dir_inode_operations;
> +	}
> +	s->s_root = d_make_root(root_inode);
> +	if (unlikely(!s->s_root)) {
> +		autofs_free_ino(ino);
> +		return -ENOMEM;
> +	}
> +	s->s_root->d_fsdata = ino;
>  
>  	if (ctx->pgrp_set) {
>  		sbi->oz_pgrp = find_get_pid(ctx->pgrp);
> -		if (!sbi->oz_pgrp) {
> -			ret = invalf(fc, "Could not find process group %d",
> -				     ctx->pgrp);
> -			goto fail_dput;
> -		}
> -	} else {
> +		if (!sbi->oz_pgrp)
> +			return invalf(fc, "Could not find process group %d",
> +				      ctx->pgrp);
> +	} else
>  		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
> -	}
>  
>  	if (autofs_type_trigger(sbi->type))
> -		__managed_dentry_set_managed(root);
> -
> -	root_inode->i_fop = &autofs_root_operations;
> -	root_inode->i_op = &autofs_dir_inode_operations;
> +		/* s->s_root won't be contended so there's little to
> +		 * be gained by not taking the d_lock when setting
> +		 * d_flags, even when a lot mounts are being done.
> +		 */
> +		managed_dentry_set_managed(s->s_root);
>  
>  	pr_debug("pipe fd = %d, pgrp = %u\n",
>  		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
>  
>  	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
> -
> -	/*
> -	 * Success! Install the root dentry now to indicate completion.
> -	 */
> -	s->s_root = root;
>  	return 0;
> -
> -	/*
> -	 * Failure ... clean up.
> -	 */
> -fail_dput:
> -	dput(root);
> -	goto fail;
> -fail_ino:
> -	autofs_free_ino(ino);
> -fail:
> -	return ret;
>  }
>  
>  /*
> -- 
> 2.41.0
> 


