Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4245E5362A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 14:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353307AbiE0MgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 08:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353021AbiE0MgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 08:36:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58266542D;
        Fri, 27 May 2022 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=geAMsSyauLMOVPX6W6eghzalquulsdZss1iC62RITD4=; b=OXBSZOwIzEo0nW3OGXNYDNcso7
        cSVBDSeUyodCUGjW0kjEI72x26/sZY5G+halPOjMqHW/csefH0Qc0ACDbcJZWOM0C9aigW5ZLORDm
        RYg+7mO8/e9EueIsvDw+GKz19plfEHQ2UZuRXBz6+rI7XgUQOZstvPajG8UOVVgRIagN6NWkQSVTR
        XNOJw6mMu6xvqKpm0T7KzjyoMmQrDk8MNY5VChOS/kM+87zJvSTzJXoN1cAMoxjkMBxrV7gJsbDj1
        0FdOWr3Qp9iK5HFfqvrXQJLS5gs0S1zcj/zvA2wwzyCWwn9NVEh6NXN1+myb1Ow7VJaqxyGrqR3bl
        yobvkScw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuYv9-00255Z-AA; Fri, 27 May 2022 12:18:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2463B300327;
        Fri, 27 May 2022 14:18:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C06992026D29A; Fri, 27 May 2022 14:18:20 +0200 (CEST)
Date:   Fri, 27 May 2022 14:18:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, mingo@redhat.com,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-api@vger.kernel.org, fam.zheng@bytedance.com
Subject: Re: [PATCH] procfs: add syscall statistics
Message-ID: <YpDBjDTpS4evca3F@hirez.programming.kicks-ass.net>
References: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 07:09:59PM +0800, Zhang Yuchen wrote:
> Add /proc/syscalls to display percpu syscall count.
> 
> We need a less resource-intensive way to count syscall per cpu
> for system problem location.
> 
> There is a similar utility syscount in the BCC project, but syscount
> has a high performance cost.
> 
> The following is a comparison on the same machine, using UnixBench
> System Call Overhead:
> 
>     ┏━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━┓
>     ┃ Change        ┃ Unixbench Score ┃ Loss   ┃
>     ┡━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━╇━━━━━━━━┩
>     │ no change     │ 1072.6          │ ---    │
>     │ syscall count │ 982.5           │ 8.40%  │
>     │ bpf syscount  │ 614.2           │ 42.74% │
>     └───────────────┴─────────────────┴────────┘
> 
> UnixBench System Call Use sys_gettid to test, this system call only reads
> one variable, so the performance penalty seems large. When tested with
> fork, the test scores were almost the same.
> 
> So the conclusion is that it does not have a significant impact on system
> call performance.
> 
> This function depends on CONFIG_FTRACE_SYSCALLS because the system call
> number is stored in syscall_metadata.

Death by a thousand cuts. 99% of people won't ever use this.

NAK
