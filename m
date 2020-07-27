Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21DE22FB63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 23:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgG0V3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 17:29:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:51726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgG0V3q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:29:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B27BAD2C;
        Mon, 27 Jul 2020 21:29:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 698CE1E12C7; Mon, 27 Jul 2020 23:29:44 +0200 (CEST)
Date:   Mon, 27 Jul 2020 23:29:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 9/9] fsnotify: pass inode to fsnotify_parent()
Message-ID: <20200727212944.GL5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
 <20200722125849.17418-10-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-10-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:49, Amir Goldstein wrote:
> We can get inode by dereferenceing dentry->d_inode, but that may have
> performance impact in the fast path of non watched file.
> 
> Kernel test robot reported a performance regression in concurrent open
> workload, so maybe that can fix it.
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: c738fbabb0ff ("fsnotify: fold fsnotify() call into fsnotify_parent()")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I didn't take this patch because honestly, I don't think the extra argument
is worth it unless we can prove real performance benefit...

								Honza

> ---
>  include/linux/fsnotify.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index d9b26c6552ee..4a9b2f5b819b 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -49,10 +49,9 @@ static inline void fsnotify_inode(struct inode *inode, __u32 mask)
>  
>  /* Notify this dentry's parent about a child's events. */
>  static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
> -				  const void *data, int data_type)
> +				  const void *data, int data_type,
> +				  struct inode *inode)
>  {
> -	struct inode *inode = d_inode(dentry);
> -
>  	if (S_ISDIR(inode->i_mode)) {
>  		mask |= FS_ISDIR;
>  
> @@ -77,7 +76,8 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
>   */
>  static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
>  {
> -	fsnotify_parent(dentry, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE);
> +	fsnotify_parent(dentry, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
> +			d_inode(dentry));
>  }
>  
>  static inline int fsnotify_file(struct file *file, __u32 mask)
> @@ -87,7 +87,8 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>  	if (file->f_mode & FMODE_NONOTIFY)
>  		return 0;
>  
> -	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
> +	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH,
> +			       file_inode(file));
>  }
>  
>  /* Simple call site for access decisions */
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
