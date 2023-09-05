Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D17927DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjIEQAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354149AbjIEJ5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:57:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3A61AE
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 02:57:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso160505e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693907852; x=1694512652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKoqPDQ4c4wMdHCcrBupTOrOf6nGa4D/pvESizqweVY=;
        b=tbLhlm9bS7qbaDVQAS25szwWRY+RrgHuGYhmJ8iDLa1MRyTke8jcXrSIuU/a2jCaMi
         9unz1FTSGqA1nL/2l0LWss6NtrECt6xIgy5C2RkDSuslprW7JmKLFFitoHBOJhBnxLDF
         ekI4fx+dEyi22h92zeT/4/kp/OyuhsQMiq0C1nPww4Lwo6JI/Tnt//C6xA//d88JjXzd
         x4oxRvYI/0lcTrbmExjxPqs51VHhsQLKY7cCdhVO7V3dtk2lFL94xlON5NPI9b9eOaSR
         FkkW2DDisKwJhTR+xWBJyY5QJtaCwVQojAVI4sJ75ezC1UtWol1s/ukycNwhjte3L7mF
         gxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693907852; x=1694512652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKoqPDQ4c4wMdHCcrBupTOrOf6nGa4D/pvESizqweVY=;
        b=apCOuqbqGs2vgqm8LbVAr1nacd6Hc2K4aPHttgEU6lvfwHhggG/cBFMlyQuo/lE/Yx
         Zs59EOirO0RyNwj6/szDM2Qx0KWV5xZqHpTKG/gOm/8W8S8ZAzA3zXXpXShqRj/smQqW
         1usXDDYE0OSkjUTf9rbWUf+Ufkhp5iaFAH+qDCH2ZXkd0HRh7XhuqnaGqntEf29KHQZh
         VeM5t2PQ2oyhun1nKUBwe+oLd/iJ+wXsluTynbSrsAlU3ZZdaxtuxRnm3/pJer3RDE28
         PRXS58AbsJe0mED8MUfU5tzXsncltgPJvBNPDo//G08AmpWCHZ0MHAwN3NgiKR63yq/r
         6Zuw==
X-Gm-Message-State: AOJu0YyYtWWEslc/Kdt36ltYSbRfhGQEoYxNU2ju8rQAmdVsnU4ldz//
        X8K/SRmOuV6/dGt7sgI8px+BkB51EJfUjJwD6WXKUg==
X-Google-Smtp-Source: AGHT+IFvBTvFUF7R7ANkYgde9PIYsgXPp7fox9gwEeYNhLFnCB3TvKs0r2mns8WNAIXVHQWCoxvSCOzyVDapcZgHkxc=
X-Received: by 2002:a05:600c:1c25:b0:400:c6de:6a20 with SMTP id
 j37-20020a05600c1c2500b00400c6de6a20mr241680wms.3.1693907851956; Tue, 05 Sep
 2023 02:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000050a49105f63ed997@google.com> <000000000000fe1297060492eb88@google.com>
In-Reply-To: <000000000000fe1297060492eb88@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 5 Sep 2023 11:57:20 +0200
Message-ID: <CANp29Y4nitnu-iF77=8rNH_k02=N_1+C7C-ix_1XmpMsf1A=BA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_dump_glock (2)
To:     syzbot <syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com, elver@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com, valentin.schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm, no, it might theoretically be that preemption affected bug
reproducibility, but this commit itself definitely has nothing to do
with the gfs2 problem.

On Tue, Sep 5, 2023 at 3:55=E2=80=AFAM syzbot
<syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit a8b76910e465d718effce0cad306a21fa4f3526b
> Author: Valentin Schneider <valentin.schneider@arm.com>
> Date:   Wed Nov 10 20:24:44 2021 +0000
>
>     preempt: Restore preemption model selection configs
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1633aaf068=
0000
> start commit:   58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.=
k..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1533aaf068=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1133aaf068000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5eadbf0d3c2ec=
e89
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D427fed3295e9a7e=
887f2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D172bead8280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14d01d0828000=
0
>
> Reported-by: syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com
> Fixes: a8b76910e465 ("preempt: Restore preemption model selection configs=
")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
