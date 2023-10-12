Return-Path: <linux-fsdevel+bounces-169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035027C6DE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 14:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64B9282143
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7D2629C;
	Thu, 12 Oct 2023 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BFVl/8Ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hIlepdmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98F22EE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 12:21:16 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C46CCC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 05:21:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4764E21863;
	Thu, 12 Oct 2023 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697113271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zd1e2JkEQEfa6VL5QCKHF0dZKzj3NHYPkabOEMNGirY=;
	b=BFVl/8EicJtCtf0egMYrRqKlkeS5lkNP/Ix1oitmrESsUVA2EepLRTSu9ZKzhTDPc7UKei
	mlla2WHYd0ZcwtpsTvEK1TnEckdkG+0y4eI1XIHPOLT4cGPVCWsGqqgc07/VBK0CJAkWDW
	D/KpvVT0qQrpZOEjBmDgGt8CeYw4eXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697113271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zd1e2JkEQEfa6VL5QCKHF0dZKzj3NHYPkabOEMNGirY=;
	b=hIlepdmFxZ4WdZ0TYGYjflZGA3yBr1CeFR641QK7QQI3UJD3p/Iv0i0lF0/Dj695TILeK4
	Gpvq2GwqOugVbACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A1CF139F9;
	Thu, 12 Oct 2023 12:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LLlACrfkJ2UqTgAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 12 Oct 2023 12:21:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A76D6A06B0; Thu, 12 Oct 2023 14:21:10 +0200 (CEST)
Date: Thu, 12 Oct 2023 14:21:10 +0200
From: Jan Kara <jack@suse.cz>
To: Yury Norov <yury.norov@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Message-ID: <20231012122110.zii5pg3ohpragpi7@quack3>
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz>
 <ZSbo1aAjteepdmcz@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSbo1aAjteepdmcz@yury-ThinkPad>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.10
