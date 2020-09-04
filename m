Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3360B25D195
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 08:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgIDGiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 02:38:19 -0400
Received: from verein.lst.de ([213.95.11.211]:40571 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbgIDGiT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:38:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1FFD68AFE; Fri,  4 Sep 2020 08:38:13 +0200 (CEST)
Date:   Fri, 4 Sep 2020 08:38:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/14] x86: remove address space overrides using
 set_fs()
Message-ID: <20200904063813.GA12204@lst.de>
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-13-hch@lst.de> <20200904025510.GO1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904025510.GO1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

Don't ask me about the how, but it builds and works with X86_5LEVEL,
and the style is copied from elsewhere..
