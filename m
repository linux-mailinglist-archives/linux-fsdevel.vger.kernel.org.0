Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6F6A6BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfGPKrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 06:47:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:34018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728235AbfGPKrj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:47:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01CF9B129;
        Tue, 16 Jul 2019 10:47:38 +0000 (UTC)
Subject: Re: [PATCH 12/12] closures: fix a race on wakeup from closure_sync
To:     Kent Overstreet <kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-13-kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <8381178e-4c1e-e0fe-430b-a459be1a9389@suse.de>
Date:   Tue, 16 Jul 2019 18:47:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190610191420.27007-13-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent,

On 2019/6/11 3:14 上午, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Acked-by: Coly Li <colyli@suse.de>

And also I receive report for suspicious closure race condition in
bcache, and people ask for having this patch into Linux v5.3.

So before this patch gets merged into upstream, I plan to rebase it to
drivers/md/bcache/closure.c at this moment. Of cause the author is you.

When lib/closure.c merged into upstream, I will rebase all closure usage
from bcache to use lib/closure.{c,h}.

Thanks in advance.

Coly Li

> ---
>  lib/closure.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/closure.c b/lib/closure.c
> index 46cfe4c382..3e6366c262 100644
> --- a/lib/closure.c
> +++ b/lib/closure.c
> @@ -104,8 +104,14 @@ struct closure_syncer {
>  
>  static void closure_sync_fn(struct closure *cl)
>  {
> -	cl->s->done = 1;
> -	wake_up_process(cl->s->task);
> +	struct closure_syncer *s = cl->s;
> +	struct task_struct *p;
> +
> +	rcu_read_lock();
> +	p = READ_ONCE(s->task);
> +	s->done = 1;
> +	wake_up_process(p);
> +	rcu_read_unlock();
>  }
>  
>  void __sched __closure_sync(struct closure *cl)
> 


-- 

Coly Li
