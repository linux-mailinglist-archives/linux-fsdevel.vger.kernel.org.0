Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97CBF4D25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 14:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKHN2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 08:28:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfKHN2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:28:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so3954092pgm.6;
        Fri, 08 Nov 2019 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Bd+lv+ey5vesu07n4NYobzJPDhnzrf+/0LFj+gyhS8s=;
        b=qWJxsyB+1nV5ZqZnc8gaDdhuffjWUcmlAPVV86OsV8q00D5wvRfsFCU8J21It2LCCG
         sg1mG5YELc/UYjt0cKBZ/7fPKFUh2l+Wvxh6zT3o89QR55tE3q++i35TBQaRp/K+m1v7
         B5DMh1IhAGAyiLhn+rFyVE7VqEPr1vy/YNPZM9GhvQhFqtn7a0mZCTsofy5CCUWD91+U
         xM0+3Qwv5btCbX8EYrTVkt70/vtPyKk2uYeB62f3zw3VsO2fjc6p0TLrYw9tQyh+Ub71
         rdEs46Erc4iPOsEx7CHsVT5/7AFS2CLEHV75LS54ftKrr82vMFzmqFrLx55p538PbaVM
         KlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bd+lv+ey5vesu07n4NYobzJPDhnzrf+/0LFj+gyhS8s=;
        b=nD27OkCfRVNy/WGI0cYanH8hW597oxUfivCITqtHV49SOk1tfW2jYvOLf6LKBnVTLe
         0Eq9sEZJKWgGz8PM62J9oPZIvOSN+hk5q8KPPNICQNpwqSxoAidnKAFt1adfo7yHpeV3
         1QDH1n7yuql0rulUiqfHfOX8AVxWCvX5ak2mq3bX86vVyNrX0dHtkzQB81+g28fCYhj2
         uW5SmOqtYYrQeM4iMLcnpPcyPIP4k/hNKAxA0FX1V+cmFkC/Ent5JUpaPMVqa7Wx+R/D
         uEOjyr991gLqYJa0m5dIzdmxXzDYM46AQ06htGTGG/fKzEW5tfEtWRGkHoIh6Teto4AK
         6Xxw==
X-Gm-Message-State: APjAAAXAoYTLCR2xgAwYcBx0g9233FA6Tj4htm+XX8yekjLuy6+QQuJ3
        9lcv8Ppyng6GmoEB1SY2MEs=
X-Google-Smtp-Source: APXvYqyaOxxuBnbDZmSHpMrfTD4x/VAAlaoE+NxKs3PbubZjjl+cDfUfn/swPFZ7yjYi0KkpBV+5Rg==
X-Received: by 2002:a17:90a:7608:: with SMTP id s8mr13726904pjk.75.1573219685049;
        Fri, 08 Nov 2019 05:28:05 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id q26sm5554373pgk.60.2019.11.08.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 05:28:04 -0800 (PST)
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        elver@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>
References: <000000000000c422a80596d595ee@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
Date:   Fri, 8 Nov 2019 05:28:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000c422a80596d595ee@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/8/19 5:16 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=10d7fd88e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ef049d50587836c0606
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in __alloc_file / __alloc_file
> 
> write to 0xffff8880bb157398 of 4 bytes by task 10993 on cpu 0:
>  get_cred include/linux/cred.h:253 [inline]
>  __alloc_file+0x74/0x210 fs/file_table.c:105
>  alloc_empty_file+0x8f/0x180 fs/file_table.c:151
>  alloc_file+0x4e/0x2b0 fs/file_table.c:193
>  alloc_file_pseudo+0x11c/0x1b0 fs/file_table.c:232
>  anon_inode_getfile fs/anon_inodes.c:91 [inline]
>  anon_inode_getfile+0x103/0x1d0 fs/anon_inodes.c:74
>  __do_sys_perf_event_open+0xd32/0x1ac0 kernel/events/core.c:11100
>  __se_sys_perf_event_open kernel/events/core.c:10867 [inline]
>  __x64_sys_perf_event_open+0x70/0x90 kernel/events/core.c:10867
>  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> write to 0xffff8880bb157398 of 4 bytes by task 11004 on cpu 1:
>  get_cred include/linux/cred.h:253 [inline]
>  __alloc_file+0x74/0x210 fs/file_table.c:105
>  alloc_empty_file+0x8f/0x180 fs/file_table.c:151
>  path_openat+0x74/0x36e0 fs/namei.c:3514
>  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
>  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
>  __do_sys_open fs/open.c:1115 [inline]
>  __se_sys_open fs/open.c:1110 [inline]
>  __x64_sys_open+0x55/0x70 fs/open.c:1110
>  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 11004 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Linus, what do you think of the following fix ?

I also took the opportunity avoiding dirtying a cache line if this was possible.

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263fbe79dfd5a36163c656dca5da220..01b5b7d4e054ddca0df676dc1ceb068e5d71a3f8 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -250,7 +250,14 @@ static inline const struct cred *get_cred(const struct cred *cred)
        if (!cred)
                return cred;
        validate_creds(cred);
-       nonconst_cred->non_rcu = 0;
+
+       /*
+        * Avoid dirtying one cache line. The WRITE_ONCE() also pairs
+        * with itself, since we run without protection of a lock.
+        */
+       if (READ_ONCE(nonconst_cred->non_rcu))
+               WRITE_ONCE(nonconst_cred->non_rcu, 0);
+
        return get_new_cred(nonconst_cred);
 }
 
@@ -262,7 +269,14 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
        if (!atomic_inc_not_zero(&nonconst_cred->usage))
                return NULL;
        validate_creds(cred);
-       nonconst_cred->non_rcu = 0;
+
+       /*
+        * Avoid dirtying one cache line. The WRITE_ONCE() also pairs
+        * with itself, since we run without protection of a lock.
+        */
+       if (READ_ONCE(nonconst_cred->non_rcu))
+               WRITE_ONCE(nonconst_cred->non_rcu, 0);
+
        return cred;
 }
 
