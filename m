Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6930E90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfEaNLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 09:11:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaNLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 09:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5J0ba4Ad42pvvelRQpkEcT3KcojCTDX3YCcgX/U44Ic=; b=pJ4t6LkHXCwBk7eHWUyyF31bL
        atygI577w3kMbTDLLv7Bt9klbP5R9DeHtJXzVoOpHE+jJVICLL1cG9Rzka2RzcDMAtnPj6EE0h9T+
        lPfIHOKqIb6k1IeL3NEddNcVSf1tbSLYBDLxGRnFAQyH+Rr23hwli5u7loQrEzxDcxgR7tvDp8DSk
        x+TyQ7nPuXjvLT4Vt3sRD6uSfZcphduOwZxhx0KswRnpDlU4qATsn7xUFKxtVxx0O4gk2rezwyfBA
        DR1b5XHINd9G79IC09pwuj+5nopkC4VOqJcZfy4hYuntVe+TKNT+G7trbG++RBBAJXhL/f4qPQHPu
        IZ0x3C5cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWhJh-0001SF-CS; Fri, 31 May 2019 13:11:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B991E20274AFF; Fri, 31 May 2019 15:11:27 +0200 (CEST)
Date:   Fri, 31 May 2019 15:11:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
Message-ID: <20190531131127.GB2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095549.GB17637@hirez.programming.kicks-ass.net>
 <7187263bcee61b9abbe687f3a7478bd1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7187263bcee61b9abbe687f3a7478bd1@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 01:24:07PM +0200, Roman Penyaev wrote:
> On 2019-05-31 11:55, Peter Zijlstra wrote:
> > On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:
> > > +#define atomic_set_unless_zero(ptr, flags)			\
> > > +({								\
> > > +	typeof(ptr) _ptr = (ptr);				\
> > > +	typeof(flags) _flags = (flags);				\
> > > +	typeof(*_ptr) _old, _val = READ_ONCE(*_ptr);		\
> > > +								\
> > > +	for (;;) {						\
> > > +		if (!_val)					\
> > > +			break;					\
> > > +		_old = cmpxchg(_ptr, _val, _flags);		\
> > > +		if (_old == _val)				\
> > > +			break;					\
> > > +		_val = _old;					\
> > > +	}							\
> > > +	_val;							\
> > > +})
> > 
> > > +#define atomic_or_with_mask(ptr, flags, mask)			\
> > > +({								\
> > > +	typeof(ptr) _ptr = (ptr);				\
> > > +	typeof(flags) _flags = (flags);				\
> > > +	typeof(flags) _mask = (mask);				\
> > > +	typeof(*_ptr) _old, _new, _val = READ_ONCE(*_ptr);	\
> > > +								\
> > > +	for (;;) {						\
> > > +		_new = (_val & ~_mask) | _flags;		\
> > > +		_old = cmpxchg(_ptr, _val, _new);		\
> > > +		if (_old == _val)				\
> > > +			break;					\
> > > +		_val = _old;					\
> > > +	}							\
> > > +	_val;							\
> > > +})
> > 
> > Don't call them atomic_*() if they're not part of the atomic_t
> > interface.
> 
> Can we add those two?  Or keep it local is better?

Afaict you're using them on the user visible values; we should not put
atomic_t into shared memory.

Your interface isn't compatible with those 'funny' architectures like
parisc etc. Since you expect userspace to do atomic ops on these
variables too. It is not a one-way interface ...
