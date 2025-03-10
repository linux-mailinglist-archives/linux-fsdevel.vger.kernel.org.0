Return-Path: <linux-fsdevel+bounces-43659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4965A5A339
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5175C7A7157
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C64423314B;
	Mon, 10 Mar 2025 18:40:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0B17A2E8;
	Mon, 10 Mar 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632016; cv=none; b=bX5ojn4r/r9p60tirkX76Vn2wOwPrife1jvi0mRbjjihY6vrx0ctbwP4Zn5JWligxHhFcRCx+fx2EIzXua7fEpEjLSYVC6WHSlAKcI+YultDXHy/4QIPpUQpVHlyd4xbHIVrAAUwVFw7f0qNkqkMpfjuGAYchJXmlqIyfyOOTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632016; c=relaxed/simple;
	bh=wJepYKSs9iAgns7W2C7eh2oyOLQhXeR6zS7sOxRdjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnsdW0szEhtRRMv1ZipC11kj1ljErpbOyTtPd2YRyot+MjWg8D59XwxdHfHLkVdpE4aqauY+NmRl//HGWMjdLeIMp9ZHoDBEcEO8xqX5+S4oATSTQpksqG2w5oh1mF+Fxvvmbd2Hi41LhNZ3F+MrFB4KKgCWZZydeEmWUILtnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3FFC4CEEC;
	Mon, 10 Mar 2025 18:40:13 +0000 (UTC)
Date: Mon, 10 Mar 2025 18:40:11 +0000
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
Message-ID: <Z88yC7Oaj9DGaswc@arm.com>
References: <20250308023314.3981455-1-pcc@google.com>
 <202503071927.1A795821A@keescook>
 <Z88jbhobIz2yWBbJ@arm.com>
 <Z88r5qFLOSo0itaq@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88r5qFLOSo0itaq@J2N7QTR9R3.cambridge.arm.com>

On Mon, Mar 10, 2025 at 06:13:58PM +0000, Mark Rutland wrote:
> On Mon, Mar 10, 2025 at 05:37:50PM +0000, Catalin Marinas wrote:
> > On Fri, Mar 07, 2025 at 07:36:31PM -0800, Kees Cook wrote:
> > > On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> > > > The optimized strscpy() and dentry_string_cmp() routines will read 8
> > > > unaligned bytes at a time via the function read_word_at_a_time(), but
> > > > this is incompatible with MTE which will fault on a partially invalid
> > > > read. The attributes on read_word_at_a_time() that disable KASAN are
> > > > invisible to the CPU so they have no effect on MTE. Let's fix the
> > > > bug for now by disabling the optimizations if the kernel is built
> > > > with HW tag-based KASAN and consider improvements for followup changes.
> > > 
> > > Why is faulting on a partially invalid read a problem? It's still
> > > invalid, so ... it should fault, yes? What am I missing?
> > 
> > read_word_at_a_time() is used to read 8 bytes, potentially unaligned and
> > beyond the end of string. The has_zero() function is then used to check
> > where the string ends. For this uses, I think we can go with
> > load_unaligned_zeropad() which handles a potential fault and pads the
> > rest with zeroes.
> 
> If we only care about synchronous and asymmetric modes, that should be
> possible, but that won't work in asynchronous mode. In asynchronous mode
> the fault will accumulate into TFSR and will be detected later
> asynchronously where it cannot be related to its source and fixed up.
> 
> That means that both read_word_at_a_time() and load_unaligned_zeropad()
> are dodgy in async mode.

load_unaligned_zeropad() has a __mte_enable_tco_async() call to set
PSTATE.TCO if in async mode, so that's covered. read_word_at_a_time() is
indeed busted and I've had Vincezo's patches for a couple of years
already, they just never made it to the list.

> Can we somehow hang this off ARCH_HAS_SUBPAGE_FAULTS?

We could, though that was mostly for user-space faults while in-kernel
we'd only need something similar if KASAN_HW_TAGS.

> ... and is there anything else that deliberately makes accesses that
> could straddle objects?

So far we only came across load_unaligned_zeropad() and
read_word_at_a_time(). I'm not aware of anything else.

-- 
Catalin

