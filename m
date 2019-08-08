Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895DC86125
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 13:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfHHLwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 07:52:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfHHLwg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:52:36 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9D59DD45F53295A29038;
        Thu,  8 Aug 2019 19:52:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.210) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 19:52:22 +0800
Subject: Re: [PATCH] epoll: optimize epmutex in ep_free and
 eventpoll_release_file
To:     Cheng Jian <cj.chengjian@huawei.com>, <viro@zeniv.linux.org.uk>,
        <houtao1@huawei.com>, <zhouxiong13@huawei.com>
References: <20190727113542.162213-1-cj.chengjian@huawei.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <a5cbb6af-d1a8-4a11-abd1-2be42f330a1b@huawei.com>
Date:   Thu, 8 Aug 2019 19:52:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190727113542.162213-1-cj.chengjian@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.210]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Zhou Xiong test it on 2 sockets 128 cores ARM64 box, and get the following numbers:

seconds, smaller is better:
concurrency	5.3-rc2		patched		diff (smaller is better)
------------------------------------------------------------------------
10		6.983		4.658		-33.30%
20		14.479		6.8		-53.04%
40		47.689		15.303		-67.91%
80		103.336		22.402		-78.32%

There is a significant improvement in high concurrent and short connection scenario.
Any comments is welcome.

The test program:

#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <unistd.h>
#include <errno.h>
#include <error.h>
#include <sys/epoll.h>

#define TRUE 1
#define FALSE 0

int main(int argc, char * argv[])
{
    int sk = 0, ret = 0;
    struct epoll_event ev, events[10];
    int ep = epoll_create(10);

    int time = 1000000;

    while (time--) {
        sk = socket(PF_INET, SOCK_STREAM, 0);
        if (sk < 0)
            perror("socket failed.\n");

        ev.events = EPOLLIN;
        ev.data.u64 = 43; // Some other number
        if (epoll_ctl(ep, EPOLL_CTL_ADD, sk, &ev) < 0) {
            error(-1, errno, "epoll_ctl");
        }

        close(sk);
    }
}



