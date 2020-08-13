Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC7243304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 05:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHMD5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 23:57:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:40389 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHMD5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:57:05 -0400
Received: by mail-il1-f200.google.com with SMTP id o9so2566408ilk.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 20:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=818BGdNc1wvnUSaZirTtzYWcZvgSsVpOYq9GYar7pzo=;
        b=fmC3R2vO/ookBYCILUXR57ybs7Ahl3T6LjR5gk8R4RzmswomVxkqId8wS48OueZCOS
         1hfbq2mWEWBUttA/YMhdnP4T2u6kS/4WHIL55HFY0EOWUTPIfM4HAR1BV9xG1gbHVj/e
         P1EJSid/X74yyDtQ8zuPeZq+gKWVnv+OYeZnh1CwFYX7mjb7wtjDS5omURX3WRT+U/RI
         z/4boCahzjptipyEbV/ny8J4Ye5EokOO8C+G2K9EkDrrp46ExTEkwGL23btAtAiyExIH
         WU1TFb0HsddhwEz7xbj6DK0SLPO0Th8NzvqA5v0lpJPEIW34iKCXi5oWQGJvfd2y+kNP
         HkSA==
X-Gm-Message-State: AOAM533dFEcQrrMWVZ6uY9e6+uaznavjk1yOEezlY6FDQtqexP23WNbh
        +O6g7G2Eg4q6f/iMnpC3RZ6xW2v3XWl+AKWbt6b9q9aSZ0sO
X-Google-Smtp-Source: ABdhPJxyW2a+ykA+fUEC8D6mFHSlTwIHpmNmLpjhnj+1O5R02Uizom5WTc4bNxK6AVfdyCvjg+GBZ9zseGC71qHLHgVFHLNbJAN8
MIME-Version: 1.0
X-Received: by 2002:a92:874a:: with SMTP id d10mr2849478ilm.273.1597291024427;
 Wed, 12 Aug 2020 20:57:04 -0700 (PDT)
Date:   Wed, 12 Aug 2020 20:57:04 -0700
In-Reply-To: <00000000000084b59f05abe928ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d3cbb05acba4cc2@google.com>
Subject: Re: INFO: task hung in pipe_release (2)
From:   syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>
To:     James.Bottomley@HansenPartnership.com, amanieu@gmail.com,
        arnd@arndb.de, benh@kernel.crashing.org, bfields@fieldses.org,
        borntraeger@de.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chris@zankel.net, christian@brauner.io, corbet@lwn.net,
        cyphar@cyphar.com, dalias@libc.org, davem@davemloft.net,
        deller@gmx.de, dvyukov@google.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jcmvbkbc@gmail.com,
        jhogan@kernel.org, jlayton@kernel.org, kvalo@codeaurora.org,
        linux-alpha@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux@armlinux.org.uk,
        linux@dominikbrodowski.net, linuxppc-dev@lists.ozlabs.org,
        luis.f.correia@gmail.com, luto@kernel.org, martink@posteo.de,
        mattst88@gmail.com, ming.lei@canonical.com, ming.lei@redhat.com,
        mingo@redhat.com, monstr@monstr.eu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit fddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
Author: Aleksa Sarai <cyphar@cyphar.com>
Date:   Sat Jan 18 12:07:59 2020 +0000

    open: introduce openat2(2) syscall

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164e716a900000
start commit:   6ba1b005 Merge tag 'asm-generic-fixes-5.8' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=154e716a900000
console output: https://syzkaller.appspot.com/x/log.txt?x=114e716a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
dashboard link: https://syzkaller.appspot.com/bug?extid=61acc40a49a3e46e25ea
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142ae224900000

Reported-by: syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com
Fixes: fddb5d430ad9 ("open: introduce openat2(2) syscall")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
