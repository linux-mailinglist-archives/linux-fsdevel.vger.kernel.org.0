Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D68724F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbjFFWaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239873AbjFFWaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:30:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E932F1717
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:30:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2563a4b6285so3190449a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686090616; x=1688682616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSnLlqw5JsJTFwRAjaS9oa9cX/ConG9itjHh20/fwu8=;
        b=tRbk3F0e2NEfHzwsFKlsj7+W8XnJxSTq0qUj/yTV4f0BBC+EQul40bTO1JmyH5XOpO
         2MwHPZmHnAV3TEvoSSrLkpYy/Br7CIQ9IrmMtQgr64AfUtdAM+NV5BW98YDb2EnPwFVy
         +YRPfrCjeEJIJMyCOOgtFUVbkY+Fp+2eyLH2Ee2WZoL5fqy6xuy6hwdW9gGV0j8RTNiJ
         M0qvAwyg0FP5CZyxhVS/hwJDCN8FYTyjFJfEl6eGPQopEG/Cdz0TtoJYJmrM91ncyloD
         hvIemNkR84xMOQB6BVUx3MWfvoCUqBByNNcr47OaIlR+a4sufD3Vw1u98Y99egFiBVG7
         rgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090616; x=1688682616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSnLlqw5JsJTFwRAjaS9oa9cX/ConG9itjHh20/fwu8=;
        b=ZSwsxsPbJ0i9+X8TMTasKPBty6SQMnkDUC341upLjQFxzBT+VrekTSttj5NQTdbQGo
         Mh5kRcQnWPSNplCJS4LqjvTIP125qMQNQs1xKKbm2lhRLBd8Gd2sHaYX0dU/aJdaCgII
         LglycLq9Lt1WVopRxBmWFYF0GrzRAKAT7k6RzAIfv8mhVZIID6XzDI8NnqiPYzxpsnb1
         GOxlBRlEjsAdEHtbu7/zPoaAfQcsgEoT+CDSWnHQsMaFS5JwgCxZBSANd0rd/o9meNgu
         REOo96YM6iyENmSHhmTbZ1b3zCNVoSeIT/UBOLzqXqk28RsPSaXm5getxFwgsDFOpcU1
         Idzw==
X-Gm-Message-State: AC+VfDw4DPsXEE0ws/sF44M59LBw59KyJYJ1JofWmzp1CX3OQoljmLLZ
        c+ZPbOwur1Fjm8ZkkFzVaJylgg==
X-Google-Smtp-Source: ACHHUZ4rURXFwCxvuvdkNt2OeJTIkA+TKnI42M3OuN0Lh/vTVsVNzkPvYww20WmLoUsPE1K/XOiANQ==
X-Received: by 2002:a17:90b:68c:b0:259:3cc4:f978 with SMTP id m12-20020a17090b068c00b002593cc4f978mr2167413pjz.19.1686090616399;
        Tue, 06 Jun 2023 15:30:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a284b00b0025621aa4c6bsm48148pjf.25.2023.06.06.15.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:30:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q6fBt-008eth-0l;
        Wed, 07 Jun 2023 08:30:13 +1000
Date:   Wed, 7 Jun 2023 08:30:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kirill Tkhai <tkhai@ya.ru>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        akpm@linux-foundation.org, vbabka@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, djwong@kernel.org, hughd@google.com,
        paulmck@kernel.org, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-ID: <ZH+zdUZS5T9T/Z+K@dread.disaster.area>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D>
 <ZH6K0McWBeCjaf16@dread.disaster.area>
 <65785745-1fd3-e0d7-26e8-dd74b1074d37@ya.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65785745-1fd3-e0d7-26e8-dd74b1074d37@ya.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:21:42AM +0300, Kirill Tkhai wrote:
