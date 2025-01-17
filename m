Return-Path: <linux-fsdevel+bounces-39474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE132A14C9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 10:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32671188BD20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39AC1FCFC1;
	Fri, 17 Jan 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR7rTmvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E01FBC99;
	Fri, 17 Jan 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107720; cv=none; b=HSjmaH5GtLOf03XrfwRR5qe7JkHTc8LvHHgu9A/PZK27Qni4FpUL6IRZITFw55V+r7Gke6jOA3FAjx0pcqspBogRwM/E8Wtb/xSJGbVUR+dQQyfvbZjpImPP1ZlQOyQZznvHdmuP4Xf8LEPOCpnlzKKeP2LUV74UirMMVmlF+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107720; c=relaxed/simple;
	bh=b2+5I4Ol2pXJvkBZ25q9n0ksWds8r5RzMGcUkZNXIng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMMUTgiQA0fOBYP+TcDzey7guNED6Za1VllrGmrkDlngth5FeeOZQIys/2yfQV6y+vv3NjL1Hd1/WSnw+YQHjKS9NXAodRuwyeJbUVg5AgigUwOSUye2muRzzl1dZqz87U4tl2PRSFK1tElJI7Y/l8Pyv74hcRVwGD0powZ6++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR7rTmvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A99C4CEDD;
	Fri, 17 Jan 2025 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737107719;
	bh=b2+5I4Ol2pXJvkBZ25q9n0ksWds8r5RzMGcUkZNXIng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vR7rTmvchnyfzF5H2XyPp+s5v4UNzLMt8hLgNgt0BW9Av3EJtMTzYNgzU8yBYQf6O
	 MJ2az8kCy+MMGnAQM3b0/4sOVDdU5hd4bwn+kCZRAcL9IIgc/L6LYaz0Jcac90tBUY
	 XSiwKHtvtallUo+yeHR18MAlGtVbe84A4/kWJypY7x7QNSELNudlnMiqd95GL2WpyC
	 nvjxxXZsVKR75XEyCu62Yp+i0UWzN9vrcIMM22DUkBDucC5HmEE9ABy4ZeFP/4awU2
	 bNWXqLsaqYQFUf4U/ETOqNBv3TfJhoLm+PBLt7l5Sx1S4OiORnc1D+Yjs/J/CX8xG+
	 2JiCJfr4mNPZQ==
Date: Fri, 17 Jan 2025 10:55:14 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kees@kernel.org, j.granados@samsung.com, willy@infradead.org, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, 
	haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, 
	dchinner@redhat.com, bfoster@redhat.com, souravpanda@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, pasha.tatashin@soleen.com, david@redhat.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, yang@os.amperecomputing.com, 
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com, 
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH v5 -next 11/16] sunrpc: simplify
 rpcauth_cache_shrink_count()
Message-ID: <cvhm3wxsuzptwhensumidxykuzgzzhp4u3ypwv4sicmssznxzk@xwfwpjclkzrf>
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
 <20250111070751.2588654-12-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111070751.2588654-12-yukaixiong@huawei.com>

On Sat, Jan 11, 2025 at 03:07:46PM +0800, Kaixiong Yu wrote:
> It is inappropriate to use sysctl_vfs_cache_pressure here.
> The sysctl is documented as: This percentage value controls
> the tendency of the kernel to reclaim the memory which is used
> for caching of directory and inode objects.
> 
> So, simplify result of rpcauth_cache_shrink_count() to
> "return number_cred_unused;".
> 
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
> v4:
>  - Simplify result of rpcauth_cache_shrink_count().
> ---
> ---
>  net/sunrpc/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 04534ea537c8..5a827afd8e3b 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -489,7 +489,7 @@ static unsigned long
>  rpcauth_cache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  
>  {
> -	return number_cred_unused * sysctl_vfs_cache_pressure / 100;
> +	return number_cred_unused;
This one is not related to the "moving sysctls out of kenrel/sysctl.c"
but I'll keep it here because of the Acks received.


>  }
>  
>  static void
> -- 
> 2.34.1
> 

-- 

Joel Granados

