Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC5782D4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbjHUPcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjHUPcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:32:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B1DD9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:32:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so14652411fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692631920; x=1693236720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ajMViAn999T2borJAKgty2s8eZcgpP+nQpjCt7tMLBs=;
        b=LPFdKYxeQdVH2E7Q5TbeGpZWaOvYdTEZXRyPlf3Uhz0AYFvFnpGtzmk+HpqhZbnAD6
         KRGlXIr+NdKupKVWthCveG9ysMQ9CXZJ/xeH+/BivusXCcmBfU962Y2wLtiNwqofGPHd
         4809M+OmUMXmes72udljBpM36v6jkoKj42MgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692631920; x=1693236720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajMViAn999T2borJAKgty2s8eZcgpP+nQpjCt7tMLBs=;
        b=G2rMi6oSwa6ZfgI4srkBq94v4nRSKi75nJjWfNIu7a5cIPQhKtWY5xF3Sc/JW2VYuk
         yo7jeLDJ+p6Q8t2SRJH5p9YafkS9yGcCUaVktZIQF3RB9VOzfPRQNH5lbp2dcaMRfzIW
         3wRATSNuP340CkB2G/bpm84d9zd1Ji6aapZi9ceVXlK8LKPku1MFbkiGoXlV2YHMmGLz
         98KtCmKeEYvlaa4IUunSZRKidgZzoAeYFAA/jJz9P2SsXiYFKSyNnVxSvu/A1ZUNXdoy
         uZ8uXG07Xpcfa+Jn4az0xHgU/LsVjftesGuoii1gbgPbbs3NNs9dMbD2l3+Igra+I4zt
         Jkeg==
X-Gm-Message-State: AOJu0Ywp/Rkaom7upnxOVrcV12l61uQYd2AIz5UPD1pR6td/k69ZSkc7
        XBZTeJKO9qzNSGp/DsncO/k5RxSaWeNa4rz3gqlbfQ==
X-Google-Smtp-Source: AGHT+IGdFCpqnhpi/bYMX4uNpBpHyfyXed6rturJBY7W67IqhYWLzE2x172dXVlzvSbZaEUD+auVrY4l54jFuZcovfk=
X-Received: by 2002:a2e:980f:0:b0:2b9:ea6b:64b with SMTP id
 a15-20020a2e980f000000b002b9ea6b064bmr4949521ljj.37.1692631919785; Mon, 21
 Aug 2023 08:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
 <ZNozdrtKgTeTaMpX@tycho.pizza> <CAJfpegt6x_=F=mD8LEL4AZPbfCLGQrpurhtbDN4Ew50fd2ngqQ@mail.gmail.com>
 <ZNqseD4hqHWmeF2w@tycho.pizza> <CAJfpegtzj7=f99=m49DShDTgLpGAzx8gpHSakgPn0qe+dNjHdw@mail.gmail.com>
 <ZON8hKOAGRvTn83a@tycho.pizza>
In-Reply-To: <ZON8hKOAGRvTn83a@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Aug 2023 17:31:48 +0200
Message-ID: <CAJfpegt2WrKBswYgSzurNogLefO-vU6ZpbCkrDrjFL365kcsug@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async fuse_flush
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Aug 2023 at 17:02, Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Mon, Aug 21, 2023 at 04:24:00PM +0200, Miklos Szeredi wrote:
> > On Tue, 15 Aug 2023 at 00:36, Tycho Andersen <tycho@tycho.pizza> wrote:
> > >
> > > On Mon, Aug 14, 2023 at 04:35:56PM +0200, Miklos Szeredi wrote:
> > > > On Mon, 14 Aug 2023 at 16:00, Tycho Andersen <tycho@tycho.pizza> wrote:
> > > >
> > > > > It seems like we really do need to wait here. I guess that means we
> > > > > need some kind of exit-proof wait?
> > > >
> > > > Could you please recap the original problem?
> > >
> > > Sure, the symptom is a deadlock, something like:
> > >
> > > # cat /proc/1528591/stack
> > > [<0>] do_wait+0x156/0x2f0
> > > [<0>] kernel_wait4+0x8d/0x140
> > > [<0>] zap_pid_ns_processes+0x104/0x180
> > > [<0>] do_exit+0xa41/0xb80
> > > [<0>] do_group_exit+0x3a/0xa0
> > > [<0>] __x64_sys_exit_group+0x14/0x20
> > > [<0>] do_syscall_64+0x37/0xb0
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > > which is stuck waiting for:
> > >
> > > # cat /proc/1544574/stack
> > > [<0>] request_wait_answer+0x12f/0x210
> > > [<0>] fuse_simple_request+0x109/0x2c0
> > > [<0>] fuse_flush+0x16f/0x1b0
> > > [<0>] filp_close+0x27/0x70
> > > [<0>] put_files_struct+0x6b/0xc0
> > > [<0>] do_exit+0x360/0xb80
> > > [<0>] do_group_exit+0x3a/0xa0
> > > [<0>] get_signal+0x140/0x870
> > > [<0>] arch_do_signal_or_restart+0xae/0x7c0
> > > [<0>] exit_to_user_mode_prepare+0x10f/0x1c0
> > > [<0>] syscall_exit_to_user_mode+0x26/0x40
> > > [<0>] do_syscall_64+0x46/0xb0
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > > I have a reproducer here:
> > > https://github.com/tych0/kernel-utils/blob/master/fuse2/Makefile#L7
> >
> > The issue seems to be that the server process is recursing into the
> > filesystem it is serving (nested_fsync()).  It's quite easy to
> > deadlock fuse this way, and I'm not sure why this would be needed for
> > any server implementation.   Can you explain?
>
> I think the idea is that they're saving snapshots of their own threads
> to the fs for debugging purposes.

This seems a fairly special situation.   Have they (whoever they may
be) thought about fixing this in their server?

> Whether this is a sane thing to do or not, it doesn't seem like it
> should deadlock pid ns destruction.

True.   So the suggested solution is to allow wait_event_killable() to
return if a terminal signal is pending in the exiting state and only
in that case turn the flush into a background request?  That would
still allow for regressions like the one reported, but that would be
much less likely to happen in real life.  Okay, I said this for the
original solution as well, so this may turn out to be wrong as well.

Anyway, I'd prefer if this was fixed in the server code, as it looks
fairly special and adding complexity to the kernel for this case might
not be justifiable.   But I'm also open to suggestions on fixing this
in the kernel in a not too complex manner.

Thanks,
Miklos
