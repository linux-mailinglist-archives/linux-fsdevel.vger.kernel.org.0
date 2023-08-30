Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D678D268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 05:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbjH3DRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 23:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbjH3DQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:16:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F274D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 20:16:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so112531cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 20:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693365410; x=1693970210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsbp1MTEU+V1uOgThW4ZCQMBGCH501XSWX0uFO9d4wk=;
        b=GKFskmJC3Usb6QiGv+3yx0kgppdm44yW/f8dC2G6LBI2VHgUM8eobmnwgDBN4MXmpc
         0SfxbVKTzwjl5Cc0zhTdquN+YYPDR5Xjj/+ADs6faqFiF7lyMxOLSmYrSHOewPgOaldE
         zBx1vBozNn0tUpEoUFGfksMHZC3a5ZAjTKaZiVVZQXxgS1bsLnh7glj+Xx9cO568AEBC
         qCmS8y8nW3+tgUYl0yzA7loqSnnZKjrC2KpbCtXWhFxt9NAM6xDC+2j4b1TZll4axyxL
         6FsPWNYGEBDD0xZ88dPgT/B15vfWJOmlSM1qUK2R9vPtY9xCZ89Uq2pptxsBebZLXr8s
         I3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693365410; x=1693970210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsbp1MTEU+V1uOgThW4ZCQMBGCH501XSWX0uFO9d4wk=;
        b=JKkUPWV156fSRdlit+luLHG/suyfN/IPB8pqdTQM2lV1WB2Qohr1hA3b+8Y/pUvpka
         JvkwlshcvJKmb7bCu1xJLF89Mh9xd/lYK2gHmGXPB6zYyVWU9zZvc7UnZ7FtB2P+3m6G
         Q4e3TAdIPU5TasGGRenimaPthjqZJ2PIacDPHRK78mxBg6TqNiyHj9CheMhJ1/9lV6IM
         +EEx0cWRvIsz6eVwYXjx0fbSdwW70ZbdTYHWBrG3GmJ6IX5fU+qHf9F2J0KEXmz9oomP
         UG3iaiwEgMvyvBFotiQCmzClO/qh+L0YPx5Y3INwIvtatdH7z+SWUXYUTm8UvIxJYrrP
         qe8w==
X-Gm-Message-State: AOJu0YwBSKZbsc2wbbGdJUQUM78DvV6htPA3pbSq0ibjqc9Y8uYSGSPu
        HXYRI3vHrv10Ag/TXPsk96vhqLp10RAxkKzzNYsLYw==
X-Google-Smtp-Source: AGHT+IF74n41/IyZQfm4cGgTZ3BY5g18F983kAFuueLTtIFcKMZXThCPPHh/XvC4DdWCgr9yJ12Qbcdr/jIjAsCG0/M=
X-Received: by 2002:a05:622a:1910:b0:403:aa88:cf7e with SMTP id
 w16-20020a05622a191000b00403aa88cf7emr323298qtc.29.1693365409601; Tue, 29 Aug
 2023 20:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000017ad3f06040bf394@google.com> <0000000000000c97a4060417bcaf@google.com>
In-Reply-To: <0000000000000c97a4060417bcaf@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 30 Aug 2023 05:16:38 +0200
Message-ID: <CANn89iKB_fnWYT6UH3SsjArRT2424gVo2FjLoMyDrpixts+m2Q@mail.gmail.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_close (5)
To:     syzbot <syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, davem@davemloft.net, eric.dumazet@gmail.com,
        gautamramk@gmail.com, hdanton@sina.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, lesliemonis@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mohitbhasi1998@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, sdp.sachin@gmail.com,
        syzkaller-bugs@googlegroups.com, tahiliani@nitk.edu.in,
        viro@zeniv.linux.org.uk, vsaicharan1998@gmail.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:57=E2=80=AFAM syzbot
<syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit ec97ecf1ebe485a17cd8395a5f35e6b80b57665a
> Author: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
> Date:   Wed Jan 22 18:22:33 2020 +0000
>
>     net: sched: add Flow Queue PIE packet scheduler
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D101bb71868=
0000
> start commit:   727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.=
k..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D121bb71868=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D141bb71868000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D45047a5b8c295=
201
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De46fbd528936346=
4bc13
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14780797a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17c1fc9fa8000=
0
>
> Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Yeah, I figured that out, and sent :

https://patchwork.kernel.org/project/netdevbpf/patch/20230829123541.3745013=
-1-edumazet@google.com/
