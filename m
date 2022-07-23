Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B957EEED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jul 2022 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiGWLMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jul 2022 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiGWLMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jul 2022 07:12:14 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAED72A409
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Jul 2022 04:12:13 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id i16-20020a5d9350000000b0067bce490d06so2600176ioo.14
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Jul 2022 04:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kSEPk2gR5UfYg7ejNXWHJjGcK8BWdPT0bnqKdUjv0Xc=;
        b=FdwbxIXwepyuPkZZ4x/nUbN6KDepHWFPT+DpxK3bpOe7VQkBqzibvRiL+Ekhv0Ue8N
         fzLqtJGfymf9Ko5MvcG0ppIYRLc6GORQqkwqht28bHXTy6LugjfiM2xRdn9jrIHkBi0Y
         Z2LoIlJd2U6wwxugBP/gYl/S69QypMt6oBjoF4UdmaV1GMQmvunJOk1AtPZJISeoe50Z
         KFngJZZjkHotoUYtU4xJmPJpwehwlOrdUlYDjBgIewCaCQFV9sMixOKyTPpRaIGhw2eR
         kV60QL062vKcZ/cp8b6R5f0TulRyCEsbUALYJVRnOuLah3KpA7nprFuYwk9BpH8oOWg0
         nUCQ==
X-Gm-Message-State: AJIora9IuHOvWefXaMqeLJ5PEe4fIFnvVXQEsBCObVF5P3oygaT931GC
        GSqzfysE1QprfRHBclqCHDuXlOKaCOaSa7AQw01a1PqOvSxm
X-Google-Smtp-Source: AGRyM1uDrwlfaO9bep5C8GKeB0JMcclfsFXKNBpHLwJ6CuERxqxLhtmt66U8Qc9s146Q7tOzC4h05jOI7Iyk8+IvlkQgmGdNs1Nj
MIME-Version: 1.0
X-Received: by 2002:a5d:9383:0:b0:67b:adc2:c053 with SMTP id
 c3-20020a5d9383000000b0067badc2c053mr1432522iol.102.1658574733153; Sat, 23
 Jul 2022 04:12:13 -0700 (PDT)
Date:   Sat, 23 Jul 2022 04:12:13 -0700
In-Reply-To: <000000000000cbe0e605e0caa8e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdbe1105e4770541@google.com>
Subject: Re: [syzbot] possible deadlock in corrupted
From:   syzbot <syzbot+5c3c53e6db862466e7b6@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        johannes.berg@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@nbd.name,
        syzkaller-bugs@googlegroups.com, toke@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f856373e2f31ffd340e47e2b00027bd4070f74b3
Author: Felix Fietkau <nbd@nbd.name>
Date:   Tue May 31 19:08:24 2022 +0000

    wifi: mac80211: do not wake queues on a vif that is being stopped

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11363672080000
start commit:   3abc3ae553c7 Merge tag '9p-for-5.19-rc4' of https://github..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=574cf8e4f636f8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=5c3c53e6db862466e7b6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16545ce4080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1087453ff00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: do not wake queues on a vif that is being stopped

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
