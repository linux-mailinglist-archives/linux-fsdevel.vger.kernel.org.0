Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FBB6FA854
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 12:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjEHKji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjEHKjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 06:39:32 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612326E85
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 03:39:30 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32b5ec09cf8so29198145ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 May 2023 03:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542370; x=1686134370;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRKL9tZpi4KnK16LFwq20APGjAFo6Bbra757/V/O5lY=;
        b=Ztx0UWdtHBYkQ03zstmWF3xwgMUztN6HhMZ7cxr8shFWYZgXadu+EdXNUWl01usXl3
         2fKt9A0SYyaDOqkwbOJ3dbEqSmT0Lp9HLNY6767hKj5lHpIlogeVGszS2gJafvo6hGfa
         0zAZaSQvKtviDR4jwmErYdokZp5YLO0bVqMgH3cUHTyQv4leQhwQq2Oho24nEI57fCuc
         x/RSLkT1lS77uBm/1CaWHAfDCvFUxj1HbVCOrPzX9BI3N/kL1RCHHAtr+T6qixe8bm4v
         rRxignO9xMu9CLoaj7XhaDQq5Xv1ZH1Qh33D3y7X+jL5CS37PfNyvewsjgHxMzqcOyHL
         rXAA==
X-Gm-Message-State: AC+VfDykI7qilU50R6ah0cZVAxag/zduQ+4MSG+ddQZW83ALhWRBDVtT
        AmI+xFgOW/C/tAjqbZUpjI/KWsFItZRk9HfjQi2Z9ezJUtuJ
X-Google-Smtp-Source: ACHHUZ5R05tiug1EyxoId0zrpDco6+skc5wYjCI02L+lDRUgi7VxBky6vQW6yIKh1pV7fSkNoWTj4YS1kF2drO4r19ycP1Z0Kkq7
MIME-Version: 1.0
X-Received: by 2002:a92:4a0a:0:b0:329:5faf:cbc0 with SMTP id
 m10-20020a924a0a000000b003295fafcbc0mr5456302ilf.2.1683542369901; Mon, 08 May
 2023 03:39:29 -0700 (PDT)
Date:   Mon, 08 May 2023 03:39:29 -0700
In-Reply-To: <0000000000005937d105f24c9809@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec231605fb2c4056@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget
From:   syzbot <syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, elic@nvidia.com, jasowang@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, parav@nvidia.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1094ee22280000
start commit:   83e5775d7afd Add linux-next specific files for 20230505
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1294ee22280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1494ee22280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c6b4b7069d73cf
dashboard link: https://syzkaller.appspot.com/bug?extid=298c5d8fb4a128bc27b0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b7c75c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1284b832280000

Reported-by: syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
