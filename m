Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D46D1E83FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2Qu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:50:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgE2QuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590771022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fGEzJ36hbKxeSGWZBn5eRmcF//8WjQ4N68JYgXcKlx8=;
        b=TpA4vEj47jJv79ypMh3yHsZ5gpZISEEINlLw3JtBIoOliLLAZhHpWe/yHbr0E3VzsMh8jK
        4BsYKFn9C8+U0cicHmX/kAWlBYVnRXUWOkrRVMO5n/byAHGKPGDLjK7110t5v9Xq9MbjIP
        Bkj5ksedSK4E+nnwggWMVHZfN8EF64A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-KlRJ6diHOj6G8t5SSxfcLg-1; Fri, 29 May 2020 12:50:18 -0400
X-MC-Unique: KlRJ6diHOj6G8t5SSxfcLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E45474;
        Fri, 29 May 2020 16:50:15 +0000 (UTC)
Received: from treble (ovpn-116-170.rdu2.redhat.com [10.10.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DA847A8D2;
        Fri, 29 May 2020 16:50:13 +0000 (UTC)
Date:   Fri, 29 May 2020 11:50:11 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200529165011.o7vvhn4wcj6zjxux@treble>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net>
 <20200529153336.GC706518@hirez.programming.kicks-ass.net>
 <20200529160514.cyaytn33thphb3tz@treble>
 <20200529161253.GD706460@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529161253.GD706460@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 06:12:53PM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 11:05:14AM -0500, Josh Poimboeuf wrote:
> 
> > It looks to me like GCC is doing the right thing.  That likely()
> > translates to:
> > 
> > #  define likely(x)	(__branch_check__(x, 1, __builtin_constant_p(x)))
> > 
> > which becomes:
> > 
> > #define __branch_check__(x, expect, is_constant) ({			\
> > 			long ______r;					\
> > 			static struct ftrace_likely_data		\
> > 				__aligned(4)				\
> > 				__section(_ftrace_annotated_branch)	\
> > 				______f = {				\
> > 				.data.func = __func__,			\
> > 				.data.file = __FILE__,			\
> > 				.data.line = __LINE__,			\
> > 			};						\
> > 			______r = __builtin_expect(!!(x), expect);	\
> > 			ftrace_likely_update(&______f, ______r,		\
> > 					     expect, is_constant);	\
> > 			______r;					\
> > 		})
> > 
> > Here 'x' is the call to user_access_begin().  It evaluates 'x' -- and
> > thus calls user_access_begin() -- before the call to
> > ftrace_likely_update().
> > 
> > So it's working as designed, right?  The likely() just needs to be
> > changed to likely_notrace().
> 
> But if !x (ie we fail user_access_begin()), we should not pass STAC() on
> the way to out_err. OTOH if x, we should not be jumping to out_err.
> 
> I'm most confused... must not stare at asm for a while.

Yeah, I saw that call to ftrace_likely_update() and got distracted.  I
forgot it's on the uaccess safe list.

From staring at the asm I think the generated code is correct, it's just
that the nested likelys with ftrace profiling cause GCC to converge the
error/success paths.  But objtool doesn't do register value tracking so
it's not smart enough to know that it's safe.

The nested likelys seem like overkill anyway -- user_access_begin() is
__always_inline and it already has unlikely(), which should be
propagated.

So just remove the outer likelys?

diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index a12b8629206d..ee63d7576fd2 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -27,7 +27,7 @@ csum_and_copy_from_user(const void __user *src, void *dst,
 	might_sleep();
 	*errp = 0;
 
-	if (!likely(user_access_begin(src, len)))
+	if (!user_access_begin(src, len))
 		goto out_err;
 
 	/*
@@ -89,7 +89,7 @@ csum_and_copy_to_user(const void *src, void __user *dst,
 
 	might_sleep();
 
-	if (unlikely(!user_access_begin(dst, len))) {
+	if (!user_access_begin(dst, len)) {
 		*errp = -EFAULT;
 		return 0;
 	}

