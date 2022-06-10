Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E024E545CE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiFJHKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbiFJHKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:10:22 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E983238AC
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 00:10:19 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so19145823ile.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 00:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1s4eQtwNPIFPmijyqkQxRHOcZ3UNMSKoKcH4SMx+dwU=;
        b=ckoDxoBFrAcv1NIp9DN9W3A+9VvV0r98D8o++9YGQcofdJJsj1sjismQkVT/mWdSUz
         5Dqgdy/+v+VATIyQ1ol2vzrRtaZsgOTI6gUS9NSS0lxpJopoLVyuTowbNuZKwtMwEzJf
         nXwp5TirC5CvE/PNpgtclvfTVwIfUMvvKF7wyG+C2ugzZWKK7UAv4yRGozNe0WdZqXhm
         w5oi3zuXPZfzqm08OZVPEI5VWGgGcIoCBVQAITMJ9OJzHv4Doi/mFs5jH/jyMBvFCvaq
         Mr8fmBIJaFSc1UXEQ0bOfIFJnUfklXFrhtBXXXgPZg49Rm4jnR2dIzvxiH2ovZlWfTZC
         FO8Q==
X-Gm-Message-State: AOAM530g1/XBQQkpcfUs+65g5rJePxyHOhM93pxMKkbsoFsnftZ1Yrbr
        27BJ3YFV1G8Txw7wxiYPA1ZRKbfkSR/k1R5+Z1FcRCpVvZrX
X-Google-Smtp-Source: ABdhPJy5bafZuLIonGH4GUOrP3ruXh8F7X7gdTY46sCg3pH3RDVeUt5B+QRwB61fcauuyJ3F6YRJ4lORT1xiAPOmM/UOYzheuU2c
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3892:b0:331:e9b0:80f2 with SMTP id
 b18-20020a056638389200b00331e9b080f2mr6982887jav.133.1654845019061; Fri, 10
 Jun 2022 00:10:19 -0700 (PDT)
Date:   Fri, 10 Jun 2022 00:10:19 -0700
In-Reply-To: <0000000000003ce9d105e0db53c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085068105e112a117@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in copy_page_from_iter_atomic (2)
From:   syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        hch@lst.de, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 4cd4aed63125ccd4efc35162627827491c2a7be7
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri May 27 08:43:20 2022 +0000

    btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1332525ff00000
start commit:   ff539ac73ea5 Add linux-next specific files for 20220609
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b2525ff00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1732525ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5002042f00a8bce
dashboard link: https://syzkaller.appspot.com/bug?extid=d2dd123304b4ae59f1bd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d6d7cff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1113b2bff00000

Reported-by: syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com
Fixes: 4cd4aed63125 ("btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
