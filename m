Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E09D76F010
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjHCQxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjHCQxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:53:45 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D303C28
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 09:53:23 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-586a3159588so234387b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691081602; x=1691686402;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iE+KLblSLBJ4kXV8+nruJL6O/VLshmXbz1ZZlAXbfhs=;
        b=K4rpr4iY87TMzY/bO2lJDOkCruiOyNMkr+8sHxp2LSxV/keG/6eK4Ls4YT+xSv7bTd
         IauXuyz/0k43lPO7qej9uuT7Nap4DJoOoicVq0Zdbct9MVw+EL1dvEas94tY/NJYnFhG
         GeOnXBabvnPW+ZK1vOZ7T5n3A0VwyyIHlXsLubzZ7zxXHvjI5sFsrVSmqAi8V2PkFdkc
         9OJ5ioJUd8ZTOwnB+Rw0ey3g+u2sfHyg08ANOh+Vdyigf97YEz5JnNdDZpK7epHuZ3tN
         dfeWZjoDoZewNELen0ZU0tV6puJQ7unM7EKdDXbXfkAtmHtcGlKP/szfQ2XTc3SPtZqz
         whbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081602; x=1691686402;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iE+KLblSLBJ4kXV8+nruJL6O/VLshmXbz1ZZlAXbfhs=;
        b=JORQ2Rhd6Y5yj60Iq5aNYQsLA0oy5oqpafZdGirJ+SNgqsyKkIUb1ztSMrrGvMVZtj
         DZAVNlP63V7cghUqI01xHLVYCPfLK9BVwYM0/uqkfKM6irw8RkzjWmrxe12OGsA5aliu
         cOda+0uDrK1jJ8JtIlako4AxLeCj4Eqp6N25VxSTD0WYPueSNgHaKHebcCZ/YjZQFdlf
         F344wtzkMcCdv397xtZp/JcH9KgfUtBFaIPW/QoLXunugUn3y4nwtEbAlAYC4UqumS0S
         DCWGPoD17eQzRf9rCvtHOtDPc2TLGfr1FUy4mcECYAvOHUpVWo3MiKztNZ7u6Tgmg2Uq
         5omA==
X-Gm-Message-State: ABy/qLaWeEqdrdUvJGTWtV3PQzlsz6ER6N7UQGgGj0vWkA4Sbx4IonQv
        BCwnvBV1GMnWlR6j2oPL1yXbTQNdX/qFfy1HAK0UjA==
X-Google-Smtp-Source: APBJJlFq03Wwzc6dStu0AHQLS94GfSxzSu4VpbSZTuFLRnYAxPo9/VX69eZHjE/Mttdel43F0F5hqw==
X-Received: by 2002:a0d:e614:0:b0:583:8c62:b162 with SMTP id p20-20020a0de614000000b005838c62b162mr21969892ywe.4.1691081602253;
        Thu, 03 Aug 2023 09:53:22 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u187-20020a8160c4000000b005869d9535dcsm86697ywb.55.2023.08.03.09.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:53:21 -0700 (PDT)
Date:   Thu, 3 Aug 2023 09:53:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jan Kara <jack@suse.cz>
cc:     Hugh Dickins <hughd@google.com>, Carlos Maiolino <cem@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [bug report] shmem: quota support
In-Reply-To: <20230803111021.ge3asfgvc3nl4uml@quack3>
Message-ID: <a2309115-81f2-bf77-ec3-5b5d91d33b67@google.com>
References: <kU3N4tqbYA3gHO6AXf5TbwIkfbkKFI9NaCK_39Uj4qC6YJKXa_j98uqXcegkmzc8Nxj8L3rD_UWv_x6y0RGv1Q==@protonmail.internalid> <ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain> <20230802142225.of27saigrzotlmza@andromeda> <1858133-56ab-fafb-7230-a7b0b66694ed@google.com>
 <20230803111021.ge3asfgvc3nl4uml@quack3>
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

