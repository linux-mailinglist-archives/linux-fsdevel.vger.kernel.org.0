Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB9521C8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 16:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbiEJOjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbiEJOiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 10:38:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA42F3CA9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 06:57:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a11so15014412pff.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kiQACap0HlYOlp8ZH4NG5Zh8+trxbQX+sb2tMEraWN4=;
        b=RCu2Xnv5xvPD3uE8m1QZj6iZlSYzlrTeqEM0k+enZcI7WKY/nNAnbfekUXtY0/2s6K
         Dx6zuMSJpB5N6X0x2Y77xtbcXc7SkTZsfyWROM40guwJHSH3/ZlB1AwrGgjUaJvTGyCL
         LQfRvdC/O/Fk+J0PEBcTaVsC2e0A21GuCYnlBZcxgx5acGuqQ2Ojq/J3oevzjYx2NY+O
         QgujmBAwtcsd0/g22Ji7gm1v+VkfG7T8qxmsMVwS+c/e+q0A79JAckEmd7KP0OZufZwO
         PNgC+7Vut8BhaWFYn2KkGoIXtLrxrFs5mfr2PK0uP3hO43FbBuJjPnQ+Y4OgiME1OPxy
         XN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kiQACap0HlYOlp8ZH4NG5Zh8+trxbQX+sb2tMEraWN4=;
        b=GaGUHcL4M6xrOHqb3Zga9ega1zGr9JYfCE5JlFI0eejfI705DmNc2S1aZGIvvvUZZA
         6tu6S/2wPvFVUQueb3G3RV2YRCtJC2xZStAT2YaGCkxFOodL3IbDrVusq67TFYlOAKFa
         mcpAFC0SKuoDYZTorIhMltjLD3f9Il7T14ayU/H0+FCoVak78JD6zyOyjVezYzy18uma
         B//wIigijf7LDmNOHQ3AUSQqzeMGjE/Ac8qy9FMdnj9KIz1mUCBe50mCRzENRKdVFlWH
         dX5cCckjVvjf0l0cBNjqmzbzBWVcgHtf88QAtrFLp6hUxEKbihWAKq5Ah67hwSCfZLm9
         iTGg==
X-Gm-Message-State: AOAM533UJ4IHCWN8i2ZofSbNcieMaxQBhwK6/TDat3ziDcVkZrPNYc96
        cwRYO66W4cEWbiJTLepG22LhFw==
X-Google-Smtp-Source: ABdhPJz3PdtYrEyYVXbIkRhiFVppqHSDAtQoc9m5MtKlcGR6pLshSbBiS5E93aq0j5zsOaa3eIWG6g==
X-Received: by 2002:a63:1c5:0:b0:39c:c779:b480 with SMTP id 188-20020a6301c5000000b0039cc779b480mr16810679pgb.311.1652191015329;
        Tue, 10 May 2022 06:56:55 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c6-20020aa79526000000b0050dc7628155sm10836976pfp.47.2022.05.10.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 06:56:54 -0700 (PDT)
Date:   Tue, 10 May 2022 13:56:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, davem@davemloft.net, jhs@mojatatu.com,
        jiri@resnulli.us, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@elte.hu, mlevitsk@redhat.com, netdev@vger.kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vinicius.gomes@intel.com,
        viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
Subject: Re: [syzbot] INFO: task hung in synchronize_rcu (3)
Message-ID: <YnpvI4tgbrEtHBG2@google.com>
References: <000000000000402c5305ab0bd2a2@google.com>
 <0000000000004f3c0d05dea46dac@google.com>
 <Ynpsc7dRs8tZugpl@google.com>
 <8f24d358-1fbd-4598-1f2d-959b4f8d75fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f24d358-1fbd-4598-1f2d-959b4f8d75fd@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022, Paolo Bonzini wrote:
> On 5/10/22 15:45, Sean Christopherson wrote:
> > > 
> > >      KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()
> > > 
> > > bisection log:https://syzkaller.appspot.com/x/bisect.txt?x=16dc2e49f00000
> > > start commit:   ea4424be1688 Merge tag 'mtd/fixes-for-5.17-rc8' of git://g..
> > > git tree:       upstream
> > > kernel config:https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
> > > dashboard link:https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
> > > syz repro:https://syzkaller.appspot.com/x/repro.syz?x=1685af9e700000
> > > C reproducer:https://syzkaller.appspot.com/x/repro.c?x=11b09df1700000
> > > 
> > > If the result looks correct, please mark the issue as fixed by replying with:
> > > 
> > > #syz fix: KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()
> > > 
> > > For information about bisection process see:https://goo.gl/tpsmEJ#bisection
> > #syz fix: KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()
> > 
> 
> Are you sure? The hang is in synchronize_*rcu* and the testcase is unrelated
> to KVM.  It seems like the testcase is not 100% reproducible.

Ugh, syzbot seems to have bundled multiple unrelated errors together.  The splat
that comes up first on the dashboard is definitely the KVM bug:

  INFO: task syz-executor500:19706 blocked for more than 143 seconds.
        Not tainted 5.17.0-rc7-syzkaller-00020-gea4424be1688 #0
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:syz-executor500 state:D stack:27048 pid:19706 ppid:  3644 flags:0x00000004
  Call Trace:
   <TASK>
   context_switch kernel/sched/core.c:4995 [inline]
   __schedule+0xa94/0x4910 kernel/sched/core.c:6304
   schedule+0xd2/0x260 kernel/sched/core.c:6377
   schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1857
   do_wait_for_common kernel/sched/completion.c:85 [inline]
   __wait_for_common+0x2af/0x360 kernel/sched/completion.c:106
   __synchronize_srcu+0x1f2/0x290 kernel/rcu/srcutree.c:930
   kvm_swap_active_memslots+0x410/0x800 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1473
   kvm_activate_memslot arch/x86/kvm/../../../virt/kvm/kvm_main.c:1595 [inline]
   kvm_create_memslot arch/x86/kvm/../../../virt/kvm/kvm_main.c:1660 [inline]
   kvm_set_memslot+0xa67/0x1010 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1772
   __kvm_set_memory_region+0xf02/0x11f0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1914
   kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1927 [inline]
   kvm_vm_ioctl_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1939 [inline]
   kvm_vm_ioctl+0x51a/0x22c0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4492
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

But there are multiple other errors that are indeed not the KVM bug.
