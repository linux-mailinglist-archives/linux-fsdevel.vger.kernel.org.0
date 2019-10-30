Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD3E9B65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 13:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfJ3MVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 08:21:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfJ3MVw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:21:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C36BB6C8;
        Wed, 30 Oct 2019 12:21:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 79AC61E485C; Wed, 30 Oct 2019 13:21:49 +0100 (CET)
Date:   Wed, 30 Oct 2019 13:21:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: Use NULL instead of 0 for pointer
Message-ID: <20191030122149.GK28525@quack2.suse.cz>
References: <1572356342-24776-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572356342-24776-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-10-19 21:39:02, Tiezhu Yang wrote:
> Fix the following sparse warning:
> 
> fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer
> 
> Fixes: be77196b809c ("fs, notify: add procfs fdinfo helper")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks for the patch but similar patch already sits in my tree as commit
ddd06c36bdb "fsnotify/fdinfo: exportfs_encode_inode_fh() takes pointer as
4th argument". I'll send it to Linus in the next merge window.

								Honza

> ---
>  fs/notify/fdinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 1e2bfd2..cd2846e 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -50,7 +50,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>  	f.handle.handle_bytes = sizeof(f.pad);
>  	size = f.handle.handle_bytes >> 2;
>  
> -	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
> +	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle,
> +				       &size, NULL);
>  	if ((ret == FILEID_INVALID) || (ret < 0)) {
>  		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>  		return;
> -- 
> 2.1.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