X-Spamd-Result: default: False [-5.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed 11-10-23 11:26:29, Yury Norov wrote:
> Long story short: KCSAN found some potential issues related to how
> people use bitmap API. And instead of working through that issues,
> the following code shuts down KCSAN by applying READ_ONCE() here
> and there.

I'm sorry but this is not what the patch does. I'm not sure how to get the
message across so maybe let me start from a different angle:

Bitmaps are perfectly fine to be used without any external locking if
only atomic bit ops (set_bit, clear_bit, test_and_{set/clear}_bit) are
used. This is a significant performance gain compared to using a spinlock
or other locking and people do this for a long time. I hope we agree on
that.

Now it is also common that you need to find a set / clear bit in a bitmap.
To maintain lockless protocol and deal with races people employ schemes
like (the dumbest form):

	do {
		bit = find_first_bit(bitmap, n);
		if (bit >= n)
			abort...
	} while (!test_and_clear_bit(bit, bitmap));

So the code loops until it finds a set bit that is successfully cleared by
it. This is perfectly fine and safe lockless code and such use should be
supported. Agreed?

*Except* that the above actually is not safe due to find_first_bit()
implementation and KCSAN warns about that. The problem is that:

Assume *addr == 1
CPU1			CPU2
find_first_bit(addr, 64)
  val = *addr;
  if (val) -> true
			clear_bit(0, addr)
    val = *addr -> compiler decided to refetch addr contents for whatever
		   reason in the generated assembly
    __ffs(val) -> now executed for value 0 which has undefined results.

And the READ_ONCE() this patch adds prevents the compiler from adding the
refetching of addr into the assembly.

Are we on the same page now?

								Honza

> On Wed, Oct 11, 2023 at 05:02:31PM +0200, Jan Kara wrote:
> > From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> > 
> > Some users of lib/find functions can operate on bitmaps that change
> > while we are looking at the bitmap. For example xarray code looks at tag
> > bitmaps only with RCU protection. The xarray users are prepared to
> > handle a situation were tag modification races with reading of a tag
> > bitmap (and thus we get back a stale information) but the find_*bit()
> > functions should return based on bitmap contents at *some* point in time.
> > As UBSAN properly warns, the code like:
> > 
> > 	val = *addr;
> > 	if (val)
> > 		__ffs(val)
> > 
> > prone to refetching 'val' contents from addr by the compiler and thus
> > passing 0 to __ffs() which has undefined results.
> > 
> > Fix the problem by using READ_ONCE() in all the appropriate places so
> > that the compiler cannot accidentally refetch the contents of addr
> > between the test and __ffs(). This makes the undefined behavior
> > impossible. The generated code is somewhat larger due to gcc tracking
> > both the index and target fetch address in separate registers (according
> > to GCC folks the volatile cast confuses their optimizer a bit, they are
> > looking into a fix). The difference in performance is minimal though.
> > Targetted microbenchmark (in userspace) of the bit searching loop shows
> > about 2% regression on some x86 microarchitectures so for normal kernel
> > workloads this should be in the noise and not worth introducing special
> > set of bitmap searching functions.
> > 
> > [JK: Wrote commit message]
> 
> READ_ONCE() fixes nothing because nothing is broken in find_bit() API.
> As I suspected, and as Matthew confirmed in his email, the true reason
> for READ_ONCE() here is to disable KCSAN check:
> 
>         READ_ONCE() serves two functions here;
>         one is that it tells the compiler not to try anything fancy, and
>         the other is that it tells KCSAN to not bother instrumenting this
>         load; no load-delay-reload.
> 
> https://lkml.kernel.org/linux-mm/ZQkhgVb8nWGxpSPk@casper.infradead.org/
> 
> And as side-effect, it of course hurts the performance. In the same
> email Matthew said he doesn't believe me that READ_ONCE would do that,
> so thank you for testing and confirming that it does.
> 
> Matthew, in my experience compilers do really well in that low-level
> things, and gambling with compilers usually makes thing worse. x86_64
> is one of the most strong-ordered architectures that I've been working
> with, and even here READ_ONCE has visible effect on performance. I
> expect that it will get even worse on more weakly ordered platforms.
> 
> I'm OK that you don't believe me; probably you can believe Paul
> McKenney and his paper on kernel memory model, which says in the very
> first paragraph:
> 
>         Applying ACCESS_ONCE() to a large array or structure is unlikely
>         to do anything useful, and use of READ_ONCE() and WRITE_ONCE()
>         in this situation can result in load-tearing and store-tearing.
> 
> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/n4444.html
> 
> Jan, I think that in your last email you confirmed that the xarray
> problem that you're trying to solve is about a lack of proper locking:
> 
>         Well, for xarray the write side is synchronized with a spinlock but the read
>         side is not (only RCU protected).
> 
> https://lkml.kernel.org/linux-mm/20230918155403.ylhfdbscgw6yek6p@quack3/
> 
> If there's no enough synchronization, why not just adding it?
> 
> Regardless performance consideration, my main concern is that this patch
> considers bitmap as an atomic structure, which is intentionally not.
> There are just a few single-bit atomic operations like set_bit() and
> clear_bit(). All other functions are non-atomic, including those
> find_bit() operations.
> 
> There is quite a lot of examples of wrong use of bitmaps wrt
> atomicity, the most typical is like:
>         for(idx = 0; idx < num; idx++) {
>                 ...
>                 set_bit(idx, bitmap);
>         }
> 
> This is wrong because a series of atomic ops is not atomic itself, and
> if you see something like this in you code, it should be converted to
> using non-atomic __set_bit(), and protected externally if needed.
> 
> Similarly, READ_ONCE() in a for-loop doesn't guarantee any ordering or
> atomicity, and only hurts the performance. And this is exactly what
> this patch does.
> 
> Thanks,
> Yury
>  
> > CC: Yury Norov <yury.norov@gmail.com>
> > Link: https://lore.kernel.org/all/20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr/
> > Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  include/linux/find.h | 40 ++++++++++++++++++++++++----------------
> >  lib/find_bit.c       | 39 +++++++++++++++++++++++----------------
> >  2 files changed, 47 insertions(+), 32 deletions(-)
> > 
> > diff --git a/include/linux/find.h b/include/linux/find.h
> > index 5e4f39ef2e72..5ef6466dc7cc 100644
> > --- a/include/linux/find.h
> > +++ b/include/linux/find.h
> > @@ -60,7 +60,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
> >  		if (unlikely(offset >= size))
> >  			return size;
> >  
> > -		val = *addr & GENMASK(size - 1, offset);
> > +		val = READ_ONCE(*addr) & GENMASK(size - 1, offset);
> >  		return val ? __ffs(val) : size;
> >  	}
> >  
> > @@ -90,7 +90,8 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
> >  		if (unlikely(offset >= size))
> >  			return size;
> >  
> > -		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
> > +		val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
> > +						GENMASK(size - 1, offset);
> >  		return val ? __ffs(val) : size;
> >  	}
> >  
> > @@ -121,7 +122,8 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
> >  		if (unlikely(offset >= size))
> >  			return size;
> >  
> > -		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
> > +		val = READ_ONCE(*addr1) & ~READ_ONCE(*addr2) &
> > +						GENMASK(size - 1, offset);
> >  		return val ? __ffs(val) : size;
> >  	}
> >  
> > @@ -151,7 +153,8 @@ unsigned long find_next_or_bit(const unsigned long *addr1,
> >  		if (unlikely(offset >= size))
> >  			return size;
> >  
> > -		val = (*addr1 | *addr2) & GENMASK(size - 1, offset);
> > +		val = (READ_ONCE(*addr1) | READ_ONCE(*addr2)) &
> > +						GENMASK(size - 1, offset);
> >  		return val ? __ffs(val) : size;
> >  	}
> >  
> > @@ -179,7 +182,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> >  		if (unlikely(offset >= size))
> >  			return size;
> >  
> > -		val = *addr | ~GENMASK(size - 1, offset);
> > +		val = READ_ONCE(*addr) | ~GENMASK(size - 1, offset);
> >  		return val == ~0UL ? size : ffz(val);
> >  	}
> >  
> > @@ -200,7 +203,7 @@ static inline
> >  unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> >  {
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val = *addr & GENMASK(size - 1, 0);
> > +		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
> >  
> >  		return val ? __ffs(val) : size;
> >  	}
> > @@ -229,7 +232,7 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
> >  		return size;
> >  
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val =  *addr & GENMASK(size - 1, 0);
> > +		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
> >  
> >  		return val ? fns(val, n) : size;
> >  	}
> > @@ -255,7 +258,8 @@ unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *
> >  		return size;
> >  
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val =  *addr1 & *addr2 & GENMASK(size - 1, 0);
> > +		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2)
> > +							& GENMASK(size - 1, 0);
> >  
> >  		return val ? fns(val, n) : size;
> >  	}
> > @@ -282,7 +286,8 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
> >  		return size;
> >  
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val =  *addr1 & (~*addr2) & GENMASK(size - 1, 0);
> > +		unsigned long val = READ_ONCE(*addr1) & ~READ_ONCE(*addr2) &
> > +							GENMASK(size - 1, 0);
> >  
> >  		return val ? fns(val, n) : size;
> >  	}
> > @@ -312,7 +317,8 @@ unsigned long find_nth_and_andnot_bit(const unsigned long *addr1,
> >  		return size;
> >  
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val =  *addr1 & *addr2 & (~*addr3) & GENMASK(size - 1, 0);
> > +		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
> > +				~READ_ONCE(*addr3) & GENMASK(size - 1, 0);
> >  
> >  		return val ? fns(val, n) : size;
> >  	}
> > @@ -336,7 +342,8 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
> >  				 unsigned long size)
> >  {
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
> > +		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
> > +							GENMASK(size - 1, 0);
> >  
> >  		return val ? __ffs(val) : size;
> >  	}
> > @@ -358,7 +365,7 @@ static inline
> >  unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
> >  {
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val = *addr | ~GENMASK(size - 1, 0);
> > +		unsigned long val = READ_ONCE(*addr) | ~GENMASK(size - 1, 0);
> >  
> >  		return val == ~0UL ? size : ffz(val);
> >  	}
> > @@ -379,7 +386,7 @@ static inline
> >  unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
> >  {
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val = *addr & GENMASK(size - 1, 0);
> > +		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
> >  
> >  		return val ? __fls(val) : size;
> >  	}
> > @@ -505,7 +512,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
> >  		long size, unsigned long offset)
> >  {
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val = *(const unsigned long *)addr;
> > +		unsigned long val = READ_ONCE(*(const unsigned long *)addr);
> >  
> >  		if (unlikely(offset >= size))
> >  			return size;
> > @@ -523,7 +530,8 @@ static inline
> >  unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
> >  {
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val = swab(*(const unsigned long *)addr) | ~GENMASK(size - 1, 0);
> > +		unsigned long val = swab(READ_ONCE(*(const unsigned long *)addr))
> > +						| ~GENMASK(size - 1, 0);
> >  
> >  		return val == ~0UL ? size : ffz(val);
> >  	}
> > @@ -538,7 +546,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
> >  		long size, unsigned long offset)
> >  {
> >  	if (small_const_nbits(size)) {
> > -		unsigned long val = *(const unsigned long *)addr;
> > +		unsigned long val = READ_ONCE(*(const unsigned long *)addr);
> >  
> >  		if (unlikely(offset >= size))
> >  			return size;
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index 32f99e9a670e..6867ef8a85e0 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -98,7 +98,7 @@ out:										\
> >   */
> >  unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
> >  {
> > -	return FIND_FIRST_BIT(addr[idx], /* nop */, size);
> > +	return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
> >  }
> >  EXPORT_SYMBOL(_find_first_bit);
> >  #endif
> > @@ -111,7 +111,8 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
> >  				  const unsigned long *addr2,
> >  				  unsigned long size)
> >  {
> > -	return FIND_FIRST_BIT(addr1[idx] & addr2[idx], /* nop */, size);
> > +	return FIND_FIRST_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
> > +				/* nop */, size);
> >  }
> >  EXPORT_SYMBOL(_find_first_and_bit);
> >  #endif
> > @@ -122,7 +123,7 @@ EXPORT_SYMBOL(_find_first_and_bit);
> >   */
> >  unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
> >  {
> > -	return FIND_FIRST_BIT(~addr[idx], /* nop */, size);
> > +	return FIND_FIRST_BIT(~READ_ONCE(addr[idx]), /* nop */, size);
> >  }
> >  EXPORT_SYMBOL(_find_first_zero_bit);
> >  #endif
> > @@ -130,28 +131,30 @@ EXPORT_SYMBOL(_find_first_zero_bit);
> >  #ifndef find_next_bit
> >  unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
> >  {
> > -	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
> > +	return FIND_NEXT_BIT(READ_ONCE(addr[idx]), /* nop */, nbits, start);
> >  }
> >  EXPORT_SYMBOL(_find_next_bit);
> >  #endif
> >  
> >  unsigned long __find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
> >  {
> > -	return FIND_NTH_BIT(addr[idx], size, n);
> > +	return FIND_NTH_BIT(READ_ONCE(addr[idx]), size, n);
> >  }
> >  EXPORT_SYMBOL(__find_nth_bit);
> >  
> >  unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
> >  				 unsigned long size, unsigned long n)
> >  {
> > -	return FIND_NTH_BIT(addr1[idx] & addr2[idx], size, n);
> > +	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
> > +			    size, n);
> >  }
> >  EXPORT_SYMBOL(__find_nth_and_bit);
> >  
> >  unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> >  				 unsigned long size, unsigned long n)
> >  {
> > -	return FIND_NTH_BIT(addr1[idx] & ~addr2[idx], size, n);
> > +	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & ~READ_ONCE(addr2[idx]),
> > +			    size, n);
> >  }
> >  EXPORT_SYMBOL(__find_nth_andnot_bit);
> >  
> > @@ -160,7 +163,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
> >  					const unsigned long *addr3,
> >  					unsigned long size, unsigned long n)
> >  {
> > -	return FIND_NTH_BIT(addr1[idx] & addr2[idx] & ~addr3[idx], size, n);
> > +	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]) &
> > +			    ~READ_ONCE(addr3[idx]), size, n);
> >  }
> >  EXPORT_SYMBOL(__find_nth_and_andnot_bit);
> >  
> > @@ -168,7 +172,8 @@ EXPORT_SYMBOL(__find_nth_and_andnot_bit);
> >  unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
> >  					unsigned long nbits, unsigned long start)
> >  {
> > -	return FIND_NEXT_BIT(addr1[idx] & addr2[idx], /* nop */, nbits, start);
> > +	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
> > +			     /* nop */, nbits, start);
> >  }
> >  EXPORT_SYMBOL(_find_next_and_bit);
> >  #endif
> > @@ -177,7 +182,8 @@ EXPORT_SYMBOL(_find_next_and_bit);
> >  unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> >  					unsigned long nbits, unsigned long start)
> >  {
> > -	return FIND_NEXT_BIT(addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
> > +	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) & ~READ_ONCE(addr2[idx]),
> > +			     /* nop */, nbits, start);
> >  }
> >  EXPORT_SYMBOL(_find_next_andnot_bit);
> >  #endif
> > @@ -186,7 +192,8 @@ EXPORT_SYMBOL(_find_next_andnot_bit);
> >  unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
> >  					unsigned long nbits, unsigned long start)
> >  {
> > -	return FIND_NEXT_BIT(addr1[idx] | addr2[idx], /* nop */, nbits, start);
> > +	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) | READ_ONCE(addr2[idx]),
> > +			     /* nop */, nbits, start);
> >  }
> >  EXPORT_SYMBOL(_find_next_or_bit);
> >  #endif
> > @@ -195,7 +202,7 @@ EXPORT_SYMBOL(_find_next_or_bit);
> >  unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
> >  					 unsigned long start)
> >  {
> > -	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
> > +	return FIND_NEXT_BIT(~READ_ONCE(addr[idx]), /* nop */, nbits, start);
> >  }
> >  EXPORT_SYMBOL(_find_next_zero_bit);
> >  #endif
> > @@ -208,7 +215,7 @@ unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
> >  		unsigned long idx = (size-1) / BITS_PER_LONG;
> >  
> >  		do {
> > -			val &= addr[idx];
> > +			val &= READ_ONCE(addr[idx]);
> >  			if (val)
> >  				return idx * BITS_PER_LONG + __fls(val);
> >  
> > @@ -242,7 +249,7 @@ EXPORT_SYMBOL(find_next_clump8);
> >   */
> >  unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
> >  {
> > -	return FIND_FIRST_BIT(~addr[idx], swab, size);
> > +	return FIND_FIRST_BIT(~READ_ONCE(addr[idx]), swab, size);
> >  }
> >  EXPORT_SYMBOL(_find_first_zero_bit_le);
> >  
> > @@ -252,7 +259,7 @@ EXPORT_SYMBOL(_find_first_zero_bit_le);
> >  unsigned long _find_next_zero_bit_le(const unsigned long *addr,
> >  					unsigned long size, unsigned long offset)
> >  {
> > -	return FIND_NEXT_BIT(~addr[idx], swab, size, offset);
> > +	return FIND_NEXT_BIT(~READ_ONCE(addr[idx]), swab, size, offset);
> >  }
> >  EXPORT_SYMBOL(_find_next_zero_bit_le);
> >  #endif
> > @@ -261,7 +268,7 @@ EXPORT_SYMBOL(_find_next_zero_bit_le);
> >  unsigned long _find_next_bit_le(const unsigned long *addr,
> >  				unsigned long size, unsigned long offset)
> >  {
> > -	return FIND_NEXT_BIT(addr[idx], swab, size, offset);
> > +	return FIND_NEXT_BIT(READ_ONCE(addr[idx]), swab, size, offset);
> >  }
> >  EXPORT_SYMBOL(_find_next_bit_le);
> >  
> > -- 
> > 2.35.3
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

