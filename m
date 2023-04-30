Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CABC6F27D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 08:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjD3Gko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 02:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjD3Gkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:40:43 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE376E6
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 23:40:42 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32f240747cdso125493555ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 23:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682836842; x=1685428842;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvwEsqS9PQZsYf/+deAUR2EWNmmTeMlxrn6znYGJXDI=;
        b=el1uvoIB9AkwjAa0j25dRb0S1gSwsmwqyvbuPNk8nfQJ5XmrtW9H251JMNcWi92Phm
         jJ7YUntoaXT+V8QUaY1Zv8uAN2IeCKYrmVJ3XWKAZR4qhNI3yiu3TGcF3FkxbBpva2oC
         1Y9VUJDPc8g4DkZ4rZk/ek6M4C/SB/5nGYeGY993+8kaR6Qcl/ZV8ERYSuT5iK6jMKoV
         G/I3MgljPaJp+YAlWk0wwdof2JiMca3vv12wl0A97wcAuY/YIYMH2aYn1bBHiIicceOO
         sZx+CKI4pZK3jufMe+3tKVWmUoBq0OKwsJqPWVvv4Ses0YQHru4DyqGbw5NOIOzhpxN4
         2soA==
X-Gm-Message-State: AC+VfDyUGft8jBh1IqJZtrPlKxF7EHxUDnnA8PcNskP8VBWS0JHsj2JA
        9rUyrvWfXHl1ptC4Ih9LCau5sgkssel/5rdB2nE2k9Jmzk/L
X-Google-Smtp-Source: ACHHUZ4IRmsyU86JQtK5Ix/FO+7HqfElebsLx/SZOOJCoCi+XBjP7WOVM5xmsnFNK+Eo2imSHe0jPQixE4Gv2d3q5hKneZeR9WtZ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:360d:b0:763:b184:fe92 with SMTP id
 bc13-20020a056602360d00b00763b184fe92mr9486769iob.0.1682836842176; Sat, 29
 Apr 2023 23:40:42 -0700 (PDT)
Date:   Sat, 29 Apr 2023 23:40:42 -0700
In-Reply-To: <ZE4NVo6rTOeGQdK+@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031682b05fa87fcbe@google.com>
Subject: Re: [syzbot] [sysv?] [vfs?] WARNING in invalidate_bh_lru
From:   syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
To:     tytso@mit.edu
Cc:     hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Wed, Dec 21, 2022 at 06:57:38PM -0800, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1560b830480000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e320b3880000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147c0577880000
>
> #syz set subsystems: sysv, udf

The specified label value is incorrect.
"sysv" is not among the allowed values.
Please use one of the supported label values.

The following labels are suported:
no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

>
> There are two reproducers, one that mounts a sysv file system, and the
> other which mounts a udf file system.  There is no mention of ext4 in
> the stack trace, and yet syzbot has assigned this to the ext4
> subsystem for some unknown reason.
>
> 					- Ted
