Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542366F0B5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 19:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbjD0Rs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242835AbjD0RsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:48:20 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37664489
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 10:48:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef36d814a5so775451cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682617679; x=1685209679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkY9b1ZD8QmBU/3LOAHMuKOQUldjjMuMq8rdAWwPjIg=;
        b=Lrq1f4JBoMLciZuhEJXD6iSGdMotUaoFNM5njsugrmbmE2AhJhcZsw7hTIkU868DwX
         /FqaYbbyjt98V4FHYNhV6l135E083xIkmRatoHvB8FYydZ5gnwOXduw+gjwSL4+Faa6+
         gzBevtKeaWngpCi+WHH863Ds7PAqvw/pBKcpvuguko2589Vp0kKJb0qILEbrxURB+9ll
         C11wj8cccug0WlR4/nKcyaKvRCpL0O9N6hkfEtHOsgNCwyTITC1UWsmZwI57eiQzWwNp
         vloV5KugvpHcQPKx+rbVa/nRr2YbHmkE4KhHRAYP97kmIP+coN867AvdbQlN1o2H2Z8r
         e51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617679; x=1685209679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkY9b1ZD8QmBU/3LOAHMuKOQUldjjMuMq8rdAWwPjIg=;
        b=fX4rs3P2V/83Yxy4kROky/guTN7FPS+aKWF+qlc3j/uyF/nwMK0bsJY0fSDyaeeTGn
         xUeRhULBi4RyH9E3uLG4Cat97QxXWTs3YJKA4TwpLhlqTJvvW6Ypb3Oo2D9aM6jHH2fa
         xhw70Gs6ZtjblHSqpcrhs/88eUdZ2QZXZg+8rBdei+rvCLB3ObnagS1JF+vD85VvyPgj
         Ep6U79l4sckOapa04u80cTpL7Kvt+4JCzn9IutXuaoG4cTVvcH76cjNtUrrG+D2T2tFd
         llMLTVB+mkEIeiaOjLoQJIrVqXD6tkN026chqOaiGdk1WHQ1sPKSp5p9yDaEYtwaq0SH
         oHyQ==
X-Gm-Message-State: AC+VfDyHFwFRlP3nUp+xwp60fUdv7WZnl1PBz6c6g2EF/sL3RSa0gZUj
        acRhiJ0H7h4CSjbA7cdXNsun0s/m+9beqAY6Ec44vA==
X-Google-Smtp-Source: ACHHUZ5DrWgfAfBOlDWXVSrI+oj6EOY6bJ1qymVeZ+McKOJ5tyYr7iKb+VXDMQ8aB39oUK1ae5itMCcCQmhDxMA+eAw=
X-Received: by 2002:a05:622a:1a03:b0:3de:1aaa:42f5 with SMTP id
 f3-20020a05622a1a0300b003de1aaa42f5mr339663qtb.15.1682617679238; Thu, 27 Apr
 2023 10:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003f3d9a05f56fcac5@google.com> <000000000000b4f18805fa54b9f7@google.com>
In-Reply-To: <000000000000b4f18805fa54b9f7@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 27 Apr 2023 19:47:47 +0200
Message-ID: <CANp29Y4pMRV8ATp+Xb4qAap=m0ruUnNzSgwSbVqomp-FJvTdVg@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] WARNING: suspicious RCU usage in mas_start
To:     syzbot <syzbot+d79e205d463e603f47ff@syzkaller.appspotmail.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        david@redhat.com, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

On Thu, Apr 27, 2023 at 7:31=E2=80=AFPM syzbot
<syzbot+d79e205d463e603f47ff@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6db504ce55bdbc575723938fc480713c9183f6a2
> Author: Liam R. Howlett <Liam.Howlett@oracle.com>
> Date:   Wed Mar 8 22:03:10 2023 +0000
>
>     mm/ksm: fix race with VMA iteration and mm_struct teardown
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1674715fc8=
0000
> start commit:   f3a2439f20d9 Merge tag 'rproc-v6.3' of git://git.kernel.o=
r..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddd442ddf29eac=
a0c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd79e205d463e603=
f47ff
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12cfaf1cc80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D149edbf0c8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: mm/ksm: fix race with VMA iteration and mm_struct teardown

Seems reasonable.
#syz fix: mm/ksm: fix race with VMA iteration and mm_struct teardown
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000b4f18805fa54b9f7%40google.com.
