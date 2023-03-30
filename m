Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432536CFF28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjC3IxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC3Iww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:52:52 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B847AA2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 01:52:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3e390e23f83so462601cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680166369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pUGbSJeXIbqbiydf5b6Zg3qCqAFB/oHTtk54OkF+CA=;
        b=UL5A7+vSaNkedjf0RM940TocfhoumuI7tBaS0YWz+AHdmXrZAsaX8wgg+j5w7RF298
         Ekgfde63pCUQs435mfNAHjovy4bNbY4sepG9CY+NHWzSERKuHVeenfS0xlvcOAc3APQ7
         vbdswldNEjf9OgMR1peH6SZRFXCyErykMe0XvFX5aBgj1YS2y9b3ZrM8ZBkPRXLIvapG
         gT+rAgFbSqezQkJTs8u5i/mu+uOUu17Ry9YM25/tirUXp0lFmsR4PwhRjtPvvznbAmC5
         H0OTEqHc5CS0RO2tYLKZWyoL9owm0IDNggklzhiqErGjZMAmBziQW5MRyNb4ipAFwD7W
         JzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680166369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pUGbSJeXIbqbiydf5b6Zg3qCqAFB/oHTtk54OkF+CA=;
        b=YaaNqKEh/LW5ely/qFmwP2LBfYJs9bwAdpmESRsUh5/gofWGvK7MUTKp4o6NYdChfp
         4V67jWJoZC9l1HDRg0TK6ug2HCvAt9LiWu4ZMmckknu9Un+jl97+qJ9s6A8gjUICuFFg
         VVsQhYGAevtLCDnrlMNAx28XW6tN4g4OSu/Aj+WNx/bjdnFnbbCz1fIe/xAjcct83qQS
         YsByKM0fsTi9ZRBuseNvOrRH7Mrx7536HP+uiAyqpRfhEzBMXNeyezrXLTlYJ8FBEppC
         jSOzW6hWe8pbYOiWXu/rKkw3cj15NipOEnCHKrDm8nIPBvbM0eO56miWGtkIpnjcKqjm
         +HuQ==
X-Gm-Message-State: AAQBX9cU1p2fqhR89rNNnvZdh0hsXGm7S89et/J8s6E9sEkiFVuxSNrS
        G3MYqM0/TuhGx/crkpOt/zXOogRFG9oGhHVsH1lTvL1pnWmVEGmDl+WKNRGd
X-Google-Smtp-Source: AKy350ZKnJPUXGH+1G0Afn3Z7bkEXPAEpBUNjaFNIywn5HYu6iVE5EFId6tutzAEuEg2L9ihnJWELlyjXRdqhcEtQqg=
X-Received: by 2002:ac8:5dd0:0:b0:3bf:c406:3a5f with SMTP id
 e16-20020ac85dd0000000b003bfc4063a5fmr75067qtx.7.1680166369621; Thu, 30 Mar
 2023 01:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003da76805f8021fb5@google.com> <20230330012750.GF3223426@dread.disaster.area>
In-Reply-To: <20230330012750.GF3223426@dread.disaster.area>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 30 Mar 2023 10:52:37 +0200
Message-ID: <CANp29Y6XNE_wxx1Osa+RrfqOUP9PZhScGnMUDgQ-qqHzYe9KFg@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmap_extents_to_btree
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:27=E2=80=AFAM 'Dave Chinner' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Tue, Mar 28, 2023 at 09:08:01PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git=
.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16f83651c80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dacdb62bf488=
a8fe5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0c383e46e9b48=
27b01b1
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/17229b6e6fe0/d=
isk-1e760fa3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/69b5d310fba0/vmli=
nux-1e760fa3.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/0c65624aace9=
/bzImage-1e760fa3.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 24101 at fs/xfs/libxfs/xfs_bmap.c:660 xfs_bmap_ext=
ents_to_btree+0xe1b/0x1190
>
> Allocation got an unexpected ENOSPC when it was supposed to have a
> valid reservation for the space. Likely because of an inconsistency
> that had been induced into the filesystem where superblock space
> accounting doesn't exactly match the AG space accounting and/or the
> tracked free space.
>
> Given this is a maliciously corrupted filesystem image, this sort of
> warning is expected and there's probably nothing we can do to avoid
> it short of a full filesystem verification pass during mount.
> That's not a viable solution, so I think we should just ignore
> syzbot when it generates this sort of warning....

If it's not a warning about a kernel bug, then WARN_ON should probably
be replaced by some more suitable reporting mechanism. Kernel coding
style document explicitly says:

"WARN*() must not be used for a condition that is expected to trigger
easily, for example, by user space actions. pr_warn_once() is a
possible alternative, if you need to notify the user of a problem."
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/coding-style.rst?id=3D1e760fa3596e8c7f08412712c168288b79=
670d78#n1223

--
Aleksandr

>
> i.e. we actually want this warning to be issued if it happens in
> normal production situations, but given that it's relatively trivial
> to create an inconsistent filesystem image that can trigger this we
> should just ignore it when it is generated by such means.
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
>
