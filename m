Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1164E25D0A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 06:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIDElt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 00:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDElt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 00:41:49 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D1EC061244;
        Thu,  3 Sep 2020 21:41:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE3Xe-00AAXp-Va; Fri, 04 Sep 2020 04:41:39 +0000
Date:   Fri, 4 Sep 2020 05:41:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/14] x86: remove address space overrides using set_fs()
Message-ID: <20200904044138.GP1236603@ZenIV.linux.org.uk>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-13-hch@lst.de>
 <20200904025510.GO1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904025510.GO1236603@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:55:10AM +0100, Al Viro wrote:
> On Thu, Sep 03, 2020 at 04:22:40PM +0200, Christoph Hellwig wrote:
> 
> > diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
> > index c8a85b512796e1..94f7be4971ed04 100644
> > --- a/arch/x86/lib/getuser.S
> > +++ b/arch/x86/lib/getuser.S
> > @@ -35,10 +35,19 @@
> >  #include <asm/smap.h>
> >  #include <asm/export.h>
> >  
> > +#ifdef CONFIG_X86_5LEVEL
> > +#define LOAD_TASK_SIZE_MINUS_N(n) \
> > +	ALTERNATIVE "mov $((1 << 47) - 4096 - (n)),%rdx", \
> > +		    "mov $((1 << 56) - 4096 - (n)),%rdx", X86_FEATURE_LA57
> > +#else
> > +#define LOAD_TASK_SIZE_MINUS_N(n) \
> > +	mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
> > +#endif
> 
> Wait a sec... how is that supposed to build with X86_5LEVEL?  Do you mean
> 
> #define LOAD_TASK_SIZE_MINUS_N(n) \
> 	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
> 		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
> 
> there?

Pushed out with the following folded in.

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 94f7be4971ed..2f052bc96866 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -37,8 +37,8 @@
 
 #ifdef CONFIG_X86_5LEVEL
 #define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE "mov $((1 << 47) - 4096 - (n)),%rdx", \
-		    "mov $((1 << 56) - 4096 - (n)),%rdx", X86_FEATURE_LA57
+	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
+		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
 #else
 #define LOAD_TASK_SIZE_MINUS_N(n) \
 	mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 445374885153..358239d77dff 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -33,8 +33,8 @@
 
 #ifdef CONFIG_X86_5LEVEL
 #define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE "mov $((1 << 47) - 4096 - (n)),%rbx", \
-		    "mov $((1 << 56) - 4096 - (n)),%rbx", X86_FEATURE_LA57
+	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rbx), \
+		    __stringify(mov $((1 << 56) - 4096 - (n)),%rbx), X86_FEATURE_LA57
 #else
 #define LOAD_TASK_SIZE_MINUS_N(n) \
 	mov $(TASK_SIZE_MAX - (n)),%_ASM_BX
