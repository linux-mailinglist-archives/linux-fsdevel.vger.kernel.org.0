Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D497759C2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGSROV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjGSROU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:14:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C069210CB
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:14:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-521ac15e333so586a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689786857; x=1692378857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kflaIto2ZRy9FWnKKeA2RV1so53nf9Q2TlLkLWYnNhM=;
        b=7jt8a5ZQWinJTMLOsw76Ptd82nTpItUAmde9SVR7wLXITm2emnqVMqRjtd/0cT2Ocy
         +g/b0COH/UoOS1SiDsnu6P9dn+S7qwCBEmvhjNsDWyx58HOsfS1rYJS+P4pNZYh5ls6j
         YxonkfEkWc/zBUjIS5fSAkYJzxGaxBS4sfEA9iUbn/Uxo6bH3RJ/5m4pQ27F1P1VEpEf
         AsvOsmek2U4OIi0U5mccr9RVZzSvn4w/Q8RwzJgXXMNwdR2KLUH/UybanHexn6gg1lTZ
         73eM3Rz3Kl4PVhQGK4h2QlmPtrI0+CHdTlDbkEwySFMcGYvRvVbzLqN4MK+YAbERJQdE
         hX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786857; x=1692378857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kflaIto2ZRy9FWnKKeA2RV1so53nf9Q2TlLkLWYnNhM=;
        b=LIKw9Gs0dz5ppLVp5kXK5/5mAfTouZy1GfhEKAwd1YTeApKZOHZ41FpIqfmwjWmr3M
         oZQbLIuuRRnvTHJEqukOmPf1cFDPnQtWZVNQrN5BXemMUqbjo47xwKSXE7qdRD+x6UeZ
         Ttx+0qUI7+Wds1qIeBf6+yoXNaDZN1BJYfgoNJ1dPXvoGsl/0caNGEo/nqFdCJ1aLUjs
         L8wPNtHBa//ZgGVZCgElavRFOkFVor/CuwzUzZ5lZUmHTd9lPmRVzggLJCz9Qn5TMaY4
         aFr/muki5k29MqT2H7ZcXrQE3YumD+1WWe4EfCqGSobAib8fQa6vltE2uVY8O5eyiLZN
         XpPw==
X-Gm-Message-State: ABy/qLbaE+eSRybY7KoSNkTKL1IHwTPMx2o057sBNmzrBkCkfxwiI9hm
        /p/LB25mTJJEeoh4OBJb83GC7Nr4SouZ6UotoWKNsvS103spEk7oQekzQg==
X-Google-Smtp-Source: APBJJlGRSF0tEvXGE/is/Qajw4UR5pJnc/wD1guMNvVxbc7T5ofk/LmI5ZFD/CCrOen4zd1SJi9EmJc0BviY3nDh0Ak=
X-Received: by 2002:a50:d783:0:b0:506:b280:4993 with SMTP id
 w3-20020a50d783000000b00506b2804993mr1169edi.2.1689786857109; Wed, 19 Jul
 2023 10:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230719170446.GR20457@twin.jikos.cz> <00000000000042a3ac0600da1f69@google.com>
In-Reply-To: <00000000000042a3ac0600da1f69@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 19 Jul 2023 19:14:05 +0200
Message-ID: <CANp29Y4Dx3puutrowfZBzkHy1VpWHhQ6tZboBrwq_qNcFRrFGw@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
 low! (2)
To:     syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>
Cc:     dsterba@suse.cz, bakmitopiacibubur@boga.indosterling.com,
        clm@fb.com, davem@davemloft.net, dsahern@kernel.org,
        dsterba@suse.com, fw@strlen.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, josef@toxicpanda.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,PLING_QUERY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 7:11=E2=80=AFPM syzbot
<syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com> wrote:
>
> > On Wed, Jul 19, 2023 at 02:32:51AM -0700, syzbot wrote:
> >> syzbot has found a reproducer for the following issue on:
> >>
> >> HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-ker=
nelci
> >> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/li=
nux.git for-kernelci
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15d92aaaa8=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc4a2640e42=
13bc2f
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9bbbacfbf1e0=
4d5221f7
> >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for =
Debian) 2.40
> >> userspace arch: arm64
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D149b2d66=
a80000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1214348aa8=
0000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/9d87aa312c0e/=
disk-e40939bb.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/22a11d32a8b2/vml=
inux-e40939bb.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/0978b5788b5=
2/Image-e40939bb.gz.xz
> >
> > #syz unset btrfs
>
> The following labels did not exist: btrfs

#syz set subsystems: netfilter

>
> >
> > The MAX_LOCKDEP_CHAIN_HLOCKS bugs/warnings can be worked around by
> > configuration, otherwise are considered invalid. This report has also
> > 'netfilter' label so I'm not closing it right away.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000042a3ac0600da1f69%40google.com.
