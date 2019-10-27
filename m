Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9122FE6122
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2019 07:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfJ0GdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Oct 2019 02:33:03 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:38773 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfJ0GdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Oct 2019 02:33:03 -0400
Received: by mail-il1-f199.google.com with SMTP id f6so6607218ilg.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2019 23:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lGwoFEs6atbJNjfwbsMMgVdENVRKdZeDwx59pl7Gnc0=;
        b=mRfiv9R2qWbR+A4SiLmMGxXOx6BWw9n1lO6Le69vaa9JD6U8iP0Ipww0ADnkIeVOVF
         4Ei1TS5pdtMwTPQqKCudKqgkszQ/VfIxQQXKqghX1QgVNe1Ach0PpbsmdyQpKZFyxyjy
         2osuVpgf2yLXdmxzZ4O5UMVyS7Q2+FnWsvrxoKeuiqQo1HHopiAlY+r1iMYRfKqfdBF6
         eN2Kxdl8lSmjCkNkld+7c10k5d6lmOEB65zG9lYnOvnK8aIIAgI5Pe7qKjZdiiiH52J7
         eNi4i/U6z4BmzOD6SZgSddO+kSi5P2UvB6MryBOwlFVxqqK7M3KiWNgJIDpIBscLBP1j
         d4GA==
X-Gm-Message-State: APjAAAWBPZ6X9TdsHAJCPYDB1N5D4xw5qo7DRgKmbgJCHLXJSVPcS9HE
        3wsv/vplIPG85LleNY0KjxJ4zgaIvJn1eEa3wHraJAR3yImz
X-Google-Smtp-Source: APXvYqybyCpDlrzzUeGRwdrxvaNZyICTlgNIiEO6W6PPjlDKJOGQERHCbQp+yT2DLtml2AKv0s7y2mTm9ga/zJuCHcqdxwm21NZZ
MIME-Version: 1.0
X-Received: by 2002:a6b:5503:: with SMTP id j3mr12197785iob.151.1572157980811;
 Sat, 26 Oct 2019 23:33:00 -0700 (PDT)
Date:   Sat, 26 Oct 2019 23:33:00 -0700
In-Reply-To: <000000000000fbbe1e0595bac322@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa2e630595de8d05@google.com>
Subject: Re: KASAN: null-ptr-deref Write in io_wq_cancel_all
From:   syzbot <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk,
        dan.j.williams@intel.com, dhowells@redhat.com, dvyukov@google.com,
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

commit d5f773aba1186142d52aef8242a426310a39fa86
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 24 13:25:42 2019 +0000

     io_uring: replace workqueue usage with io-wq

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142c6d18e00000
start commit:   139c2d13 Add linux-next specific files for 20191025
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=162c6d18e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=122c6d18e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28fd7a693df38d29
dashboard link: https://syzkaller.appspot.com/bug?extid=d958a65633ea70280b23
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160573c0e00000

Reported-by: syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com
Fixes: d5f773aba118 ("io_uring: replace workqueue usage with io-wq")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
