Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C44F0DCE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 05:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiDDDy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 23:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiDDDyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:54:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A223057C;
        Sun,  3 Apr 2022 20:52:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so14859330lfg.7;
        Sun, 03 Apr 2022 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WQ2ng76YMyireTVK7QydyIIGkOLkWB3pjbKX7aVqK3I=;
        b=ljYChF9Ht9yebTi3EgabD0asciHHMyAAz3CTF9X8T6elFNyvl8IUvZ2AXE8l6s/VTj
         eYQja2lx/vbVN7JqE+Yu6Ckc/vUn05VF0sF8DXEc6hFvSKT/IRvWXSZLC3AN81c3XlRF
         LwVs0J8EbghLnmrAQPlP+iCNOLmMO+LBGQmVRiFPagfhmW5gcHz7HNtLoYM6cfzSE19O
         bxpHrM1QU9TnFFiGngP8tOwSKuXhWMhCz1c3QkXI/GMnALb949byDrKOwbt5kl/jJRA2
         t5DEGJ2olVupvQrzz5DUuFG6z0NxiRcQUgQ4e9FZs1oaGD3PH4rNsB0POSZ3kr8YilOm
         X+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WQ2ng76YMyireTVK7QydyIIGkOLkWB3pjbKX7aVqK3I=;
        b=TIBwZdo+R8IUKQiDfllo7/mqXCKnNhbgQNO3dvDBs/S1RVG+Z/bz6p9xNJ9neytBop
         F2stqTv+bjPNDujiRvCe6Cfwzilov/MB7NJBgZaxhkoCYnwjVfzeNJuJ8BkQG2Md8JFJ
         OXBGb6IoEP1B6tg90CbY096cV4LjzUC8UbLgAlrNWT8ckEPu4a132BtaMaZldz5+BHRs
         tT7N7gg8Husst2Aymt2Y5rdiqGy+86LK7Y32MBwbaUs4a/tO1Ms4+KTh60luDO/jwRl3
         KEviarkuT19SkGlG+O5IJJlVbcJuakvpT7An1PMHlp2LeVZffgT+jMxaMWZi/hNzR75V
         UI4Q==
X-Gm-Message-State: AOAM530NN8QSbt+LvRojOJSQ6az4oR+aQTPvyFrpEQm1w7f3B/B2vUi5
        YQtVKsx/AB/GdtMOvDzQqi6N9tGxa2sMjIcIoR3izWiMe6c=
X-Google-Smtp-Source: ABdhPJxgGjNiwSRRHklO/aLlZFadWThWYuueFrAsAY4m/AV9JU8BAsjPTpRXKONxVJDMbbWYG80rty/jE9VKUBlTR3E=
X-Received: by 2002:ac2:5444:0:b0:44a:846e:ad2b with SMTP id
 d4-20020ac25444000000b0044a846ead2bmr21586904lfn.545.1649044375866; Sun, 03
 Apr 2022 20:52:55 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 3 Apr 2022 22:52:43 -0500
Message-ID: <CAH2r5msa7ZW3j+oO1JvKA0OLgaP2thyviRDGxTiK6gz2H9r-jA@mail.gmail.com>
Subject: UBSAN shitf-out-of-bounds regression in NFS in 5.18-rc1
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Noticed this shift-out-of-bounds error in NFS, and also similar
messages logged in a few other drivers when running 5.18-rc1.  It
seems to have regressed in the last ten days because I didn't see it
in the same setup when running an earlier version of the rc (about 10
days ago).  Any ideas?

