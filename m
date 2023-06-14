Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E135072F844
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjFNIuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243982AbjFNIuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:50:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B7B1BD4
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 01:50:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f61efe4584so1617e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686732615; x=1689324615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QvqI8Mn5442slnN4bMkfgcgs+D0vQtmOk1Tmf4jn+oQ=;
        b=5Oh5dMC+ehz0CR/xX31cyOHUjR3/6XTEG3m8qsbtdKKtqeQGwrVI5jQUD6k/YPfO0l
         GIyZjSDXRmsUMDCY47os1zDIQ31BLDzzUXhQ/66RYCSN6wylQj3b11GA9WjxEPo9R8hn
         xGK0701TSSftCJf6ueUwWHVwqqGvADCU6vDd2JljH0P6OLavKKfbX0xQN89zOK3j8r5X
         JZs/L1BCxopbRfLtkRWFGVJpVyfeNdnx4KrEumQPlTOuqBWwnDwybLdZrZejtIFXf8kE
         6waFma4vgbHBgR4hyvU7/f4pqpQKJvmUSucvX3eSdIXlbq+APMZKfOKPI6DR/uSSXkeH
         vJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732615; x=1689324615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvqI8Mn5442slnN4bMkfgcgs+D0vQtmOk1Tmf4jn+oQ=;
        b=DgFh2n3cZhKZ2aoI4OAMEG41NB1QGJEPld96j/snsNciN/gQhsPyhHgYJFiERzYF1X
         oUvlzVT3hNakJM1USEuNXXOukfKkhFWp81wjipXHFa4Ahx+90cmWqtydby4mHN2UT8SL
         6TsGGU/CGTv6Ch3rlXIOh1I7YTRmgK8YjlYaiMzOq+n6WHerIH/WLec75kmw6PTGmlyr
         /GfrT+VoNdqopP748Fgr2yq3qZmeuduy+Zi7rnSTxiKAga34fhifO9Y/oVB4KHuJWARk
         UhINUEX4XWI1iPw8t6lxJ3ZyDwbCPdR+eGYBT4ltZkeHlQBZKkANU3CHEolVOCJvU7hS
         rfmw==
X-Gm-Message-State: AC+VfDycdZXfOQFX8Ygpjm05fQg9TEPnMpcC7jongPTNWFFfk/7Oj32f
        9hRpkFBzrm+dTfwNrB3/mejWkH297w8EjbSKmeU+9Dduxm0txL2KlBGP+A==
X-Google-Smtp-Source: ACHHUZ4Y+C4+ZVih15pjCljP83z9agQjBLGlBmyYJPFm12grpcH5LQ/ivV9kqQ6JOfANpnxixSLHu9LWkBkFoMOHsFY=
X-Received: by 2002:a05:6512:3902:b0:4f6:132d:a9c2 with SMTP id
 a2-20020a056512390200b004f6132da9c2mr37539lfu.3.1686732615291; Wed, 14 Jun
 2023 01:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ab092305e268a016@google.com> <000000000000d88b1e05fdf513c3@google.com>
In-Reply-To: <000000000000d88b1e05fdf513c3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 14 Jun 2023 10:50:03 +0200
Message-ID: <CACT4Y+ZGEucU4yhooRGDia5jxjEb7BhSVh9y9s8UfRzrZapusA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_evict_inode (2)
To:     syzbot <syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 12 Jun 2023 at 23:05, syzbot
<syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 504a10d9e46bc37b23d0a1ae2f28973c8516e636
> Author: Bob Peterson <rpeterso@redhat.com>
> Date:   Fri Apr 28 16:07:46 2023 +0000
>
>     gfs2: Don't deref jdesc in evict
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1544372d280000
> start commit:   7df047b3f0aa Merge tag 'vfio-v6.4-rc1' of https://github.c..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=474780ac1e194316
> dashboard link: https://syzkaller.appspot.com/bug?extid=8a5fc6416c175cecea34
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1294d2d2280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104a7508280000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: gfs2: Don't deref jdesc in evict

Looks reasonable:

#syz fix: gfs2: Don't deref jdesc in evict
