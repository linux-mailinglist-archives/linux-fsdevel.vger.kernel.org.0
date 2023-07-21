Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A875C310
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjGUJaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUJai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:30:38 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80322726
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 02:30:37 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a3a70425b4so4115177b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 02:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931837; x=1690536637;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYejIZlDiZxhZWChNwFaBtexUzMMfkDxTXb2Y1FEkHg=;
        b=P6V7t9uRP94ly/K/w9e7a6EVBXT7zE0P67TkRNrWS9awehG9A36UPz0jDW4uxawwFs
         U81r1SnRPhAxNySvZy232OheokrGdIeU0PUCeG4MjsU2HFEXAmPBkqGvFbm2F2Vfo//x
         Feegxc3re1lmKig+LkTz9mNZFYwcpohlWMSeI1Mo0Loe4j/1KtaRvrkYcwH0gfFN7Chg
         jduAy2AvNjn+5uNxLczJnQmpWwotIQs6OEUq3jHehKkXLRyK7xBKLPQ0ODCYdDqZ/oA7
         oQfRjNkIqhp1MLgsXZVAi1KXp6eq0WPWyoG5XqKManLYGZ9tNeo6JDhERpLr5oOkCTRI
         8xaw==
X-Gm-Message-State: ABy/qLZPU17q11M4QRzcIpCCVEbpf6YWgJNkogl1nUOE5Kd5UNRti3FD
        Vo9STOAzP/pRlrg+TAjSjM+mVotzXj6brO4RMqAoFk/dzo4L
X-Google-Smtp-Source: APBJJlFDohVTJfAd1FYWPW8XraQSiXjvwSpHJQgmUPh6MBS1fvzkU8eFzD4PzIFZjbfULEH/Pdyc6aYvqovHckTC/eNLCF0q9OOW
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b0b:b0:3a0:3d3c:1f03 with SMTP id
 bx11-20020a0568081b0b00b003a03d3c1f03mr3750837oib.11.1689931837171; Fri, 21
 Jul 2023 02:30:37 -0700 (PDT)
Date:   Fri, 21 Jul 2023 02:30:37 -0700
In-Reply-To: <000000000000c11ed40600e994b1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d96eec0600fbea8f@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in ep_poll_callback
From:   syzbot <syzbot+c2b68bdf76e442836443@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org, bvanassche@acm.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
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

commit a0b0fd53e1e67639b303b15939b9c653dbe7a8c4
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Thu Feb 14 23:00:46 2019 +0000

    locking/lockdep: Free lock classes that are no longer in use

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c0c84ea80000
start commit:   bfa3037d8280 Merge tag 'fuse-update-6.5' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c0c84ea80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c0c84ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27e33fd2346a54b
dashboard link: https://syzkaller.appspot.com/bug?extid=c2b68bdf76e442836443
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111c904ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b0faaa80000

Reported-by: syzbot+c2b68bdf76e442836443@syzkaller.appspotmail.com
Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
