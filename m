Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A294B545D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355681AbiBNPPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 10:15:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiBNPPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:15:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992AB488B7;
        Mon, 14 Feb 2022 07:15:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EB5BECE1824;
        Mon, 14 Feb 2022 15:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4F4C340E9;
        Mon, 14 Feb 2022 15:15:08 +0000 (UTC)
Date:   Mon, 14 Feb 2022 10:15:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: mmotm 2022-02-11-15-07 uploaded (objtool: ftrace_likely_update)
Message-ID: <20220214101506.3e69ea97@gandalf.local.home>
In-Reply-To: <YgdqmbK7Irwa2Ryh@hirez.programming.kicks-ass.net>
References: <20220211230819.191B1C340E9@smtp.kernel.org>
        <8074da01-7aa3-9913-1a1e-2ce307ccdbbd@infradead.org>
        <YgdqmbK7Irwa2Ryh@hirez.programming.kicks-ass.net>
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

On Sat, 12 Feb 2022 09:06:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Yes, TRACE_BRANCH_PROFILING and PROFILE_ALL_BRANCHES are fundamentally
> broken and I have no intention of trying to fix them.
> 
> The moment we pull PTI into noinstr C code this will result in insta
> boot fail.

Actually, I don't think anyone has every used the "tracers" for this, and I
will be happy to get rid of it:

void ftrace_likely_update(struct ftrace_likely_data *f, int val,
			  int expect, int is_constant)
{
	unsigned long flags = user_access_save();

	/* A constant is always correct */
	if (is_constant) {
		f->constant++;
		val = expect;
	}


------8<------
	/*
	 * I would love to have a trace point here instead, but the
	 * trace point code is so inundated with unlikely and likely
	 * conditions that the recursive nightmare that exists is too
	 * much to try to get working. At least for now.
	 */
	trace_likely_condition(f, val, expect);
----->8-------

	/* FIXME: Make this atomic! */
	if (val == expect)
		f->data.correct++;
	else
		f->data.incorrect++;

	user_access_restore(flags);
}
EXPORT_SYMBOL(ftrace_likely_update);

The above with the cut lines I added.

I still use the likely and unlikely counters. Would it be possible to mark
that function as "noinstr" and still record them (I don't care if there's
races where we miss a few or add a few too many). But they have been really
affective in finding bad locations of likely and unlikely callers.

As I said. I have no problem with removing the trace portion of that code.
It was more of an academic exercise than a useful one, but the counters
are still very useful to have.

-- Steve
