Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6868C1DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 16:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBFPmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 10:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBFPlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:41:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06922B29E;
        Mon,  6 Feb 2023 07:40:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30D06B8120F;
        Mon,  6 Feb 2023 15:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0AFC433D2;
        Mon,  6 Feb 2023 15:38:57 +0000 (UTC)
Date:   Mon, 6 Feb 2023 10:38:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: [LSF/MM/BPF TOPIC]  sframe: An orc like stack unwinder for the
 kernel to get a user space stacktrace
Message-ID: <20230206103828.6efcb28f@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Title: sframe: An orc like stack unwinder for the kernel to get a user space stacktrace 

Due to performance reasons, most applications do not enable frame
pointers (although Fedora has announced that they have done so[1]
Although, some of the maintainers that did, would prefer another
solution[2]) Thus getting a reliable user space stack trace for
profiling or tracing can be difficult. One method that perf uses, is to
grab a large section of the user space stack and save it into the ring
buffer, and then use dwarf to later parse this information. This is
slow and wastes a lot of ring buffer real-estate leading to lost events.

It also requires post processing and after the trace to find where
these locations exist (the kernel can at least figure out where in the
file the addresses are by using the proc/$$/maps data).

With the a new sframe section that has been introduced by binutils[3],
this will allow the kernel to get an accurate stack trace from user
space. This may even be extended to allow for symbol lookup from user
space as well.

The idea is the following:

1. On exec (binfmt_elf.c) the kernel could see that an sframe section
exists in the kernel and flag the task struct, and record some
information of where it exists.

2. perf/ftrace/bpf in any context (NMI, interrupt, etc) wants to take a
user space stack trace and would request one. This will set a flag in
the task struct to go the ptrace path before entering back into user
space. A callback function would need to be registered to handle this
as well.

3. On the ptrace path (where it's guaranteed to be back into normal
context and is allowed to fault) it would read the sframe section to
extract the stack trace (and possibly another section to retrieve a
symbol table if necessary). It would then call a list of callback
functions that were added by perf/ftrace/bpf with the stack trace and
allow them to record it.

We would probably need a system call of some kind to allow the dynamic
linker to notify the kernel of sframe sections that exist in libraries
that are loaded after the initial exec as well.

I'd like to discuss the above ideas about getting this implemented.

-- Steve


[1] https://lwn.net/Articles/919940/
[2] https://social.kernel.org/notice/ARHY3JdFu2WMYDb888
[3] https://www.phoronix.com/news/GNU-Binutils-SFrame
