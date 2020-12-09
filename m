Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A149D2D430F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 14:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgLINRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 08:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgLINRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:17:39 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FFCC0613CF;
        Wed,  9 Dec 2020 05:16:59 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmzKu-0003xz-BA; Wed, 09 Dec 2020 13:16:52 +0000
Date:   Wed, 9 Dec 2020 13:16:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yahu Gao <yahu.gao@windriver.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: Fix NULL pointer dereference in
 pid_delete_dentry
Message-ID: <20201209131652.GM3579531@ZenIV.linux.org.uk>
References: <20201209112100.47653-1-yahu.gao@windriver.com>
 <20201209112100.47653-2-yahu.gao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209112100.47653-2-yahu.gao@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:21:00PM +0800, Yahu Gao wrote:
> Get the staus of task from the pointer of proc inode directly is not
> safe. The function get_proc_task make it happen in RCU protection.

This is completely broken,  get_proc_task() acquires a reference to
task_struct; your patch is an instant leak.

> Signed-off-by: Yahu Gao <yahu.gao@windriver.com>
> ---
>  fs/proc/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 1bc9bcdef09f..05f33bb35067 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1994,7 +1994,7 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>  
>  static inline bool proc_inode_is_dead(struct inode *inode)
>  {
> -	return !proc_pid(inode)->tasks[PIDTYPE_PID].first;
> +	return !get_proc_task(inode);
>  }
>  
>  int pid_delete_dentry(const struct dentry *dentry)
> -- 
> 2.25.1
> 
