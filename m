Return-Path: <linux-fsdevel+bounces-46278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC8A860DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707181B86395
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A21F5851;
	Fri, 11 Apr 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy4x+GJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DCD1EB5D9;
	Fri, 11 Apr 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382273; cv=none; b=EsrXl1t3shSGeYDgqg7qnQc/Df3ONDJ/6v9dnPsN3bhbqg/Psi1WB/UkC+aCpmHqflEybcxGeGX2NMEImAZxp5j4Xal2kg39gh2ZaZyUvPSjDWZkrL1i3pVIlYcx/mkP4KDGjfm8erU6tJRnuIoui81fDw0h77pw1giPpxASz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382273; c=relaxed/simple;
	bh=BvMeTmdP0Kv4v4VAxguK+dk/XGGWH7c+tdnfidAXJCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgL3bK40ayPcirRSmTefFfwM7B7Se5Km8w+CFuxnxG3mNfuNDLXp8vz8lLOlpjKfXptHw7Hrk1y6jwrY+ONnWggr6xBPCyzcu3DS+efOJ7frCYpvJF2AK0UqFMLUwzjKjbaYaclpTqeEhZ4lrcALMO+XlB13KJOxo4opaNyAr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy4x+GJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80634C4CEE2;
	Fri, 11 Apr 2025 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744382272;
	bh=BvMeTmdP0Kv4v4VAxguK+dk/XGGWH7c+tdnfidAXJCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sy4x+GJIuxXO0ZtOnZL8rbmoG4HKTuXW4l56vHSIGhulKImCyoXe/9YR7xd6XWeJK
	 vEd/wiHYL+rUFUgaR7BwTSchhp7OXCjDUrvmblYpAYpI8RwSez9k4IYPmSyfblexU7
	 +fPBMtmODnub0bZu1DxzFFpfTZcJYNkSCDNQTXBBRzkn52j6HeGu4DavvJ/Jk0EaxC
	 0UsLZt9Yh369kKjlK/ZROjVyOh+AZcx0IjExgENo1cqhZ+/StVYmdeVWKh12d/kfSL
	 hURkEKb/5+WZy3wQ7mB2Een8CQU3Ee8gFJFlWV4/Ydsc7CmYcaqfbVqzQVviwJolSU
	 uunRB/X8mYdJA==
Date: Fri, 11 Apr 2025 16:37:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 3/5] fs/fs_parse: Fix 3 issues for
 validate_constant_table()
Message-ID: <20250411-beteuern-fusionieren-2a3d24f055d0@brauner>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
 <20250410-fix_fs-v1-3-7c14ccc8ebaa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410-fix_fs-v1-3-7c14ccc8ebaa@quicinc.com>

On Thu, Apr 10, 2025 at 07:45:29PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Constant table array array[] which must end with a empty entry and fix
> below issues for validate_constant_table(array, ARRAY_SIZE(array), ...):
> 
> - Always return wrong value for good constant table array which ends
>   with a empty entry.
> 
> - Imprecise error message for missorted case.
> 
> - Potential NULL pointer dereference.

I really dislike "potential NULL deref" without an explanation. Please
explain how this supposed NULL deref can happen.

> Fixes: 31d921c7fb96 ("vfs: Add configuration parser helpers")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  fs/fs_parser.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index e635a81e17d965df78ffef27f6885cd70996c6dd..ef7876340a917876bc40df9cdde9232204125a75 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -399,6 +399,9 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
>  	}
>  
>  	for (i = 0; i < tbl_size; i++) {
> +		if (!tbl[i].name && (i + 1 == tbl_size))
> +			break;
> +
>  		if (!tbl[i].name) {
>  			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
>  			good = false;
> @@ -411,13 +414,13 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
>  				good = false;
>  			}
>  			if (c > 0) {
> -				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
> +				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>%s\n",
>  				       i, tbl[i-1].name, tbl[i].name);
>  				good = false;
>  			}
>  		}
>  
> -		if (tbl[i].value != special &&
> +		if (tbl[i].name && tbl[i].value != special &&
>  		    (tbl[i].value < low || tbl[i].value > high)) {
>  			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
>  			       i, tbl[i].name, tbl[i].value, low, high);
> 
> -- 
> 2.34.1
> 

