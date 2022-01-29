Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41A4A2A8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 01:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbiA2AZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 19:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiA2AZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:25:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701CC061714;
        Fri, 28 Jan 2022 16:25:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so7604980plh.13;
        Fri, 28 Jan 2022 16:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/pPDd+attnJsl63O2HKUbF+O/A8INXps1SnOP74pJYY=;
        b=ZmMi/m8mJU70T7Kv/C8oVf4m938D9oPY/i7w9HyEzZkX8ZQfLSDnpE465uNVFvLURo
         ELT2NuHM0MTPAW8GnUsQs++zggWqi4hdHYNbs0V7AI0WZNGufmb1W/5ByBln2lgdyMvf
         okoCuC10ZC/71OjePfylGC7ZDr5bId3WyBoOD6EOFfSZeZJpwptCqM31ranhTQyhKteY
         puWSQv7ULMBhJc5W+qpaOeEV4Ys8AVAe0OPlR/FNZY7M69fmq6fT8Bxan0k5vO5B7Ens
         Du5JmaOtNR4ivaexI8ja30CQjn2tycvyxuQVgpINjsegiOFatUZawO0VAulStkIHeVQ3
         yOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/pPDd+attnJsl63O2HKUbF+O/A8INXps1SnOP74pJYY=;
        b=yh5Vg3a3/VPFwf8BK0uGgQQQs9JfzlyiosHB7fU9lEBIutLZ/QqJrRUk+6FSwi9uqp
         /iHjqDfu3p0klUJlaJGuFUR+/u4atWFgC+1k8Gnoxsz7PadVhyW/oD2RZOmYkULUkZeb
         Z8C08HZqtKMcwkXX2ljaTYXNXlt3I6zDODaFL6OspFuaof+GvGZVaiTq06vdb8CDPxh4
         82daMhQpoxnhqadM/57qlYbT++GvhYlESZPhAA1YDHCn7bp436pKvdkah0baWC+A2DPJ
         zTGgQF1OVTXMDyzNyq9kcmEU8yYHW2orU7NNLDzcqH68//PcglaM5SnWdbkFAjQRxot5
         Y4WQ==
X-Gm-Message-State: AOAM533CxJyXUCl3RjxPj459RItg6bs6O6fumJy3RscOYe8U2WNoDzy8
        jN9p/J8Q1CIO1nPv/2ChcY8=
X-Google-Smtp-Source: ABdhPJxGUBwrXIsIvWjyBvE7iD7hhKKZofoG8jdKEZkaAkI6iN89JrcM0KVp7Fklh5htvME7X79KGw==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr12833133pjb.20.1643415950815;
        Fri, 28 Jan 2022 16:25:50 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nn2sm3455850pjb.35.2022.01.28.16.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:25:50 -0800 (PST)
Date:   Sat, 29 Jan 2022 08:25:43 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1] binfmt_misc: fix crash when load/unload module
Message-ID: <20220129002543.hjintsmbjtprwugw@xzhoux.usersys.redhat.com>
References: <20220124003342.1457437-1-ztong0001@gmail.com>
 <202201241937.i9KSsyAj-lkp@intel.com>
 <20220124151611.30db4381d910c853fc0c9728@linux-foundation.org>
 <CADJHv_vh03bhn1FX2-jc6JoH3Hm6cRiWs+iXFO-coGy_yUY1Mw@mail.gmail.com>
 <CAA5qM4Btrnp9Te2pm0s=OuDk0ASTE3-LyLt8nf0fXKxhehXUgA@mail.gmail.com>
 <CAA5qM4DdvMNeG-PndWR9vb_jXTZ3v9aBXpW9QjV66DQFny65Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4DdvMNeG-PndWR9vb_jXTZ3v9aBXpW9QjV66DQFny65Wg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:33:22PM -0800, Tong Zhang wrote:
