Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05BEA1395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfH2IZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 04:25:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55640 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfH2IZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=120ASc5CfxclYJhY7EFAVAvAR3LTc4Yy6ktyuTmJDRA=; b=oOi8m8/nu7e3QiAQrmP0/hdhg
        qbKyB38a2s30Iu7GWe0UIxIGH4U7r0uHXnKYW0Eax0SxJ/bmGrCnMkKrFb5JBERCAwh/jISr6mTM1
        qVOt8NWWldXI62o8JDG2AJdqB5idOPbXzBehaZ3CNd33SGb50ATS644/j7XOHBQEoSg9r0c5vaeuW
        p6Pi8NWiAnvErk+A4q2+XkDuAYFAV0UHw9gsg+8LOl9vdssXHY3wt6VNUKMCH/3whymlYwZVEEKwF
        K7XYKtk+EO9x1RRk5iD6oMEhgaaw7R9OawBEBomXh4PeJd0RkMlrWGIcAEhy8E6m++zciB2hasuz8
        4rRxJvEFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Fjb-000087-TT; Thu, 29 Aug 2019 08:24:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFD093070F4;
        Thu, 29 Aug 2019 10:24:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DB5F20C74402; Thu, 29 Aug 2019 10:24:45 +0200 (CEST)
Date:   Thu, 29 Aug 2019 10:24:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2019-08-27-20-39 uploaded (objtool: xen)
Message-ID: <20190829082445.GM2369@hirez.programming.kicks-ass.net>
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org>
 <8b09d93a-bc42-bd8e-29ee-cd37765f4899@infradead.org>
 <20190828171923.4sir3sxwsnc2pvjy@treble>
 <57d6ab2e-1bae-dca3-2544-4f6e6a936c3a@infradead.org>
 <20190828200134.d3lwgyunlpxc6cbn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828200134.d3lwgyunlpxc6cbn@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:01:34PM -0500, Josh Poimboeuf wrote:
> On Wed, Aug 28, 2019 at 10:56:25AM -0700, Randy Dunlap wrote:
> > >> drivers/xen/gntdev.o: warning: objtool: gntdev_copy()+0x229: call to __ubsan_handle_out_of_bounds() with UACCESS enabled
> > > 
> > > Easy one :-)
> > > 
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index 0c8e17f946cd..6a935ab93149 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -483,6 +483,7 @@ static const char *uaccess_safe_builtin[] = {
> > >  	"ubsan_type_mismatch_common",
> > >  	"__ubsan_handle_type_mismatch",
> > >  	"__ubsan_handle_type_mismatch_v1",
> > > +	"__ubsan_handle_out_of_bounds",
> > >  	/* misc */
> > >  	"csum_partial_copy_generic",
> > >  	"__memcpy_mcsafe",
> > > 
> > 
> > 
> > then I get this one:
> > 
> > lib/ubsan.o: warning: objtool: __ubsan_handle_out_of_bounds()+0x5d: call to ubsan_prologue() with UACCESS enabled
> 
> And of course I jinxed it by calling it easy.
> 
> Peter, how do you want to handle this?
> 
> Should we just disable UACCESS checking in lib/ubsan.c?

No, that is actually unsafe and could break things (as would you patch
above).

I'm thinking the below patch ought to cure things:

---
Subject: x86/uaccess: Don't leak the AC flags into __get_user() argument evalidation

Identical to __put_user(); the __get_user() argument evalution will too
leak UBSAN crud into the __uaccess_begin() / __uaccess_end() region.
While uncommon this was observed to happen for:

  drivers/xen/gntdev.c: if (__get_user(old_status, batch->status[i]))

where UBSAN added array bound checking.

This complements commit:

  6ae865615fc4 ("x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation")

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: luto@kernel.org
---
 arch/x86/include/asm/uaccess.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 9c4435307ff8..35c225ede0e4 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -444,8 +444,10 @@ __pu_label:							\
 ({									\
 	int __gu_err;							\
 	__inttype(*(ptr)) __gu_val;					\
+	__typeof__(ptr) __gu_ptr = (ptr);				\
+	__typeof__(size) __gu_size = (size);				\
 	__uaccess_begin_nospec();					\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
+	__get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_err, -EFAULT);	\
 	__uaccess_end();						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__builtin_expect(__gu_err, 0);					\
