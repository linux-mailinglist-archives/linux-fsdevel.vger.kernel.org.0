Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC576DBE1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 02:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjHCABB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 20:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHCABA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:01:00 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD52D43
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 17:00:59 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5839f38342fso3176817b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691020858; x=1691625658;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LpVe26Go9OijFX1KyR3zeStDg9CzBEWRIOPZGWl218=;
        b=Z36CN6eVM+75yMw8ieui52ogTz5kn+DDKibjhGjYMzhehuZY8XHtoWJaIxWdrxz7nh
         qqlYN0BOoT29Xd4WCRcUhYKlGvuhCrCk0GUy3/RUVjQ5M5JB/PU+Ay3mz0/AZrBJVq26
         Ctxl4WmRiuRba2Tw/ocalt0tyKxEYk5npn7M5yLQ/pMyEtfqW6VQHhIS8iVI4ASAiSXQ
         0lxcmQZrEqA0Gi1Q+YUDV3oVtKsl3bBfjLafo0sFfI7U/NMb0IE2RFHKs5EU+jxLZ5SL
         Kmf0PY0WSPNzEkIZUsQlmpTxZe6IxrRti0wGJREDzAZ1UBpwTeoMhma+hiSRzv7ewosG
         yRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691020858; x=1691625658;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LpVe26Go9OijFX1KyR3zeStDg9CzBEWRIOPZGWl218=;
        b=K2bZTjMoCICe/9Qo3jKblZXK2hQ4OdF4xq6ZcKA8Y+iwD6KBK7bVSKiwkJJ+eFcF/5
         krICajPwmNadFtp3nsZfVsv6comO+/6WvAaPRMOrxQr6tUyYK7hqKMN/NYB5gG+X7eog
         EAf7p4IDaik6cqB7Yg2UxIWuCHRKCXJ0l8I/u0RMvxbMmY3Bd71FQKN+TEB9Iwu6dRhq
         f6HQbjUnYmpfRRRw/qYZfYlLF9/+yRRypIhqwUBAKMuNjztFD3iuuFkWK6ss/6H7B9k3
         nKTj7qdQYr1MO7gwo/jBTCjysrujsTvmLrTi47TKR/+wsEb5DADsW6opkeNcagn1xb6I
         LAQg==
X-Gm-Message-State: ABy/qLZ7Avzkqk4QisBdqQ4B7TTwuvah+nXd8G/c8sR8tcP58S+tlLQD
        K6ZjX3mpa7QAiL/T4WHwaQ0TdQ==
X-Google-Smtp-Source: APBJJlH+589spTw6VYWXLet+X2wEUqAVJj6mVrbnQe14GIxf1b/tvS3uaY7SLSbYWlUf4svZPuQ4PA==
X-Received: by 2002:a0d:ccd4:0:b0:56f:f40f:9414 with SMTP id o203-20020a0dccd4000000b0056ff40f9414mr20041546ywd.38.1691020858293;
        Wed, 02 Aug 2023 17:00:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y80-20020a81a153000000b0058419c57c66sm4991563ywg.4.2023.08.02.17.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:00:57 -0700 (PDT)
Date:   Wed, 2 Aug 2023 17:00:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Carlos Maiolino <cem@kernel.org>
cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
        hughd@google.com
