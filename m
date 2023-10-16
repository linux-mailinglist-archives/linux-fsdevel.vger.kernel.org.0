Return-Path: <linux-fsdevel+bounces-384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 487377CA3FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30ACB20D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40301C6AE;
	Mon, 16 Oct 2023 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jy0d75Xx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qLM9PAUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9151C689
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:23:05 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270B0B4;
	Mon, 16 Oct 2023 02:23:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFBA01F8C1;
	Mon, 16 Oct 2023 09:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697448179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncEmaJpGCEkUvSIDaJyvviOSOQUcVNocJwvIFZralxs=;
	b=Jy0d75XxHX0wz6UMRr6WwZ3ATAiOBsPEcBvB6Hg2vJMoQl40TjoDDwvutlrOhW6Vc9NP0z
	1FGS9YVdZAV2e6YJaNG0Vif1ii7Hj5jpUFcxBPwwP236fNuXPZN26fYxagu3wng8QKv40u
	YpnAwjqaCb0SYUWYcRxg0cwKKrrDMQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697448179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncEmaJpGCEkUvSIDaJyvviOSOQUcVNocJwvIFZralxs=;
	b=qLM9PAUHUeiMgdewTO8M250jYv8exh9MKMhgrvQL0Jl3j4Vaf5TuaeuEau7OGrB+M9T3b1
	v/1MGu7eCCt1OhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFC9C138EF;
	Mon, 16 Oct 2023 09:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id APrkKvMALWUFMAAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 16 Oct 2023 09:22:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 34460A0657; Mon, 16 Oct 2023 11:22:59 +0200 (CEST)
Date: Mon, 16 Oct 2023 11:22:59 +0200
From: Jan Kara <jack@suse.cz>
To: Yury Norov <yury.norov@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Message-ID: <20231016092259.h4ny5slr4v5hcmpy@quack3>
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-1-jack@suse.cz>
 <ZSbo1aAjteepdmcz@yury-ThinkPad>
 <20231012122110.zii5pg3ohpragpi7@quack3>
 <ZSndoNcA7YWHXeUi@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSndoNcA7YWHXeUi@yury-ThinkPad>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 NEURAL_SPAM_LONG(3.00)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
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

On Fri 13-10-23 17:15:28, Yury Norov wrote:
> On Thu, Oct 12, 2023 at 02:21:10PM +0200, Jan Kara wrote:
> > On Wed 11-10-23 11:26:29, Yury Norov wrote:
> > > Long story short: KCSAN found some potential issues related to how
> > > people use bitmap API. And instead of working through that issues,
> > > the following code shuts down KCSAN by applying READ_ONCE() here
> > > and there.
> > 
> > I'm sorry but this is not what the patch does. I'm not sure how to get the
> > message across so maybe let me start from a different angle:
> > 
> > Bitmaps are perfectly fine to be used without any external locking if
> > only atomic bit ops (set_bit, clear_bit, test_and_{set/clear}_bit) are
> > used. This is a significant performance gain compared to using a spinlock
> > or other locking and people do this for a long time. I hope we agree on
> > that.
> > 
> > Now it is also common that you need to find a set / clear bit in a bitmap.
> > To maintain lockless protocol and deal with races people employ schemes
> > like (the dumbest form):
> > 
> > 	do {
> > 		bit = find_first_bit(bitmap, n);
> > 		if (bit >= n)
> > 			abort...
> > 	} while (!test_and_clear_bit(bit, bitmap));
> > 
> > So the code loops until it finds a set bit that is successfully cleared by
> > it. This is perfectly fine and safe lockless code and such use should be
> > supported. Agreed?
> 
> Great example. When you're running non-atomic functions concurrently,
> the result may easily become incorrect, and this is what you're
> demonstrating here.
> 
> Regarding find_first_bit() it means that:
>  - it may erroneously return unset bit;
>  - it may erroneously return non-first set bit;
>  - it may erroneously return no bits for non-empty bitmap.

Correct.

> Effectively it means that find_first bit may just return a random number.

I prefer to think that it can return a result that is no longer valid by
the time we further use it :)

> Let's take another example:
> 
> 	do {
> 		bit = get_random_number();
> 		if (bit >= n)
> 			abort...
> 	} while (!test_and_clear_bit(bit, bitmap));
> 
> When running concurrently, the difference between this and your code
> is only in probability of getting set bit somewhere from around the
> beginning of bitmap.

Well, as you say the difference is in the probability - i.e., average
number of loops taken is higher with using truly random number and that is
the whole point. We bother with complexity of lockless access exactly
because of performance :). As long as find_first_bit() returns set bit in
case there's no collision with other bitmap modification, we are fine with
its results (usually we don't expect the collision to happen, often the
bitmap users also employ schemes to spread different processes modifying
the bitmap to different parts of the bitmap to further reduce likelyhood of
a collision).

