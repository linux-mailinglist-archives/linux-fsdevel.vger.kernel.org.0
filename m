Return-Path: <linux-fsdevel+bounces-17652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23918B108F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C111C2307B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14316D30F;
	Wed, 24 Apr 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYZbtrXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560C158867;
	Wed, 24 Apr 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978098; cv=none; b=A5cUUPGCMGxSEIqtdAH35OgbS+LL6HE5sV6oGMh5EIUKc+qbC4kATsAq4GQM+WeI4Mb2VQfnIjxhSJnkDbYTCfs4jZx3ll/70Ho35tevR6/RjVDfmIbiaJeWVoiZzUuDEl8MLAsFuXREB/kb5yth+MACJPWthYa+iuZcXkDEvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978098; c=relaxed/simple;
	bh=w988jo+lIUr9L/JqmZ0jDECyv0nP7HP9YfsgJRNVM+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIZ1ApcQ9YqUp7YEKkr9KpWD+++Lddr3Wk5p8zQHoCFw1aK3sEGqxWKkLEfK5d6GOrLHQPjv6T1piyTomf3ZkbZSADBTdqjnFKEUn+08l0Bh9qZhKZyZ/LjSBSAStdT0OiLNvPiEin6uolojCRLrAYw1heb98+4brBWK5cPdZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYZbtrXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEA6C113CD;
	Wed, 24 Apr 2024 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713978098;
	bh=w988jo+lIUr9L/JqmZ0jDECyv0nP7HP9YfsgJRNVM+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYZbtrXFw6s2q521SVjMf/a/7XcxfIULZpFDzfe3iAg6hdL7puQMEyCQxbUScImLR
	 I552oFPpodbHQ9brM1Dvq/w5WKI6m2pmXFO51XpHq/E7l4r8pro/VDnClsbSH1JePU
	 dAxYjVgvpwdlDlMHpqk2niS4YOvRvukk7KRgdzD9O2Ypu0WDhGXNAD0zA2mmhmpo+Z
	 yHMNt967CpBPmsoAaSGO2wG8TfZ/0u+I4AgCRC63k+8ay/VbT2JOYoUB3JxzFxNaop
	 siVcEN+TaWsmOR4nyqgcr6bRMFOweTxI5BcdXSycrepUrQ9egYvnANKNBSWQNzmCPs
	 9aLABcyhAHEGw==
Date: Wed, 24 Apr 2024 19:01:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
Message-ID: <20240424-befund-unantastbar-9b0154bec6e7@brauner>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403021808.309900-1-vinicius.gomes@intel.com>

On Tue, Apr 02, 2024 at 07:18:05PM -0700, Vinicius Costa Gomes wrote:
> Hi,
> 
> Changes from RFC v3:
>  - Removed the warning "fixes" patches, as they could hide potencial
>    bugs (Christian Brauner);
>  - Added "cred-specific" macros (Christian Brauner), from my side,
>    added a few '_' to the guards to signify that the newly introduced
>    helper macros are preferred.
>  - Changed a few guard() to scoped_guard() to fix the clang (17.0.6)
>    compilation error about 'goto' bypassing variable initialization;
> 
> Link to RFC v3:
> 
> https://lore.kernel.org/r/20240216051640.197378-1-vinicius.gomes@intel.com/
> 
> Changes from RFC v2:
>  - Added separate patches for the warnings for the discarded const
>    when using the cleanup macros: one for DEFINE_GUARD() and one for
>    DEFINE_LOCK_GUARD_1() (I am uncertain if it's better to squash them
>    together);
>  - Reordered the series so the backing file patch is the first user of
>    the introduced helpers (Amir Goldstein);
>  - Change the definition of the cleanup "class" from a GUARD to a
>    LOCK_GUARD_1, which defines an implicit container, that allows us
>    to remove some variable declarations to store the overriden
>    credentials (Amir Goldstein);
>  - Replaced most of the uses of scoped_guard() with guard(), to reduce
>    the code churn, the remaining ones I wasn't sure if I was changing
>    the behavior: either they were nested (overrides "inside"
>    overrides) or something calls current_cred() (Amir Goldstein).
> 
> New questions:
>  - The backing file callbacks are now called with the "light"
>    overriden credentials, so they are kind of restricted in what they
>    can do with their credentials, is this acceptable in general?

Until we grow additional users, I think yes. Just needs to be
documented.

>  - in ovl_rename() I had to manually call the "light" the overrides,
>    both using the guard() macro or using the non-light version causes
>    the workload to crash the kernel. I still have to investigate why
>    this is happening. Hints are appreciated.

Do you have a reproducer? Do you have a splat from dmesg?

