Return-Path: <linux-fsdevel+bounces-43652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D9A5A1DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0703AF254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291A3233D9D;
	Mon, 10 Mar 2025 18:14:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3157E2309B0;
	Mon, 10 Mar 2025 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630448; cv=none; b=M1vUKagsPc4+v2V/9gXPpl9htzQR4UFGzXXtaOt8m/VJnb10366Z4jCpf1hYluMqpHEdDXYgdVXYguTsFrriVUShPdcsQKiZyrDw2rVPrflpUS2eoWp1942/z4n+Dq0vkD9owGHl86tEif7JA8lkRD1fFWvmj33dpFccpbJznxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630448; c=relaxed/simple;
	bh=ezEtvSAQQtWgB42Sy/x7q5T+84ZtPQyPSPtg9T/meuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkK0ijLqN1/4T2gdZmDegEJBFtOd57lN4XLfytPOm8sVVsIpzBtxhhJcLlTV09UtT/NzL9bgnsPrmyKso2w1Z9dnFjqItb3XYvMXEaoF2LgkNSqtPuFZQsF2iQKj607acd4Y+aALqYLCuH0KfiLU6WDOpzEYEI7prT56I30qJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD4F9152B;
	Mon, 10 Mar 2025 11:14:17 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 295F43F673;
	Mon, 10 Mar 2025 11:14:04 -0700 (PDT)
Date: Mon, 10 Mar 2025 18:13:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <Z88r5qFLOSo0itaq@J2N7QTR9R3.cambridge.arm.com>
References: <20250308023314.3981455-1-pcc@google.com>
 <202503071927.1A795821A@keescook>
 <Z88jbhobIz2yWBbJ@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88jbhobIz2yWBbJ@arm.com>

On Mon, Mar 10, 2025 at 05:37:50PM +0000, Catalin Marinas wrote:
> On Fri, Mar 07, 2025 at 07:36:31PM -0800, Kees Cook wrote:
> > On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> > > The optimized strscpy() and dentry_string_cmp() routines will read 8
> > > unaligned bytes at a time via the function read_word_at_a_time(), but
> > > this is incompatible with MTE which will fault on a partially invalid
> > > read. The attributes on read_word_at_a_time() that disable KASAN are
> > > invisible to the CPU so they have no effect on MTE. Let's fix the
> > > bug for now by disabling the optimizations if the kernel is built
> > > with HW tag-based KASAN and consider improvements for followup changes.
> > 
> > Why is faulting on a partially invalid read a problem? It's still
> > invalid, so ... it should fault, yes? What am I missing?
> 
> read_word_at_a_time() is used to read 8 bytes, potentially unaligned and
> beyond the end of string. The has_zero() function is then used to check
> where the string ends. For this uses, I think we can go with
> load_unaligned_zeropad() which handles a potential fault and pads the
> rest with zeroes.

If we only care about synchronous and asymmetric modes, that should be
possible, but that won't work in asynchronous mode. In asynchronous mode
the fault will accumulate into TFSR and will be detected later
asynchronously where it cannot be related to its source and fixed up.

That means that both read_word_at_a_time() and load_unaligned_zeropad()
are dodgy in async mode.

Can we somehow hang this off ARCH_HAS_SUBPAGE_FAULTS?

... and is there anything else that deliberately makes accesses that
could straddle objects?

Mark.

