Return-Path: <linux-fsdevel+bounces-43669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3EFA5A3E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAFE17407A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A423644E;
	Mon, 10 Mar 2025 19:37:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0572356CC;
	Mon, 10 Mar 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635464; cv=none; b=f09Z+QxytirLFmSe4+cCwWXKpQ47PoOBR3aKG833jwyWFeyl9IKb2uIhG7sn3Ullq0tycS9gIvv9NVqoYRoM5aDd+sjsp3ZYUQ6017W+5xcojctji9kucHQLfJiz525TmZs2dX5FXxfYq4CAZKhIRpxlJmUz6hGXZpwnFopHV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635464; c=relaxed/simple;
	bh=c1iYrSO8Kd/12THIxsVRKDsAM0Bj4Yao50BlyA3CgBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr6wJ87uhj6dXvwYVxAM8dKmaUlUMmmqt6xllOd0gjQETRNLzzOj8MZkNznn+LBEISL6tcHrXzVIKgyLv0PinomdJA+fsVhBrez7pET/bZ7G7L74cFCyoyg+x6yV/GPaZ1uw5oQeBufRBqSSCa7OLsigDztwGBpcSAa4tARd1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8194A152B;
	Mon, 10 Mar 2025 12:37:52 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B96A83F694;
	Mon, 10 Mar 2025 12:37:38 -0700 (PDT)
Date: Mon, 10 Mar 2025 19:37:32 +0000
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
Message-ID: <Z88_fFgr23_EtHMf@J2N7QTR9R3>
References: <20250308023314.3981455-1-pcc@google.com>
 <202503071927.1A795821A@keescook>
 <Z88jbhobIz2yWBbJ@arm.com>
 <Z88r5qFLOSo0itaq@J2N7QTR9R3.cambridge.arm.com>
 <Z88yC7Oaj9DGaswc@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88yC7Oaj9DGaswc@arm.com>

On Mon, Mar 10, 2025 at 06:40:11PM +0000, Catalin Marinas wrote:
> On Mon, Mar 10, 2025 at 06:13:58PM +0000, Mark Rutland wrote:
> > On Mon, Mar 10, 2025 at 05:37:50PM +0000, Catalin Marinas wrote:
> > > On Fri, Mar 07, 2025 at 07:36:31PM -0800, Kees Cook wrote:
> > > > On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> > > > > The optimized strscpy() and dentry_string_cmp() routines will read 8
> > > > > unaligned bytes at a time via the function read_word_at_a_time(), but
> > > > > this is incompatible with MTE which will fault on a partially invalid
> > > > > read. The attributes on read_word_at_a_time() that disable KASAN are
> > > > > invisible to the CPU so they have no effect on MTE. Let's fix the
> > > > > bug for now by disabling the optimizations if the kernel is built
> > > > > with HW tag-based KASAN and consider improvements for followup changes.
> > > > 
> > > > Why is faulting on a partially invalid read a problem? It's still
> > > > invalid, so ... it should fault, yes? What am I missing?
> > > 
> > > read_word_at_a_time() is used to read 8 bytes, potentially unaligned and
> > > beyond the end of string. The has_zero() function is then used to check
> > > where the string ends. For this uses, I think we can go with
> > > load_unaligned_zeropad() which handles a potential fault and pads the
> > > rest with zeroes.
> > 
> > If we only care about synchronous and asymmetric modes, that should be
> > possible, but that won't work in asynchronous mode. In asynchronous mode
> > the fault will accumulate into TFSR and will be detected later
> > asynchronously where it cannot be related to its source and fixed up.
> > 
> > That means that both read_word_at_a_time() and load_unaligned_zeropad()
> > are dodgy in async mode.
> 
> load_unaligned_zeropad() has a __mte_enable_tco_async() call to set
> PSTATE.TCO if in async mode, so that's covered. read_word_at_a_time() is
> indeed busted and I've had Vincezo's patches for a couple of years
> already, they just never made it to the list.

Sorry, I missed the __mte_{enable,disable}_tco_async() calls. So long as
we're happy to omit the check in that case, that's fine.

I was worried that ex_handler_load_unaligned_zeropad() might not do the
right thing in response to a tag check fault (e.g. access the wrong 8
bytes), but it looks as though that's ok due to the way it generates the
offset and the aligned pointer.

If load_unaligned_zeropad() is handed a string that starts with an
unexpected tag (and even if that starts off aligned),
ex_handler_load_unaligned_zeropad() will access that and cause another
tag check fault, which will be reported.

Mark.

