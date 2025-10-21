Return-Path: <linux-fsdevel+bounces-64942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEEEBF7456
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52FA1895F81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC523342CB2;
	Tue, 21 Oct 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXOdL9YH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC7242D7C;
	Tue, 21 Oct 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059349; cv=none; b=P52A8ZXz+t1HrXIS8PKqLlXQqEkV+f3r/Op7CiTY9ISG7dgyzvu8yFDjUbBgmWP2Cg9VK8WRQbmbZ9moT2uinPcCKuyMieZrEcbWaFGwuMZYCJXxvJwS7pC/A/5wqz99KLWxl6jAw1GLfaq7C5Ek9wvZiFw2je8c40YSti9b5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059349; c=relaxed/simple;
	bh=Xk4Lp8qVguRdNJEnylB5z9zbgHn7Y64gu99Lcgdv1Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7KhtnH+pzMfQrQ2V8SRXYt+iatyHhk/JnBjYldQak9TJ4YJYl74nQmw4Bq+9qX4uNovP9FqGEGkmhoQIsVPJQ1DDjvBZF/J/rXIVEqKxglSSNU63KbJ0qwlblH+xdKrhxyRWE7a9aYt4pRBneDh44G5lTIp7x1w3TNZ4+qSg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXOdL9YH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D819DC4CEF1;
	Tue, 21 Oct 2025 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761059349;
	bh=Xk4Lp8qVguRdNJEnylB5z9zbgHn7Y64gu99Lcgdv1Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXOdL9YHBxATL4p08Cc7K6ZZIhXKrxUt6CVqlILZs5vnyJ4IpKBQBIc1Nk8GFh/T+
	 fCiN4TsRYpMRuBi1ULaw4ztF8i3VlxwxUHD+S42OOE1yHL7jtDjLs31KW/0P7RcSKD
	 67UzyvEilxAWPBDJZekVRIYYuq1FzG9SrzV3Xk+oZbKHNRoVH0zbhbTRYdgzHiapM1
	 R/oNv1qAWHEMW9+WvEUGJoZtFnN0gJru1Xxe6jaNqHK+QGvGyLb1MtAqM1VK/Wh9jV
	 SFGV05bviyVxsZLr++4n4lM8snh8oAZOjBpe/+2YF1Vr0cUW/lAvDnjd6Kzd1SKbeD
	 ZqBqEmWMy/PQg==
Date: Tue, 21 Oct 2025 08:09:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: ecryptfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	Tyler Hicks <code@tyhicks.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: Use MD5 library instead of crypto_shash
Message-ID: <20251021150901.GA1644@quark>
References: <20251011200010.193140-1-ebiggers@kernel.org>
 <20251021-uferpromenade-fachpersonal-70469a562891@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-uferpromenade-fachpersonal-70469a562891@brauner>

On Tue, Oct 21, 2025 at 02:27:47PM +0200, Christian Brauner wrote:
> On Sat, Oct 11, 2025 at 01:00:10PM -0700, Eric Biggers wrote:
> > eCryptfs uses MD5 for a couple unusual purposes: to "mix" the key into
> > the IVs for file contents encryption (similar to ESSIV), and to prepend
> > some key-dependent bytes to the plaintext when encrypting filenames
> > (which is useless since eCryptfs encrypts the filenames with ECB).
> > 
> > Currently, eCryptfs computes these MD5 hashes using the crypto_shash
> > API.  Update it to instead use the MD5 library API.  This is simpler and
> > faster: the library doesn't require memory allocations, can't fail, and
> > provides direct access to MD5 without overhead such as indirect calls.
> > 
> > To preserve the existing behavior of eCryptfs support being disabled
> > when the kernel is booted with "fips=1", make ecryptfs_get_tree() check
> > fips_enabled itself.  Previously it relied on crypto_alloc_shash("md5")
> > failing.  I don't know for sure that this is actually needed; e.g., it
> > could be argued that eCryptfs's use of MD5 isn't for a security purpose
> > as far as FIPS is concerned.  But this preserves the existing behavior.
> > 
> > Tested by verifying that an existing eCryptfs can still be mounted with
> > a kernel that has this commit, with all the files matching.  Also tested
> > creating a filesystem with this commit and mounting+reading it without.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> > 
> > I can take this through the libcrypto tree if no one else volunteers.
> > (It looks like eCryptfs doesn't have an active git tree anymore.)
> 
> Thanks, but not need, fixes for orphaned fses (that have valid acks) are
> taken through a VFS tree.

Sounds good, thanks!

- Eric

