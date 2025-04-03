Return-Path: <linux-fsdevel+bounces-45624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F09A7A062
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7DA1737E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318512459FA;
	Thu,  3 Apr 2025 09:47:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25F78F58;
	Thu,  3 Apr 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673653; cv=none; b=raKcqbzwCp4CyHwLKHr7CwCe2TlJmyNykkW6RXMSII7YiuDM7Vle4a9auTh/mLFmG6SgVac7BsFjpYnWGnOYHOfY2xSfteJLpjEIRdauwG2K4jS4PQcv9TVNlnb+qCd/yYB/woCxY2T1ARZOoJgjpWartk0rGyT+mUSiIDIGStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673653; c=relaxed/simple;
	bh=6zobr+z8sKB+pPfr/ot4tpcb6Bc4NQ/pj7nUWow2KRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlqvP5F2oYNVbNzlW18Iqir4iKkSRc5Z/1KSFU8W6K0CoOLDLCdo46U+FsXFDm9JZIvvcwas2cXQ7eqriQ646r4uvo+asN9MhvTQTN/n60dIX9RBQBnP1quvRbmYRpkylArqklvA6nNVB5I6NBFZ4u2/Nqab3XRd26giMnb1f50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFF5C4CEE3;
	Thu,  3 Apr 2025 09:47:30 +0000 (UTC)
Date: Thu, 3 Apr 2025 10:47:28 +0100
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
Subject: Re: [PATCH v5 1/2] string: Add load_unaligned_zeropad() code path to
 sized_strscpy()
Message-ID: <Z-5ZMOqhca_Z6FV7@arm.com>
References: <20250403000703.2584581-1-pcc@google.com>
 <20250403000703.2584581-2-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403000703.2584581-2-pcc@google.com>

On Wed, Apr 02, 2025 at 05:06:59PM -0700, Peter Collingbourne wrote:
> The call to read_word_at_a_time() in sized_strscpy() is problematic
> with MTE because it may trigger a tag check fault when reading
> across a tag granule (16 bytes) boundary. To make this code
> MTE compatible, let's start using load_unaligned_zeropad()
> on architectures where it is available (i.e. architectures that
> define CONFIG_DCACHE_WORD_ACCESS). Because load_unaligned_zeropad()
> takes care of page boundaries as well as tag granule boundaries,
> also disable the code preventing crossing page boundaries when using
> load_unaligned_zeropad().
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
> Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> Cc: stable@vger.kernel.org

Up to you if you want to keep the panic behaviour on unmapped pages.
Either way:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