On 2019/7/27 19:35, Cheng Jian wrote:
> We are optimizing the Request-Per-Second of nginx http server,
> and we found that acquiring epmutex in eventpoll_release_file()
> will become a bottleneck under the one-request-per-connection
> scenario.
> 
> Optimize the epmutex with a smaller granularity. Introduce
> an ref-counter to eventpoll and free eventpoll by rcu, using rcu
> and list_first_or_null_rcu() to iterate file->f_ep_links instead
> of epmutex.
> 
> The following are some details of the scenario:
> 
> HTTP server (nginx):
> 	* under ARM64 with 64 cores
> 	* 64 worker processes, each worker is binded to a specific CPU
> 	* keepalive_requests = 1 in nginx.conf: nginx will close the
> 	  connection fd after a reply is send
> HTTP client[benchmark] (wrk):
> 	* under x86-64 with 48 cores
> 	* 16 threads, 64 connections per-thread
> 
> Before the patch, the RPS measured by wrk is ~220K, after applying
> the patch the RPS is ~240K. We also measure the overhead of
> eventpoll_release_file() and its children by perf: 29% before and
> 2% after.
> 
> Link : https://lkml.org/lkml/2017/10/28/81
> 
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/eventpoll.c | 106 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 92 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index d7f1f5011fac..dc81f1c4fbaa 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -38,6 +38,7 @@
>  #include <linux/compat.h>
>  #include <linux/rculist.h>
>  #include <net/busy_poll.h>
> +#include <linux/refcount.h>
>  
>  /*
>   * LOCKING:
> @@ -225,6 +226,11 @@ struct eventpoll {
>  	/* used to track busy poll napi_id */
>  	unsigned int napi_id;
>  #endif
> +
> +	/* used to ensure the validity of eventpoll when release file */
> +	refcount_t ref;
> +	/* used to free itself */
> +	struct rcu_head rcu;
>  };
>  
>  /* Wait structure used by the poll hooks */
> @@ -809,6 +815,32 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
>  	return 0;
>  }
>  
> +static void ep_rcu_free(struct rcu_head *head)
> +{
> +	struct eventpoll *ep = container_of(head, struct eventpoll, rcu);
> +
> +	kfree(ep);
> +}
> +
> +static void eventpoll_put_ep(struct eventpoll *ep)
> +{
> +	if (refcount_dec_and_test(&ep->ref)) {
> +		mutex_destroy(&ep->mtx);
> +		free_uid(ep->user);
> +		wakeup_source_unregister(ep->ws);
> +
> +		call_rcu(&ep->rcu, ep_rcu_free);
> +	}
> +}
> +
> +static struct eventpoll *eventpoll_get_ep(struct eventpoll *ep)
> +{
> +	if (refcount_inc_not_zero(&ep->ref))
> +		return ep;
> +	else
> +		return NULL;
> +}
> +
>  static void ep_free(struct eventpoll *ep)
>  {
>  	struct rb_node *rbp;
> @@ -826,11 +858,11 @@ static void ep_free(struct eventpoll *ep)
>  	 * anymore. The only hit might come from eventpoll_release_file() but
>  	 * holding "epmutex" is sufficient here.
>  	 */
> -	mutex_lock(&epmutex);
>  
>  	/*
>  	 * Walks through the whole tree by unregistering poll callbacks.
>  	 */
> +	mutex_lock(&ep->mtx);
>  	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
>  		epi = rb_entry(rbp, struct epitem, rbn);
>  
> @@ -846,7 +878,6 @@ static void ep_free(struct eventpoll *ep)
>  	 * We do not need to lock ep->mtx, either, we only do it to prevent
>  	 * a lockdep warning.
>  	 */
> -	mutex_lock(&ep->mtx);
>  	while ((rbp = rb_first_cached(&ep->rbr)) != NULL) {
>  		epi = rb_entry(rbp, struct epitem, rbn);
>  		ep_remove(ep, epi);
> @@ -854,11 +885,19 @@ static void ep_free(struct eventpoll *ep)
>  	}
>  	mutex_unlock(&ep->mtx);
>  
> -	mutex_unlock(&epmutex);
> -	mutex_destroy(&ep->mtx);
> -	free_uid(ep->user);
> -	wakeup_source_unregister(ep->ws);
> -	kfree(ep);
> +	/*
> +	 * ep will not been added to visited_list, because ep_ctrl()
> +	 * can not get its reference and can not reference it by the
> +	 * corresponding epitem. The only possible operation is list_del_init,
> +	 * so it's OK to use list_empty_careful() here.
> +	 */
> +	if (!list_empty_careful(&ep->visited_list_link)) {
> +		mutex_lock(&epmutex);
> +		list_del_init(&ep->visited_list_link);
> +		mutex_unlock(&epmutex);
> +	}
> +
> +	eventpoll_put_ep(ep);
>  }
>  
>  static int ep_eventpoll_release(struct inode *inode, struct file *file)
> @@ -985,7 +1024,7 @@ static const struct file_operations eventpoll_fops = {
>  void eventpoll_release_file(struct file *file)
>  {
>  	struct eventpoll *ep;
> -	struct epitem *epi, *next;
> +	struct epitem *epi;
>  
>  	/*
>  	 * We don't want to get "file->f_lock" because it is not
> @@ -1000,14 +1039,51 @@ void eventpoll_release_file(struct file *file)
>  	 *
>  	 * Besides, ep_remove() acquires the lock, so we can't hold it here.
>  	 */
> -	mutex_lock(&epmutex);
> -	list_for_each_entry_safe(epi, next, &file->f_ep_links, fllink) {
> -		ep = epi->ep;
> +	rcu_read_lock();
> +	while (true) {
> +		epi = list_first_or_null_rcu(&file->f_ep_links,
> +				struct epitem, fllink);
> +		if (!epi)
> +			break;
> +
> +		ep = eventpoll_get_ep(epi->ep);
> +		/* Current epi had been removed by ep_free() */
> +		if (!ep)
> +			continue;
> +		rcu_read_unlock();
> +
>  		mutex_lock_nested(&ep->mtx, 0);
> -		ep_remove(ep, epi);
> +		/*
> +		 * If rb_first_cached() returns NULL, it means that
> +		 * the current epi had been removed by ep_free().
> +		 * To prevent epi from double-freeing, check the
> +		 * condition before invoking ep_remove().
> +		 * If eventpoll_release_file() frees epi firstly,
> +		 * the epi will not be freed again because the epi
> +		 * must have been removed from ep->rbr when ep_free()
> +		 * is invoked.
> +		 */
> +		if (rb_first_cached(&ep->rbr))
> +			ep_remove(ep, epi);
>  		mutex_unlock(&ep->mtx);
> +
> +		eventpoll_put_ep(ep);
> +
> +		rcu_read_lock();
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * The file can not been added to tfile_check_list again, because
> +	 * (1) refcnt has been zero, ep_ctrl() can no longer get its reference
> +	 * (2) related ep items have been removed, ep_loop_check_proc() can not
> +	 *     get the file by ep->rbr.
> +	 */
> +	if (!list_empty_careful(&file->f_tfile_llink)) {
> +		mutex_lock(&epmutex);
> +		list_del_init(&file->f_tfile_llink);
> +		mutex_unlock(&epmutex);
>  	}
> -	mutex_unlock(&epmutex);
>  }
>  
>  static int ep_alloc(struct eventpoll **pep)
> @@ -1030,6 +1106,8 @@ static int ep_alloc(struct eventpoll **pep)
>  	ep->rbr = RB_ROOT_CACHED;
>  	ep->ovflist = EP_UNACTIVE_PTR;
>  	ep->user = user;
> +	INIT_LIST_HEAD(&ep->visited_list_link);
> +	refcount_set(&ep->ref, 1);
>  
>  	*pep = ep;
>  
> @@ -2018,7 +2096,7 @@ static int ep_loop_check(struct eventpoll *ep, struct file *file)
>  	list_for_each_entry_safe(ep_cur, ep_next, &visited_list,
>  							visited_list_link) {
>  		ep_cur->visited = 0;
> -		list_del(&ep_cur->visited_list_link);
> +		list_del_init(&ep_cur->visited_list_link);
>  	}
>  	return ret;
>  }
> 

-- 
Thanks,
Xie XiuQi

