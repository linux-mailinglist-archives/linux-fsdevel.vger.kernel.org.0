Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A3F3007
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbfKGNmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:42:08 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:32816 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389078AbfKGNmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:08 -0500
Received: by mail-il1-f200.google.com with SMTP id z14so2675388ill.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Nw05O48tfZnOsvKSy1GxiAM521gtqxH1bmLh1PZrh9M=;
        b=o2ToTL2bAqthahXy/fRj/PnOSKtz8+ougPBFkVKWSoAxSqSN+jLoezG3fdpl/1R1fR
         iiCuJZx9B5fXmLd/oInBEZw2nqvVeVQnRmsFCdPcoecUZZ3dgEiK6AQXH7djAOSaDtDB
         MlWig1SV3nwSwiYWMmT/vVE9UBY4h5v4Dnb+KMzCPya5uDQCZi4RGIVuu1oTWCyesAPW
         fGF8bbPuMd+CVCA8K9OAOD+OL9c/6YQKyLCS8I7yz0btwB4/Md8GpILa8fu1OR/v1Yc3
         ZJk79UIUKdPaEzGvMVS/m9Ule2Q9hzJFzJABDsDnDLYhArVSnjJY7V7hEcZVGUt0Cuvm
         osKA==
X-Gm-Message-State: APjAAAVrT85BhfTiiWlW8h9dlQupmKs2qVJ2C1jhRWaUg5gGuKZmoB3L
        AoRVDq5uVKRlbCG6vEcYKYtlStmu1hQ1aPh+j2ogRInHVOiT
X-Google-Smtp-Source: APXvYqyNENH6B9y0Wez5W5uFuh4AQx6Njq+f4QH6gQ9D1z+gBpWcYcVbu/AE80nseMiHpzphhK8i6DvSZXMZjz4S+ATHb/GjXcIG
MIME-Version: 1.0
X-Received: by 2002:a5d:8450:: with SMTP id w16mr3313990ior.11.1573134127375;
 Thu, 07 Nov 2019 05:42:07 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:07 -0800
In-Reply-To: <000000000000bfd4270578abe88b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8b0630596c1d4a0@google.com>
Subject: Re: possible deadlock in flush_workqueue (2)
From:   syzbot <syzbot+a50c7541a4a55cd49b02@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, adilger.kernel@dilger.ca,
        akpm@linux-foundation.org, aneesh.kumar@linux.vnet.ibm.com,
        dave@stgolabs.net, davem@davemloft.net, hughd@google.com,
        jiangshanlai@gmail.com, kirill.shutemov@linux.intel.com,
        kuznet@ms2.inr.ac.ru, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com, netdev@vger.kernel.org,
        prakash.sangappa@oracle.com, sbrivio@redhat.com,
        sd@queasysnail.net, syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit e7c58097793ef15d58fadf190ee58738fbf447cd
Author: Mike Kravetz <mike.kravetz@oracle.com>
Date:   Tue Jan 8 23:23:32 2019 +0000

     hugetlbfs: revert "Use i_mmap_rwsem to fix page fault/truncate race"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ec0d2c600000
start commit:   ca9eb48f Merge tag 'regulator-v5.0' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=963b24abf3f7c2d8
dashboard link: https://syzkaller.appspot.com/bug?extid=a50c7541a4a55cd49b02
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12097f03400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b55ac5400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: hugetlbfs: revert "Use i_mmap_rwsem to fix page fault/truncate  
race"

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
