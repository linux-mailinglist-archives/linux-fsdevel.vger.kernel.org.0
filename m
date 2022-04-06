Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C04F6676
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiDFQ42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbiDFQzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:55:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9881E6F97;
        Wed,  6 Apr 2022 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jd5mGjSbX47w2X+2S3x1eLe58DMjaD30ZV5S+64MR24=; b=oAj37mZgYGKYE01JQUyBn6XaeH
        7W9y0feU9pl7TuryQObRZK4vnceajbqIPXBFI9ttn0ygE/dTS4e8S5ViYR8cUL6bSW0GW5cYC/ouP
        at8TEgpOWlx8FIFUjjnlRfT8zYqw4675vYLfUvp275wWTcuiSWKaXiT7IMPHv6qqpDlfyP6yd3wE9
        HTwskVIEH2F2eenvBrp8pCLYYLvdDG0vjldTcvZqdQOU0sTqlgzX8fOYLTlKjuYHfTi1mHd9M089U
        kRdV16FIMeY7pGe7tb7qB5PwFlCMFS63hE2xZ3n9c07GoVWin95kWtirUwtoylvMFs0HBFGTcL2S5
        HDTAqm9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nc73E-007ubg-N1; Wed, 06 Apr 2022 14:54:28 +0000
Date:   Wed, 6 Apr 2022 15:54:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tglx@linutronix.de, clg@kaod.org, nitesh@redhat.com,
        edumazet@google.com, peterz@infradead.org, joshdon@google.com,
        masahiroy@kernel.org, nathan@kernel.org, akpm@linux-foundation.org,
        vbabka@suse.cz, gustavoars@kernel.org, arnd@arndb.de,
        chris@chrisdown.name, dmitry.torokhov@gmail.com,
        linux@rasmusvillemoes.dk, daniel@iogearbox.net,
        john.ogness@linutronix.de, will@kernel.org, dave@stgolabs.net,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, heying24@huawei.com,
        guohanjun@huawei.com, weiyongjun1@huawei.com
Subject: Re: [RFC 0/3] softirq: Introduce softirq throttling
Message-ID: <Yk2ppI60P98E2Qj5@casper.infradead.org>
References: <20220406025241.191300-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406025241.191300-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:52:38AM +0800, Liao Chang wrote:
> Kernel check for pending softirqs periodically, they are performed in a
> few points of kernel code, such as irq_exit() and __local_bh_enable_ip(),
> softirqs that have been activated by a given CPU must be executed on the
> same CPU, this characteristic of softirq is always a potentially
> "dangerous" operation, because one CPU might be end up very busy while
> the other are most idle.
> 
> Above concern is proven in a networking user case: recenlty, we
> engineer find out the time used for connection re-establishment on
> kernel v5.10 is 300 times larger than v4.19, meanwhile, softirq
> monopolize almost 99% of CPU. This problem stem from that the connection
> between Sender and Receiver node get lost, the NIC driver on Sender node
> will keep raising NET_TX softirq before connection recovery. The system
> log show that most of softirq is performed from __local_bh_enable_ip(),
> since __local_bh_enable_ip is used widley in kernel code, it is very
> easy to run out most of CPU, and the user-mode application can't obtain
> enough CPU cycles to establish connection as soon as possible.

Shouldn't you fix that bug instead?  This seems like papering over the
bad effects of a bug and would make it harder to find bugs like this in
the future.  Essentially, it's the same as a screaming hardware interrupt,
except that it's a software interrupt, so we can fix the bug instead of
working around broken hardware.