> The key point is that find_bit() may return undef even if READ_ONCE() is
> used. If bitmap gets changed anytime in the process, the result becomes
> invalid. It may happen even after returning from find_first_bit().
> 
> And if my understanding correct, your code is designed in the
> assumption that find_first_bit() may return garbage, so handles it
> correctly.

Yes, that is true.

> > *Except* that the above actually is not safe due to find_first_bit()
> > implementation and KCSAN warns about that. The problem is that:
> > 
> > Assume *addr == 1
> > CPU1			CPU2
> > find_first_bit(addr, 64)
> >   val = *addr;
> >   if (val) -> true
> > 			clear_bit(0, addr)
> >     val = *addr -> compiler decided to refetch addr contents for whatever
> > 		   reason in the generated assembly
> >     __ffs(val) -> now executed for value 0 which has undefined results.
> 
> Yes, __ffs(0) is undef. But the whole function is undef when accessing
> bitmap concurrently.

So here I think we get at the core of our misunderstanding :): Yes,
find_first_bit() may return a bit number that is not set any longer. But it
is guaranteed to return some number between 0 and n where n is the bitmap
size. What __ffs() does when passed 0 value is unclear and likely will be
architecture dependent. If we are guaranteed it returns some number between
0 and 8*sizeof(unsigned long), then we are fine. But I'm concerned it may
throw exception (similarly to division by 0) or return number greater than
8*sizeof(unsigned long) for some architecture and that would be a problem.
E.g. reading the x86 bsf instruction documentation, the destination
register is untouched if there is no set bit so the result can indeed be >
8*sizeof(unsigned long). So __ffs(0) can result in returning a number
beyond the end of the bitmap (e.g. 0xffffffff). And that is IMO
unacceptable output for find_first_bit().

> > And the READ_ONCE() this patch adds prevents the compiler from adding the
> > refetching of addr into the assembly.
> 
> That's true. But it doesn't improve on the situation. It was an undef
> before, and it's undef after, but a 2% slower undef.
> 
> Now on that KCSAN warning. If I understand things correctly, for the
> example above, KCSAN warning is false-positive, because you're
> intentionally running lockless.

As I wrote above, there are different levels of "undefinedness" and that
matters in this case. KCSAN is complaining that the value passed to __ffs()
function may be different one from the one tested in the condition before
it. Depending on exact __ffs() behavior this may be fine or it may be not.

> But for some other people it may be a true error, and now they'll have
> no chance to catch it if KCSAN is forced to ignore find_bit() entirely.

I agree some people may accidentally use bitmap function unlocked without
properly handling the races. However in this case KCSAN does not warn about
unsafe use of the result from find_bit() (which is what should happen for
those unsafe uses). It complains about unsafe internal implementation of
find_bit() when it is used without external synchronization. These two are
different things so I don't think this is a good argument for leaving the
race in find_bit().

Furthermore I'd note that READ_ONCE() does not make KCSAN ignore find_bit()
completely. READ_ONCE() forces the compiler to use the same value for the
test and __ffs() argument (by telling it it cannot assume the standard C
memory model using "volatile" keyword for this fetch). That's all.  That
makes it impossible for KCSAN to inject a modification of the bitmap &
refetch from memory inbetween the two uses of the local variable and thus
it doesn't generate the warning anymore.

> We've got the whole class of lockless algorithms that allow safe concurrent
> access to the memory. And now that there's a tool that searches for them
> (concurrent accesses), we need to have an option to somehow teach it
> to suppress irrelevant warnings. Maybe something like this?
> 
>         lockless_algorithm_begin(bitmap, bitmap_size(nbits));
> 	do {
> 		bit = find_first_bit(bitmap, nbits);
> 		if (bit >= nbits)
> 			break;
> 	} while (!test_and_clear_bit(bit, bitmap));
>         lockless_algorithm_end(bitmap, bitmap_size(nbits));
> 
> And, of course, as I suggested a couple iterations ago, you can invent
> a thread-safe version of find_bit(), that would be perfectly correct
> for lockless use:
> 
>  unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long size)
>  {
>         unsigned long bit = 0;
>  
>         while (!test_and_clear_bit(bit, bitmap) {
>                 bit = FIND_FIRST_BIT(addr[idx], /* nop */, size);
>                 if (bit >= size)
>                         return size;
>         }
> 
>         return bit;
>  }
> 
> Didn't test that, but I hope 'volatile' specifier should be enough
> for compiler to realize that it shouldn't optimize memory access, and
> for KCSAN that everything's OK here. 

Based on my research regarding __ffs() we indeed do need find_*_bit()
functions that are guaranteed to return number in 0-n range even in
presence of concurrent bitmap modifications. Do I get it right you'd
rather prefer cloning all the find_*_bit() implementations to create
such variants? IMO that's worse both in terms of maintainability (more
code) and usability (users have to be aware special functions are needed
for lockless code) so the 2% of performance overhead until gcc is fixed
isn't IMO worth it but you are the maintainer...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

