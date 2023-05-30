Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C7715ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjE3J6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjE3J6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 05:58:30 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2101CD
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 02:58:29 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33baee0235cso91315ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685440709; x=1688032709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e75vb+3hqOpm7JcGwESgwqcoPR1HC2HqMQ0wDSBbOIc=;
        b=AA6pQ6WyJXxKP9RHJB2dEoaddEeajkb2olokQhAks514pvBBeH/F0v38GBGBJcYfZL
         jPrOeQof44QZ2OXRk/IRaqj1morc9DawOXB8f3knOGfKSCwLyewUzCcs0dCsooL82ROd
         Dg4+h/yTyUUwdKB0EZ1wG5/PmyJr5tjAO9FmRCIUr7gCni5YMEKKq/dCLJYDHQ+ZKoVA
         H4LU8Dn0NV7iaa7SFsHYpnJHbjHcUOYB3T0+PWVE8mjjh3+EdFB5c82EdfI9/qpuDXFL
         49oMkf+tn1IOroKtv7QDhzXRtJ+W78OWMow65DBn8kGVGqSEJd9OR5dq2y8eCLuPu71c
         q7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440709; x=1688032709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e75vb+3hqOpm7JcGwESgwqcoPR1HC2HqMQ0wDSBbOIc=;
        b=e3shfmMvTyss0eljmeCOWNkWP8jrb3TILR9K/wfBFHiKVdIc8eEyeEhqSuOFhMyb9P
         5EWAp3I2WmrxQCJhyzLiCb1/gZ0mfFezaDhNaY+utfiZYHCMKxniBUY+NHQK/iVCmM1Z
         OeiGY2UB8UePqphxiiq1JO4wDB242mYuYPXiLLFdzk/zMVxE0KWYVIG0Rjc4CKAOb6d8
         glK0G2DUTl8NRDQMUuFWq2xrK+s8Dh0yCkdFYkr23vguOZKCi1imdmAheYAIDRRspVNj
         tdqdyQqKuTlsFSuR7ketUBEjjdAsIChanCD/g7o5THdwH8i+wBlQ58qzUDKIBEkC2JU9
         hCiQ==
X-Gm-Message-State: AC+VfDwKRkCQxx+YzG6ZOjMPFKiPOZ2ck1sEL32mbuqn0EOvfYZIUGBO
        6SiOx2YyqFD+ODvJ/TPrdPD5+CPbZ3eNC43M7ViixQ==
X-Google-Smtp-Source: ACHHUZ6rjhZm1OQzYP16rgvILMdIMf1hOb5s4mThPWXqNfPyd48lNVKtLfvMI/MHYOP2wH5YMzSzw3AG0wB5HeqRaBw=
X-Received: by 2002:a92:c24e:0:b0:338:3b6a:4719 with SMTP id
 k14-20020a92c24e000000b003383b6a4719mr87280ilo.17.1685440708956; Tue, 30 May
 2023 02:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000540fc405f01401bf@google.com> <0000000000003ccc9b05fcbfdb68@google.com>
In-Reply-To: <0000000000003ccc9b05fcbfdb68@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 30 May 2023 11:58:17 +0200
Message-ID: <CANp29Y6vkDOAbL4T7hBdd-3fjfkM1vAJfhJF2Xw_UHNPEjawLQ@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] general protection fault in __xfs_free_extent
To:     syzbot <syzbot+bfbc1eecdfb9b10e5792@syzkaller.appspotmail.com>
Cc:     dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 28, 2023 at 2:10=E2=80=AFPM syzbot
<syzbot+bfbc1eecdfb9b10e5792@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b2ccab3199aa7cea9154d80ea2585312c5f6eba0
> Author: Darrick J. Wong <djwong@kernel.org>
> Date:   Wed Apr 12 01:59:53 2023 +0000
>
>     xfs: pass per-ag references to xfs_free_extent
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1007e5c128=
0000
> start commit:   02bf43c7b7f7 Merge tag 'fs.xattr.simple.rework.rbtree.rwl=
o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8c59170b68d26=
a55
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbfbc1eecdfb9b10=
e5792
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1798429d880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D161b948f88000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: xfs: pass per-ag references to xfs_free_extent

Seems reasonable.

#syz fix: xfs: pass per-ag references to xfs_free_extent

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
d/syzkaller-bugs/0000000000003ccc9b05fcbfdb68%40google.com.
