Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3572F398059
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 06:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFBEcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 00:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBEcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:32:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A56EC061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 21:30:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x38so1236893lfa.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 21:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=t4VkHdMeD2ov/i16GAJsERc6vAv4nqFTxDarbH2Z8sQ=;
        b=TFwgg/sPyVjtbW4vwzh1cdjTnt4PXiEDC/eTDhb+nHO1/04+lW7c6KidfJtvWGqCTn
         BGuM4Yc0PnFKZkE+rMltBXAbiosMR+LdLVTwtEiamvLIGlkT5gyYhy1ReddbY4Wecpfi
         M0GlL25CSUu215hoXfVwRmFDu5yHYWbgcZbllhqm8BSIUMo6unfXEe6/m+5Jag9zRvFF
         WRbg0/3aleQpcuueEM93+axlALaF/cSLulZVu+yqPgQHa2sMCDD9C8JckwH1yInYXKvs
         fNvATOIoypAHn0KDAPYIXbsekdnVflaD9WKrl83WYzS49mg7CAac4nU4D3LFaBC7JMP5
         Iubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t4VkHdMeD2ov/i16GAJsERc6vAv4nqFTxDarbH2Z8sQ=;
        b=ppYM6/Zs6WIjYBzGWzHQFYQdbW9JA9pyKIraDMmv0h/COtCOh5JM+2yPwUw6nBoNMr
         +hRkhZ0LvsBO0MkJ8ywD4Ua/j6Y16WgcZ18pAY2dMOFA6yiaIgKfiL5VNHvsOEKh/9sc
         +f2/bt8nJqceq/0zrUTwaUk6chIjJjIOvkkW2hSO80kf4G3P7sWzWBGJV/GLbmOaA9VE
         TyheFnWwOdbGC8XYiwfyWnT0kXiyBzGyRACO8/wHfts+9uzjx3cw3dl8HAjSL3M701F2
         soPqW+IlogU9SbpTiAIWyWxn1MFB1F2xH8DguQqMgDJMO/MUYSKsTtElpmZ1vbeLfbdZ
         XJ5Q==
X-Gm-Message-State: AOAM533lgna/5rkFlC6hC1ruNJ/ur0Z9HbvQh6KV8ZSZEFaAFF/mKSuB
        2bZYpW9FvEImiNbBjGDj24eEVHTEOJWs8tpsp2A8ItxayaQ=
X-Google-Smtp-Source: ABdhPJyhKT+H059LWMi5CwqfWVnE3RSj4szh1915Vyf4diRUQ5qM28hEsLNvxEjVY2jOa8PvAQQc4F1lJcvuMXiev5Y=
X-Received: by 2002:a05:6512:220b:: with SMTP id h11mr20883863lfu.17.1622608246919;
 Tue, 01 Jun 2021 21:30:46 -0700 (PDT)
MIME-Version: 1.0
From:   strager <strager.nds@gmail.com>
Date:   Tue, 1 Jun 2021 21:30:35 -0700
Message-ID: <CAC-ggsFLmFpz5Y=-9MMLwxuO2LOS9rhpewDp_-u2hrT9J79ryg@mail.gmail.com>
Subject: slow close() for inotify fd
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello wonderful kernel dev team!

I noticed a weird performance behavior when closing an inotify file descriptor.

Here is a test C program which demonstrates the issue:
https://gist.github.com/1fa8ae0e0d16a0618691d896315d93e8

My test C program's job is to call inotify_init1(), inotify_add_watch(), then
close(). Each watch is for a different directory. Each inotify fd gets one
watch. The program times how long close()ing the inotify fd takes.

When I run my test C program on my machine, I get this output:
https://gist.github.com/b396f2379cc066e78e15938b5490cb4d

close() is very slow depending on how you call it in relation to other inotify
fds in the process. I looked at inotify's implementation and I think the
slowness is because of the synchronize_srcu() call in
fsnotify_mark_destroy_workfn() (fs/notify/mark.c).

Why does close() performance matter to me? I am writing a test suite for a
program which uses inotify. Many test cases in the test suite do the following:

1. Create a temporary directory
2. Add files into the temporary directory
3. Create an inotify fd
4. Watch some directories and files in temporary directory
5. Manipulate the filesystem in interesting ways
6. Read the inotify fd and do application-specific logic
7. Assert that the application did the right thing
8. Close the inotify fd
9. Delete the temporary directory and its contents

I noticed that my test suite started becoming slow. With only a handful of test
cases, the test suite was taking half a second. I tracked the problem down to
close(), so I created a test C program to demonstrate the performance behavior
of close() (linked above).

I naively expected close() for an inotify fd to be pretty fast. (I do
understand that close() can be slow for files on NFS, though.)

I found a workaround for the slowness: at the end of each test case, don't
close() the inotify fd. Instead, unwatch everything associated with that inotify
fd, and every few test cases, close all the inotify fds. This amortizes the RCU
synchronization in my test suite. This workaround is codified by
TEST_WATCH_AND_UNWATCH_EACH_THEN_CLOSE_ALL in my test C program.

With this workaround, I don't need close() to be faster. I thought I'd bring the
issue to your attention regardless.

Have a nice day,
strager
