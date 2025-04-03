Return-Path: <linux-fsdevel+bounces-45623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBA9A7A060
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDDE1896983
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286A9248878;
	Thu,  3 Apr 2025 09:46:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79E24503F;
	Thu,  3 Apr 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673613; cv=none; b=P2gNqHIdLwmefvrpTxEBis3NlJBH2oHE2EKPZyEPrENimSNet6e6OPvX2MW6R2ZbX3pH5BRElzRNlKFMBfznBcs8byVbOrIGfO852LddbrSmwAkIglAGU9JwvPd6ljP5Z6YrbC2+IQ+sOipxHpvsUcKmIBj/JT9y0Fjc5ZlFEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673613; c=relaxed/simple;
	bh=QnMCHcUeM+W1q0Zg76iQRhDEtl5RDhg+CheDfK0DLLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0KVn88lIjSLCtwMX0SMSqa3bXhYu6VJq19SiZHq8vPfGTnf2XQL+Enj63wLTkj3BZXRkPdgfSSaQDlpeGbZ9PT5RLAdAwRkEaTC5440xA5A8eqONflreB+OVG0k9q5Yua3pIxtfN5mZO1Fb0OJzaVOLgW8fasu36KeGonN6dl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC1FC4CEE8;
	Thu,  3 Apr 2025 09:46:50 +0000 (UTC)
Date: Thu, 3 Apr 2025 10:46:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Collingbourne <pcc@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] string: Add load_unaligned_zeropad() code path to
 sized_strscpy()
Message-ID: <Z-5ZCP5qw2Lcs9pA@arm.com>
References: <20250329000338.1031289-1-pcc@google.com>
 <20250329000338.1031289-2-pcc@google.com>
 <Z-2ZwThH-7rkQW86@arm.com>
 <CAMn1gO55tC78BpD+KuFgygg1Of57pr16O4BvKsUsrpo830-jEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMn1gO55tC78BpD+KuFgygg1Of57pr16O4BvKsUsrpo830-jEw@mail.gmail.com>

On Wed, Apr 02, 2025 at 05:08:51PM -0700, Peter Collingbourne wrote:
> On Wed, Apr 2, 2025 at 1:10 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Mar 28, 2025 at 05:03:36PM -0700, Peter Collingbourne wrote:
> > > diff --git a/lib/string.c b/lib/string.c
> > > index eb4486ed40d25..b632c71df1a50 100644
> > > --- a/lib/string.c
> > > +++ b/lib/string.c
> > > @@ -119,6 +119,7 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
> > >       if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
> > >               return -E2BIG;
> > >
> > > +#ifndef CONFIG_DCACHE_WORD_ACCESS
> > >  #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >       /*
> > >        * If src is unaligned, don't cross a page boundary,
> > > @@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
> > >       /* If src or dest is unaligned, don't do word-at-a-time. */
> > >       if (((long) dest | (long) src) & (sizeof(long) - 1))
> > >               max = 0;
> > > +#endif
> > >  #endif
> > >
> > >       /*
> > > -      * read_word_at_a_time() below may read uninitialized bytes after the
> > > -      * trailing zero and use them in comparisons. Disable this optimization
> > > -      * under KMSAN to prevent false positive reports.
> > > +      * load_unaligned_zeropad() or read_word_at_a_time() below may read
> > > +      * uninitialized bytes after the trailing zero and use them in
> > > +      * comparisons. Disable this optimization under KMSAN to prevent
> > > +      * false positive reports.
> > >        */
> > >       if (IS_ENABLED(CONFIG_KMSAN))
> > >               max = 0;
> > > @@ -146,7 +149,11 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
> > >       while (max >= sizeof(unsigned long)) {
> > >               unsigned long c, data;
> > >
> > > +#ifdef CONFIG_DCACHE_WORD_ACCESS
> > > +             c = load_unaligned_zeropad(src+res);
> > > +#else
> > >               c = read_word_at_a_time(src+res);
> > > +#endif
> > >               if (has_zero(c, &data, &constants)) {
> > >                       data = prep_zero_mask(c, data, &constants);
> > >                       data = create_zero_mask(data);
> >
> > Kees mentioned the scenario where this crosses the page boundary and we
> > pad the source with zeros. It's probably fine but there are 70+ cases
> > where the strscpy() return value is checked, I only looked at a couple.
> 
> The return value is the same with/without the patch, it's the number
> of bytes copied before the null terminator (i.e. not including the
> extra nulls now written).

I was thinking of the -E2BIG return but you are right, the patch
wouldn't change this. If, for example, you read 8 bytes across a page
boundary and it faults, load_unaligned_zeropad() returns fewer
characters copied, implying the source was null-terminated.
read_word_at_a_time(), OTOH, panics in the next
byte-at-a-time loop. But it wouldn't return -E2BIG either, so it doesn't
matter for the caller.

> > Could we at least preserve the behaviour with regards to page boundaries
> > and keep the existing 'max' limiting logic? If I read the code
> > correctly, a fall back to reading one byte at a time from an unmapped
> > page would panic. We also get this behaviour if src[0] is reading from
> > an invalid address, though for arm64 the panic would be in
> > ex_handler_load_unaligned_zeropad() when count >= 8.
> 
> So do you think that the code should continue to panic if the source
> string is unterminated because of a page boundary? I don't have a
> strong opinion but maybe that's something that we should only do if
> some error checking option is turned on?

It's mostly about keeping the current behaviour w.r.t. page boundaries.
Not a strong opinion either. The change would be to not read across page
boundaries.

> > Reading across tag granule (but not across page boundary) and causing a
> > tag check fault would result in padding but we can live with this and
> > only architectures that do MTE-style tag checking would get the new
> > behaviour.
> 
> By "padding" do you mean the extra (up to sizeof(unsigned long)) nulls
> now written to the destination?

No, I meant the padding of the source when a fault occurs. The write to
the destination would only be a single '\0' byte. It's the destination
safe termination vs. panic above.

> > What I haven't checked is whether a tag check fault in
> > ex_handler_load_unaligned_zeropad() would confuse the KASAN logic for
> > MTE (it would be a second tag check fault while processing the first).
> > At a quick look, it seems ok but it might be worth checking.
> 
> Yes, that works, and I added a test case for that in v5. The stack
> trace looks like this:

Thanks for checking.

-- 
Catalin

