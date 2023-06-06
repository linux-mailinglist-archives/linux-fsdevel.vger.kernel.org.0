Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2107724EB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 23:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbjFFVVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjFFVVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:21:48 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6410EC;
        Tue,  6 Jun 2023 14:21:46 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3487:0:640:5432:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 782E95E88D;
        Wed,  7 Jun 2023 00:21:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id gLb9nX1DXW20-iN3RTibD;
        Wed, 07 Jun 2023 00:21:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1686086503;
        bh=RMot/4BQsuRfbRLhJgaV6MPyHz0uyQeRv16SmPWU6H8=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=IPPmyYR+daX6HIFKKvQk6V4E1dR0yVfYKzRLugVmFGTmJ6tHUSuBnWefkrvFEilZN
         Ik6Jh6P98aaPYwLo5Q2mSu5QD9N5OzRJpZxN31caVNkBytQtbyEwlte9duWxBSqqgU
         XViYQ2v1kXWC35+Dlg2CF12F1Gea5BnZ81wiOhrY=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <65785745-1fd3-e0d7-26e8-dd74b1074d37@ya.ru>
Date:   Wed, 7 Jun 2023 00:21:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, djwong@kernel.org, hughd@google.com,
        paulmck@kernel.org, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D> <ZH6K0McWBeCjaf16@dread.disaster.area>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <ZH6K0McWBeCjaf16@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.06.2023 04:24, Dave Chinner wrote:
> On Mon, Jun 05, 2023 at 05:38:27PM -0700, Roman Gushchin wrote:
>> On Mon, Jun 05, 2023 at 10:03:25PM +0300, Kirill Tkhai wrote:
>>> Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
>>> test case caused by commit: f95bdb700bc6 ("mm: vmscan: make global slab
>>> shrink lockless"). Qi Zheng investigated that the reason is in long SRCU's
>>> synchronize_srcu() occuring in unregister_shrinker().
>>>
>>> This patch fixes the problem by using new unregistration interfaces,
>>> which split unregister_shrinker() in two parts. First part actually only
>>> notifies shrinker subsystem about the fact of unregistration and it prevents
>>> future shrinker methods calls. The second part completes the unregistration
>>> and it insures, that struct shrinker is not used during shrinker chain
>>> iteration anymore, so shrinker memory may be freed. Since the long second
>>> part is called from delayed work asynchronously, it hides synchronize_srcu()
>>> delay from a user.
>>>
>>> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
>>> ---
>>>  fs/super.c |    3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/super.c b/fs/super.c
>>> index 8d8d68799b34..f3e4f205ec79 100644
>>> --- a/fs/super.c
>>> +++ b/fs/super.c
>>> @@ -159,6 +159,7 @@ static void destroy_super_work(struct work_struct *work)
>>>  							destroy_work);
>>>  	int i;
>>>  
>>> +	unregister_shrinker_delayed_finalize(&s->s_shrink);
>>>  	for (i = 0; i < SB_FREEZE_LEVELS; i++)
>>>  		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
>>>  	kfree(s);
>>> @@ -327,7 +328,7 @@ void deactivate_locked_super(struct super_block *s)
>>>  {
>>>  	struct file_system_type *fs = s->s_type;
>>>  	if (atomic_dec_and_test(&s->s_active)) {
>>> -		unregister_shrinker(&s->s_shrink);
>>> +		unregister_shrinker_delayed_initiate(&s->s_shrink);
>>
>> Hm, it makes the API more complex and easier to mess with. Like what will happen
>> if the second part is never called? Or it's called without the first part being
>> called first?
> 
> Bad things.
> 
> Also, it doesn't fix the three other unregister_shrinker() calls in
> the XFS unmount path, nor the three in the ext4/mbcache/jbd2 unmount
> path.
> 
> Those are just some of the unregister_shrinker() calls that have
> dynamic contexts that would also need this same fix; I haven't
> audited the 3 dozen other unregister_shrinker() calls around the
> kernel to determine if any of them need similar treatment, too.
> 
> IOWs, this patchset is purely a band-aid to fix the reported
> regression, not an actual fix for the underlying problems caused by
> moving the shrinker infrastructure to SRCU protection.  This is why
> I really want the SRCU changeover reverted.
> 
> Not only are the significant changes the API being necessary, it's
> put the entire shrinker paths under a SRCU critical section. AIUI,
> this means while the shrinkers are running the RCU grace period
> cannot expire and no RCU freed memory will actually get freed until
> the srcu read lock is dropped by the shrinker.

Why so? Doesn't SRCU and RCU have different grace period and they does not prolong
each other?

Also, it looks like every SRCU has it's own namespace like shrinker_srcu for shrinker.
Don't different SRCU namespaces never prolong each other?!
 
> Given the superblock shrinkers are freeing dentry and inode objects
> by RCU freeing, this is also a fairly significant change of
> behaviour. i.e.  cond_resched() in the shrinker processing loops no
> longer allows RCU grace periods to expire and have memory freed with
> the shrinkers are running.
> 
> Are there problems this will cause? I don't know, but I'm pretty
> sure they haven't even been considered until now....
> 
>> Isn't it possible to hide it from a user and call the second part from a work
>> context automatically?
> 
> Nope, because it has to be done before the struct shrinker is freed.
> Those are embedded into other structures rather than being
> dynamically allocated objects. Hence the synchronise_srcu() has to
> complete before the structure the shrinker is embedded in is freed.
> 
> Now, this can be dealt with by having register_shrinker() return an
> allocated struct shrinker and the callers only keep a pointer, but
> that's an even bigger API change. But, IMO, it is an API change that
> should have been done before SRCU was introduced precisely because
> it allows decoupling of shrinker execution and completion from
> the owning structure.
> 
> Then we can stop shrinker execution, wait for it to complete and
> prevent future execution in unregister_shrinker(), then punt the
> expensive shrinker list removal to background work where processing
> delays just don't matter for dead shrinker instances. It doesn't
> need SRCU at all...
> 
> -Dave.

