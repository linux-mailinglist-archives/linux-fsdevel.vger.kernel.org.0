Return-Path: <linux-fsdevel+bounces-43706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5DA5BFD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A4B173DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6A3255E3A;
	Tue, 11 Mar 2025 11:55:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1772221F10;
	Tue, 11 Mar 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694158; cv=none; b=TARmqLB7u1dpeig+Tm0blu9IXu4MfL/II0z47c7RjZh47pB0bp/rnUvBBYy+LcEe9krfksHqU/Scv73Qt0aEdJhE5sFeLOSQD04wXdpixbj4X6eDbSdehdsgGXwVeb+rEsXinHmAIR1gPqYlxjxR7Xo+mdwn3opKUhkkbyIcAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694158; c=relaxed/simple;
	bh=R6D6TLTMr0oW9Mj0KH3+YY8ScQKRFMhfTtqWwF7+U0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXRN/6f27gNAEaOrWDnjbSfAOqdZ8KVct899yFuWgWmQTdvNenVcTupA5S2v8eS1/OMjSDVL8L5IDm3eZRR0CvqoX+tL5N/SUlBm2VVQp8hNN3zR0j+lI9bFKvlNTfsv5SADehhrLOafnAeo+bumtTeytnfQInovGwiugrIPOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2722A152B;
	Tue, 11 Mar 2025 04:56:07 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00443F673;
	Tue, 11 Mar 2025 04:55:53 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:55:43 +0000
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
Message-ID: <Z9Akv6qQFfmYFReD@J2N7QTR9R3>
References: <20250308023314.3981455-1-pcc@google.com>
 <202503071927.1A795821A@keescook>
 <Z88jbhobIz2yWBbJ@arm.com>
 <Z88r5qFLOSo0itaq@J2N7QTR9R3.cambridge.arm.com>
 <Z88yC7Oaj9DGaswc@arm.com>
 <Z88_fFgr23_EtHMf@J2N7QTR9R3>
 <Z9AiUQdC4o0g8sxu@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9AiUQdC4o0g8sxu@arm.com>

On Tue, Mar 11, 2025 at 11:45:21AM +0000, Catalin Marinas wrote:
> On Mon, Mar 10, 2025 at 07:37:32PM +0000, Mark Rutland wrote:
> > I was worried that ex_handler_load_unaligned_zeropad() might not do the
> > right thing in response to a tag check fault (e.g. access the wrong 8
> > bytes), but it looks as though that's ok due to the way it generates the
> > offset and the aligned pointer.
> > 
> > If load_unaligned_zeropad() is handed a string that starts with an
> > unexpected tag (and even if that starts off aligned),
> > ex_handler_load_unaligned_zeropad() will access that and cause another
> > tag check fault, which will be reported.
> 
> Yes, it will report an async tag check fault on the
> exit_to_kernel_mode() path _if_ load_unaligned_zeropad() triggered the
> fault for other reasons (end of page).

Sorry, yes. The aligned case I mentioned shouldn't apply here.

> It's slightly inconsistent, we could set TCO for the async case in
> ex_handler_load_unaligned_zeropad() as well.

Yep, I think that'd be necessary for async mode.

> For sync checks, we'd get the first fault ending up in
> ex_handler_load_unaligned_zeropad() and a second tag check fault while
> processing the first. This ends up in do_tag_recovery and we disable
> tag checking after the report. Not ideal but not that bad.

Yep; that's what I was describing in the second paragraph above, though
I forgot to say that was assuming sync or asymm mode.

> We could adjust ex_handler_load_unaligned_zeropad() to return false if
> the pointer is already aligned but we need to check the semantics of
> load_unaligned_zeropad(), is it allowed to fault on the first byte?

IIUC today it's only expected to fault due to misalignment, and the
gneral expectation is that for a sequence of load_unaligned_zeropad()
calls, we should get at least one byte without faulting (for the NUL
terminator).

I reckon it'd be better to figure this out based on the ESR if possible.
Kristina's patches for MOPS would give us that.

Mark.