> On Tue, Jan 25, 2022 at 9:23 PM Tong Zhang <ztong0001@gmail.com> wrote:
> >
> > On Tue, Jan 25, 2022 at 9:04 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> > >
> > > Still panic with this patch on Linux-next tree:
> > >
> > > [ 1128.275515] LTP: starting binfmt_misc02 (binfmt_misc02.sh)
> > > [ 1128.303975] CPU: 1 PID: 107182 Comm: modprobe Kdump: loaded
> > > Tainted: G        W         5.17.0-rc1-next-20220125+ #1
> > > [ 1128.305264] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> > > [ 1128.305992] Call Trace:
> > > [ 1128.306376]  <TASK>
> > > [ 1128.306682]  dump_stack_lvl+0x34/0x44
> > > [ 1128.307211]  __register_sysctl_table+0x2c7/0x4a0
> > > [ 1128.307846]  ? load_module+0xb37/0xbb0
> > > [ 1128.308339]  ? 0xffffffffc01b6000
> > > [ 1128.308762]  init_misc_binfmt+0x32/0x1000 [binfmt_misc]
> > > [ 1128.309402]  do_one_initcall+0x44/0x200
> > > [ 1128.309937]  ? kmem_cache_alloc_trace+0x163/0x2c0
> > > [ 1128.310535]  do_init_module+0x5c/0x260
> > > [ 1128.311045]  __do_sys_finit_module+0xb4/0x120
> > > [ 1128.311603]  do_syscall_64+0x3b/0x90
> > > [ 1128.312088]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [ 1128.312755] RIP: 0033:0x7f929ab85fbd
> > >
> > > Testing patch on Linus tree.
> >
> > Hi Murphy,
> > Did you apply this patch?
> > Link: https://lkml.kernel.org/r/20220124181812.1869535-2-ztong0001@gmail.com
> > I tested it on top of the current master branch and it works on my
> > setup using the reproducer I mentioned.
> > Could you share your test script?
> > Thanks,
> > - Tong
> 
> I can find binfmt_misc02.sh on github, and running the following
> command shows: failed 0.
> 
> ./runltp -s binfmt_misc
> Running tests.......
> <<<test_start>>>
> tag=binfmt_misc01 stime=1643178454
> cmdline="binfmt_misc01.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> [   90.908282] LTP: starting binfmt_misc01 (binfmt_misc01.sh)
> binfmt_misc01 1 TINFO: timeout per run is 0h 5m 0s
> binfmt_misc01 1 TPASS: Failed to register a binary type
> binfmt_misc01 2 TPASS: Failed to register a binary type
> binfmt_misc01 3 TPASS: Failed to register a binary type
> binfmt_misc01 4 TPASS: Failed to register a binary type
> binfmt_misc01 5 TPASS: Failed to register a binary type
> binfmt_misc01 6 TPASS: Failed to register a binary type
> binfmt_misc01 7 TPASS: Failed to register a binary type
> binfmt_misc01 8 TPASS: Failed to register a binary type
> binfmt_misc01 9 TPASS: Failed to register a binary type
> 
> Summary:
> passed   9
> failed   0
> broken   0
> skipped  0
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=2 cstime=17
> <<<test_end>>>
> <<<test_start>>>
> tag=binfmt_misc02 stime=1643178454
> cmdline="binfmt_misc02.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> [   91.133399] LTP: starting binfmt_misc02 (binfmt_misc02.sh)
> incrementing stop
> binfmt_misc02 1 TINFO: timeout per run is 0h 5m 0s
> binfmt_misc02 1 TPASS: Recognise and unrecognise a binary type as expected
> binfmt_misc02 2 TPASS: Recognise and unrecognise a binary type as expected
> binfmt_misc02 3 TPASS: Recognise and unrecognise a binary type as expected
> binfmt_misc02 4 TPASS: Recognise and unrecognise a binary type as expected
> binfmt_misc02 5 TPASS: Fail to recognise a binary type
> binfmt_misc02 6 TPASS: Fail to recognise a binary type
> 
> Summary:
> passed   6
> failed   0
> broken   0
> skipped  0
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=3 cstime=25
> <<<test_end>>>
> INFO: ltp-pan reported all tests PASS
> LTP Version: 20220121-9-g010e4f783
> 
>        ###############################################################
> 
>             Done executing testcases.
>             LTP Version:  20220121-9-g010e4f783
>        ###############################################################

Ya, looks like it's working. No panic on next-20220128 tree.

Thanks,
-- 
Murphy
