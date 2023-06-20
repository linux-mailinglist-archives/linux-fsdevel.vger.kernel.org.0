Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00345736588
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFTH7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFTH6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:58:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232EB1991;
        Tue, 20 Jun 2023 00:58:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b466073e19so42601571fa.1;
        Tue, 20 Jun 2023 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687247910; x=1689839910;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nUePLlIsXbvh6FDAcQ5EWj0nl9vClHwyNGCJCvpRtKU=;
        b=dV/O+wJThT05mGVj3DHCFIln90RC/XQVt6kU8APLv8EExjjzQLGW/7LGbdh8KR5AMc
         YwxVBzTZ7Ha2TYuSXhg5u4nj8FevKAgCpZa/tD4TgwJ0BPB2S2a+KcsXGfkZFyV/yL07
         qLHBoTHHElTARXdNRzdgAfuQdrX+2evXERrPEIjumx7j9SuMPNj1h/CkcaG5FjjGQdyl
         FKXgBdcAGYHFCHknbdGtfLHVx8nNZUdqIMnJHVlrEs4yteezqi9w9j/BBaKo2tdqJGzJ
         Y+sAEWMc1P6xfxCyQBXZnkE+d/602RE0zZgqJupFTLxY/oI6cQjRG5eSKD8co6E8xFyo
         Vdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247910; x=1689839910;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUePLlIsXbvh6FDAcQ5EWj0nl9vClHwyNGCJCvpRtKU=;
        b=IdjFMttk2NDU2iRdDhJAfWYhrbVIm/+4FUpQnSWoUhmtqHo46Vp8VXn/tTJBWyczCy
         /2htTkP09OSyYp8Q7uRPDmjFMCbzdF10bUgL5sMO+uUWXXEbWdNWAouUllBP4bK9ppps
         byMu+lBS6Wj1oczenq70PAfJtNI9lKKmEoCFqddFyDtPGWQauyiN+/WpAslp//QPckqy
         UhPkfNPxi12PWPSt9yWdS4wZmtkwe8o+PHDpOZlnWv87XoM+llmg0dA1fxnKpsRPAOvE
         CtuAxipecDnbeUajjTuyz14l99NEGM31eY3jtBFXaH2d6xknbD68kKLxlAIHSruAiMNr
         eFag==
X-Gm-Message-State: AC+VfDzHvNiCJxZevGYuDFD1iogX7MvbkwYI2k0Ek7t7wesf3H5AkBrT
        cbpy1St9HrF7zVlfOjqn6dn9CMlIDZYVPIBcqq8=
X-Google-Smtp-Source: ACHHUZ5XVKllmbPa/ga44q7tt984qf5Fm7N9w8OQYzB9qaD8eXbseT5P6oNjLOU70O2kDauFWowirwQpDy9tgyQ+780=
X-Received: by 2002:a2e:8702:0:b0:2b4:7f2e:a433 with SMTP id
 m2-20020a2e8702000000b002b47f2ea433mr2945602lji.36.1687247909561; Tue, 20 Jun
 2023 00:58:29 -0700 (PDT)
MIME-Version: 1.0
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 20 Jun 2023 13:28:18 +0530
Message-ID: <CANT5p=qDON8uO9z92xEcP16kvRdHrf84owmcb20MGZnOxT_xmg@mail.gmail.com>
Subject: Hang seen with the latest mainline kernel
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David/Matthew,

We've been running some stress testing lately in Microsoft with Linux
6.4-rc4 kernel, and I've noticed some warnings of hangs with this
stack trace. Can you please take a look and let me know what you
think?

This seems to be reproducing quite often on this test setup. So please
let me know if there's more data you need to debug this.

