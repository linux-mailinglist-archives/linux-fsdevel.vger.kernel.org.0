Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C016FA275
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjEHIkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 04:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEHIjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 04:39:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048D17DCD;
        Mon,  8 May 2023 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/1KExNcE7Wnmx5lqqgWUNAAEwP1cS0k9vm/3gTrShQ0=; b=Q4ZmT6o6NHSlxm0gZzh+8pWZHf
        XjqBOWiFbblldzvHxMqy+uMFFyZ9eFGNqmZf33DxNkXS/dmKoJT0uol/cwGjS0ovSl2EURaWhGPK5
        zjl7tJkq3kKQzqH9VFm6KgiB32YZzF677qGlN5DWUxkiyjFNzyE/cncLccmAvNfld3XBNfloI7kCz
        oOwdeVJh4lilAFkvCPrVsd3kPJUcjTYbqtxar0DIZ5grC+YrDc/eSjUftjzCFpmbtZoFLdVR51e44
        a4jLow2n9izMWpDoAbz/lJYYYAqvdfOvida4xDqteQnBs8QbReH5C/NwqFK/fzbNCn/B5f8yrz+m+
        HGw3XR1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pvwP4-00Dyv8-P6; Mon, 08 May 2023 08:39:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DE49300786;
        Mon,  8 May 2023 10:39:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 382EE263B7D50; Mon,  8 May 2023 10:39:29 +0200 (CEST)
Date:   Mon, 8 May 2023 10:39:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
Message-ID: <20230508083929.GT83892@hirez.programming.kicks-ass.net>
References: <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk>
 <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
 <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
 <CAHk-=wjSuGTLrmygUSNh==u81iWUtVzJ5GNSz0A-jbr4WGoZyw@mail.gmail.com>
 <20230425194910.GA1350354@hirez.programming.kicks-ass.net>
 <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
 <978690c4-1d25-46e8-3375-45940ec1ea51@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978690c4-1d25-46e8-3375-45940ec1ea51@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 04:04:23PM +0200, Jonas Oberhauser wrote:
> 
> Am 4/25/2023 um 9:58 PM schrieb Linus Torvalds:
> > Yes, I think Mark is right. It's not that 'old' might be wrong - that
> > doesn't matter because cmpxchg will work it out - it's just that 'new'
> > might not be consistent with the old value we then use.
> 
> In the general pattern, besides the potential issue raised by Mark, tearing
> may also be an issue (longer example inspired by a case we met at the end of
> the mail) where 'old' being wrong matters.

There is yet another pattern where it actually matters:

	old = READ_ONCE(*ptr);
	do {
		if (cond(old))
			return false;

		new = func(old);
	} while (!try_cmpxchg(ptr, &old, new));

	return true;

In this case we rely on old being 'coherent'. The more obvious case is
where it returns old (also not uncommon), but even if it just checks a
(multi-bit) condition on old you don't want tearing.
