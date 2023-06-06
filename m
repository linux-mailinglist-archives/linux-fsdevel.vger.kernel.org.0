Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB29723473
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 03:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjFFBYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 21:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFFBYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:24:46 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A331103
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 18:24:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39a523e8209so3079254b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686014677; x=1688606677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEO737aUec1lwK9pGviD1SIdvncYRmvXW6gxg/j13BM=;
        b=O9ZFIh1Q61+tKTknsBCMtIRxeAkqIbO4BxvPoMGA4kqRsNG8NIGLudQ4gAEWlLWLnt
         3k4xyS4YC+EcSEl5kwL9vLcvm14OLojC2SxqMP5bH4YQ0zR9MFmSVZT8z3/Nel8mifoc
         gdNhBEuLUUSOUiam1VEsCdw15h7YEhmZFII3T7r0p9Q3F4Yqhb1rcirey7PpdTxIMxK5
         RmQH+kCUOxejayky8B/YD2blSch3v+ncvWbFeZ0W0mtwVzve/fb6paZB4Gl9kTDjKzho
         0+s8srRDttqYni1onJzPjOLoOAh36NjpLtTz+hVHIX4LP4L1yn2ox2kKIL2yxV3kEjM4
         KaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686014677; x=1688606677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEO737aUec1lwK9pGviD1SIdvncYRmvXW6gxg/j13BM=;
        b=Dr+EQ1H3QirR+7V170XLc0JQVc/g98S+Xoo0EZ/ZHJgoZ+wp4N9S03GEFOaISHonmo
         MwPBBd8M09zKfK2df//N1kCC4sWC2dJ4/GjSH+uuGeJmESbB0tWmL46p2b6Et4PgcTNz
         EQuYLp3DPe1BP11JvnmcktCliQ5DtF5ApcKuPdf+pR4w54kD6lFssXCF/lBSKFtmvy5W
         Ow2EwZoGrTvvoBfYaNZYnGIfUye2yf0z1551oTRHv5+CD6/h/TiuZCTAvYpWGZx0vzWM
         OTS5Jc4b0XhwevhlB7OxWUIO15AdBfXVZWbKK3stysBZ+2957f0jFVIOQ6Z2ytzkwGfN
         Ospg==
X-Gm-Message-State: AC+VfDxkWLuT1CkwForGRcFp4LjB5j7CK5kLsHDw2HX8gX3TClZEZl/Z
        MqoohlkIK2Wy5CaqZ4fgf2eRLg==
X-Google-Smtp-Source: ACHHUZ64+rRg/QutfbvttESibwwvT1V7VA2ydXsz/+IAYaJjFQeY7U7IQY/GCjwxut9llPVB2GRiGg==
X-Received: by 2002:a05:6359:3af:b0:129:c53e:eab with SMTP id eg47-20020a05635903af00b00129c53e0eabmr655510rwb.12.1686014676615;
        Mon, 05 Jun 2023 18:24:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b00246cc751c6bsm8817189pjf.46.2023.06.05.18.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:24:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q6LR2-008IwX-2D;
        Tue, 06 Jun 2023 11:24:32 +1000
Date:   Tue, 6 Jun 2023 11:24:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-ID: <ZH6K0McWBeCjaf16@dread.disaster.area>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH6AA72wOd4HKTKE@P9FQF9L96D>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 05:38:27PM -0700, Roman Gushchin wrote:
> On Mon, Jun 05, 2023 at 10:03:25PM +0300, Kirill Tkhai wrote:
> > Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
> > test case caused by commit: f95bdb700bc6 ("mm: vmscan: make global slab
> > shrink lockless"). Qi Zheng investigated that the reason is in long SRCU's
> > synchronize_srcu() occuring in unregister_shrinker().
> > 
> > This patch fixes the problem by using new unregistration interfaces,
> > which split unregister_shrinker() in two parts. First part actually only
> > notifies shrinker subsystem about the fact of unregistration and it prevents
> > future shrinker methods calls. The second part completes the unregistration
> > and it insures, that struct shrinker is not used during shrinker chain
> > iteration anymore, so shrinker memory may be freed. Since the long second
> > part is called from delayed work asynchronously, it hides synchronize_srcu()
> > delay from a user.
> > 
> > Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> > ---
> >  fs/super.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index 8d8d68799b34..f3e4f205ec79 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -159,6 +159,7 @@ static void destroy_super_work(struct work_struct *work)
> >  							destroy_work);
> >  	int i;
> >  
> > +	unregister_shrinker_delayed_finalize(&s->s_shrink);
> >  	for (i = 0; i < SB_FREEZE_LEVELS; i++)
> >  		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> >  	kfree(s);
> > @@ -327,7 +328,7 @@ void deactivate_locked_super(struct super_block *s)
> >  {
> >  	struct file_system_type *fs = s->s_type;
> >  	if (atomic_dec_and_test(&s->s_active)) {
> > -		unregister_shrinker(&s->s_shrink);
> > +		unregister_shrinker_delayed_initiate(&s->s_shrink);
> 
> Hm, it makes the API more complex and easier to mess with. Like what will happen
> if the second part is never called? Or it's called without the first part being
> called first?

Bad things.

Also, it doesn't fix the three other unregister_shrinker() calls in
the XFS unmount path, nor the three in the ext4/mbcache/jbd2 unmount
path.

Those are just some of the unregister_shrinker() calls that have
dynamic contexts that would also need this same fix; I haven't
audited the 3 dozen other unregister_shrinker() calls around the
kernel to determine if any of them need similar treatment, too.

IOWs, this patchset is purely a band-aid to fix the reported
regression, not an actual fix for the underlying problems caused by
moving the shrinker infrastructure to SRCU protection.  This is why
I really want the SRCU changeover reverted.

Not only are the significant changes the API being necessary, it's
put the entire shrinker paths under a SRCU critical section. AIUI,
this means while the shrinkers are running the RCU grace period
cannot expire and no RCU freed memory will actually get freed until
the srcu read lock is dropped by the shrinker.

Given the superblock shrinkers are freeing dentry and inode objects
by RCU freeing, this is also a fairly significant change of
behaviour. i.e.  cond_resched() in the shrinker processing loops no
longer allows RCU grace periods to expire and have memory freed with
the shrinkers are running.

Are there problems this will cause? I don't know, but I'm pretty
sure they haven't even been considered until now....

> Isn't it possible to hide it from a user and call the second part from a work
> context automatically?

Nope, because it has to be done before the struct shrinker is freed.
Those are embedded into other structures rather than being
dynamically allocated objects. Hence the synchronise_srcu() has to
complete before the structure the shrinker is embedded in is freed.

Now, this can be dealt with by having register_shrinker() return an
allocated struct shrinker and the callers only keep a pointer, but
that's an even bigger API change. But, IMO, it is an API change that
should have been done before SRCU was introduced precisely because
it allows decoupling of shrinker execution and completion from
the owning structure.

Then we can stop shrinker execution, wait for it to complete and
prevent future execution in unregister_shrinker(), then punt the
expensive shrinker list removal to background work where processing
delays just don't matter for dead shrinker instances. It doesn't
need SRCU at all...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
