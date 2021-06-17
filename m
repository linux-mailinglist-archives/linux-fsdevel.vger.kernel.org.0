Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484673AB5A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhFQOTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 10:19:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34288 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQOTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:19:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B52601FD7D;
        Thu, 17 Jun 2021 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623939441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vk+cyjGJ36YWDJsgfR+xPOajoQrdSBKg4DxQNTPCfEg=;
        b=N2Z0gOflTAsA4kIhg0oygEqDHAhKnphs62XVn/Utgy0N4qsYUjrRwHDHeKnXpO5J8IIyG7
        +tGkkMXA+LkycQs7tgOA0KXU8T+xIz5s2/Rv97qyIXZyWmTG5oG4kVnBC+5LvxyuqO3bgB
        q+J04bIs14tFsMrMPr9t6eDG+X3WQDs=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85DBEA3BB8;
        Thu, 17 Jun 2021 14:17:21 +0000 (UTC)
Date:   Thu, 17 Jun 2021 16:17:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jia He <justin.he@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFCv4 3/4] lib/test_printf.c: split write-beyond-buffer
 check in two
Message-ID: <YMtZcVy4gvmMtYv+@alley>
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615154952.2744-4-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-06-15 23:49:51, Jia He wrote:
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Before each invocation of vsnprintf(), do_test() memsets the entire
> allocated buffer to a sentinel value. That buffer includes leading and
> trailing padding which is never included in the buffer area handed to
> vsnprintf (spaces merely for clarity):
> 
>   pad  test_buffer      pad
>   **** **************** ****
> 
> Then vsnprintf() is invoked with a bufsize argument <=
> BUF_SIZE. Suppose bufsize=10, then we'd have e.g.
> 
>  |pad |   test_buffer    |pad |
>   **** pizza0 **** ****** ****
>  A    B      C    D           E
> 
> where vsnprintf() was given the area from B to D.
> 
> It is obviously a bug for vsnprintf to touch anything between A and B
> or between D and E. The former is checked for as one would expect. But
> for the latter, we are actually a little stricter in that we check the
> area between C and E.
> 
> Split that check in two, providing a clearer error message in case it
> was a genuine buffer overrun and not merely a write within the
> provided buffer, but after the end of the generated string.
> 
> So far, no part of the vsnprintf() implementation has had any use for
> using the whole buffer as scratch space, but it's not unreasonable to
> allow that, as long as the result is properly nul-terminated and the
> return value is the right one. However, it is somewhat unusual, and
> most %<something> won't need this, so keep the [C,D] check, but make
> it easy for a later patch to make that part opt-out for certain tests.

Excellent commit message.

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Tested-by: Jia He <justin.he@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
