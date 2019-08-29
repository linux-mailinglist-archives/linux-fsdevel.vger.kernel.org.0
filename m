Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45B8A2AFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 01:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfH2Xhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 19:37:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfH2Xhj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:37:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F807317528C;
        Thu, 29 Aug 2019 23:37:39 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0B9C608C1;
        Thu, 29 Aug 2019 23:37:37 +0000 (UTC)
Date:   Thu, 29 Aug 2019 18:37:35 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2019-08-27-20-39 uploaded (objtool: xen)
Message-ID: <20190829233735.yp3mwhg6er353qw5@treble>
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org>
 <8b09d93a-bc42-bd8e-29ee-cd37765f4899@infradead.org>
 <20190828171923.4sir3sxwsnc2pvjy@treble>
 <57d6ab2e-1bae-dca3-2544-4f6e6a936c3a@infradead.org>
 <20190828200134.d3lwgyunlpxc6cbn@treble>
 <20190829082445.GM2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829082445.GM2369@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 29 Aug 2019 23:37:39 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:24:45AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 28, 2019 at 03:01:34PM -0500, Josh Poimboeuf wrote:
> > On Wed, Aug 28, 2019 at 10:56:25AM -0700, Randy Dunlap wrote:
> > > >> drivers/xen/gntdev.o: warning: objtool: gntdev_copy()+0x229: call to __ubsan_handle_out_of_bounds() with UACCESS enabled
> > > > 
> > > > Easy one :-)
> > > > 
> > > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > > index 0c8e17f946cd..6a935ab93149 100644
> > > > --- a/tools/objtool/check.c
> > > > +++ b/tools/objtool/check.c
> > > > @@ -483,6 +483,7 @@ static const char *uaccess_safe_builtin[] = {
> > > >  	"ubsan_type_mismatch_common",
> > > >  	"__ubsan_handle_type_mismatch",
> > > >  	"__ubsan_handle_type_mismatch_v1",
> > > > +	"__ubsan_handle_out_of_bounds",
> > > >  	/* misc */
> > > >  	"csum_partial_copy_generic",
> > > >  	"__memcpy_mcsafe",
> > > > 
> > > 
> > > 
> > > then I get this one:
> > > 
> > > lib/ubsan.o: warning: objtool: __ubsan_handle_out_of_bounds()+0x5d: call to ubsan_prologue() with UACCESS enabled
> > 
> > And of course I jinxed it by calling it easy.
> > 
> > Peter, how do you want to handle this?
> > 
> > Should we just disable UACCESS checking in lib/ubsan.c?
> 
> No, that is actually unsafe and could break things (as would you patch
> above).

Oops.  -EFIXINGTOOMANYOBJTOOLISSUESATONCE

> I'm thinking the below patch ought to cure things:
> 
> ---
> Subject: x86/uaccess: Don't leak the AC flags into __get_user() argument evalidation

s/evalidation/evaluation

> Identical to __put_user(); the __get_user() argument evalution will too
> leak UBSAN crud into the __uaccess_begin() / __uaccess_end() region.
> While uncommon this was observed to happen for:
> 
>   drivers/xen/gntdev.c: if (__get_user(old_status, batch->status[i]))
> 
> where UBSAN added array bound checking.
> 
> This complements commit:
> 
>   6ae865615fc4 ("x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation")
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: luto@kernel.org
> ---
>  arch/x86/include/asm/uaccess.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 9c4435307ff8..35c225ede0e4 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -444,8 +444,10 @@ __pu_label:							\
>  ({									\
>  	int __gu_err;							\
>  	__inttype(*(ptr)) __gu_val;					\
> +	__typeof__(ptr) __gu_ptr = (ptr);				\
> +	__typeof__(size) __gu_size = (size);				\
>  	__uaccess_begin_nospec();					\
> -	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
> +	__get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_err, -EFAULT);	\
>  	__uaccess_end();						\
>  	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
>  	__builtin_expect(__gu_err, 0);					\

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
