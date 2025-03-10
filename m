Return-Path: <linux-fsdevel+bounces-43650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C5A59F4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEEA3A787A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9A232378;
	Mon, 10 Mar 2025 17:37:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736301DE89C;
	Mon, 10 Mar 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628275; cv=none; b=FL7eztX3ETWKgc+NNm7DWwhVdzbR22B/owME1Jlk4TYYXt8p56UpUG//kYHxoJCF6zsMP9OZ0WWm6ArGgm9kCnoxIP5kJIdpIOUKBSD8yr+T0QBnui95aFtK0cWqljhGZA/0ZEd5pLnuj0PcNJH6K5+M2zAEsFWVa1ZjBGgMGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628275; c=relaxed/simple;
	bh=RGwv37QAnQo/a2wz5AMKCuLUSQ01Tyu2yE4BPDzoJK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LabITKIJTb7k3K7elEzWFGuLMl7kuY7ZuD6s9xWJU35Ny6o5rIr8E0MvswCdleqxqHQjU0GQTKjHPENOMPsTsIbZzwuqlU7aRSSouSrJlqGFE4Cjgl3CerW1LTPXSSyIcc95AbIPK0tjgeUPiM8ATZoXzjNo5apS2lmDUQ90MtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D57C4CEE5;
	Mon, 10 Mar 2025 17:37:52 +0000 (UTC)
Date: Mon, 10 Mar 2025 17:37:50 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kees Cook <kees@kernel.org>
Cc: Peter Collingbourne <pcc@google.com>,
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
Message-ID: <Z88jbhobIz2yWBbJ@arm.com>
References: <20250308023314.3981455-1-pcc@google.com>
 <202503071927.1A795821A@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503071927.1A795821A@keescook>

On Fri, Mar 07, 2025 at 07:36:31PM -0800, Kees Cook wrote:
> On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> > The optimized strscpy() and dentry_string_cmp() routines will read 8
> > unaligned bytes at a time via the function read_word_at_a_time(), but
> > this is incompatible with MTE which will fault on a partially invalid
> > read. The attributes on read_word_at_a_time() that disable KASAN are
> > invisible to the CPU so they have no effect on MTE. Let's fix the
> > bug for now by disabling the optimizations if the kernel is built
> > with HW tag-based KASAN and consider improvements for followup changes.
> 
> Why is faulting on a partially invalid read a problem? It's still
> invalid, so ... it should fault, yes? What am I missing?

read_word_at_a_time() is used to read 8 bytes, potentially unaligned and
beyond the end of string. The has_zero() function is then used to check
where the string ends. For this uses, I think we can go with
load_unaligned_zeropad() which handles a potential fault and pads the
rest with zeroes.

> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
> > Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> > Cc: stable@vger.kernel.org
> > ---
> >  fs/dcache.c  | 2 +-
> >  lib/string.c | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> Why are DCACHE_WORD_ACCESS and HAVE_EFFICIENT_UNALIGNED_ACCESS separate
> things? I can see at least one place where it's directly tied:
> 
> arch/arm/Kconfig:58:    select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS

DCACHE_WORD_ACCESS requires load_unaligned_zeropad() which handles the
faults. For some reason, read_word_at_a_time() doesn't expect to fault
and it is only used with HAVE_EFFICIENT_UNALIGNED_ACCESS. I guess arm32
only enabled load_unaligned_zeropad() on hardware that supports
efficient unaligned accesses (v6 onwards), hence the dependency.

> Would it make sense to sort this out so that KASAN_HW_TAGS can be taken
> into account at the Kconfig level instead?

I don't think we should play with config options but rather sort out the
fault path (load_unaligned_zeropad) or disable MTE temporarily. I'd go
with the former as long as read_word_at_a_time() is only used for
strings in conjunction with has_zero(). I haven't checked.

-- 
Catalin

