Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106FE53AB3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356216AbiFAQph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350860AbiFAQpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:45:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A8F9E9FF
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 09:45:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so4971733ejc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sm/cES+pkDaSks5uDugp823Ct/h/91frIrCS39haBeI=;
        b=U+W2VnjjiSr/t1zwPDQhof68HxSYrjuFmU4KxvbNwAxMXa7BqM5kLE36ZdtINvTa34
         ojgk21vPuSmXj7NWL6elHx902k/NPV1EXQtsu1yPF8OkeGmVnGeJAX/sH0BCmE4pp1ZT
         26spaIH9P5OU5fZ1Ek/Wd5EQ3UMh+JGqR4Idc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sm/cES+pkDaSks5uDugp823Ct/h/91frIrCS39haBeI=;
        b=w/uW6KtcPJto3yD3ElSNVVrFbk2Y6lhTu7K1nqAEZxREa5vepTmGg89Pors1bXDJda
         3rz57bXK1Tg/YAWWG4T6PBTye14WAs4gNggEueYaexfj9TuRcfL0LrlxPWK6v4n8VHhM
         v0jhJGVnQX2kgTmoXh5KWe42Ozo4GmvxHRORDoGW12YoD/k2zsSI9o03vDzFJh31r4uD
         +zt6czDr9i0wMbKN3NunUfwWdZ58ID5oQu7RaqpYcBEKYvWNN8TzrLBh1xVPdDpwBYFt
         JZaSPWJOw4GFSKpb7hLnd+hV46WSpsd3bQoB0VdX+HUEuX/O+HuhmHEhTTVCo1NYu/2r
         xfHA==
X-Gm-Message-State: AOAM530hhbq7GO+WbK7HFdrKWYjJ4H+//0rMcxWDM78ZsqvNcajmSo6u
        4894sPyF6om8vGM60osmaysnb3yZDqZ0pf7f
X-Google-Smtp-Source: ABdhPJx80yadF3bz/UAUtWUXWHILJlbPXxNlHwsq4c59nUciHY+vYfEzrfBpXQHUQISF/LO9UDlTSQ==
X-Received: by 2002:a17:907:3e29:b0:6fe:cf85:31a8 with SMTP id hp41-20020a1709073e2900b006fecf8531a8mr402565ejc.18.1654101933353;
        Wed, 01 Jun 2022 09:45:33 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090639ca00b007030c97ae62sm893091eje.191.2022.06.01.09.45.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 09:45:32 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id p19so1300207wmg.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 09:45:32 -0700 (PDT)
X-Received: by 2002:a7b:c409:0:b0:397:8536:d558 with SMTP id
 k9-20020a7bc409000000b003978536d558mr295369wmi.38.1654101932086; Wed, 01 Jun
 2022 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org> <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
In-Reply-To: <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 09:45:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com>
Message-ID: <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] sysctl: ipc: Do not use dynamic memory
To:     Alexey Gladkov <legion@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 1, 2022 at 6:20 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> Dynamic memory allocation is needed to modify .data and specify the per
> namespace parameter. The new sysctl API is allowed to get rid of the
> need for such modification.

Ok, this is looking better. That said, a few comments:

>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index ef313ecfb53a..833b670c38f3 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -68,26 +68,94 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
>         return ret;
>  }
>
> +static inline void *data_from_ns(struct ctl_context *ctx, struct ctl_table *table);
> +
> +static int ipc_sys_open(struct ctl_context *ctx, struct inode *inode, struct file *file)
> +{
> +       struct ipc_namespace *ns = current->nsproxy->ipc_ns;
> +
> +       // For now, we only allow changes in init_user_ns.
> +       if (ns->user_ns != &init_user_ns)
> +               return -EPERM;
> +
> +#ifdef CONFIG_CHECKPOINT_RESTORE
> +       int index = (ctx->table - ipc_sysctls);
> +
> +       switch (index) {
> +               case IPC_SYSCTL_SEM_NEXT_ID:
> +               case IPC_SYSCTL_MSG_NEXT_ID:
[...]

I don't think you actually even compile-tested this, because you're
using these IPC_SYSCTL_SEM_NEXT_ID etc enums before you even declared
them later in the same file.

> +static ssize_t ipc_sys_read(struct ctl_context *ctx, struct file *file,
> +                    char *buffer, size_t *lenp, loff_t *ppos)
> +{
> +       struct ctl_table table = *ctx->table;
> +       table.data = data_from_ns(ctx, ctx->table);
> +       return table.proc_handler(&table, 0, buffer, lenp, ppos);
> +}

Can we please fix the names and the types of this new 'ctx' structure?

Yes, yes, I know the old legacy "sysctl table" is horribly named, and
uses "ctl_table".

But let's just write it out. It's not some random control table for
anything. It's a very odd and specific thing: "sysctl". Let's use the
full name.

Also, Please just make that "ctl_data" member in that "ctl_context"
struct not just have a real name, but a real type. Make it literally
be

    struct ipc_namespace *ipc_ns;

and if we end up with other things wanting other pointers, just add a
new one (or make a union if we care about the size of that allocation,
which I don't see any reason we'd do when it's literally just like a
couple of pointers in size).

There is no reason to have some pseudo-generic "void *ctl_data" that
makes it ambiguous and allows for type confusion and isn't
self-documenting. I'd rather have a properly typed pointer that is
just initialized to NULL and is not always used or needed, but always
has a clear case for *what* it would be used for.

Yes, yes, we have f_private etc for things that are really very very
generic and have arbitrary users. But 'sysctl' is not that kind of
truly generic use.

I wish we didn't have that silly "create a temporary ctl_table entry"
either, and I wish it was properly named. But it's not worth the
pointless churn to fix old bad interfaces. But the new ones should
have better names, and try to avoid those bad old decisions.

But yeah, I think this all is a step in the right direction. And maybe
some of those cases and old 'ctl_table' things can be migrated to just
using individual read() functions entirely. The whole 'ctl_table'
model was broken, and came from the bad old days with an actual
'sysctl()' system call.

Because I think it would be lovely if people would move away from the
'sysctl table' approach entirely for cases where that makes sense, and
these guys that already need special handling are very much in that
situation.

          Linus
