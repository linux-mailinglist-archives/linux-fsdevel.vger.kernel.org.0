Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AED4805C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 03:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhL1Crw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 21:47:52 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:47574 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234611AbhL1Crw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 21:47:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V00M7xX_1640659669;
Received: from 30.225.24.26(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V00M7xX_1640659669)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 10:47:50 +0800
Message-ID: <d066131d-1bcb-e64d-a10b-b3dbb4506b96@linux.alibaba.com>
Date:   Tue, 28 Dec 2021 10:47:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 01/23] cachefiles: add cachefiles_demand devnode
Content-Language: en-US
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-2-jefflexu@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20211227125444.21187-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/27/21 8:54 PM, Jeffle Xu wrote:
> fscache/cachefiles used to serve as a local cache for remote fs. The
> following patches will introduce a new use case, in which local
> read-only fs could implement demand reading with fscache. By then the
> user daemon needs to read and poll on the devnode, and thus the original
> cachefiles devnode can't be reused in this case.
> 
> Thus create a new devnode specifically for the new mode. The following
> patches will add more file_operations.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/cachefiles/daemon.c   |  8 ++++++++
>  fs/cachefiles/internal.h |  1 +
>  fs/cachefiles/main.c     | 12 ++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 40a792421fc1..871f1e0f423d 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -56,6 +56,14 @@ const struct file_operations cachefiles_daemon_fops = {
>  	.llseek		= noop_llseek,
>  };
>  
> +const struct file_operations cachefiles_demand_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= cachefiles_daemon_open,
> +	.release	= cachefiles_daemon_release,
> +	.write		= cachefiles_daemon_write,
> +	.llseek		= noop_llseek,
> +};
> +

Better to prepare the on-demand read() and poll() first, and then add
the on-demand cachefiles dev.

Thanks,
Joseph

>  struct cachefiles_daemon_cmd {
>  	char name[8];
>  	int (*handler)(struct cachefiles_cache *cache, char *args);
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 421423819d63..e0ed811d628d 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -145,6 +145,7 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
>   * daemon.c
>   */
>  extern const struct file_operations cachefiles_daemon_fops;
> +extern const struct file_operations cachefiles_demand_fops;
>  
>  /*
>   * error_inject.c
> diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
> index 3f369c6f816d..0a423274d283 100644
> --- a/fs/cachefiles/main.c
> +++ b/fs/cachefiles/main.c
> @@ -39,6 +39,12 @@ static struct miscdevice cachefiles_dev = {
>  	.fops	= &cachefiles_daemon_fops,
>  };
>  
> +static struct miscdevice cachefiles_demand_dev = {
> +	.minor	= MISC_DYNAMIC_MINOR,
> +	.name	= "cachefiles_demand",
> +	.fops	= &cachefiles_demand_fops,
> +};
> +
>  /*
>   * initialise the fs caching module
>   */
> @@ -52,6 +58,9 @@ static int __init cachefiles_init(void)
>  	ret = misc_register(&cachefiles_dev);
>  	if (ret < 0)
>  		goto error_dev;
> +	ret = misc_register(&cachefiles_demand_dev);
> +	if (ret < 0)
> +		goto error_demand_dev;
>  
>  	/* create an object jar */
>  	ret = -ENOMEM;
> @@ -68,6 +77,8 @@ static int __init cachefiles_init(void)
>  	return 0;
>  
>  error_object_jar:
> +	misc_deregister(&cachefiles_demand_dev);
> +error_demand_dev:
>  	misc_deregister(&cachefiles_dev);
>  error_dev:
>  	cachefiles_unregister_error_injection();
> @@ -86,6 +97,7 @@ static void __exit cachefiles_exit(void)
>  	pr_info("Unloading\n");
>  
>  	kmem_cache_destroy(cachefiles_object_jar);
> +	misc_deregister(&cachefiles_demand_dev);
>  	misc_deregister(&cachefiles_dev);
>  	cachefiles_unregister_error_injection();
>  }
