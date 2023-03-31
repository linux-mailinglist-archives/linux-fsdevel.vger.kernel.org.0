Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBD6D1AA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 10:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCaIpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 04:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjCaIoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:44:55 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C443C3A
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 01:44:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3e0965f70ecso663671cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680252244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sha7c++P1pbeS2BqNK6x5hml1dJwu4esM9ohuBhGxoo=;
        b=lNYvkbIyWPH+TukSN5yijUu/JrmZj5WLsnvNYR2WMPTr/aAoGX4PBhqjDnocmACo/T
         MKxWcIAMY6g3Qj3EA7bH3uhenyiYlZLrcq47lMizoYpId8Y00zJXLJhsXqzYJUDCI+Cs
         nJFAiwfBkcqXwhCkReUQoQbazemGfu/2fNZZdHzwCN8a/LD6dFtSVYxkOmw8Ts/TZsD9
         geCQiwZK6Gadn3rKi2GqtqZonAv/8GNP8y8jMIYB2MnziogexhLHL9zEHNcY8w3arIpM
         ORlmLAp2o9A8/h4lzpencXFRzCRdmDOFVaEetAa+suLQmmE+ripVLYdvVUFqjg4VtSDS
         M9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680252244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sha7c++P1pbeS2BqNK6x5hml1dJwu4esM9ohuBhGxoo=;
        b=Ed2/xNHswWnjFq+6l+WXGXVCIYvLn7DT+9Uju2hTeWCEK92y8QgGdzZufOeMSkKkPj
         ySv9MeWj6pLXhMcUhHWz49l5gVQJK2gWBp705MnVrR3zpnu4WSCcjFqlSD9gLLdxFiYY
         5qPYCpf4lbwDvBfUaARAZJg2zaod/J7tMSBDs19MHHnQNz+bYin13YgODVfj6CpNHEXi
         z28IXZ3ZXwS/4uVaBtBStyXJCnc16Zx3jx3tKouQ5U1O0klfAcxwkckMEWcLX+SDgFXv
         o5EAr1ltjpuBhO6zcaMKHesNdT9FBb5nOL0nJGNBEvzMURAjvpwvSgnwHrxEcdPSJNJe
         Q/Tw==
X-Gm-Message-State: AAQBX9dmk+ACluSfd9BsT52SNQnTraLWBLts9OJXptEiRprPRyXhgSzV
        f5yhLQFFBbogqn3rsgPbfy4VCgEh20C7szrlEzKnIQ==
X-Google-Smtp-Source: AKy350b8nraY3tqqEiP3oP5jd8OLxt+sQatka0/Et5K9qmgE0sibhdHo4mg2zz3tsXHVyCIrioMNFjdncGojggKz9ac=
X-Received: by 2002:a05:622a:189a:b0:3df:6cbb:c76 with SMTP id
 v26-20020a05622a189a00b003df6cbb0c76mr199176qtc.13.1680252244119; Fri, 31 Mar
 2023 01:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000093079705ea9aada2@google.com> <0000000000004ee9b405f82355d8@google.com>
In-Reply-To: <0000000000004ee9b405f82355d8@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 31 Mar 2023 10:43:50 +0200
Message-ID: <CANp29Y7wQccVBGJM_jJzrszzkE9wiHOhjdYoaPtzB=0WP0BbDA@mail.gmail.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindCtl
To:     syzbot <syzbot+7edb85bc97be9f350d90@syzkaller.appspotmail.com>
Cc:     dave.kleikamp@oracle.com, jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 9:45=E2=80=AFPM syzbot
<syzbot+7edb85bc97be9f350d90@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit fad376fce0af58deebc5075b8539dc05bf639af3
> Author: Liu Shixin via Jfs-discussion <jfs-discussion@lists.sourceforge.n=
et>
> Date:   Thu Nov 3 03:01:59 2022 +0000
>
>     fs/jfs: fix shift exponent db_agl2size negative
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D146d74a5c8=
0000
> start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10=
-..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da66c6c673fb55=
5e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7edb85bc97be9f3=
50d90
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16d5817a880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15d68cde88000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs/jfs: fix shift exponent db_agl2size negative

It might well be possible. The patch improves the validation of
db_agl2size parameter, which affects the execution some frames up in
the crash stack trace:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
jfs/jfs_dmap.c?id=3D6d36c728bc2e2d632f4b0dea00df5532e20dfdab#n729

#syz fix: fs/jfs: fix shift exponent db_agl2size negative

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
