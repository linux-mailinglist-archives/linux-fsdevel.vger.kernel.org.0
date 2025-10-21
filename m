Return-Path: <linux-fsdevel+bounces-64914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A371BF6718
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551EC19A386C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67F3128D3;
	Tue, 21 Oct 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF4rgRzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3E1DC988;
	Tue, 21 Oct 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049671; cv=none; b=J6nBHO0mz6xs54Po0islJMa1R516/7tX4sINgTzb8dy1Ui9JN1o1ZIw7a0tMpGSLuUGw24JmAYEWd46LGGHrItSeQ8Dotsy/+lhxUw1VcKbH+WUPRgTKIUKFdFqq4iZ4/2l0blzVIPWeTLIOWhNOISto/28G8Zj69M2TvRS5RkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049671; c=relaxed/simple;
	bh=cpFOH12+xB0EZH6KKI6aTNG01Psbzr7rxs134yqW9pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOJufCURWM1bMH9MO/FTvC8DFnIebwAGlIFF9yt2/4YEEBV6qDX2fa08a2MwbtNRF5Iqq4dz3PX90oX8zeU35kS2Akrs97qYRPyRtB+lSuMBHpVLkbnXDZ7w3YTlewdqjaWQ9zLGQ9i0ocUqjw56JMqcJFlwLT842zVCIEhgpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF4rgRzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D07C4CEF1;
	Tue, 21 Oct 2025 12:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761049670;
	bh=cpFOH12+xB0EZH6KKI6aTNG01Psbzr7rxs134yqW9pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uF4rgRzBbtiuYdq9OIhom1iFAbTLHCKmiIfgHaJQagh2NIVSvbKxqvUxUk+QjAftA
	 dKlCBFHd3nQhRp3uZAqC2ZkywK2z56NJFk5pcYzdSJ+PCG02iVCJbhQXDPe2xoiZP3
	 h3IPK92qWZZrJlkcLvuMZ+meY6t8H2vJfdtkHdAaAFo7j1F53mxwW8i9jJ2N0XRwVg
	 p100QFKX9XFyoYeV6PpifsdHUCLCoBVb8LzdpPuFjOa1kRXOtUqIqTSeb+XuSk6LBT
	 m89G1riuxH8/AFZ2x1/9+vQW4Fss/qFS8+yQg8ecqBDpbVwm7DfxAtCOKxAQ4sG+yA
	 4ffAojBEC6LMg==
Date: Tue, 21 Oct 2025 14:27:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: ecryptfs@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Tyler Hicks <code@tyhicks.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: Use MD5 library instead of crypto_shash
Message-ID: <20251021-uferpromenade-fachpersonal-70469a562891@brauner>
References: <20251011200010.193140-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251011200010.193140-1-ebiggers@kernel.org>

On Sat, Oct 11, 2025 at 01:00:10PM -0700, Eric Biggers wrote:
> eCryptfs uses MD5 for a couple unusual purposes: to "mix" the key into
> the IVs for file contents encryption (similar to ESSIV), and to prepend
> some key-dependent bytes to the plaintext when encrypting filenames
> (which is useless since eCryptfs encrypts the filenames with ECB).
> 
> Currently, eCryptfs computes these MD5 hashes using the crypto_shash
> API.  Update it to instead use the MD5 library API.  This is simpler and
> faster: the library doesn't require memory allocations, can't fail, and
> provides direct access to MD5 without overhead such as indirect calls.
> 
> To preserve the existing behavior of eCryptfs support being disabled
> when the kernel is booted with "fips=1", make ecryptfs_get_tree() check
> fips_enabled itself.  Previously it relied on crypto_alloc_shash("md5")
> failing.  I don't know for sure that this is actually needed; e.g., it
> could be argued that eCryptfs's use of MD5 isn't for a security purpose
> as far as FIPS is concerned.  But this preserves the existing behavior.
> 
> Tested by verifying that an existing eCryptfs can still be mounted with
> a kernel that has this commit, with all the files matching.  Also tested
> creating a filesystem with this commit and mounting+reading it without.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> I can take this through the libcrypto tree if no one else volunteers.
> (It looks like eCryptfs doesn't have an active git tree anymore.)

Thanks, but not need, fixes for orphaned fses (that have valid acks) are
taken through a VFS tree.

