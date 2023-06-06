Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB7723583
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 04:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjFFC5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 22:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjFFC5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:57:11 -0400
Received: from out-12.mta0.migadu.com (out-12.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D2118
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 19:57:09 -0700 (PDT)
Date:   Mon, 5 Jun 2023 19:56:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686020227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hHraN3hVCqrmJmmPSWWTuJqPN0R81IdA9hVV/jS2Z0A=;
        b=trn4mw3JuTr7EBl5wGrwvR/Ct5O4ZvVjVNTwDhjDBfcDV9kO1vxVvmXsBt951zKGGmIelG
        Q0QHBL+CPaEpXVjcfoB93wadslMSoongpSClmoZYKSEUPe+luWsNhzu6+gAKVLEQtg7zSP
        R/jXD+cKeHia3kebX1GigHBP9lI9Sik=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-ID: <ZH6ge3yiGAotYRR9@P9FQF9L96D>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D>
 <ZH6K0McWBeCjaf16@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH6K0McWBeCjaf16@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:24:32AM +1000, Dave Chinner wrote:
> On Mon, Jun 05, 2023 at 05:38:27PM -0700, Roman Gushchin wrote:
> > On Mon, Jun 05, 2023 at 10:03:25PM +0300, Kirill Tkhai wrote:
> > > Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
> > > test case caused by commit: f95bdb700bc6 ("mm: vmscan: make global slab
> > > shrink lockless"). Qi Zheng investigated that the reason is in long SRCU's
> > > synchronize_srcu() occuring in unregister_shrinker().
> > > 
> > > This patch fixes the problem by using new unregistration interfaces,
> > > which split unregister_shrinker() in two parts. First part actually only
> > > notifies shrinker subsystem about the fact of unregistration and it prevents
> > > future shrinker methods calls. The second part completes the unregistration
> > > and it insures, that struct shrinker is not used during shrinker chain
> > > iteration anymore, so shrinker memory may be freed. Since the long second
> > > part is called from delayed work asynchronously, it hides synchronize_srcu()
> > > delay from a user.
> > > 
> > > Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> > > ---
> > >  fs/super.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/super.c b/fs/super.c
> > > index 8d8d68799b34..f3e4f205ec79 100644
> > > --- a/fs/super.c
> > > +++ b/fs/super.c
> > > @@ -159,6 +159,7 @@ static void destroy_super_work(struct work_struct *work)
> > >  							destroy_work);
> > >  	int i;
> > >  
> > > +	unregister_shrinker_delayed_finalize(&s->s_shrink);
> > >  	for (i = 0; i < SB_FREEZE_LEVELS; i++)
> > >  		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> > >  	kfree(s);
> > > @@ -327,7 +328,7 @@ void deactivate_locked_super(struct super_block *s)
> > >  {
> > >  	struct file_system_type *fs = s->s_type;
> > >  	if (atomic_dec_and_test(&s->s_active)) {
> > > -		unregister_shrinker(&s->s_shrink);
> > > +		unregister_shrinker_delayed_initiate(&s->s_shrink);
> > 
> > Hm, it makes the API more complex and easier to mess with. Like what will happen
> > if the second part is never called? Or it's called without the first part being
> > called first?
> 
> Bad things.

Agree.

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
> 
> Given the superblock shrinkers are freeing dentry and inode objects
> by RCU freeing, this is also a fairly significant change of
> behaviour. i.e.  cond_resched() in the shrinker processing loops no
> longer allows RCU grace periods to expire and have memory freed with
> the shrinkers are running.
> 
> Are there problems this will cause? I don't know, but I'm pretty
> sure they haven't even been considered until now....
> 
> > Isn't it possible to hide it from a user and call the second part from a work
> > context automatically?
> 
> Nope, because it has to be done before the struct shrinker is freed.
> Those are embedded into other structures rather than being
> dynamically allocated objects.

This part we might consider to revisit, if it helps to solve other problems.
Having an extra memory allocation (or two) per mount-point doesn't look
that expensive. Again, iff it helps with more important problems.

Thanks!
