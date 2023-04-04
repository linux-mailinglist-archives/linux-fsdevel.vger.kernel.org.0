Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624D16D70C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjDDXgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 19:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjDDXgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 19:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531381736;
        Tue,  4 Apr 2023 16:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1ED163A0B;
        Tue,  4 Apr 2023 23:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33497C433D2;
        Tue,  4 Apr 2023 23:36:19 +0000 (UTC)
Date:   Tue, 4 Apr 2023 19:36:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [BUG RESEND] [BISECTED]: selftest: ftracetest: memleak in
 vfs_write()
Message-ID: <20230404193616.378357f1@gandalf.local.home>
In-Reply-To: <20230404182428.4ccd3f96@gandalf.local.home>
References: <ca4dca01-66ce-c1a9-23cd-9d83b0d2c4b0@alu.unizg.hr>
        <76134d9f-a5ba-6a0d-37b3-28310b4a1e91@alu.unizg.hr>
        <20230404220744.GB1893@sol.localdomain>
        <20230404182428.4ccd3f96@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 4 Apr 2023 18:24:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 4 Apr 2023 15:07:44 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > This looks like an issue with the tracing subsystem.  I appreciate that you've
> > now added the tracing maintainers to Cc.  I don't think your bisection to commit
> > 71946a25f357 ("Merge tag 'mmc-v6.2' ...") is correct; that looks unrelated.  
> 
> No that is not the correct commit. I think I see the issue. The error log
> of a tracing instance doesn't seem to be freed if the instance is removed.
> 
> I'm guessing this can cause the bug:
> 
>  # cd /sys/kernel/tracincg
>  # mkdir instances/foo
>  # echo 'p:nothing no_function_here' > instances/foo/dynamic_events

OK, it required me to touch a trigger as dynamic_events only exists in the
top level (and the bug report shows a filter):

 # echo 'hist:keys=x' > instances/foo/events/sched/sched_switch/trigger

>  # rmdir instances/foo
> 

Anyway, I was able to reproduce the leak. Can you test this patch?

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ae51f1dea8e..352a804b016d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9516,6 +9516,7 @@ static int __remove_instance(struct trace_array *tr)
 	tracefs_remove(tr->dir);
 	free_percpu(tr->last_func_repeats);
 	free_trace_buffers(tr);
+	clear_tracing_err_log(tr);
 
 	for (i = 0; i < tr->nr_topts; i++) {
 		kfree(tr->topts[i].topts);
