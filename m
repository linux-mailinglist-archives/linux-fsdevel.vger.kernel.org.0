Return-Path: <linux-fsdevel+bounces-26696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91595B138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DAAB21C08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F95217A588;
	Thu, 22 Aug 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mspR5PAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F619470;
	Thu, 22 Aug 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317964; cv=none; b=s5xmfclwrYwcPncJEV9VTBhjUmrwEGGIcNenZXKXzJHtYly0R4kLvDxKAoUveF3lYRXBCEjLU60CFC+A2QFlI52sFneNVLchGN6HC3MYhdFN6HPR3labn4+FuHsiTYExI/JQUEatTqGPgLJifBix8K6FqAENeTW5b8qFhYObkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317964; c=relaxed/simple;
	bh=ErJiKEK5G37+dg2nUY77KorrfZ7TJOVu+eV+9xqhaIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo4cVvIVyNeBK6zprUyn1o0rFmmOL2minzdPJBEXBGwBPYmHxsgMSQRggz21ApAjXfqpNSCMqJCVJeOS0ua+S6vmfuwQuo54CnL3wpJnXEt3qAi9oEBXj4PXcDCcRrMMORE3cdSG8kWluKPI/aPo3rYbOJzLXzszGKp5OWNswlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mspR5PAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD35C4AF09;
	Thu, 22 Aug 2024 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724317964;
	bh=ErJiKEK5G37+dg2nUY77KorrfZ7TJOVu+eV+9xqhaIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mspR5PAs/louWx0dQ7mHXf1Jz07vLd++l6aP83SN8ptT/ZzHIoVkGhwb02bYY+ZRD
	 jrrRoyrou/Ug94C+9OWihAlMPjwdFOPbNnlYu9kVcjcv2JIlcU6SjbWiaY6uplJE8S
	 2uIVuvqjCcjMNQAABQdxbG6DaWMpCjnw1dvs4xWnYQIcvGRCBrKXSPdY9+EGibJjZZ
	 j5rkipBb4neoKNX5bsBnP6VILPyMYz7HHczHqoTS1gcAoI7Q0d6aO0mH1beKlnzuZA
	 dxSnrn7fmfixlDXy1N+t0YI7Vuwbvd2UzONDRBqvuaz+D6sAE+Wg9dQiKx+AWXgmbL
	 YOPnNQVVMRCCQ==
Date: Thu, 22 Aug 2024 11:12:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Seth Forshee <sforshee@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] mnt_idmapping: Use kmemdup_array instead of kmemdup
 for multiple allocation
Message-ID: <20240822-atmen-geopolitisch-1c3dfe9b1179@brauner>
References: <20240821091507.158463-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240821091507.158463-1-yujiaoliang@vivo.com>

On Wed, Aug 21, 2024 at 05:15:07PM GMT, Yu Jiaoliang wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
>  fs/mnt_idmapping.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 3c60f1eaca61..fea0244a87ce 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -228,9 +228,9 @@ static int copy_mnt_idmap(struct uid_gid_map *map_from,
>  		return 0;
>  	}
>  
> -	forward = kmemdup(map_from->forward,
> -			  nr_extents * sizeof(struct uid_gid_extent),
> -			  GFP_KERNEL_ACCOUNT);
> +	forward = kmemdup_array(map_from->forward, nr_extents,
> +				sizeof(struct uid_gid_extent),
> +				GFP_KERNEL_ACCOUNT);

Why did you only convert the forward array and not the reverse array?

