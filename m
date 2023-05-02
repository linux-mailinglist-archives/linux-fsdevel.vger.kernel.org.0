Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D806F3C87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 06:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjEBEHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 00:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBEHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 00:07:22 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA97630EF
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 21:07:19 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7606e3c6c8aso191894839f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 21:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683000439; x=1685592439;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sun8IGOZKfcXnn6ZeN9QAEArnmcog0Uu2cpeM9kwUI=;
        b=cZVqXn0Ou7nUqVv3RQoM8T3KUODe3aVWgcLzsoCmPFNye7sCBQkkgEz75SoWJFCSt2
         KMK5emLiYAqiw24CesLVS1b54OhFFRqFbbxZmwnGPHGKcA9ivFbIVb+kBud4QniCJqKl
         7XpM+qIOwlnC6uuMngn2qej4hpHoK6Jws6mtooVtXztO22+OugHhc471i7CBAcuomidc
         zBLCO2FCuqqqS2y6KJuhZhUGfVSaGmWDXXhGz51gFoeXijQVqRd4pYXq5bxe5a0I3eNs
         j0ElD/AOAREb3yDqsbVHXN1+2Pu5TT1qDASO6K9/eapTHMKab25P6QpgFLIKedeJGW6f
         yOCw==
X-Gm-Message-State: AC+VfDxvMxhz6K/oW6s1jGYSU9+gNkHrviBs7BloZmASJQ9iJw9qFijx
        LdnO+QxW4jl5ha+oRYdQrstjM7bJcTdmw1k9iQYcCtwkCiAc
X-Google-Smtp-Source: ACHHUZ6HteCvjq8AgQxcAHWcEz8BI0SGep+xEoEPUn42TgCm6UnDnPtPQMvVh6TaW82nUTZSDkGQJ9vcsdO4VFR616JuAkgADzru
MIME-Version: 1.0
X-Received: by 2002:a02:b1ca:0:b0:40f:7193:87dd with SMTP id
 u10-20020a02b1ca000000b0040f719387ddmr7128974jah.5.1683000439247; Mon, 01 May
 2023 21:07:19 -0700 (PDT)
Date:   Mon, 01 May 2023 21:07:19 -0700
In-Reply-To: <000000000000c5beb705faa6577d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000569d3405faae13db@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xfs_getbmap
From:   syzbot <syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com>
To:     david@fromorbit.com, dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yebin10@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 8ee81ed581ff35882b006a5205100db0b57bf070
Author: Ye Bin <yebin10@huawei.com>
Date:   Wed Apr 12 05:49:44 2023 +0000

    xfs: fix BUG_ON in xfs_getbmap()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1235f544280000
start commit:   58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1135f544280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1635f544280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=c103d3808a0de5faaf80
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e25f2c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14945d10280000

Reported-by: syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com
Fixes: 8ee81ed581ff ("xfs: fix BUG_ON in xfs_getbmap()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