Thanks for very helpful reply, Jan: it changes everything, at the bottom.

On Thu, 3 Aug 2023, Jan Kara wrote:
> On Wed 02-08-23 17:00:49, Hugh Dickins wrote:
> > 
> > This is certainly a problem, for both dquot_alloc and dquot_free paths.
> > Thank you, Dan, for catching it.
> > 
> > GFP_NOWAIT is an invitation to flakiness: I don't think it's right to
> > regress existing quota users by changing GFP_NOFS to GFP_NOWAIT in all
> > cases there; but it does seem a sensible stopgap for the new experimental
> > user tmpfs.
> 
> So passing gfp argument to quota_send_warning() and propagating the
> blocking info through __dquot_alloc_space() and __dquot_free_space() flags
> would be OK for me *but* if CONFIG_PRINT_QUOTA_WARNING is set (which is
> deprecated but still exists), we end up calling tty_write_message() out of
> flush_warnings() and that can definitely block.

Oh yes :(

> 
> So if we are looking for unintrusive stopgap solution, maybe tmpfs can just
> tell quota code to not issue warnings at all by using
> __dquot_alloc_space() without DQUOT_SPACE_WARN flag and add support for
> this flag to __dquot_free_space()? The feature is not used too much AFAIK
> anyway. And once we move dquot calls into places where they can sleep, we
> can reenable the warning support.

If the warning feature is not used very much at all (I did not realize
that), then certainly this would be a better way to go for now, than
the inadequate and extra DQUOT_SPACE_WARN_NOWAIT I was suggesting.

> 
> > I think the thing to do, for now, is to add a flag (DQUOT_SPACE_WARN_NOWAIT?)
> > which gets passed down to the __dquot_alloc and __dquot_free for tmpfs,
> > and those choose GFP_NOFS or GFP_NOWAIT accordingly, and pass that gfp_t
> > on down to flush_warnings() to quota_send_warning() to genlmsg_new() and
> > genlmsg_multicast().  Carlos, if you agree, please try that.

Carlos, sorry, please don't waste your time on DQUOT_SPACE_WARN_NOWAIT
or no-DQUOT_SPACE_WARN.

> > 
> > I have no experience with netlink whatsoever: I hope that will be enough
> > to stop it from blocking.
> 
> Yes, if you pass non-blocking gfp mode to netlink code, it takes care not
> to block when allocating and sending the message.

Useful info, thanks.

>  
> > I did toy with the idea of passing back the dquot_warn, and letting the
> > caller do the flush_warnings() at a more suitable moment; and that might
> > work out, but I suspect that the rearrangement involved would be better
> > directed to just rearranging where mm/shmem.c makes it dquot_alloc and
> > dquot_free calls.
> 
> Yeah, frankly I think this is the best fix. AFAIU the problem is only with
> shmem_recalc_inode() getting called under info->lock which looks managable
> as far as I'm looking at the call sites and relatively easy wrt quotas as
> freeing of quota space cannot fail. At least all shmem_inode_acct_blocks()
> calls seem to be in places where they can sleep.

Ah, I believe you're right, and that's great: I was living in the past,
when shmem_charge() was still calling shmem_inode_acct_block() under
info->lock.

I agree, the only problem appears to be that shmem_inode_unacct_blocks()
call which I had to place inside shmem_recalc_inode(): under info->lock,
so I was just perpetuating the problems - extending them even.

So the fix should not require any rearrangement of where the dquot_alloc
and dquot_free are done: I may want to do so later, when updating to fix
the failures of concurrent allocation of last block, but there's no need
to get into any such rearrangement as part of this fix.

We just want shmem_recalc_inode() to take the info->lock itself, do its
adjustments and balancing, release the lock and dquot_free the excess.

I had a quick look through that, most places look straightforward to
update, but there are a couple where I need to think a bit first.
So no patch in this mail, but I'll get back to it in a few hours.

Hugh
