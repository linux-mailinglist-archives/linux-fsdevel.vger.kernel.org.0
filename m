Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BA765E84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 23:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjG0V4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 17:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjG0V4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:56:31 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07BB35AF
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 14:56:25 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5ab2d29bbso2979303b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 14:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690494985; x=1691099785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTZFcDWEnalsrrsj91+aV+exj/gSz6DkLyYFyJHhczQ=;
        b=MVgCa3UzPNr2n6a4OxwkFTYC3bJ+2pfZ+HVc/8Bvvt+hs2GH9oSIRsQs4oJDoACLhb
         po6V1TP7Lheh6OCcZElT5yAn5VRAkR00srjP28a5y0+NYq0t8217cbnHHczict7Y4TUS
         uSiHeXFK55mLZYPdW9+MnFWJenZX4iPOZ27AEMXmuycO8A3oZIjXcwWqNa8xOzt1nu7x
         mEy5B9OFf1jhUMPlTNGiVuU6pSTVq4b6CJjppmV1DbWAdg9yAUsGe3AVDCBLeCuBQxcR
         ay9AKvWGT85ggAUkp6Iy2VFTbamekCMnjSZKxyXy40QoN1BLM18r3U0BKiB5129aFdDt
         b8zg==
X-Gm-Message-State: ABy/qLbEVEt4WeaubArr+pH2yECM3GSNgl/yoafBFDAhomiW/ZQtn64o
        gSLgX/uHY1nlLVVlMxVu+46PeZIdLV6IUE9hDpP5gE7AIu2+
X-Google-Smtp-Source: APBJJlH27w/I6S9cUeylwXarAxaDlL/rMDcRdn6KLWkdjH2BJtEUNIhS7lk/MWp1h0vRqgIhlJrFWuq2xzxANoqLIN7JnzjhDHdp
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b24:b0:3a3:7087:bbfb with SMTP id
 bx36-20020a0568081b2400b003a37087bbfbmr1067033oib.6.1690494985416; Thu, 27
 Jul 2023 14:56:25 -0700 (PDT)
Date:   Thu, 27 Jul 2023 14:56:25 -0700
In-Reply-To: <000000000000b4e906060113fd63@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019b5b106017f096a@google.com>
Subject: Re: [syzbot] [nilfs?] KASAN: slab-use-after-free Read in
 nilfs_load_inode_block (2)
From:   syzbot <syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, konishi.ryusuke@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 28a65b49eb53e172d23567005465019658bfdb4d
Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu Apr 27 01:15:26 2023 +0000

    nilfs2: do not write dirty data after degenerating to read-only

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177150e5a80000
start commit:   5f0bc0b042fc mm: suppress mm fault logging if fatal signal..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f150e5a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f150e5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=74db8b3087f293d3a13a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15176d81a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132d93d9a80000

Reported-by: syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com
Fixes: 28a65b49eb53 ("nilfs2: do not write dirty data after degenerating to read-only")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
