Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223587689E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 04:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGaCNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 22:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGaCNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:13:31 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D10E53
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 19:13:29 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1bc012be5baso5037760fac.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 19:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690769609; x=1691374409;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPkgU757mcAfVErB4JqXmP6kqt1Ainnk7Zov9FfgpnM=;
        b=RzifVrsccIba2vrpnFod2hUmOyxy/57HYgfz8//cLRhRDIUVvnz6TK5GAdJCDTShWd
         Mu90ReqX5xbxyMMobhAqxf+xi3XIR79euTCYyrO/MjXuUBbNZ/r8rSCU9q7xUJlO65wk
         HtdJNQSn8vUJFCAP4d9FoYupDVFeREshzZQL+6pxhY/9CMKGe3+ArZ8ZjI7cNxAZsuHa
         L8Y6ZFSRcxlLqoFu1EO9bb9SBwz9fjrEJWP2kkjIMFXZmWBhcsuNCLIpdm3RvzN7/QYk
         z9ewXZZqOtB8VKcAM9S84NGB9PFa7z5Ke7/DbLpMwmCa04TQP/kNndL5n82oHvcUGHLq
         tQTQ==
X-Gm-Message-State: ABy/qLY8e5L4s13q+jUyyuy7T4Iw679XWq3LH3fxpJqzK2Ha6MhTJQbO
        XYMfGEPPJQioAsXqwW0crSH+S6x+WmUUagwkpsDRXyw443eZ
X-Google-Smtp-Source: APBJJlGXOGBA2AgNlWNY31LIsNq0WRqp6IlSCViwbyXiU2fsMGi3dC8fkFp/KA9wRkqtorpwD5/slNt3e/VUr55xOY+neabpk0dh
MIME-Version: 1.0
X-Received: by 2002:a05:6870:76b3:b0:1bb:3cab:49b0 with SMTP id
 dx51-20020a05687076b300b001bb3cab49b0mr10439028oab.6.1690769609114; Sun, 30
 Jul 2023 19:13:29 -0700 (PDT)
Date:   Sun, 30 Jul 2023 19:13:29 -0700
In-Reply-To: <000000000000a3d67705ff730522@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2ca8f0601bef9ca@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, hch@lst.de,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 85724171b302914bb8999b9df091fd4616a36eb7
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue May 23 08:40:18 2023 +0000

    btrfs: fix the btrfs_get_global_root return value

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12343ac5a80000
start commit:   d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11343ac5a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16343ac5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230cc11a80000

Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Fixes: 85724171b302 ("btrfs: fix the btrfs_get_global_root return value")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
