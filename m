Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B800219D040
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 08:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbgDCGfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 02:35:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47766 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgDCGfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:35:05 -0400
Received: by mail-io1-f71.google.com with SMTP id c2so5217339iok.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 23:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XvuEaZQv34Wl9b97Fox7ORd+MiG4pPZiu4HFMMCz9b8=;
        b=QkVnxiSL2USxYmcRYbf29vz4AvtAsOewyDpymyYDjjsrtTXbaq+gLwLP8zjKHC7GeC
         ZsM4TcMt5C3DlQ0glCPf3iLomZWf4Owi7Vd38vgCGKGNoYCdX2PM/QNGpoZ2+7QNAtkm
         fvlpgL5ICY5a8msxjo3jQmWtdIs+6jT7tRfvPxrXflAmUhIEeRPd+7laX9yick5YwxIv
         9FD22c3MAjVUzLeDur/EgGObeH7qcg2Jp/B8i+x/V7G/qY8M39VRjBeWL7EVOthuiPrZ
         R0F3t9a9n1SuJMHh7B/YtXQfISM4Fk6Y1/CvkY7VKTsYG/2lkkJY9B3dPju+LzGktgvl
         JlcQ==
X-Gm-Message-State: AGi0Pua9O/uMBUOvxTogs+VUlERq0RGZuOH1KHV3Wgh4VqBmIlaPoElW
        RKvuCEDrk/1UI1L5pyi3t1L59hwXn7z2Idy6Qw2oxXK14xOk
X-Google-Smtp-Source: APiQypKgLxYQRiqluE41KROTRCotuILsRHbZsSaEH/+7vCLB93a2aY6B1Ii2FwOvd8Q/As54JAPWEwyCmr2596qDdnICcLdBc2AL
MIME-Version: 1.0
X-Received: by 2002:a02:6c8:: with SMTP id 191mr6878565jav.133.1585895704787;
 Thu, 02 Apr 2020 23:35:04 -0700 (PDT)
Date:   Thu, 02 Apr 2020 23:35:04 -0700
In-Reply-To: <000000000000f1aa0d05a25cfab6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000227f0c05a25d1e9e@google.com>
Subject: Re: possible deadlock in free_ioctx_users (2)
From:   syzbot <syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bcrl@kvack.org, christian@brauner.io,
        cyphar@cyphar.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, guro@fb.com, joel@joelfernandes.org,
        keescook@chromium.org, linmiaohe@huawei.com, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, oleg@redhat.com,
        peterz@infradead.org, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 7bc3e6e55acf065500a24621f3b313e7e5998acf
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Feb 20 00:22:26 2020 +0000

    proc: Use a list of inodes to flush from proc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164ae51fe00000
start commit:   7be97138 Merge tag 'xfs-5.7-merge-8' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=154ae51fe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=114ae51fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec722f9d4eb221d2
dashboard link: https://syzkaller.appspot.com/bug?extid=832aabf700bc3ec920b9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f37663e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16feb91fe00000

Reported-by: syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com
Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
