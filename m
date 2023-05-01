Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CF6F2FD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjEAJSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEAJSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 05:18:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF3131
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 02:18:40 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-330ec047d3bso38435ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682932719; x=1685524719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O86laohwidt7Bpepl03li3jzMB4EXmXzNejm8wi6V84=;
        b=jvs7kr4VxgxyccvQgBhbQK9IwARcESd2U3pKgjhOVP4NNOFXTd7usmhNIpWhGDQYUv
         X9/zszV9c9VElnowdKqA2s7mBjXZgA1dMPT6GMvUQ0EQvfeRH76UG9N+ZNQ92v9BNr8Q
         FEar4Nl2LalrM7wLcoemncbZ4eS+YLyaaweWkyOy3wybB6clODU8itjhoBqIDtr/9z2U
         G/0qZbBY+iuKkNZXmT+LWf5TpVIqLCxfONNUIOO2SRzQxkuiIdnqBnUICFHYmrW6p93q
         0GuRhRc/ewB6u/i+e0glrufgN1R1+e3Z+O0XTAyoZLybYJFo8/v+bgBKQe39iFrK2SGP
         SWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682932719; x=1685524719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O86laohwidt7Bpepl03li3jzMB4EXmXzNejm8wi6V84=;
        b=kYqAxHVslf7J8a74DsfmM45Hr4q8mmmVRb1DYaAnKywhSO+agQuWo69d/fCq+Jte2d
         miYOQxbYuFYAFJj2LGMVTY2Ncca8WnbduzvW3yXIPTXgMMNVxgOHtVUP0P1w2DbCktRe
         mCDg87AZMHgYcN2jnFzOy2bUhbweKKMSN/P2TZn8MNoOKu0nTFYpbcwFvcF6bmvI6iVr
         D7QHfQbI/TkrsykztrABZuK8TW+37j45HKsg0pmpwJTpKrC/Tt4SpRrlNKAkpA8X8heV
         18G9maMC+qCS10uelCdhUh3L5dTsNOOydSrPngGnlg0cCTVW5vnGYjs5sk9OKerVsdKC
         LYwA==
X-Gm-Message-State: AC+VfDxtHB615CMnq/7icdUQGAXpI2S3KpZJsoIyb+/5lgZu1kl3hIK+
        INaVDiMJiZFa3TCVwvBzKep4k43A1jtQB+v9csMvZw==
X-Google-Smtp-Source: ACHHUZ5ngfNanfrhJTCmcKjegKker9g3iRo8IO02+ZEh/87VQJgz1tmGSQF+THePU63x3ALCCiPcmgXXSt2jenW6ZvI=
X-Received: by 2002:a05:6e02:b49:b0:32a:642d:2a13 with SMTP id
 f9-20020a056e020b4900b0032a642d2a13mr440333ilu.6.1682932719586; Mon, 01 May
 2023 02:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eccdc505f061d47f@google.com> <ZE4NVo6rTOeGQdK+@mit.edu>
In-Reply-To: <ZE4NVo6rTOeGQdK+@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 1 May 2023 11:18:28 +0200
Message-ID: <CANp29Y7dG3Z11Bt99rS0y8epdXfaKk+HJfXt=ePbm29vYF88Gg@mail.gmail.com>
Subject: Re: [syzbot] [sysv?] [vfs?] WARNING in invalidate_bh_lru
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>,
        hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On Sun, Apr 30, 2023 at 8:40=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Wed, Dec 21, 2022 at 06:57:38PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kern=
elci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/lin=
ux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1560b830480=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcbd4e584773=
e9397
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9743a41f74f00=
e50fc77
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2=
da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15e320b38=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D147c0577880=
000
>
> #syz set subsystems: sysv, udf
>
> There are two reproducers, one that mounts a sysv file system, and the
> other which mounts a udf file system.  There is no mention of ext4 in
> the stack trace, and yet syzbot has assigned this to the ext4
> subsystem for some unknown reason.

In this particular case, there were two ext4-related crashes as well:

https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14c7dd1b480000
https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1153a07f480000

I think syzbot picked a too generic frame as a bug title and it just
got confused by crashes belonging to different filesystems.
Maybe we need to display subsystems for individual crashes as well, so
that it's easier for a human to understand what's going on..

--
Aleksandr


>
>                                         - Ted
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/ZE4NVo6rTOeGQdK%2B%40mit.edu.
