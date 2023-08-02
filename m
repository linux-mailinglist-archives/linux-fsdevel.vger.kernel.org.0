Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75776D022
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjHBOff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 10:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjHBOfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:35:33 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E59E26AB
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:35:32 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9f057f6daso12519580a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 07:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690986931; x=1691591731;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMzVnXoXwmrDEP/EBdZT0/0KvQJuotKfTHODxNRgwrQ=;
        b=dRC3J9KzahiJSKUlLVdR3h3SI194+RXfhRBK0NCDB/LD7vcUsEf1Fcp0KSRQRKjFly
         UvCKlk3jYYV4e9/BgeAoSaINq8LwXtMJAMzNd1gHjnFuTSVjbnCHt4ruv2gcHqbhxJf3
         LIBo1nqUSdT/DKLxVcanWDnLAbztuDNZBHEnJ4wYdmWfVTu9jUso6keS9pP3hzlRiFpi
         sU5cm28gkPPJwWYHmIRPWayjYd9zNJls3PySaM1n6SyFwxl4HGccz6qH8HvswMGlZeSm
         LznvJ+gZHRnACy/PEaceyCd7AvqcHNq+OEJYmiCTKDITxCb6McaWoRNDtKJLlwNrF36J
         qNzA==
X-Gm-Message-State: ABy/qLahfmaeopy/JGWu5fujfuqVJpErzMRiggNPabuT1dUrr0xQqfwK
        DrS0TsPR7XpM8iuhX4DbRcpVLJBJZg7gEoOG8O6ZOB2qxW4A
X-Google-Smtp-Source: APBJJlFzh1WWYcMl7B/lP9jcvknVyu6XVG3DLcNWnDU6HKWjBszAOCCUF9w3ZlWwsVd4D1WBmvjV8y+rzl9+7AJJQDJVNiDRbtHu
MIME-Version: 1.0
X-Received: by 2002:a9d:7b59:0:b0:6b7:4ec4:cbb1 with SMTP id
 f25-20020a9d7b59000000b006b74ec4cbb1mr16261534oto.7.1690986931595; Wed, 02
 Aug 2023 07:35:31 -0700 (PDT)
Date:   Wed, 02 Aug 2023 07:35:31 -0700
In-Reply-To: <000000000000672c810601db3e84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060bb2a0601f1936f@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit b19c98f237cd76981aaded52c258ce93f7daa8cb
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Fri Jun 23 05:05:41 2023 +0000

    btrfs: fix race between balance and cancel/pause

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12223eb9a80000
start commit:   5d0c230f1de8 Linux 6.5-rc4
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11223eb9a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16223eb9a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=d6443e1f040e8d616e7b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1167e711a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a90161a80000

Reported-by: syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com
Fixes: b19c98f237cd ("btrfs: fix race between balance and cancel/pause")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
