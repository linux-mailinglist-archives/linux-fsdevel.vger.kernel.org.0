Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C410F58043E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 21:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiGYTCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 15:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGYTCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:02:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23541D32E
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jul 2022 12:02:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so22239122eju.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jul 2022 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUM1CP+2ZUXhXNaHHKSpsTwJwtJWDDOSw2yAzcWT8HA=;
        b=Ypv/i1muEan0Jrz4RW1JiLlZsx7zfu0ARaCP6zqgK8Dlpn80HGGhrRt8UE6mn9DmkJ
         vxHb3S355f1kNXk55/F9pYtnWV4f+Ey56rYjhEXyAG3cFqxlQA47EZo8qxAaIPcmnY6v
         YGxToS3ajc5GxWQqtUZd+BlwV30mYDfKwTico=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUM1CP+2ZUXhXNaHHKSpsTwJwtJWDDOSw2yAzcWT8HA=;
        b=MDGhDnlkHrYU5s8nhQQbhnEQIsY8GNqsxLNjtAJZm/gGZq2zvf8lKDELvzmYyKYGi8
         8nmiUWX5QAR0xXJu7/a4bBMLpphQ40c1vZMt4W/W0sYOdKtJVXjxp2TRNzP9hjMXRHVB
         qGHKubl7iKVlJqct4nTPAug8Lft4EMWa53v5erZLFQI+qnBs1Eia0F1jbDO3lpYcJzOT
         HuCBB0yvVB62679yEFl1rQIBkwn+32KPzCeGNrdKeVO9Qb7fUDLeh3YojfpBKP353N5A
         e/Lkfa2fxbLkBwupOY5K9FQp4jal6KibD3lNExcTkEr5HkYEZNwO3bihY4SwyK5LH6ws
         R7+A==
X-Gm-Message-State: AJIora8x/u7U0O3yGu/FbXmyBLY0LwMrZYXQ2m1cJCfKd1i55GR16buo
        44MKjQfwqoCgVKt4xAAXIqrIRM3k+g1CMgi2
X-Google-Smtp-Source: AGRyM1sYmLTgC/we+qd796r2Bg5M4KUDhF4+NHG/vPQ9iH/8cOEnkE//7yiKdHgWGQ1Tdpdb0d+g2Q==
X-Received: by 2002:a17:906:ef90:b0:72b:9ce5:f016 with SMTP id ze16-20020a170906ef9000b0072b9ce5f016mr10950455ejb.697.1658775754997;
        Mon, 25 Jul 2022 12:02:34 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906151500b007030c97ae62sm5598225ejd.191.2022.07.25.12.02.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 12:02:33 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id c22so7426209wmr.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jul 2022 12:02:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr19647350wmq.145.1658775753078; Mon, 25
 Jul 2022 12:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <YtR8tPTkL/L1kFkY@yury-laptop> <Yt7jfiSlNOeeookP@yury-laptop>
In-Reply-To: <Yt7jfiSlNOeeookP@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jul 2022 12:02:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjroqb0Hr9-1BCATjSuBdfdkWS6qqFaLXrwFCsHvgGH_g@mail.gmail.com>
Message-ID: <CAHk-=wjroqb0Hr9-1BCATjSuBdfdkWS6qqFaLXrwFCsHvgGH_g@mail.gmail.com>
Subject: Re: x86_64/kvm: kernel hangs on poweroff
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:40 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> I didn't investigate on it and I think I'll have no chance to look
> closer at next week or two.

I suspect you will have to bisect it, but it may not even be kernel-specific.

> Just reproduced on v5.19-rc8.

Well, it apparently also reproduces with 5.18, so it's not a regression.

> > [   22.162259] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> > [   22.163539] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.19.0-rc6 #198
> > [   22.164327] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> > [   22.164327] Call Trace:
> > [   22.164327]  <TASK>
> > [   22.164327]  dump_stack_lvl+0x34/0x44
> > [   22.164327]  panic+0x107/0x28a
> > [   22.164327]  do_exit.cold+0x15/0x15
> > [   22.164327]  ? sys_off_notify+0x3e/0x60
> > [   22.164327]  __do_sys_reboot+0x1df/0x220
> > [   22.164327]  ? vfs_writev+0xc7/0x190
> > [   22.164327]  ? virtio_crypto_ctrl_vq_request+0xd0/0xd0
> > [   22.164327]  ? fpregs_assert_state_consistent+0x1e/0x40
> > [   22.164327]  do_syscall_64+0x3b/0x90
> > [   22.164327]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > [   22.164327] RIP: 0033:0x7f42b4118443
> > [   22.164327] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 f9 c9 0d 00 f7 d8

That's literally the "exit()" system call.

So the only reason the kernel is complaining is that your user mode
'init' is calling 'exit()'. Thaty will just make the kernel go "Sorry,
I can't continue, I need init as the child reaper". IOW, it's not a
"kernel bug" kind of panic, it's literally the kernel just going "I'm
done".

The fact that I don't think I've seen anybody else reporting this
makes me think it's something you do.

Without any other reports I can find, and thus no pattern to it, I
think it's on you to figure out when this started happening and what
it is that triggers it, since you're the only one that sees it.

It smells like it's your KVM setup that doesn't recognize the
power-off sequence, so the IO operation that is *supposed* to power
off the machine (and in the case of KVM, make it exit), doesn't do so,
and then that poweroff() thing returns to user space, and then user
space says "I tried to power off, it didn't work, so I'm just going to
exit", and that is what makes the kernel then say "init exited, I
can't continue either"

              Linus
