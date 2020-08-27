Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE8254294
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 11:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgH0Jhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 05:37:52 -0400
Received: from verein.lst.de ([213.95.11.211]:37484 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbgH0Jhw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:37:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8281168B02; Thu, 27 Aug 2020 11:37:48 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:37:48 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 09/11] x86: remove address space overrides using
 set_fs()
Message-ID: <20200827093748.GA13887@lst.de>
References: <20200817073212.830069-1-hch@lst.de> <20200817073212.830069-10-hch@lst.de> <935d551809894d14965e430e05d21057@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935d551809894d14965e430e05d21057@AcuMS.aculab.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 08:23:11AM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 17 August 2020 08:32
> >
> > Stop providing the possibility to override the address space using
> > set_fs() now that there is no need for that any more.  To properly
> > handle the TASK_SIZE_MAX checking for 4 vs 5-level page tables on
> > x86 a new alternative is introduced, which just like the one in
> > entry_64.S has to use the hardcoded virtual address bits to escape
> > the fact that TASK_SIZE_MAX isn't actually a constant when 5-level
> > page tables are enabled.
> ....
> > @@ -93,7 +69,7 @@ static inline bool pagefault_disabled(void);
> >  #define access_ok(addr, size)					\
> >  ({									\
> >  	WARN_ON_IN_IRQ();						\
> > -	likely(!__range_not_ok(addr, size, user_addr_max()));		\
> > +	likely(!__range_not_ok(addr, size, TASK_SIZE_MAX));		\
> >  })
> 
> Can't that always compare against a constant even when 5-levl
> page tables are enabled on x86-64?
> 
> On x86-64 it can (probably) reduce to (addr | (addr + size)) < 0.

I'll leave that to the x86 maintainers as a future cleanup if wanted.
