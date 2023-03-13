Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4004C6B84E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 23:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCMWma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 18:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCMWm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:42:28 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309AD8F51E
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 15:42:20 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id c9-20020a929409000000b0032307610dfaso2399729ili.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 15:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747339;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eByn0hcpMeptzqeE5fW4i3qazh2DBAhZRn02bjUF1dw=;
        b=rS61a64SeJwYbFGgX1gYow+eUIYiTVfUiEJx5FPFYZrWoHAKuw6ix6GM/S/8mS1v/U
         pbLsl7cOkMpNTuwrOZeP1Mrd79rhhYliQbMyTlzRuZhJmEx3jdTQ7znTTitnajNQH0TZ
         QjknkneaDXUNhvkWZUhzHxcDQLyGD6XHZ6GtjiX60XPrDwadw31lVZ87qKnhDx8+JFZT
         JuJRZFhdaGwtd82Q6IS2saVG8kwLal/xa0gFAfwrP6IeL/VtusvXgoU0cZZqVfmywgdj
         DMnI1UkxQPFdRo2m9F4y3XF0ERlZJSjfOiT1ptVi6UJ58f7au6juES7y1AoW5yEJTDEH
         x/GA==
X-Gm-Message-State: AO0yUKVkwx1LhgQ5lH59UYa76WHH5rs3ym3gRFEarCphZoqoFupN1UJf
        PaSNmBvHXuZNDKJHDIhcYoHMgGmW9iYPncuOIUJdKfFjdc3qiM8=
X-Google-Smtp-Source: AK7set+fnk55krITt4nQ7dp/jxaceUY4R+J29wFnbO5f0kTTIE+CiL6hu7x9nP551hGsq4nMawWE93qeRydgkCVUG8z6POugriqz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:54f:b0:319:34bf:dbef with SMTP id
 i15-20020a056e02054f00b0031934bfdbefmr648931ils.0.1678747339558; Mon, 13 Mar
 2023 15:42:19 -0700 (PDT)
Date:   Mon, 13 Mar 2023 15:42:19 -0700
In-Reply-To: <000000000000e3af1a05eec2e287@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7988d05f6cfd256@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: use-after-free Read in leaf_paste_in_buffer
From:   syzbot <syzbot+55b82aea13452e3d128f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 26388a7c353f7b1d3fd8a6df6452fa9773193155
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Jan 12 19:44:03 2023 +0000

    cpuidle,arch: Mark all regular cpuidle_state:: Enter methods __cpuidle

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fc20aac80000
start commit:   420b2d431d18 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb1911ff9919df0
dashboard link: https://syzkaller.appspot.com/bug?extid=55b82aea13452e3d128f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17249347480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14281c1b480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cpuidle,arch: Mark all regular cpuidle_state:: Enter methods __cpuidle

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
