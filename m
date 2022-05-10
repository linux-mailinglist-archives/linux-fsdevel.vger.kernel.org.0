Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DE52100C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiEJIzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238238AbiEJIzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 04:55:11 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AB43E5C4
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 01:51:14 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id g11-20020a056e021a2b00b002cf48b48824so8972942ile.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 01:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gEeJNjfS0q6RM62Nvi60TGEoWat+e1zZfxTGA+WRzSY=;
        b=l1yEA1hK2BtFDdLnpJovbkoi7uueRNT7kJa/yL9r5/kQX71ewuSOHitjMUzH1Sj1K6
         WKyrMQPVEgkm6Emg5ob9lj3yypnouHX2UkLQ6QKBsWEFsn4OXq0Pblc38uzO5vjOFsiG
         7e2R/KSg9lS3zDsviZ/LXgGe388UnKdD/tz93UthJIoX6FeSql4a7JLpYJ8QONIbVEFl
         6RYKav/6H6ljBnzZkrRsnpurLY6Iq6UrcKnV5C1jNS8yeJUw1ZOzW4qztUCb+/xgr4bv
         RqOteENsyiX0XAeU+n6U3ZXFZ4Hrr5N+xOmyQuF+os0jjvftjpG/37ruiUWvpemmUw3W
         6Q2g==
X-Gm-Message-State: AOAM5303m0VUeSar9mo8CYrEFZJ/yxOsRDJESc7CgtIdrCCN2mUYfxWg
        EX/HG5nYpUlfUkytkvrhHMc/O1uLChaciqQK+plbZKziC62V
X-Google-Smtp-Source: ABdhPJymd70zSLRupmjht8i7wwnCSSg/9t9Ls3kE6/21v2tdD1hcmHlI4ApXwuuuEnn2Izn9LJhqsv6m4l19IZnSt7QWs+/iF9HJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:2cd:fb28:5417 with SMTP id
 j11-20020a056e02218b00b002cdfb285417mr9002492ila.83.1652172673463; Tue, 10
 May 2022 01:51:13 -0700 (PDT)
Date:   Tue, 10 May 2022 01:51:13 -0700
In-Reply-To: <000000000000402c5305ab0bd2a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f3c0d05dea46dac@google.com>
Subject: Re: [syzbot] INFO: task hung in synchronize_rcu (3)
From:   syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net, jhs@mojatatu.com,
        jiri@resnulli.us, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@elte.hu, mlevitsk@redhat.com, netdev@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vinicius.gomes@intel.com, viro@zeniv.linux.org.uk,
        xiyou.wangcong@gmail.com
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

syzbot suspects this issue was fixed by commit:

commit 2d08935682ac5f6bfb70f7e6844ec27d4a245fa4
Author: Sean Christopherson <seanjc@google.com>
Date:   Fri Apr 15 00:43:41 2022 +0000

    KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16dc2e49f00000
start commit:   ea4424be1688 Merge tag 'mtd/fixes-for-5.17-rc8' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1685af9e700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b09df1700000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
