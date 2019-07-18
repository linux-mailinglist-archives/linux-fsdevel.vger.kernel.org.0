Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2D16CA36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 09:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389194AbfGRHqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 03:46:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfGRHqx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:46:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF51DAEAF;
        Thu, 18 Jul 2019 07:46:51 +0000 (UTC)
Subject: Re: [PATCH 12/12] closures: fix a race on wakeup from closure_sync
From:   Coly Li <colyli@suse.de>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-13-kent.overstreet@gmail.com>
 <8381178e-4c1e-e0fe-430b-a459be1a9389@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <48527b97-e39a-0791-e038-d9f2ec28943e@suse.de>
Date:   Thu, 18 Jul 2019 15:46:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8381178e-4c1e-e0fe-430b-a459be1a9389@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/7/16 6:47 下午, Coly Li wrote:
> Hi Kent,
> 
> On 2019/6/11 3:14 上午, Kent Overstreet wrote:
>> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Acked-by: Coly Li <colyli@suse.de>
> 
> And also I receive report for suspicious closure race condition in
> bcache, and people ask for having this patch into Linux v5.3.
> 
> So before this patch gets merged into upstream, I plan to rebase it to
> drivers/md/bcache/closure.c at this moment. Of cause the author is you.
> 
> When lib/closure.c merged into upstream, I will rebase all closure usage
> from bcache to use lib/closure.{c,h}.

Hi Kent,

The race bug reporter replies me that the closure race bug is very rare
to reproduce, after applying the patch and testing, they are not sure
whether their closure race problem is fixed or not.

And I notice rcu_read_lock()/rcu_read_unlock() is used here, but it is
not clear to me what is the functionality of the rcu read lock in
closure_sync_fn(). I believe you have reason to use the rcu stuffs here,
could you please provide some hints to help me to understand the change
better ?

Thanks in advance.

Coly Li

>> ---
>>  lib/closure.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/closure.c b/lib/closure.c
>> index 46cfe4c382..3e6366c262 100644
>> --- a/lib/closure.c
>> +++ b/lib/closure.c
>> @@ -104,8 +104,14 @@ struct closure_syncer {
>>  
>>  static void closure_sync_fn(struct closure *cl)
>>  {
>> -	cl->s->done = 1;
>> -	wake_up_process(cl->s->task);
>> +	struct closure_syncer *s = cl->s;
>> +	struct task_struct *p;
>> +
>> +	rcu_read_lock();
>> +	p = READ_ONCE(s->task);
>> +	s->done = 1;
>> +	wake_up_process(p);
>> +	rcu_read_unlock();
>>  }
>>  
>>  void __sched __closure_sync(struct closure *cl)
