Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D4E9755
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 08:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfJ3HoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 03:44:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48744 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfJ3HoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:44:03 -0400
Received: by mail-io1-f71.google.com with SMTP id q84so1199879iod.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 00:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dxnBOmtjfHc78Shusa2+2C/dwRTd+Y9TDOU+bAXew3I=;
        b=jQzjqQZH+8PMNb97SUtNKMsJcMkRe92Lz59DJSM8TmclINZlt9DdWdcwc1qC6a8TmQ
         dz3EusVe50thFCQDUsJH1RBcX33OecwqfihPh35ykZ0XThnIqgM4hvHpSWWRpQ1sPhX4
         9S+BQUM4V11hhchIUdNy6qYL8X7zGB/J36NuMbpVU1B6LXh9WaBxoYLENBAJPXv9OYv9
         lvuTzX5ka70kMr446+29bgt3uvxO7tLAk76LQNaprIon4QZFNEHPQgUp/qfztv341aKH
         hsQdDGx6vVuei19v2NZXWeHa6o+UIU0iQhL6R0oldWmsWqkc6xlSLVJmvW0A3pnR3USo
         u39w==
X-Gm-Message-State: APjAAAXnOyutvURKycdkLSZkVqBJwYkQGCjPCCiDs3aV+kMdeuzVyYS1
        8hjVA2uRxUaDu+SF7PfxWvDxo4RwWlrjgc6PQ51/5wM37LF8
X-Google-Smtp-Source: APXvYqzGVHBXNanN7A1gB3Pu8U6dJQ1xC84jP6Pgwkt0UEP1XoERs3CsFZrP1t2i7TE5nit9eB6qSkADskBzJ+BxPwORRiMLm+9o
MIME-Version: 1.0
X-Received: by 2002:a92:99ca:: with SMTP id t71mr16932987ilk.61.1572421440730;
 Wed, 30 Oct 2019 00:44:00 -0700 (PDT)
Date:   Wed, 30 Oct 2019 00:44:00 -0700
In-Reply-To: <000000000000c6fb2a05961a0dd8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069801e05961be5fb@google.com>
Subject: Re: BUG: unable to handle kernel paging request in io_wq_cancel_all
From:   syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk,
        dan.j.williams@intel.com, dhowells@redhat.com,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        joel@joelfernandes.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, mingo@redhat.com,
        patrick.bellasi@arm.com, rgb@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit ef0524d3654628ead811f328af0a4a2953a8310f
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 24 13:25:42 2019 +0000

     io_uring: replace workqueue usage with io-wq

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16acf5d0e00000
start commit:   c57cf383 Add linux-next specific files for 20191029
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15acf5d0e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11acf5d0e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000

Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com
Fixes: ef0524d36546 ("io_uring: replace workqueue usage with io-wq")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
