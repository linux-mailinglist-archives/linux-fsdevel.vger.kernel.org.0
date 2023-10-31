Return-Path: <linux-fsdevel+bounces-1611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB87DC473
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B2B20F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 02:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56C25C89;
	Tue, 31 Oct 2023 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4D5677
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 02:30:08 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EBBEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 19:30:01 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VvFqNoH_1698719397;
Received: from 30.221.133.171(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvFqNoH_1698719397)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:29:58 +0800
Message-ID: <6e6e255d-ee6b-264f-afd2-89005dcc16af@linux.alibaba.com>
Date: Tue, 31 Oct 2023 10:29:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
References: <20231030003759.GW800259@ZenIV> <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <67ded994-b001-4e9b-e2c9-530e201096d5@linux.alibaba.com>
In-Reply-To: <67ded994-b001-4e9b-e2c9-530e201096d5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/10/31 10:25, Gao Xiang wrote:
> Hi Linus,
> 
> On 2023/10/31 06:18, Linus Torvalds wrote:
>> On Mon, 30 Oct 2023 at 11:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>
>>> After fixing a couple of brainos, it seems to work.
>>
>> This all makes me unnaturally nervous, probably because it;s overly
>> subtle, and I have lost the context for some of the rules.
>>
>> I like the patch, because honestly, our current logic for dput_fast()
>> is nasty, andI agree with you that the existence of d_op->d_delete()
>> shouldn't change the locking logic.
>>
>> At the same time, I just worry. That whole lockref_put_return() thing
>> has horrific semantics, and this is the only case that uses it, and I
>> wish we didn't need it.
>>
>> [ Looks around. Oh. Except we have lockref_put_return() in fs/erofs/
>> too, and that looks completely bogus, since it doesn't check the
>> return value! ]
> 
>   74 struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>   75                                                struct erofs_workgroup *grp)
>   76 {
>   77         struct erofs_sb_info *const sbi = EROFS_SB(sb);
>   78         struct erofs_workgroup *pre;
>   79
>   80         /*
>   81          * Bump up before making this visible to others for the XArray in order
>   82          * to avoid potential UAF without serialized by xa_lock.
>   83          */
>   84         lockref_get(&grp->lockref);
>   85
>   86 repeat:
>   87         xa_lock(&sbi->managed_pslots);
>   88         pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
>   89                            NULL, grp, GFP_NOFS);
>   90         if (pre) {
>   91                 if (xa_is_err(pre)) {
>   92                         pre = ERR_PTR(xa_err(pre));
>   93                 } else if (!erofs_workgroup_get(pre)) {
>   94                         /* try to legitimize the current in-tree one */
>   95                         xa_unlock(&sbi->managed_pslots);
>   96                         cond_resched();
>   97                         goto repeat;
>   98                 }
>   99                 lockref_put_return(&grp->lockref);
> 
> This line it just decreases the reference count just bumpped up at the
> line 84 (and it will always succeed).

Add some words: also since it's a new allocated one without populated
so it won't be locked by others.

> 
> Since it finds a previous one at line 88, so the old one will be used
> (and be returned) instead of the new one and the new allocated one
> will be freed in the caller.
> 
> Hopefully it explains the use case here.
> 
> 100                 grp = pre;
> 101         }
> 102         xa_unlock(&sbi->managed_pslots);
> 103         return grp;
> 104 }
> 
> Thanks,
> Gao Xiang
> 

