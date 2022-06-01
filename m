Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E548453ACBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 20:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356251AbiFASZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356609AbiFASZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A263A5015;
        Wed,  1 Jun 2022 11:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A917C6136A;
        Wed,  1 Jun 2022 18:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF094C385A5;
        Wed,  1 Jun 2022 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654107901;
        bh=7dmwc1JxqNEK2I53MV/piGLSWyqlDbqSz/Nd/W+NUIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dB5hoqwz3LSkhmpIp+wjclCAcSFgV1Wcdbfs98/GYhIWhH9VDtEFXJuDbWY35vBJ8
         4ILCaLzeDc2L/gu8ht+k387/xYhr/lsmoH+8is2Vl0ZjSbcoT/hGwIpSDNesvCaCpa
         ysptCPynP7wFXBermVj+UHCAX+fViNjoc5I2STgtOu9BRBrWE7bBdfsG60DpFaWRY3
         pEiVGVP3pm0hJeDMKsjRcLoO+DHmyK/HKF9Sntssnqpb0R2hfUpTcLvCPRiXEtLMLE
         VG7Etu0VPVNPTKGjPhGdxU562kuDk0FAQE3Rw1FR4zINJEu7w2tx/MQ3F0iUG7XVZQ
         MCZiK8GFjRnYg==
Date:   Wed, 1 Jun 2022 20:24:55 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [RFC PATCH 2/4] sysctl: ipc: Do not use dynamic memory
Message-ID: <Ypeu97GDg6mNiKQ8@example.org>
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org>
 <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
 <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 09:45:15AM -0700, Linus Torvalds wrote:
> On Wed, Jun 1, 2022 at 6:20 AM Alexey Gladkov <legion@kernel.org> wrote:
> >
> > Dynamic memory allocation is needed to modify .data and specify the per
> > namespace parameter. The new sysctl API is allowed to get rid of the
> > need for such modification.
> 
> Ok, this is looking better. That said, a few comments:
> 
> >
> > diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> > index ef313ecfb53a..833b670c38f3 100644
> > --- a/ipc/ipc_sysctl.c
> > +++ b/ipc/ipc_sysctl.c
> > @@ -68,26 +68,94 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
> >         return ret;
> >  }
> >
> > +static inline void *data_from_ns(struct ctl_context *ctx, struct ctl_table *table);
> > +
> > +static int ipc_sys_open(struct ctl_context *ctx, struct inode *inode, struct file *file)
> > +{
> > +       struct ipc_namespace *ns = current->nsproxy->ipc_ns;
> > +
> > +       // For now, we only allow changes in init_user_ns.
> > +       if (ns->user_ns != &init_user_ns)
> > +               return -EPERM;
> > +
> > +#ifdef CONFIG_CHECKPOINT_RESTORE
> > +       int index = (ctx->table - ipc_sysctls);
> > +
> > +       switch (index) {
> > +               case IPC_SYSCTL_SEM_NEXT_ID:
> > +               case IPC_SYSCTL_MSG_NEXT_ID

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/cgroup.c#n1392:
> [...]
> 
> I don't think you actually even compile-tested this, because you're
> using these IPC_SYSCTL_SEM_NEXT_ID etc enums before you even declared
> them later in the same file.

I did it but without CONFIG_CHECKPOINT_RESTORE.

This is where I'm not sure who can write to ipc sysctls inside
ipc_namespace.

> > +static ssize_t ipc_sys_read(struct ctl_context *ctx, struct file *file,
> > +                    char *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +       struct ctl_table table = *ctx->table;
> > +       table.data = data_from_ns(ctx, ctx->table);
> > +       return table.proc_handler(&table, 0, buffer, lenp, ppos);
> > +}
> 
> Can we please fix the names and the types of this new 'ctx' structure?
> 
> Yes, yes, I know the old legacy "sysctl table" is horribly named, and
> uses "ctl_table".

Sure.

> But let's just write it out. It's not some random control table for
> anything. It's a very odd and specific thing: "sysctl". Let's use the
> full name.
> 
> Also, Please just make that "ctl_data" member in that "ctl_context"
> struct not just have a real name, but a real type. Make it literally
> be
> 
>     struct ipc_namespace *ipc_ns;
> 
> and if we end up with other things wanting other pointers, just add a
> new one (or make a union if we care about the size of that allocation,
> which I don't see any reason we'd do when it's literally just like a
> couple of pointers in size).
> 
> There is no reason to have some pseudo-generic "void *ctl_data" that
> makes it ambiguous and allows for type confusion and isn't
> self-documenting. I'd rather have a properly typed pointer that is
> just initialized to NULL and is not always used or needed, but always
> has a clear case for *what* it would be used for.
> 
> Yes, yes, we have f_private etc for things that are really very very
> generic and have arbitrary users. But 'sysctl' is not that kind of
> truly generic use.

Yep. I made ctl_data in the same way as f_private. My idea is that if
someone needs to store more than one pointer, they can put a struct there.
But it turned out that at least now, apart from ipc_namespace, nothing is
needed.

> I wish we didn't have that silly "create a temporary ctl_table entry"
> either, and I wish it was properly named. But it's not worth the
> pointless churn to fix old bad interfaces. But the new ones should
> have better names, and try to avoid those bad old decisions.

Currently temporary ctl_table is the main strategy for handling sysctl
entries.

Perhaps it will be possible to get rid of this if we add another
get_data() that would return what is currently placed in .data in
ctl_table. I mean make getting .data dynamic.

> But yeah, I think this all is a step in the right direction. And maybe
> some of those cases and old 'ctl_table' things can be migrated to just
> using individual read() functions entirely. The whole 'ctl_table'
> model was broken, and came from the bad old days with an actual
> 'sysctl()' system call.

I'm not sure how to get rid of ctl_table since net sysctls are heavily
dependent on it.

I was wondering if it's possible to get rid of ctl_table but if it's not
possible to rewrite everything to some kind of new magic API, then keeping
two of them would be a nightmare.

Another problem is that ctl_table is being used by __cgroup_bpf_run_filter_sysctl.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/cgroup.c#n1392

> Because I think it would be lovely if people would move away from the
> 'sysctl table' approach entirely for cases where that makes sense, and
> these guys that already need special handling are very much in that
> situation.

Since you think that these patches are a step in the right direction, then
I will prepare the first version with your comments in mind.

-- 
Rgrds, legion

