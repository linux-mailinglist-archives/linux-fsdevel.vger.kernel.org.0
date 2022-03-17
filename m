Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370A84DCDC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 19:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbiCQSlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiCQSlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:41:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D74204C85;
        Thu, 17 Mar 2022 11:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50E9EB81E97;
        Thu, 17 Mar 2022 18:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19892C340E9;
        Thu, 17 Mar 2022 18:39:40 +0000 (UTC)
Date:   Thu, 17 Mar 2022 14:39:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
Message-ID: <20220317143938.745e1420@gandalf.local.home>
In-Reply-To: <yt9dr1706b4i.fsf@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
        <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
        <yt9dr1706b4i.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You already replied, but this was what I was working on.

On Thu, 17 Mar 2022 13:01:49 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> I'm getting the following oops with that patch:

I think I know the issue.

> 
> [    0.937455] VFS: Disk quotas dquot_6.6.0
> [    0.937474] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.958347] Unable to handle kernel pointer dereference in virtual kernel address space
> [    0.958350] Failing address: 00000000010de000 TEID: 00000000010de407
> [    0.958353] Fault in home space mode while using kernel ASCE.
> [    0.958357] AS:0000000001ed0007 R3:00000002ffff0007 S:0000000001003701
> [    0.958388] Oops: 0004 ilc:3 [#1] SMP
> [    0.958393] Modules linked in:
> [    0.958398] CPU: 0 PID: 8 Comm: kworker/u128:0 Not tainted 5.17.0-rc8-next-20220317 #396
> [    0.958403] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)

I'm guessing this is a s390?

> [    0.958407] Workqueue: eval_map_wq eval_map_work_func
> 
> [    0.958446] Krnl PSW : 0704e00180000000 000000000090a9d6 (number+0x25e/0x3c0)
> [    0.958456]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> [    0.958461] Krnl GPRS: 0000000000000058 00000000010de0ac 0000000000000001 00000000fffffffc
> [    0.958467]            0000038000047b80 0affffff010de0ab 0000000000000000 0000000000000000
> [    0.958481]            0000000000000020 0000038000000000 00000000010de0ad 00000000010de0ab
> [    0.958484]            0000000080312100 0000000000e68910 0000038000047b50 0000038000047ab8
> [    0.958494] Krnl Code: 000000000090a9c6: f0c84112b001        srp     274(13,%r4),1(%r11),8
> [    0.958494]            000000000090a9cc: 41202001            la      %r2,1(%r2)
> [    0.958494]           #000000000090a9d0: ecab0006c065        clgrj   %r10,%r11,12,000000000090a9dc
> [    0.958494]           >000000000090a9d6: d200b0004000        mvc     0(1,%r11),0(%r4)
> [    0.958494]            000000000090a9dc: 41b0b001            la      %r11,1(%r11)
> [    0.958494]            000000000090a9e0: a74bffff
>             aghi    %r4,-1
> [    0.958494]            000000000090a9e4: a727fff6            brctg   %r2,000000000090a9d0
> [    0.958494]            000000000090a9e8: a73affff            ahi     %r3,-1
> [    0.958575] Call Trace:
> [    0.958580]  [<000000000090a9d6>] number+0x25e/0x3c0
> [    0.958594] ([<0000000000289516>] update_event_printk+0xde/0x200)
> [    0.958602]  [<0000000000910020>] vsnprintf+0x4b0/0x7c8
> [    0.958606]  [<00000000009103e8>] snprintf+0x40/0x50
> [    0.958610]  [<00000000002893d2>] eval_replace+0x62/0xc8
> [    0.958614]  [<000000000028e2fe>] trace_event_eval_update+0x206/0x248
> [    0.958619]  [<0000000000171bba>] process_one_work+0x1fa/0x460
> [    0.958625]  [<000000000017234c>] worker_thread+0x64/0x468
> [    0.958629]  [<000000000017af90>] kthread+0x108/0x110
> [    0.958634]  [<00000000001032ec>] __ret_from_fork+0x3c/0x58
> [    0.958640]  [<0000000000cce43a>] ret_from_fork+0xa/0x40
> [    0.958648] Last Breaking-Event-Address:
> [    0.958652]  [<000000000090a99c>] number+0x224/0x3c0
> [    0.958661] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> I haven't really checked what TRACE_DEFINE_ENUM() does, but removing the
> last line ("TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);") makes the oops go
> away. Looking at all the other defines looks like the _MAX enum
> shouldn't be added there?

What I believe is happening is that we are modifying different memory to
fix up the enums by the types. The print_fmt happens to be defined by:

static char print_fmt_##call[] = print;

Which is writable. But the types are defined with:

.type = #_type"["__stringify(_len)"]", .name = #_item,

Which are not. It just so happens that on x86 this is still writable
during boot up, so it wasn't a problem.

[ here I wanted to add a patch, but I haven't figured out the best way to
  fix it yet. ]

-- Steve
