Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD26F6CA11F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 12:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjC0KU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjC0KUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:20:55 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D340249E9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 03:20:43 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32RAJmSJ002733;
        Mon, 27 Mar 2023 19:19:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 27 Mar 2023 19:19:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32RAJmN0002730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Mar 2023 19:19:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6bfca9e9-d4d8-37ec-d53c-0c77e7c70e85@I-love.SAKURA.ne.jp>
Date:   Mon, 27 Mar 2023 19:19:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] sysv: convert pointers_lock from rw_lock to rw_sem
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>
References: <0000000000000ccf9a05ee84f5b0@google.com>
 <6fcbdc89-6aff-064b-a040-0966152856e0@I-love.SAKURA.ne.jp>
 <20230327000440.GF3390869@ZenIV>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230327000440.GF3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/03/27 9:04, Al Viro wrote:
> However, I don't think this is the right fix.  Note that the problem is
> with get_branch() done under the rwlock; all other places are safe.  But
> in get_branch() we only need the lock (and only shared, at that) around
> the verify+add pair.  See how it's done in fs/minix/itree_common.c...
> Something like this:

I can see fs/minix/itree_common.c is doing similar things. But since I'm not
familiar with filesystems, I can't be convinced that minix's assumption is safe.

>  static Indirect *find_shared(struct inode *inode,
>                                 int depth,
>                                 int offsets[],
>                                 Indirect chain[],
>                                 sysv_zone_t *top)
>  {
>         Indirect *partial, *p;
>         int k, err;
> 
>         *top = 0;
>         for (k = depth; k > 1 && !offsets[k-1]; k--)
>                 ;
> 
> -       write_lock(&pointers_lock);
>         partial = get_branch(inode, k, offsets, chain, &err);

Does the result of verify_chain() from get_branch() remain valid even after
sleep by preemption at this line made get_branch() to execute "*err = -EAGAIN;"
line rather than "return NULL;" line?

>         if (!partial)
>                 partial = chain + k-1;

Can sleep by preemption at this line or

> +
> +       write_lock(&pointers_lock);
>         /*
>          * If the branch acquired continuation since we've looked at it -
>          * fine, it should all survive and (new) top doesn't belong to us.
>          */
>         if (!partial->key && *partial->p) {
>                 write_unlock(&pointers_lock);

at this line change the result of "!partial->key && *partial->p" test above?

>                 goto no_top;
>         }
>         for (p=partial; p>chain && all_zeroes((sysv_zone_t*)p->bh->b_data,p->p); p--)
>                 ;
>         /*
>          * OK, we've found the last block that must survive. The rest of our
>          * branch should be detached before unlocking. However, if that rest
>          * of branch is all ours and does not grow immediately from the inode
>          * it's easier to cheat and just decrement partial->p.
>          */
>         if (p == chain + k - 1 && p > chain) {
>                 p->p--;
>         } else {
>                 *top = *p->p;
>                 *p->p = 0;
>         }
>         write_unlock(&pointers_lock);
>  
>         while (partial > p) {
>                 brelse(partial->bh);
>                 partial--;
>         }
>  no_top:
>         return partial;
>  }

I feel worried about

	/*
	 * Indirect block might be removed by truncate while we were
	 * reading it. Handling of that case (forget what we've got and
	 * reread) is taken out of the main path.
	 */
	if (err == -EAGAIN)
		goto changed;

in get_block()...

