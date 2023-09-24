Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4BE7AC5F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 02:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjIXACc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 20:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIXACb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 20:02:31 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB1180
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 17:02:23 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c0ca2454dbso6663416a34.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 17:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695513743; x=1696118543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRTLhAaHmBf6L92pgz9HMkE8lNZQYMRgmuo+q5ZisvY=;
        b=tf9quWlkJUU3T7estjpT1hOJXRWl76M8gL5ESzm8/4JebAzRg0lgLAQ1/GIiUlyEUp
         0sdu5GFWYI5xvVcpH8oh7Qk+nI9fnClbQe/sN7SRYrsij7mUWAaBYcpoVmJcptvQM5I3
         6bWmJ2cOi56bRtOWMs5LrCVruiBjwGDb65jlQaFMjzSladpStE127fHH6wy8QXffcM4p
         5Dz6BglrHt59LpDnBeiz0SmT5jO2mQubehNGIDvZPecChbBtP8LNZre0YFf5Yewmawpb
         i3U7QNnjnn7pXlMWuJwG2PZf2fdYeXU0chlSqzaL7qMrWUpk4Y4W0PEgBDfpQKvfE1FV
         Tk6w==
X-Gm-Message-State: AOJu0Yyx47tAYfH//t+8MeS4EnjqTEMhLcY+4FG8lOXf5dylzSx8FJYB
        6gVPuT9eCoRVPZ4bJw3z7dLnrYQ8kzvne0ZRY/b0O1/NFVj5
X-Google-Smtp-Source: AGHT+IGfx89OEM0dgcl6E42YsvcsU1YHXoQ79b1Iq0lAsZKrrx1aIx1LBPvW3hRAJipQ9VuzTrj5v2LLTyX1cbAPAO3EopyoxB0h
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1786:b0:3ad:f6ad:b9cc with SMTP id
 bg6-20020a056808178600b003adf6adb9ccmr1827021oib.10.1695513743310; Sat, 23
 Sep 2023 17:02:23 -0700 (PDT)
Date:   Sat, 23 Sep 2023 17:02:23 -0700
In-Reply-To: <0000000000007fcc9c05f909f7f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061c35a06060f8eb3@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in fix_nodes
From:   syzbot <syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        rkovhaev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit d24396c5290ba8ab04ba505176874c4e04a2d53c
Author: Rustam Kovhaev <rkovhaev@gmail.com>
Date:   Sun Nov 1 14:09:58 2020 +0000

    reiserfs: add check for an invalid ih_entry_count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15244cfa680000
start commit:   b6dad5178cea Merge tag 'nios2_fix_v6.4' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17244cfa680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13244cfa680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=5184326923f180b9d11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bbc887280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c9558b280000

Reported-by: syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com
Fixes: d24396c5290b ("reiserfs: add check for an invalid ih_entry_count")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
