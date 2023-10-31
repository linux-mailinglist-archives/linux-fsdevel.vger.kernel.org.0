Return-Path: <linux-fsdevel+bounces-1613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0867DC4C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 04:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5551F2177C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAAB5672;
	Tue, 31 Oct 2023 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91A5663
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 03:14:07 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFAD98
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:14:00 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VvFy3Qi_1698722035;
Received: from 30.221.133.171(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvFy3Qi_1698722035)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 11:13:57 +0800
Message-ID: <030da6c6-de84-7aed-7901-0e26ed8f1521@linux.alibaba.com>
Date: Tue, 31 Oct 2023 11:13:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
References: <20231030003759.GW800259@ZenIV> <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <67ded994-b001-4e9b-e2c9-530e201096d5@linux.alibaba.com>
 <CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/10/31 11:02, Linus Torvalds wrote:
> On Mon, 30 Oct 2023 at 16:25, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>>
>>> [ Looks around. Oh. Except we have lockref_put_return() in fs/erofs/
>>> too, and that looks completely bogus, since it doesn't check the
>>> return value! ]
>>
>>    74 struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>>    75                                                struct erofs_workgroup *grp)
>>    76 {
>>    77         struct erofs_sb_info *const sbi = EROFS_SB(sb);
>>    78         struct erofs_workgroup *pre;
>>    79
>>    80         /*
>>    81          * Bump up before making this visible to others for the XArray in order
>>    82          * to avoid potential UAF without serialized by xa_lock.
>>    83          */
>>    84         lockref_get(&grp->lockref);
>>    85
>>    86 repeat:
>>    87         xa_lock(&sbi->managed_pslots);
>>    88         pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
>>    89                            NULL, grp, GFP_NOFS);
>>    90         if (pre) {
>>    91                 if (xa_is_err(pre)) {
>>    92                         pre = ERR_PTR(xa_err(pre));
>>    93                 } else if (!erofs_workgroup_get(pre)) {
>>    94                         /* try to legitimize the current in-tree one */
>>    95                         xa_unlock(&sbi->managed_pslots);
>>    96                         cond_resched();
>>    97                         goto repeat;
>>    98                 }
>>    99                 lockref_put_return(&grp->lockref);
>>
>> This line it just decreases the reference count just bumpped up at the
>> line 84 (and it will always succeed).
> 
> You have two possible scenarios:
> 
>   - it doesn't always succeed, because somebody else has the lock on
> the grp->lockref right now, or because lockref doesn't do any
> optimized cases at all
> 
>   - nobody else can access grp->lockref at the same time, so the lock
> is pointless, so you shouldn't be using lockref in the first place,
> and certainly not lockref_put_return

Yeah, the second case is the real use case here.

> 
> IOW, I don't see how lockref_put_return() could possibly *ever* be the
> right thing to do.
> 
> The thing is, lockref_put_return() is fundamentally designed to be
> something that can fail.
> 
> In  fact, in some situations it will *always* fail. Check this out:
> 
> #define USE_CMPXCHG_LOCKREF \
>          (IS_ENABLED(CONFIG_ARCH_USE_CMPXCHG_LOCKREF) && \
>           IS_ENABLED(CONFIG_SMP) && SPINLOCK_SIZE <= 4)
> ...
> #if USE_CMPXCHG_LOCKREF
> ...
> #else
> 
> #define CMPXCHG_LOOP(CODE, SUCCESS) do { } while (0)
> 
> #endif
> ...
> int lockref_put_return(struct lockref *lockref)
> {
>          CMPXCHG_LOOP(
>                  new.count--;
>                  if (old.count <= 0)
>                          return -1;
>          ,
>                  return new.count;
>          );
>          return -1;
> }
> 
> look, if USE_CMPXCHG_LOCKREF is false (on UP, or if spinlock are big
> because of spinlock debugging, or whatever), lockref_put_return() will
> *always* fail, expecting the caller to deal with that failure.
> 
> So doing a lockref_put_return() without dealing with the failure case
> is FUNDAMENTALLY BROKEN.

Yeah, thanks for point out, I get it.  I think this really needs to be
cleaned up since we don't actually care about locking here (since as I
said it doesn't actually populate to XArray).

> 
> Yes, it's an odd function. It's a function that is literally designed
> for that dcache use-case, where we have a fast-path and a slow path,
> and the "lockref_put_return() fails" is the slow-path that needs to
> take the spinlock and do it carefully.
> 
> You *cannot* use that function without failure handling. Really.

I will fix+cleanup this path later and send upstream.  Thanks for the
heads up.

Thanks,
Gao Xiang

> 
>                       Linus

