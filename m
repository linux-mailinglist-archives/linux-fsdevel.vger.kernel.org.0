Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA77C6320EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKULmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 06:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiKULly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:41:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A2AE76;
        Mon, 21 Nov 2022 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5OxVIP2sJTBTWq/HDoIIRbvS+t0aPa1aRm3P4GNn+Wk=; b=H4laSJ1TRP/mfaaM4wESvfDwE9
        PFHpESfJfhILhDgGrfBvGQt/qt3VCehWWLDrm+3wbzIsgaj43DnA4q4kHZ+ocqjg6PqKq1+cW5fVL
        +OMQXU+zdhPwvy2lgbUEFiM8B4tidtEmyesfJv4tcYq50Aknwyg4vWOvBRmPRK3SPfIZqaw7tdcuW
        Gmmqwf6OEDTRSF/J0YFyK5U8pRokBYunI8v+jDzUb8KnybQIPKMh4gOd7ftySOe40RF0m5kxwQg54
        SGmU5+8+6TGl481N79xPo+MNFGh6LImMgNKvgAsTcGfmiGz1aunrZhGOhvPVXkyukdyBLiojt1LYq
        2Vq72oTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox5Ay-005AXw-Rb; Mon, 21 Nov 2022 11:41:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F7A13006A4;
        Mon, 21 Nov 2022 12:41:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 870972BE3B104; Mon, 21 Nov 2022 12:41:17 +0100 (CET)
Date:   Mon, 21 Nov 2022 12:41:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: Move numa_balancing sysctls to its own file
Message-ID: <Y3tj3SnsLxM5IIli@hirez.programming.kicks-ass.net>
References: <20220908072531.87916-1-wangkefeng.wang@huawei.com>
 <YxqDa+WALRr8L7Q8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxqDa+WALRr8L7Q8@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 05:06:03PM -0700, Luis Chamberlain wrote:
> On Thu, Sep 08, 2022 at 03:25:31PM +0800, Kefeng Wang wrote:
> > The sysctl_numa_balancing_promote_rate_limit and sysctl_numa_balancing
> > are part of sched, move them to its own file.
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> There is quite a bit of random cleanup on each kernel release
> for sysctls to do things like what you just did. Because of this it has its
> own tree to help avoid conflicts. Can you base your patches on the
> sysctl-testing branch here and re-submit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing
> 
> If testing goes fine, then I'd move this to sysctl-next which linux-next
> picks up for yet more testing.
> 
> Are scheduling folks OK with this patch and me picking it up on the
> sysctl-next tree if all tests are a go?

Yeah, think so, it just moves stuff around a bit.

ACK.
