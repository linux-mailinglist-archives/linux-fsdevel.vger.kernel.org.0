Return-Path: <linux-fsdevel+bounces-43700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F9A5BF84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292C8189857B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7961A254AE5;
	Tue, 11 Mar 2025 11:45:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0F1D514E;
	Tue, 11 Mar 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693527; cv=none; b=cqkV4Cvvz3hJsIqsnabD86hS7fcW3U1hXOGqUkrREMihUSiZCgr7roUBkigV7s8dGjSRjSyynCBeQGGr/dff7xswhp/mpPJVGKeFddKQGHBLeqd3EQWUkirMeAFhXaVbzR3wymje2bfdiQyy4V64kBWzDPeUj2F3MYqcNygLzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693527; c=relaxed/simple;
	bh=iBNg5mEvsajHG4sU2bcGfllId35XtLdM5A9w2n+8DnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peYPW5KHZo84xHZ4cofB/s+E9iW0+zY0F0ju4dXyPd2ny5EH0kIqgSANWu/Dv0Z5sGO/zPp7jz7iADI4CXTiuagXiQaDdItuPCVM/+i0ZZeMgetodBopqixMh4MmxkrS4+wtIv+xlTOi9YUDSTBKGTd6ayhMqQ1Kgg182THq0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249CBC4CEE9;
	Tue, 11 Mar 2025 11:45:23 +0000 (UTC)
Date: Tue, 11 Mar 2025 11:45:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>, Peter Collingbourne <pcc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] string: Disable read_word_at_a_time() optimizations if
 kernel MTE is enabled
Message-ID: <Z9AiUQdC4o0g8sxu@arm.com>
References: <20250308023314.3981455-1-pcc@google.com>
 <202503071927.1A795821A@keescook>
 <Z88jbhobIz2yWBbJ@arm.com>
 <Z88r5qFLOSo0itaq@J2N7QTR9R3.cambridge.arm.com>
 <Z88yC7Oaj9DGaswc@arm.com>
 <Z88_fFgr23_EtHMf@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88_fFgr23_EtHMf@J2N7QTR9R3>

On Mon, Mar 10, 2025 at 07:37:32PM +0000, Mark Rutland wrote:
> On Mon, Mar 10, 2025 at 06:40:11PM +0000, Catalin Marinas wrote:
> > On Mon, Mar 10, 2025 at 06:13:58PM +0000, Mark Rutland wrote:
> > > On Mon, Mar 10, 2025 at 05:37:50PM +0000, Catalin Marinas wrote:
> > > > On Fri, Mar 07, 2025 at 07:36:31PM -0800, Kees Cook wrote:
> > > > > On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> > > > > > The optimized strscpy() and dentry_string_cmp() routines will read 8
> > > > > > unaligned bytes at a time via the function read_word_at_a_time(), but
> > > > > > this is incompatible with MTE which will fault on a partially invalid
> > > > > > read. The attributes on read_word_at_a_time() that disable KASAN are
> > > > > > invisible to the CPU so they have no effect on MTE. Let's fix the
> > > > > > bug for now by disabling the optimizations if the kernel is built
> > > > > > with HW tag-based KASAN and consider improvements for followup changes.
> > > > > 
> > > > > Why is faulting on a partially invalid read a problem? It's still
> > > > > invalid, so ... it should fault, yes? What am I missing?
> > > > 
> > > > read_word_at_a_time() is used to read 8 bytes, potentially unaligned and
> > > > beyond the end of string. The has_zero() function is then used to check
> > > > where the string ends. For this uses, I think we can go with
> > > > load_unaligned_zeropad() which handles a potential fault and pads the
> > > > rest with zeroes.
> > > 
> > > If we only care about synchronous and asymmetric modes, that should be
> > > possible, but that won't work in asynchronous mode. In asynchronous mode
> > > the fault will accumulate into TFSR and will be detected later
> > > asynchronously where it cannot be related to its source and fixed up.
> > > 
> > > That means that both read_word_at_a_time() and load_unaligned_zeropad()
> > > are dodgy in async mode.
> > 
> > load_unaligned_zeropad() has a __mte_enable_tco_async() call to set
> > PSTATE.TCO if in async mode, so that's covered. read_word_at_a_time() is
> > indeed busted and I've had Vincezo's patches for a couple of years
> > already, they just never made it to the list.
> 
> Sorry, I missed the __mte_{enable,disable}_tco_async() calls. So long as
> we're happy to omit the check in that case, that's fine.

That was the easiest. Alternatively we can try to sync the TFSR before
and after the load but with the ISBs, that's too expensive. We could
also do a dummy one byte load before setting TCO. read_word_at_a_time()
does have an explicit kasan_check_read() but last time I checked it has
no effect on MTE.

> I was worried that ex_handler_load_unaligned_zeropad() might not do the
> right thing in response to a tag check fault (e.g. access the wrong 8
> bytes), but it looks as though that's ok due to the way it generates the
> offset and the aligned pointer.
> 
> If load_unaligned_zeropad() is handed a string that starts with an
> unexpected tag (and even if that starts off aligned),
> ex_handler_load_unaligned_zeropad() will access that and cause another
> tag check fault, which will be reported.

Yes, it will report an async tag check fault on the
exit_to_kernel_mode() path _if_ load_unaligned_zeropad() triggered the
fault for other reasons (end of page). It's slightly inconsistent, we
could set TCO for the async case in ex_handler_load_unaligned_zeropad()
as well.

For sync checks, we'd get the first fault ending up in
ex_handler_load_unaligned_zeropad() and a second tag check fault while
processing the first. This ends up in do_tag_recovery and we disable tag
checking after the report. Not ideal but not that bad. We could adjust
ex_handler_load_unaligned_zeropad() to return false if the pointer is
already aligned but we need to check the semantics of
load_unaligned_zeropad(), is it allowed to fault on the first byte?

-- 
Catalin

