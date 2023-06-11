Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A855772B41E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 23:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFKVSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFKVSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:18:32 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F48E55
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 14:18:30 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77abce06481so366063439f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 14:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686518309; x=1689110309;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++zemBX/2RrOYOFOLtSc1QjMmPmCs+Z/n8b0jPh3c7o=;
        b=d83m63B8W1AQ1dCQZZCGV4sdxabdKDfeD6xTylMDSHqBf67UvjU6MKjBC5Gw7Nj3st
         2SiQ4NN2cQGd/nwL3LADx+dyLcLRDHqtnxvdNq2T8opp18GWfnMBVVjMs755K5EP7c51
         FGYYWxvnI2wpH5kYrd1ZfXEwPfoD4kY0AHW6zwNWNphjMsCEf9uKw9FY+AyH50Z0Wml2
         EGj1hPVdrRkcY6IOMUTH7glcs0XVqaxXv424jg7AiNqBeUkCXq6HcI6rQUM1/4x1k2DK
         Xl9EF2DvsHRsMcceNupc99csTaulyANwjuifytYZJDJ8dnkpAX8Wat5sS0r+Z+wg7jmY
         A6Aw==
X-Gm-Message-State: AC+VfDxtsc/vWMv3ECL3ZK15Ah3spyfMEOzIl9GeDnsVIOesB9A88lNX
        s47HVbIW/v9XFzDUx4bbb4jqGgpC/ZQftL+b9PcZ5ubvY2Sk
X-Google-Smtp-Source: ACHHUZ5uexlpBPtPJccaNdHhmErmovEuc0aJEQv+DulBACxbzELH3wDT/Ehuljo6vWiQkQ7yLj0tlIJ2iLEPDZLXWLeSG1iJZatu
MIME-Version: 1.0
X-Received: by 2002:a6b:fd15:0:b0:777:afc6:8da0 with SMTP id
 c21-20020a6bfd15000000b00777afc68da0mr2935869ioi.1.1686518309621; Sun, 11 Jun
 2023 14:18:29 -0700 (PDT)
Date:   Sun, 11 Jun 2023 14:18:29 -0700
In-Reply-To: <000000000000da4f6b05eb9bf593@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0951105fde12435@google.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in nilfs_clear_dirty_page
From:   syzbot <syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dsterba@suse.com, hch@lst.de,
        konishi.ryusuke@gmail.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
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

commit 4a445b7b6178d88956192c0202463063f52e8667
Author: Qu Wenruo <wqu@suse.com>
Date:   Sat Aug 13 08:06:53 2022 +0000

    btrfs: don't merge pages into bio if their page offset is not contiguous

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17778475280000
start commit:   022ce8862dff Merge tag 'i2c-for-6.4-rc6' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f78475280000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f78475280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=53369d11851d8f26735c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e9d48b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d7fa63280000

Reported-by: syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com
Fixes: 4a445b7b6178 ("btrfs: don't merge pages into bio if their page offset is not contiguous")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
