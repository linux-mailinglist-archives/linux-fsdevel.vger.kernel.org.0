Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC16E008B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDLVMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDLVMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C146A7F;
        Wed, 12 Apr 2023 14:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3DFD632B0;
        Wed, 12 Apr 2023 21:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BE7C433D2;
        Wed, 12 Apr 2023 21:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681333937;
        bh=9gB2mGFB6sk7lKqjsy7MbN72ZEJ0ICs26aBiPeN3y+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rjkrSfP2YwvvRScBvxWN9x84liozbr35remjUYkZHRlO/Cswc2psrGCU0AdeqpNjf
         hOz2ECYBBlmIf7gRobYBN7hw44whuZGlFeHWZIQwkZlNGnCYf8TOSySYm8PrVoDKij
         6UfVjVrA3O7JqxPGsGDWuMBtgewVER+Cn6EyBTQw=
Date:   Wed, 12 Apr 2023 14:12:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chunguang Wu <aman2008@qq.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] fs/proc: add Kthread flag to /proc/$pid/status
Message-Id: <20230412141216.c8f2c1313f34ee0100ac9ae4@linux-foundation.org>
In-Reply-To: <tencent_3E1CBD85D91AD4CDDCB5F429A3948EB94306@qq.com>
References: <tencent_3E1CBD85D91AD4CDDCB5F429A3948EB94306@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Apr 2023 22:34:02 +0800 Chunguang Wu <aman2008@qq.com> wrote:

> user can know that a process is kernel thread or not.
> 
> ...
>
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -434,6 +434,12 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>  
>  	task_state(m, ns, pid, task);
>  
> +	if ((mm == NULL) || (task->flags & PF_KTHREAD)) {
> +		seq_puts(m, "Kthread:\tYes\n");
> +	} else {
> +		seq_puts(m, "Kthread:\tNo\n");
> +	}
> +
>  	if (mm) {
>  		task_mem(m, mm);
>  		task_core_dumping(m, task);

Well..   Why is this information useful?  What is the use case?

There are many ways of working this out from the existing output - why
is this change required?