[Mon Jun 19 16:05:49 2023] INFO: task newstress:61476 blocked for more
than 966 seconds.
[Mon Jun 19 16:05:49 2023]       Tainted: G           OE
6.4.0-rc3-wkasan #5
[Mon Jun 19 16:05:49 2023] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Mon Jun 19 16:05:49 2023] task:newstress     state:D stack:0
pid:61476 ppid:61160  flags:0x00000002
[Mon Jun 19 16:05:49 2023] Call Trace:
[Mon Jun 19 16:05:49 2023]  <TASK>
[Mon Jun 19 16:05:49 2023]  __schedule+0x782/0x2500
[Mon Jun 19 16:05:49 2023]  ? __rcu_read_unlock+0x53/0x80
[Mon Jun 19 16:05:49 2023]  ? __kasan_check_read+0x11/0x20
[Mon Jun 19 16:05:49 2023]  ? __pfx___schedule+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? __rcu_read_unlock+0x53/0x80
[Mon Jun 19 16:05:49 2023]  ? cgroup_rstat_updated+0x82/0x250
[Mon Jun 19 16:05:49 2023]  ? __kasan_check_write+0x14/0x30
[Mon Jun 19 16:05:49 2023]  schedule+0x9b/0x150
[Mon Jun 19 16:05:49 2023]  io_schedule+0x70/0xc0
[Mon Jun 19 16:05:49 2023]  folio_wait_bit_common+0x232/0x550
[Mon Jun 19 16:05:49 2023]  ? __pfx_folio_wait_bit_common+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? __filemap_remove_folio+0x177/0x3a0
[Mon Jun 19 16:05:49 2023]  ? __pfx_wake_page_function+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? __pfx_workingset_update_node+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[Mon Jun 19 16:05:49 2023]  __folio_lock+0x17/0x30
[Mon Jun 19 16:05:49 2023]  invalidate_inode_pages2_range+0x5b4/0x840
[Mon Jun 19 16:05:49 2023]  ? __pfx_invalidate_inode_pages2_range+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? cifs_dentry_needs_reval+0x27f/0x390 [cifs]
[Mon Jun 19 16:05:49 2023]  ? cifs_revalidate_dentry_attr+0xa4/0x650 [cifs]
[Mon Jun 19 16:05:49 2023]  invalidate_inode_pages2+0x17/0x30
[Mon Jun 19 16:05:49 2023]  cifs_invalidate_mapping+0x57/0x90 [cifs]
[Mon Jun 19 16:05:49 2023]  cifs_revalidate_mapping+0xd5/0x130 [cifs]
[Mon Jun 19 16:05:49 2023]  cifs_revalidate_dentry+0x32/0x40 [cifs]
[Mon Jun 19 16:05:49 2023]  cifs_d_revalidate+0xa3/0x220 [cifs]
[Mon Jun 19 16:05:49 2023]  lookup_fast+0xfc/0x1c0
[Mon Jun 19 16:05:49 2023]  walk_component+0x39/0x240
[Mon Jun 19 16:05:49 2023]  path_lookupat+0xb2/0x2f0
[Mon Jun 19 16:05:49 2023]  filename_lookup+0x16f/0x340
[Mon Jun 19 16:05:49 2023]  ? __pfx_filename_lookup+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? __kasan_slab_alloc+0x9d/0xa0
[Mon Jun 19 16:05:49 2023]  ? kmem_cache_alloc+0x176/0x3a0
[Mon Jun 19 16:05:49 2023]  ? getname_flags.part.0+0x3c/0x260
[Mon Jun 19 16:05:49 2023]  ? getname_flags+0x56/0x90
[Mon Jun 19 16:05:49 2023]  ? __x64_sys_statx+0x9b/0xf0
[Mon Jun 19 16:05:49 2023]  ? do_syscall_64+0x5c/0x90
[Mon Jun 19 16:05:49 2023]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[Mon Jun 19 16:05:49 2023]  ? __rcu_read_unlock+0x53/0x80
[Mon Jun 19 16:05:49 2023]  vfs_statx+0xf4/0x260
[Mon Jun 19 16:05:49 2023]  ? __pfx_vfs_statx+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? __kasan_check_write+0x14/0x30
[Mon Jun 19 16:05:49 2023]  ? lockref_get+0xdb/0x170
[Mon Jun 19 16:05:49 2023]  ? __pfx_lockref_get+0x10/0x10
[Mon Jun 19 16:05:49 2023]  do_statx+0x99/0x100
[Mon Jun 19 16:05:49 2023]  ? __pfx_do_statx+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? __pfx_do_statx+0x10/0x10
[Mon Jun 19 16:05:49 2023]  ? _raw_spin_unlock+0xe/0x40
[Mon Jun 19 16:05:49 2023]  ? audit_alloc_name+0x1b0/0x1e0
[Mon Jun 19 16:05:49 2023]  ? __audit_getname+0x98/0xb0
[Mon Jun 19 16:05:49 2023]  ? getname_flags.part.0+0x10f/0x260
[Mon Jun 19 16:05:49 2023]  ? getname_flags+0x56/0x90
[Mon Jun 19 16:05:49 2023]  __x64_sys_statx+0xb3/0xf0
[Mon Jun 19 16:05:49 2023]  do_syscall_64+0x5c/0x90
[Mon Jun 19 16:05:49 2023]  ? do_syscall_64+0x69/0x90
[Mon Jun 19 16:05:49 2023]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[Mon Jun 19 16:05:49 2023] RIP: 0033:0x7f0e14f121ee
[Mon Jun 19 16:05:49 2023] RSP: 002b:00007f0ccf7e3668 EFLAGS: 00000206
ORIG_RAX: 000000000000014c
[Mon Jun 19 16:05:49 2023] RAX: ffffffffffffffda RBX: 00007f0ccf7e3b30
RCX: 00007f0e14f121ee
[Mon Jun 19 16:05:49 2023] RDX: 0000000000002100 RSI: 00007f0d8073da80
RDI: 0000000000000000
[Mon Jun 19 16:05:49 2023] RBP: 00007f0ccf7e3a90 R08: 00007f0ccf7e3950
R09: 00007f0d8073da80
[Mon Jun 19 16:05:49 2023] R10: 0000000000000fff R11: 0000000000000206
R12: 00007f0ccf7e37a0
[Mon Jun 19 16:05:49 2023] R13: 00007f0d800061d0 R14: 00007f0ccf7e3740
R15: 00007f0ccf7e3770
[Mon Jun 19 16:05:49 2023]  </TASK>


-- 
Regards,
Shyam