[Sun Apr 3 22:16:57 2022] UBSAN: shift-out-of-bounds in
lib/percpu-refcount.c:140:63
[Sun Apr 3 22:16:57 2022] left shift of negative value -9223372036854775807
[Sun Apr 3 22:16:57 2022] CPU: 7 PID: 10230 Comm: aio-free-ring-w Not
tainted 5.18.0-rc1 #1
[Sun Apr 3 22:16:57 2022] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[Sun Apr 3 22:16:57 2022] Call Trace:
[Sun Apr 3 22:16:57 2022] <TASK>
[Sun Apr 3 22:16:57 2022] dump_stack_lvl+0x55/0x6d
[Sun Apr 3 22:16:57 2022] ubsan_epilogue+0x5/0x40
[Sun Apr 3 22:16:57 2022] __ubsan_handle_shift_out_of_bounds+0xfa/0x140
[Sun Apr 3 22:16:57 2022] ? lock_acquire+0x275/0x320
[Sun Apr 3 22:16:57 2022] ? _raw_spin_unlock_irqrestore+0x40/0x60
[Sun Apr 3 22:16:57 2022] ? percpu_ref_exit+0x87/0x90
[Sun Apr 3 22:16:57 2022] percpu_ref_exit+0x87/0x90
[Sun Apr 3 22:16:57 2022] ioctx_alloc+0x500/0x8f0
[Sun Apr 3 22:16:57 2022] __x64_sys_io_setup+0x58/0x240
[Sun Apr 3 22:16:57 2022] do_syscall_64+0x3a/0x80
[Sun Apr 3 22:16:57 2022] entry_SYSCALL_64_after_hwframe+0x44/0xae
[Sun Apr 3 22:16:57 2022] RIP: 0033:0x7f0c32c52d6d
[Sun Apr 3 22:16:57 2022] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90
f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c
8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d eb 80 0c 00 f7
d8 64 89 01 48
[Sun Apr 3 22:16:57 2022] RSP: 002b:00007fffff3fedc8 EFLAGS: 00000202
ORIG_RAX: 00000000000000ce
[Sun Apr 3 22:16:57 2022] RAX: ffffffffffffffda RBX: 0000000000002710
RCX: 00007f0c32c52d6d
[Sun Apr 3 22:16:57 2022] RDX: 00007f0c32c52f47 RSI: 00007fffff3fee08
RDI: 0000000000002710
[Sun Apr 3 22:16:57 2022] RBP: 00007f0c32b586c0 R08: 0000000000000000
R09: 00007fffff3fef08
[Sun Apr 3 22:16:57 2022] R10: 0000000000000000 R11: 0000000000000202
R12: 000000000000000c
[Sun Apr 3 22:16:57 2022] R13: 00007fffff3fee08 R14: 0000000000000000
R15: 0000000000000000
[Sun Apr  3 22:16:57 2022]  </TASK>
[Sun Apr  3 22:16:57 2022]
================================================================================
[Sun Apr  3 22:16:57 2022]
================================================================================
[Sun Apr  3 22:16:57 2022] UBSAN: shift-out-of-bounds in
./include/linux/nfs_fs.h:606:9
[Sun Apr  3 22:16:57 2022] left shift of 1 by 63 places cannot be
represented in type 'long long int'
[Sun Apr  3 22:16:57 2022] CPU: 5 PID: 32260 Comm: kworker/u16:3 Not
tainted 5.18.0-rc1 #1
[Sun Apr  3 22:16:57 2022] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[Sun Apr  3 22:16:57 2022] Workqueue: rpciod rpc_async_schedule [sunrpc]
[Sun Apr  3 22:16:57 2022] Call Trace:
[Sun Apr  3 22:16:57 2022]  <TASK>
[Sun Apr  3 22:16:57 2022]  dump_stack_lvl+0x55/0x6d
[Sun Apr  3 22:16:57 2022]  ubsan_epilogue+0x5/0x40
[Sun Apr  3 22:16:57 2022]  __ubsan_handle_shift_out_of_bounds+0xfa/0x140
[Sun Apr  3 22:16:57 2022]  ? lock_acquire+0x275/0x320
[Sun Apr  3 22:16:57 2022]  ? ww_mutex_trylock+0x2f1/0x370
[Sun Apr  3 22:16:57 2022]  ? nfs_writeback_update_inode+0x5f/0xd0 [nfs]
[Sun Apr  3 22:16:57 2022]  nfs_writeback_update_inode+0x5f/0xd0 [nfs]
[Sun Apr  3 22:16:57 2022]  ?
trace_raw_output_svcsock_new_socket+0xc0/0xc0 [sunrpc]
[Sun Apr  3 22:16:57 2022]  ?
trace_raw_output_svcsock_new_socket+0xc0/0xc0 [sunrpc]
[Sun Apr  3 22:16:57 2022]  nfs4_write_done_cb+0x61/0x1d0 [nfsv4]
[Sun Apr  3 22:16:57 2022]  ?
trace_raw_output_svcsock_new_socket+0xc0/0xc0 [sunrpc]
[Sun Apr  3 22:16:57 2022]  ?
trace_raw_output_svcsock_new_socket+0xc0/0xc0 [sunrpc]
[Sun Apr  3 22:16:57 2022]  ? nfs41_sequence_done+0x2c/0x40 [nfsv4]
[Sun Apr  3 22:16:57 2022]  nfs_writeback_done+0x37/0x210 [nfs]
[Sun Apr  3 22:16:57 2022]  ?
trace_raw_output_svcsock_new_socket+0xc0/0xc0 [sunrpc]
[Sun Apr  3 22:16:57 2022]  nfs_pgio_result+0x1d/0x60 [nfs]
[Sun Apr  3 22:16:57 2022]  rpc_exit_task+0x97/0x2b0 [sunrpc]
[Sun Apr  3 22:16:57 2022]  __rpc_execute+0xc4/0x7d0 [sunrpc]
[Sun Apr  3 22:16:57 2022]  ? lock_is_held_type+0xea/0x140
[Sun Apr  3 22:16:57 2022]  rpc_async_schedule+0x29/0x40 [sunrpc]
[Sun Apr  3 22:16:57 2022]  process_one_work+0x25b/0x5f0
[Sun Apr  3 22:16:57 2022]  worker_thread+0x30/0x360
[Sun Apr  3 22:16:57 2022]  ? process_one_work+0x5f0/0x5f0
[Sun Apr  3 22:16:57 2022]  kthread+0xe8/0x110
[Sun Apr  3 22:16:57 2022]  ? kthread_complete_and_exit+0x20/0x20
[Sun Apr  3 22:16:57 2022]  ret_from_fork+0x22/0x30
[Sun Apr  3 22:16:57 2022]  </TASK>
[Sun Apr  3 22:16:57 2022]
================================================================================


-- 
Thanks,

Steve
