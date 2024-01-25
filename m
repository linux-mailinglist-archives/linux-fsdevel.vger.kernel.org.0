Return-Path: <linux-fsdevel+bounces-8835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B751683B780
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 04:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5751E1F24E9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 03:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD386127;
	Thu, 25 Jan 2024 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2MBZ2Ii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337721866;
	Thu, 25 Jan 2024 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151933; cv=none; b=bTOG1bKS2di8QiPTvi2y0neyqSAOmj+OQZLMwq5j/pue3Oi9Unn3kVYdCzC6a5/hfzzBBYX3wCwhtBf5hBL4wXt/BsQAmryGHDR2hYWlDMDcbLd8rdDce42550pBgGP34TighvVXQ6mwYBgpPO6GQViQvBbjKEYd8Ur3Nj9fi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151933; c=relaxed/simple;
	bh=k/lcg2zazVrlN5kWliEtrgP95ZsgX1rocgc1aIdg3L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNK5Iy7zKFOaceyOREpECHlEbCqWXkj9gPcb8MWJNN4NvjWzrySlxv05dYXEatYhdiBsMRV2RXJNedtO0NOfW8AgcOLjYRLk8gsJfy5i75WJg9ebks3zHOCDGnHmE5NOXZRfbiFXtaOqVGNNv8gioNosOsVsBoEwwVP26+Cbux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2MBZ2Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F35DC433F1;
	Thu, 25 Jan 2024 03:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706151932;
	bh=k/lcg2zazVrlN5kWliEtrgP95ZsgX1rocgc1aIdg3L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2MBZ2Ii8noSNTJIR9GJXA/gpybC54e7/5EkfmuEekhstUGgZBwcYYV7cn5pvnmFj
	 mnI91/Enut3AM5eLngfH35zaZXbp/aaoypZPhVJ1csin1MBrgy1J8zlfKF6RkWFC4H
	 1038qtJRm8ANP8twzH7GGrGr1boqXCBxtwCCkVX2qDaZgUvmE9Z8jwz9/ByhXw8OLI
	 bCXBsupFXihzmYcAyHi5K8rxJiuj3XFotYLULPttjSAmSl9fQQP418LAvDWHBG04Yf
	 xqvaNZ/pqPLly+hnluO8JNn141QNZl3ge17G7QrHsO/LGe6z9UlDV48Tf6fyK8j3je
	 HFIW9zCxGXjDg==
Date: Wed, 24 Jan 2024 19:05:30 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH v3 02/10] fscrypt: Share code between functions that
 prepare lookup
Message-ID: <20240125030530.GB52073@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-3-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119184742.31088-3-krisman@suse.de>

On Fri, Jan 19, 2024 at 03:47:34PM -0300, Gabriel Krisman Bertazi wrote:
> To make the patch simpler, we now call fscrypt_get_encryption_info twice
> for fscrypt_prepare_lookup, once inside fscrypt_setup_filename and once
> inside fscrypt_prepare_lookup_dentry.  It seems safe to do, and
> considering it will bail early in the second lookup and most lookups
> should go to the dcache anyway, it doesn't seem problematic for
> performance.  In addition, we add a function call for the unencrypted
> case, also during lookup.

Unfortunately I don't think it's correct.  This is basically undoing my fix
b01531db6cec ("fscrypt: fix race where ->lookup() marks plaintext dentry as
ciphertext") from several years ago.

When a lookup is done, the filesystem needs to either treat the name being
looked up as a no-key name *or* as a regular name, depending on whether the
directory's key is present.  We shouldn't enable race conditions where, due to
the key being concurrently added, the name is treated as a no-key name for
filename matching purposes but a regular name for dentry validation purposes.
That can result in an anomaly where a file that exists ends up with a negative
dentry that doesn't get invalidated.

Basically, the boolean fscrypt_name::is_nokey_name that's produced by
fscrypt_setup_filename() should continue to be propagated to DCACHE_NOKEY_NAME.

- Eric

