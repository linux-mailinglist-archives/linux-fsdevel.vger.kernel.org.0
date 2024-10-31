Return-Path: <linux-fsdevel+bounces-33356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F40A9B7C72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 15:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FF41F2168C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638E21A070D;
	Thu, 31 Oct 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWx7oxo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA097483;
	Thu, 31 Oct 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383779; cv=none; b=CJvhdfB1xtiDVoFhCSNsptOefBeKaHvFCkT/xH2RZCpSr4R2Z6o3YMsOq82328Gc7Ua43lkz2yoo7tcxI5nTjHx/x4cIDma0Z+RXDTqDbza892gfv2HU16rextfWFBgLIXrN4WoEOQkF3Lv/3gGkcXj5n/VTGNS3H56d2g69zM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383779; c=relaxed/simple;
	bh=4ceT/iOIGZcSpJVdW0LWOwHAcJw2b/1T7CPx9IuqL/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duuy7hsPl5u43/k5F1X6F3TYdauMGex4K8j/RjGTL/wlRK7UncS9KHnnvzlgpfpaOTWsKji8zVNnD6SVs9V+59xs1z9iV4W1CkJkN77PknsI6yEJJBliEeN5Gu79rxZD0RgPbCDjMC7uQ0SzY6qkk4MI94SdKd/FagNdxSsXGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWx7oxo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB0AC4FF78;
	Thu, 31 Oct 2024 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383779;
	bh=4ceT/iOIGZcSpJVdW0LWOwHAcJw2b/1T7CPx9IuqL/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWx7oxo/BWefgupPnyVBFF4EVpoLomBSGE9ciTgQZWG4GP58bKIm6HsqHGAB0Vui1
	 xfij0CepoVPLYF+ZkexuvOYQBFhjW+zsTDfelI7ZWd8BpJ0g6HfhEbA+83IrD91ikc
	 OBOtukngbNprUkkarKpY5+yHCncE6aK4voihvs58+3qw37vJe9ciMzsO+dAnnRtAGL
	 lWFrUikZ78NpdHv5TlXgAdrGOopyN+ei8Nlh6bgbB0VinjdKUD1L91zAPfQ+TQR0KR
	 TSJdpHzsba7ExepK7DBbR5XMkPZp/MiZ19Lzq9cxbB3Esmy5FdC1fe+9FCpR/yrBWW
	 gTyIpMoDfYUGw==
Date: Thu, 31 Oct 2024 15:08:56 +0100
From: Joel Granados <joel.granados@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	netfilter-devel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, 
	pablo@netfilter.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kees@kernel.org, mcgrof@kernel.org, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 14/14] net: sysctl: introduce sysctl
 SYSCTL_FIVE
Message-ID: <qnrzl4tjlgw5rzlvxavr3pt7fhkslnm4dd62q7uqzb3mfoa2jg@fuayx77rfcs6>
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>

On Mon, Oct 21, 2024 at 11:59:10PM +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Add SYSCTL_FIVE for new AccECN feedback modes of net.ipv4.tcp_ecn.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/sysctl.h | 17 +++++++++--------
>  kernel/sysctl.c        |  3 ++-
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index aa4c6d44aaa0..37c95a70c10e 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -37,21 +37,22 @@ struct ctl_table_root;
>  struct ctl_table_header;
>  struct ctl_dir;
>  
> -/* Keep the same order as in fs/proc/proc_sysctl.c */
> +/* Keep the same order as in kernel/sysctl.c */
>  #define SYSCTL_ZERO			((void *)&sysctl_vals[0])
>  #define SYSCTL_ONE			((void *)&sysctl_vals[1])
>  #define SYSCTL_TWO			((void *)&sysctl_vals[2])
>  #define SYSCTL_THREE			((void *)&sysctl_vals[3])
>  #define SYSCTL_FOUR			((void *)&sysctl_vals[4])
> -#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
> -#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
> -#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
> -#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
> -#define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
> +#define SYSCTL_FIVE			((void *)&sysctl_vals[5])
Is it necessary to insert the value instead of appending it to the end
of sysctl_vals? I would actually consider Paolo Abeni's suggestion to
just use a constant if you are using it only in one place.

> +#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[6])
> +#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[7])
> +#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[8])
> +#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[9])
> +#define SYSCTL_INT_MAX			((void *)&sysctl_vals[10])
>  
>  /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
> -#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
> -#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[11])
> +#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[11])
> +#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[12])
>  
>  extern const int sysctl_vals[];
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48..68b6ca67a0c6 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -82,7 +82,8 @@
>  #endif
>  
>  /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
> +const int sysctl_vals[] = { 0, 1, 2, 3, 4, 5, 100, 200, 1000, 3000, INT_MAX,
> +			   65535, -1 };
>  EXPORT_SYMBOL(sysctl_vals);
>  
>  const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
> -- 
> 2.34.1
> 

-- 

Joel Granados

