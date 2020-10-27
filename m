Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590A229A7AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509266AbgJ0JVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 05:21:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5676 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404528AbgJ0JVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:21:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CL5n84Sqzz15Lls;
        Tue, 27 Oct 2020 17:21:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 27 Oct 2020
 17:21:35 +0800
Subject: Re: [PATCH] fuse: fix potential accessing NULL pointer problem in
 fuse_send_init()
To:     <miklos@szeredi.hu>, <mszeredi@redhat.com>
CC:     linfeilong <linfeilong@huawei.com>,
        <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lihaotian <lihaotian9@huawei.com>,
        <fuse-devel@lists.sourceforge.net>, <kschalk@nvidia.com>,
        <Nikolaus@rath.org>
References: <5e1bf70a-0c6b-89b6-dc9f-474ccfcfe597@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <bf3f21db-1825-ad43-4895-87843d822c49@huawei.com>
Date:   Tue, 27 Oct 2020 17:21:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5e1bf70a-0c6b-89b6-dc9f-474ccfcfe597@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

friendly ping...

On 2020/10/22 22:51, Zhiqiang Liu wrote:
> 
> In fuse_send_init func, ia is allocated by calling kzalloc func, and
> we donot check whether ia is NULL before using it. Thus, if allocating
> ia fails, accessing NULL pointer problem will occur.
> 
> Here, we will call process_init_reply func if ia is NULL.
> 
> Fixes: 615047eff108 ("fuse: convert init to simple api")
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: Haotian Li <lihaotian9@huawei.com>
> ---
>  fs/fuse/inode.c | 161 ++++++++++++++++++++++++++----------------------
>  1 file changed, 87 insertions(+), 74 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 581329203d68..bb526d8cf5b0 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -898,88 +898,97 @@ struct fuse_init_args {
>  static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
>  			       int error)
>  {
> -	struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
> -	struct fuse_init_out *arg = &ia->out;
> +	struct fuse_init_args *ia;
> +	struct fuse_init_out *arg;
> +	unsigned long ra_pages;
> 
> -	if (error || arg->major != FUSE_KERNEL_VERSION)
> +	if (!args) {
>  		fc->conn_error = 1;
> -	else {
> -		unsigned long ra_pages;
> +		goto out;
> +	}
> 
> -		process_init_limits(fc, arg);
> +	ia = container_of(args, typeof(*ia), args);
> +	arg = &ia->out;
> +	if (error || arg->major != FUSE_KERNEL_VERSION) {
> +		fc->conn_error = 1;
> +		goto out_free_ia;
> +	}
> 
> -		if (arg->minor >= 6) {
> -			ra_pages = arg->max_readahead / PAGE_SIZE;
> -			if (arg->flags & FUSE_ASYNC_READ)
> -				fc->async_read = 1;
> -			if (!(arg->flags & FUSE_POSIX_LOCKS))
> -				fc->no_lock = 1;
> -			if (arg->minor >= 17) {
> -				if (!(arg->flags & FUSE_FLOCK_LOCKS))
> -					fc->no_flock = 1;
> -			} else {
> -				if (!(arg->flags & FUSE_POSIX_LOCKS))
> -					fc->no_flock = 1;
> -			}
> -			if (arg->flags & FUSE_ATOMIC_O_TRUNC)
> -				fc->atomic_o_trunc = 1;
> -			if (arg->minor >= 9) {
> -				/* LOOKUP has dependency on proto version */
> -				if (arg->flags & FUSE_EXPORT_SUPPORT)
> -					fc->export_support = 1;
> -			}
> -			if (arg->flags & FUSE_BIG_WRITES)
> -				fc->big_writes = 1;
> -			if (arg->flags & FUSE_DONT_MASK)
> -				fc->dont_mask = 1;
> -			if (arg->flags & FUSE_AUTO_INVAL_DATA)
> -				fc->auto_inval_data = 1;
> -			else if (arg->flags & FUSE_EXPLICIT_INVAL_DATA)
> -				fc->explicit_inval_data = 1;
> -			if (arg->flags & FUSE_DO_READDIRPLUS) {
> -				fc->do_readdirplus = 1;
> -				if (arg->flags & FUSE_READDIRPLUS_AUTO)
> -					fc->readdirplus_auto = 1;
> -			}
> -			if (arg->flags & FUSE_ASYNC_DIO)
> -				fc->async_dio = 1;
> -			if (arg->flags & FUSE_WRITEBACK_CACHE)
> -				fc->writeback_cache = 1;
> -			if (arg->flags & FUSE_PARALLEL_DIROPS)
> -				fc->parallel_dirops = 1;
> -			if (arg->flags & FUSE_HANDLE_KILLPRIV)
> -				fc->handle_killpriv = 1;
> -			if (arg->time_gran && arg->time_gran <= 1000000000)
> -				fc->sb->s_time_gran = arg->time_gran;
> -			if ((arg->flags & FUSE_POSIX_ACL)) {
> -				fc->default_permissions = 1;
> -				fc->posix_acl = 1;
> -				fc->sb->s_xattr = fuse_acl_xattr_handlers;
> -			}
> -			if (arg->flags & FUSE_CACHE_SYMLINKS)
> -				fc->cache_symlinks = 1;
> -			if (arg->flags & FUSE_ABORT_ERROR)
> -				fc->abort_err = 1;
> -			if (arg->flags & FUSE_MAX_PAGES) {
> -				fc->max_pages =
> -					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
> -					max_t(unsigned int, arg->max_pages, 1));
> -			}
> -		} else {
> -			ra_pages = fc->max_read / PAGE_SIZE;
> +	process_init_limits(fc, arg);
> +
> +	if (arg->minor >= 6) {
> +		ra_pages = arg->max_readahead / PAGE_SIZE;
> +		if (arg->flags & FUSE_ASYNC_READ)
> +			fc->async_read = 1;
> +		if (!(arg->flags & FUSE_POSIX_LOCKS))
>  			fc->no_lock = 1;
> -			fc->no_flock = 1;
> +		if (arg->minor >= 17) {
> +			if (!(arg->flags & FUSE_FLOCK_LOCKS))
> +				fc->no_flock = 1;
> +		} else {
> +			if (!(arg->flags & FUSE_POSIX_LOCKS))
> +				fc->no_flock = 1;
>  		}
> -
> -		fc->sb->s_bdi->ra_pages =
> -				min(fc->sb->s_bdi->ra_pages, ra_pages);
> -		fc->minor = arg->minor;
> -		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
> -		fc->max_write = max_t(unsigned, 4096, fc->max_write);
> -		fc->conn_init = 1;
> +		if (arg->flags & FUSE_ATOMIC_O_TRUNC)
> +			fc->atomic_o_trunc = 1;
> +		if (arg->minor >= 9) {
> +			/* LOOKUP has dependency on proto version */
> +			if (arg->flags & FUSE_EXPORT_SUPPORT)
> +				fc->export_support = 1;
> +		}
> +		if (arg->flags & FUSE_BIG_WRITES)
> +			fc->big_writes = 1;
> +		if (arg->flags & FUSE_DONT_MASK)
> +			fc->dont_mask = 1;
> +		if (arg->flags & FUSE_AUTO_INVAL_DATA)
> +			fc->auto_inval_data = 1;
> +		else if (arg->flags & FUSE_EXPLICIT_INVAL_DATA)
> +			fc->explicit_inval_data = 1;
> +		if (arg->flags & FUSE_DO_READDIRPLUS) {
> +			fc->do_readdirplus = 1;
> +			if (arg->flags & FUSE_READDIRPLUS_AUTO)
> +				fc->readdirplus_auto = 1;
> +		}
> +		if (arg->flags & FUSE_ASYNC_DIO)
> +			fc->async_dio = 1;
> +		if (arg->flags & FUSE_WRITEBACK_CACHE)
> +			fc->writeback_cache = 1;
> +		if (arg->flags & FUSE_PARALLEL_DIROPS)
> +			fc->parallel_dirops = 1;
> +		if (arg->flags & FUSE_HANDLE_KILLPRIV)
> +			fc->handle_killpriv = 1;
> +		if (arg->time_gran && arg->time_gran <= 1000000000)
> +			fc->sb->s_time_gran = arg->time_gran;
> +		if ((arg->flags & FUSE_POSIX_ACL)) {
> +			fc->default_permissions = 1;
> +			fc->posix_acl = 1;
> +			fc->sb->s_xattr = fuse_acl_xattr_handlers;
> +		}
> +		if (arg->flags & FUSE_CACHE_SYMLINKS)
> +			fc->cache_symlinks = 1;
> +		if (arg->flags & FUSE_ABORT_ERROR)
> +			fc->abort_err = 1;
> +		if (arg->flags & FUSE_MAX_PAGES) {
> +			fc->max_pages =
> +				min_t(unsigned int, FUSE_MAX_MAX_PAGES,
> +				max_t(unsigned int, arg->max_pages, 1));
> +		}
> +	} else {
> +		ra_pages = fc->max_read / PAGE_SIZE;
> +		fc->no_lock = 1;
> +		fc->no_flock = 1;
>  	}
> -	kfree(ia);
> 
> +	fc->sb->s_bdi->ra_pages =
> +			min(fc->sb->s_bdi->ra_pages, ra_pages);
> +	fc->minor = arg->minor;
> +	fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
> +	fc->max_write = max_t(unsigned int, 4096, fc->max_write);
> +	fc->conn_init = 1;
> +
> +out_free_ia:
> +	kfree(ia);
> +out:
>  	fuse_set_initialized(fc);
>  	wake_up_all(&fc->blocked_waitq);
>  }
> @@ -989,6 +998,10 @@ void fuse_send_init(struct fuse_conn *fc)
>  	struct fuse_init_args *ia;
> 
>  	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
> +	if (!ia) {
> +		process_init_reply(fc, NULL, -ENOTCONN);
> +		return;
> +	}
> 
>  	ia->in.major = FUSE_KERNEL_VERSION;
>  	ia->in.minor = FUSE_KERNEL_MINOR_VERSION;
> 