Subject: Re: [bug report] shmem: quota support
In-Reply-To: <20230802142225.of27saigrzotlmza@andromeda>
Message-ID: <1858133-56ab-fafb-7230-a7b0b66694ed@google.com>
References: <kU3N4tqbYA3gHO6AXf5TbwIkfbkKFI9NaCK_39Uj4qC6YJKXa_j98uqXcegkmzc8Nxj8L3rD_UWv_x6y0RGv1Q==@protonmail.internalid> <ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain> <20230802142225.of27saigrzotlmza@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2 Aug 2023, Carlos Maiolino wrote:
> On Wed, Aug 02, 2023 at 09:53:54AM +0300, Dan Carpenter wrote:
> > Hello Carlos Maiolino,
> > 
> > The patch 9a9f8f590f6d: "shmem: quota support" from Jul 25, 2023
> > (linux-next), leads to the following Smatch static checker warning:
> > 
> > 	fs/quota/dquot.c:1271 flush_warnings()
> > 	warn: sleeping in atomic context
> > 
> 
> Thanks for the report Dan!
> 
> > fs/quota/dquot.c
> >     1261 static void flush_warnings(struct dquot_warn *warn)
> >     1262 {
> >     1263         int i;
> >     1264
> >     1265         for (i = 0; i < MAXQUOTAS; i++) {
> >     1266                 if (warn[i].w_type == QUOTA_NL_NOWARN)
> >     1267                         continue;
> >     1268 #ifdef CONFIG_PRINT_QUOTA_WARNING
> >     1269                 print_warning(&warn[i]);
> >     1270 #endif
> > --> 1271                 quota_send_warning(warn[i].w_dq_id,
> >     1272                                    warn[i].w_sb->s_dev, warn[i].w_type);
> > 
> > The quota_send_warning() function does GFP_NOFS allocations, which don't
> > touch the fs but can still sleep.  GFP_ATOMIC or GFP_NOWAIT don't sleep.
> > 
> 
> Hmm, tbh I think the simplest way to fix it is indeed change GFP_NOFS to
> GFP_NOWAIT when calling genlmsg_new(), quota_send_warnings() already abstain to
> pass any error back to its caller, I don't think moving it from GFP_NOFS ->
> GFP_NOWAIT will have much impact here as the amount of memory required for it is
> not that big and wouldn't fail unless free memory is really short. I might be
> wrong though.
> 
> If not that, another option would be to swap tmpfs spinlocks for mutexes, but I
> would rather avoid that.
> 
> CC'ing other folks for more suggestions.

This is certainly a problem, for both dquot_alloc and dquot_free paths.
Thank you, Dan, for catching it.

GFP_NOWAIT is an invitation to flakiness: I don't think it's right to
regress existing quota users by changing GFP_NOFS to GFP_NOWAIT in all
cases there; but it does seem a sensible stopgap for the new experimental
user tmpfs.

I think the thing to do, for now, is to add a flag (DQUOT_SPACE_WARN_NOWAIT?)
which gets passed down to the __dquot_alloc and __dquot_free for tmpfs,
and those choose GFP_NOFS or GFP_NOWAIT accordingly, and pass that gfp_t
on down to flush_warnings() to quota_send_warning() to genlmsg_new() and
genlmsg_multicast().  Carlos, if you agree, please try that.

I have no experience with netlink whatsoever: I hope that will be enough
to stop it from blocking.

I did toy with the idea of passing back the dquot_warn, and letting the
caller do the flush_warnings() at a more suitable moment; and that might
work out, but I suspect that the rearrangement involved would be better
directed to just rearranging where mm/shmem.c makes it dquot_alloc and
dquot_free calls.

And that's something I shall probably want to do, but not rush into.
There's an existing problem, for which I do have the pre-quotas fix,
of concurrent faulters in a size-limited tmpfs getting failures when
they try to allocate the last block (worse when huge page).  Respecting
all the different layers of limiting is awkward, now quotas add another.

Ordinariily, with this blocking issue coming up now, I'd have asked to
back the tmpfs quotas series out of the next tree, and you rework where
the dquot_alloc and dquot_free are done, then bring the series back in
the next cycle.  But with it being managed from vfs.git for this cycle,
and strong preference to return to mm.git next cycle, let's try for a
workaround now, then maybe I can do the rearrangement in mm/shmem.c
next cycle - it is one of the things I was hoping to do then (but
"hope" is not much of a guarantee).

info->mutex instead of info->lock: no thanks.

Hugh

> 
> Carlos
> 
> >     1273         }
> >     1274 }
> > 
> > The call trees that Smatch is worried about are listed.  The "disables
> > preempt" functions take the spin_lock_irq(&info->lock) before calling
> > shmem_recalc_inode().
> > 
> > shmem_charge() <- disables preempt
> > shmem_uncharge() <- disables preempt
> > shmem_undo_range() <- disables preempt
> > shmem_getattr() <- disables preempt
> > shmem_writepage() <- disables preempt
> > shmem_set_folio_swapin_error() <- disables preempt
> > shmem_swapin_folio() <- disables preempt
> > shmem_get_folio_gfp() <- disables preempt
> > -> shmem_recalc_inode()
> >    -> shmem_inode_unacct_blocks()
> >       -> dquot_free_block_nodirty()
> >          -> dquot_free_space_nodirty()
> >             -> __dquot_free_space()
> >                -> flush_warnings()
> 
> Hm, I see, we add dquot_free_block_nodirty() call to shmem_inode_unacct_blocks()
> here, which leads to this possible sleep inside spin_lock_irq().
> > 
> > regards,
> > dan carpenter
