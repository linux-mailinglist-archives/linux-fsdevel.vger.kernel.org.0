Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF110723418
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 02:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjFFAif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 20:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFFAie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:38:34 -0400
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 17:38:33 PDT
Received: from out-60.mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228AA6
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 17:38:33 -0700 (PDT)
Date:   Mon, 5 Jun 2023 17:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686011912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Xi6jsYM9ZciceNFvAe5rQ/vkIA6YXglfKKPWJ53Rcs=;
        b=VPOYBWQpwtuyh3+GVgcQm9QECvPCcs07jSDc2pPEuISsH2r70ERXuO5x53OEK/80nVzsSN
        FSmDit1vPnaSLvzCVTcm+5vS7WBxkVdMIW1l0j7Sa8DI/kJoYLGoEfmZLk93rPaGcuKAD7
        mGYJufXyPbDEfJ8uVPhbXAqenfdGVMQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kirill Tkhai <tkhai@ya.ru>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, djwong@kernel.org, hughd@google.com,
        paulmck@kernel.org, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
        david@fromorbit.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-ID: <ZH6AA72wOd4HKTKE@P9FQF9L96D>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168599180526.70911.14606767590861123431.stgit@pro.pro>
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

On Mon, Jun 05, 2023 at 10:03:25PM +0300, Kirill Tkhai wrote:
> Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
> test case caused by commit: f95bdb700bc6 ("mm: vmscan: make global slab
> shrink lockless"). Qi Zheng investigated that the reason is in long SRCU's
> synchronize_srcu() occuring in unregister_shrinker().
> 
> This patch fixes the problem by using new unregistration interfaces,
> which split unregister_shrinker() in two parts. First part actually only
> notifies shrinker subsystem about the fact of unregistration and it prevents
> future shrinker methods calls. The second part completes the unregistration
> and it insures, that struct shrinker is not used during shrinker chain
> iteration anymore, so shrinker memory may be freed. Since the long second
> part is called from delayed work asynchronously, it hides synchronize_srcu()
> delay from a user.
> 
> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> ---
>  fs/super.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 8d8d68799b34..f3e4f205ec79 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -159,6 +159,7 @@ static void destroy_super_work(struct work_struct *work)
>  							destroy_work);
>  	int i;
>  
> +	unregister_shrinker_delayed_finalize(&s->s_shrink);
>  	for (i = 0; i < SB_FREEZE_LEVELS; i++)
>  		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
>  	kfree(s);
> @@ -327,7 +328,7 @@ void deactivate_locked_super(struct super_block *s)
>  {
>  	struct file_system_type *fs = s->s_type;
>  	if (atomic_dec_and_test(&s->s_active)) {
> -		unregister_shrinker(&s->s_shrink);
> +		unregister_shrinker_delayed_initiate(&s->s_shrink);

Hm, it makes the API more complex and easier to mess with. Like what will happen
if the second part is never called? Or it's called without the first part being
called first?

Isn't it possible to hide it from a user and call the second part from a work
context automatically?

Thanks!
