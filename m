Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1B1E8310
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgE2QF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:05:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30039 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727076AbgE2QF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590768325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7jCISGZbxSmJilyCDgnakzVWWHis8T5aaEOojdPPxw=;
        b=gj+Qy+QdHSbkaxIwWf8YKjPyB3W+TPdrSnH8DudCA8iqg2D+1FjKNPGHNdtIis64NMusLS
        ToI2d0VqQ1180kEk/oCyydThpsCpbjeug53y8q2itr/FPTOvNGTBZtagSCMth2jcDd+Wvt
        7FZsW7HOX3Cc1qHn9EaOHR4/6XVDs9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-gT3lMQgbO6CEz4SuLJ-bbg-1; Fri, 29 May 2020 12:05:21 -0400
X-MC-Unique: gT3lMQgbO6CEz4SuLJ-bbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0DDD107ACF2;
        Fri, 29 May 2020 16:05:18 +0000 (UTC)
Received: from treble (ovpn-116-170.rdu2.redhat.com [10.10.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86B287A8D3;
        Fri, 29 May 2020 16:05:16 +0000 (UTC)
Date:   Fri, 29 May 2020 11:05:14 -0500
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
Message-ID: <20200529160514.cyaytn33thphb3tz@treble>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net>
 <20200529153336.GC706518@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529153336.GC706518@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 05:33:36PM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 04:53:25PM +0200, Peter Zijlstra wrote:
> > On Fri, May 29, 2020 at 04:35:56PM +0200, Peter Zijlstra wrote:
> 
> > *groan*, this is one of those CONFIG_PROFILE_ALL_BRANCHES builds. If I
> > disable that it goes away.
> > 
> > Still trying to untangle the mess it generated, but on first go it
> > looks like objtool is right, but I'm not sure what went wrong.
> 
> $ tools/objtool/objtool check -fab arch/x86/lib/csum-wrappers_64.o
> arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_from_user()+0x29f: call to memset() with UACCESS enabled
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x283: (branch)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x113: (branch)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0xea: (alt)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0xe7: (alt)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0xd2: (branch)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x7e: (branch)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x43: (branch)
> arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x0: <=== (sym)
> 
> The problem is with the +0x113 branch, which is at 0x1d1.
> 
> That looks to be:
> 
> 	if (!likely(user_access_begin(src, len)))
> 		goto out_err;
> 
> Except that the brach profiling stuff confused GCC enough to leak STAC
> into the error path or something.

It looks to me like GCC is doing the right thing.  That likely()
translates to:

#  define likely(x)	(__branch_check__(x, 1, __builtin_constant_p(x)))

which becomes:

#define __branch_check__(x, expect, is_constant) ({			\
			long ______r;					\
			static struct ftrace_likely_data		\
				__aligned(4)				\
				__section(_ftrace_annotated_branch)	\
				______f = {				\
				.data.func = __func__,			\
				.data.file = __FILE__,			\
				.data.line = __LINE__,			\
			};						\
			______r = __builtin_expect(!!(x), expect);	\
			ftrace_likely_update(&______f, ______r,		\
					     expect, is_constant);	\
			______r;					\
		})

Here 'x' is the call to user_access_begin().  It evaluates 'x' -- and
thus calls user_access_begin() -- before the call to
ftrace_likely_update().

So it's working as designed, right?  The likely() just needs to be
changed to likely_notrace().

-- 
Josh

