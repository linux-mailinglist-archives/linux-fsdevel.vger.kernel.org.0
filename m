Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9E5BCEFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiISOfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiISOex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:34:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393AB65C7;
        Mon, 19 Sep 2022 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gMLf/rqQpWC2+XjEGcuSjEkDKbi/0GhYcmxhsgsT9kI=; b=HKy/YcOBOeh2qwxkz/0aIlfx1K
        HE80ZpMr8zuQCCd3t/UE0BntI4h3Mu1TeG+TL6ja45VvI33jmN9jJtZYvzCEOZgvBMqlIiax/uZ86
        nN5Y/W4ip8jWmp5Jz/az5yx0PoUwTc5xyRbORDbg+FI20GDX/DbL7e+2VAw3/4gK6vMJpwKAus9To
        tuQ8JkjszjBlJCP9pYt7n7gssZtw7O34SwbJfd9eEZW2MeOFJaKI25dIcHjlcxcIuba5Si3O3pNCO
        OzeofN6ymvrV/BcVaYHgci0sQTd73g39ca1pf/UTeCMJQz19ZfTILSjvCaP9IARP2/GAy4NWyZ8/G
        oa6wH0Og==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaHrB-004m7e-4e; Mon, 19 Sep 2022 14:34:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 070283001F3;
        Mon, 19 Sep 2022 16:34:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5B612BAC7765; Mon, 19 Sep 2022 16:34:40 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:34:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <Yyh+AFYJJwvx3iun@hirez.programming.kicks-ass.net>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202209160727.5FC78B735@keescook>
 <YyTY+OaClK+JHCOw@localhost>
 <202209161637.9EDAF6B18@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209161637.9EDAF6B18@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 05:11:18PM -0700, Kees Cook wrote:

> The interaction with sched_exec() should be no worse (the file is opened
> before it in either case), but in reading that function, it talks about
> taking the opportunity to move the process to another CPU (IIUC) since,
> paraphrasing, "it is at its lowest memory/cache size." But I wonder if
> there is an existing accidental pessimistic result in that the process
> stack has already been allocated. I am only passingly familiar with how
> tasks get moved around under NUMA -- is the scheduler going to move
> this process onto a different NUMA node and now it will be forced to
> have the userspace process stack on one node and the program text and
> heap on another? Or is that totally lost in the noise?

Probably noise; text is going to be a crap-shoot anyway due to DSOs only
having a single copy in the page-cache. And the stack will be relatively
small at this point and also, numa-balance can migrate those pages
around if they matter.

> More specifically, I was wondering if processes would benefit from having
> sched_exec() moved before the mm creation?

Can't hurt I think.
