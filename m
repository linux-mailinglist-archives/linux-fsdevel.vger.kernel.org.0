Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85941E84EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 19:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgE2Rdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 13:33:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23048 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726898AbgE2Rd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 13:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590773605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x0aFDdEIWprzVJ+1w7q7ZPdjI2x8X8Jq4phAYixSU2s=;
        b=WLdFTFWi2HFIWjS/w+rZms7AuoUUklf6cyRD/yBraB5Wv5yRAEBZL6E0UR/ITz8Ex7Egup
        mXyUtfRE9Gth95wxP3Xza9NAzKnhjR4t8iI8vYjEj3kgcNjUAuXp7/jhoKycPsJ3X6xnO9
        nIRzF+FVgoUX2yHiSeLVQUon0nn4awA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-fXOlowKrPN6-kKeCKTRHcw-1; Fri, 29 May 2020 13:25:12 -0400
X-MC-Unique: fXOlowKrPN6-kKeCKTRHcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21AF5872FE0;
        Fri, 29 May 2020 17:25:10 +0000 (UTC)
Received: from treble (ovpn-116-170.rdu2.redhat.com [10.10.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB56F7A1ED;
        Fri, 29 May 2020 17:25:07 +0000 (UTC)
Date:   Fri, 29 May 2020 12:25:05 -0500
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
Subject: [PATCH] x86/uaccess: Remove redundant likely/unlikely annotations
Message-ID: <20200529172505.fdjppgquujab7ayv@treble>
References: <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net>
 <20200529153336.GC706518@hirez.programming.kicks-ass.net>
 <20200529160514.cyaytn33thphb3tz@treble>
 <20200529161253.GD706460@hirez.programming.kicks-ass.net>
 <20200529165011.o7vvhn4wcj6zjxux@treble>
 <20200529165419.GF706460@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529165419.GF706460@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 06:54:19PM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 11:50:11AM -0500, Josh Poimboeuf wrote:
> > The nested likelys seem like overkill anyway -- user_access_begin() is
> > __always_inline and it already has unlikely(), which should be
> > propagated.
> > 
> > So just remove the outer likelys?
> 
> That fixes it. Ack!

If there are no objections to the patch, I can add it to my objtool-core
branch unless anybody else wants to take it.  It only affects
linux-next.

---8<---

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/uaccess: Remove redundant likely/unlikely annotations

Since user_access_begin() already has an unlikely() annotation for its
access_ok() check, "if (likely(user_access_begin))" results in nested
likely annotations.  When combined with CONFIG_TRACE_BRANCH_PROFILING,
GCC converges the error/success paths of the nested ifs, using a
register value to distinguish between them.

While the code is technically uaccess safe, it complicates the
branch-profiling generated code.  It also confuses objtool, because it
doesn't do register value tracking, resulting in the following warnings:

  arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_from_user()+0x2a4: call to memset() with UACCESS enabled
  arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_to_user()+0x243: return with UACCESS enabled

The outer likely annotations aren't actually needed anyway, since the
compiler propagates the error path coldness when it inlines
user_access_begin().

Fixes: 18372ef87665 ("x86_64: csum_..._copy_..._user(): switch to unsafe_..._user()")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/lib/csum-wrappers_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.21.3

