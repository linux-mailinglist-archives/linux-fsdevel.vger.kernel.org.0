Return-Path: <linux-fsdevel+bounces-74286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C7D38D26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 08:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 962953008195
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0B313E25;
	Sat, 17 Jan 2026 07:51:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A727587D
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768636282; cv=none; b=lMdQ7OQR5DSSMhzloB1EXZ2fqvTEuBFwgd3OC2YsrLiN7WWuTDaPlAL7vOt6EUWe3qsLLPsaE185s09vUjgznTBDWd8gKMzzS7/NXJYfyeCZA2TMJ18OWCZ8tOaMm2SR/G8EQEbmZiyBYGUNSgkZa3IW5b8duMDd8a+9w8kVXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768636282; c=relaxed/simple;
	bh=xGWmbbHEz37esijLKgHG072ZsNAyyfux5OMMi34ejZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj3HVw27wayj9V7nVngfQz0sbI7K8sqb3kWyffjjJKJ3sjwULmAM4pJWWID4r09fggYQXvixifV1jT+85U/RhynTSywKGVa5frm1wkXm7U5pO+j4Kk2BJDh8YK2PaSS8F8YuRpIy9s+uZe+BWUSLmcBD/wOBexwxIJR6tK9AE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id CCD91E02D1;
	Sat, 17 Jan 2026 08:51:12 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Sat, 17 Jan 2026 08:51:12 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com
Subject: Re: [PATCH v1 0/3] fuse: clean up offset and page count calculations
Message-ID: <aWs-4Dzih8bYVeLI@fedora>
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116235606.2205801-1-joannelkoong@gmail.com>

On Fri, Jan 16, 2026 at 03:56:03PM -0800, Joanne Koong wrote:
> This patchset aims to improve code clarity by using standard kernel helper
> macros for common calculations:
>  * DIV_ROUND_UP() for page count calculations
>  * offset_in_folio() for large folio offset calculations
>  * offset_in_page() for page offset calculations
> 
> These helpers improve readability and consistency with patterns used
> elsewhere in the kernel. No functional changes intended.
> 
> This patchset is on top of Jingbo's patch in [1].
> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jefflexu@linux.alibaba.com/
> 
> Joanne Koong (3):
>   fuse: use DIV_ROUND_UP() for page count calculations
>   fuse: use offset_in_folio() for large folio offset calculations
>   fuse: use offset_in_page() for page offset calculations
> 
>  fs/fuse/dev.c     | 14 +++++++-------
>  fs/fuse/file.c    |  2 +-
>  fs/fuse/readdir.c |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> -- 
> 2.47.3
>

Looks good to me.

Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>