> On 06.06.2023 04:24, Dave Chinner wrote:
> > On Mon, Jun 05, 2023 at 05:38:27PM -0700, Roman Gushchin wrote:
> >> On Mon, Jun 05, 2023 at 10:03:25PM +0300, Kirill Tkhai wrote:
> >>> Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
> >>> test case caused by commit: f95bdb700bc6 ("mm: vmscan: make global slab
> >>> shrink lockless"). Qi Zheng investigated that the reason is in long SRCU's
> >>> synchronize_srcu() occuring in unregister_shrinker().
> >>>
> >>> This patch fixes the problem by using new unregistration interfaces,
> >>> which split unregister_shrinker() in two parts. First part actually only
> >>> notifies shrinker subsystem about the fact of unregistration and it prevents
> >>> future shrinker methods calls. The second part completes the unregistration
> >>> and it insures, that struct shrinker is not used during shrinker chain
> >>> iteration anymore, so shrinker memory may be freed. Since the long second
> >>> part is called from delayed work asynchronously, it hides synchronize_srcu()
> >>> delay from a user.
> >>>
> >>> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> >>> ---
> >>>  fs/super.c |    3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/super.c b/fs/super.c
> >>> index 8d8d68799b34..f3e4f205ec79 100644
> >>> --- a/fs/super.c
> >>> +++ b/fs/super.c
> >>> @@ -159,6 +159,7 @@ static void destroy_super_work(struct work_struct *work)
> >>>  							destroy_work);
> >>>  	int i;
> >>>  
> >>> +	unregister_shrinker_delayed_finalize(&s->s_shrink);
> >>>  	for (i = 0; i < SB_FREEZE_LEVELS; i++)
> >>>  		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> >>>  	kfree(s);
> >>> @@ -327,7 +328,7 @@ void deactivate_locked_super(struct super_block *s)
> >>>  {
> >>>  	struct file_system_type *fs = s->s_type;
> >>>  	if (atomic_dec_and_test(&s->s_active)) {
> >>> -		unregister_shrinker(&s->s_shrink);
> >>> +		unregister_shrinker_delayed_initiate(&s->s_shrink);
> >>
> >> Hm, it makes the API more complex and easier to mess with. Like what will happen
> >> if the second part is never called? Or it's called without the first part being
> >> called first?
> > 
> > Bad things.
> > 
> > Also, it doesn't fix the three other unregister_shrinker() calls in
> > the XFS unmount path, nor the three in the ext4/mbcache/jbd2 unmount
> > path.
> > 
> > Those are just some of the unregister_shrinker() calls that have
> > dynamic contexts that would also need this same fix; I haven't
> > audited the 3 dozen other unregister_shrinker() calls around the
> > kernel to determine if any of them need similar treatment, too.
> > 
> > IOWs, this patchset is purely a band-aid to fix the reported
> > regression, not an actual fix for the underlying problems caused by
> > moving the shrinker infrastructure to SRCU protection.  This is why
> > I really want the SRCU changeover reverted.
> > 
> > Not only are the significant changes the API being necessary, it's
> > put the entire shrinker paths under a SRCU critical section. AIUI,
> > this means while the shrinkers are running the RCU grace period
> > cannot expire and no RCU freed memory will actually get freed until
> > the srcu read lock is dropped by the shrinker.
> 
> Why so? Doesn't SRCU and RCU have different grace period and they does not prolong
> each other?

No idea - Documentation/RCU/whatisRCU.rst doesn't describe any
differences between SRCU and RCU except for "use SRCU if you need to
sleep in the read side" and there's no discussion of how they
interact, either. maybe there's some discussion in other RCU
documentation, but there's nothing in the "how to use RCU"
documentation that tells me they use different grace period
definitions...

> Also, it looks like every SRCU has it's own namespace like shrinker_srcu for shrinker.
> Don't different SRCU namespaces never prolong each other?!

RIght, SRCU vs SRCU is well defined. What is not clear from anything
I've read is SRCU vs RCU interactions, so I can only assuming from
the shared "RCU" in the name there are shared implementation
details and interactions...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
