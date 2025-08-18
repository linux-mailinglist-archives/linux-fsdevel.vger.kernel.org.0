Return-Path: <linux-fsdevel+bounces-58144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731FB2A0C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6AD16DB90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EE926F296;
	Mon, 18 Aug 2025 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V503yscL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64555258EC7;
	Mon, 18 Aug 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517342; cv=none; b=nCAvllbieVOSV0Z4ZWnMD+USqBM/BGZwQWHL2ez6eAe48gVqPnvC41xeYiGCwfGqACN6O3iTXA79YmJ/79B2vd2zllbgPUtcS0wa1lR8rIuArWTS5ZLYm0pEz8DKYhmB/fi9ngQIBHw8LkxPZ6cIsapy/xR+y4IAgGzli0Sfffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517342; c=relaxed/simple;
	bh=oC5vZnztnlIcER5pgvEzBD+Ze82XllsXn8EMgCLpIMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaoyizuf7at6m0OhZDkAoGHoocACasfi49NF22CdHh9xZz9Yj2w8EAPy9H6k8FZYMHsmZzOys86w8buQ54dSKSpphWiSKHC3hk6LDgOdm4EDjcUGdwonulL9+blGkr9Jfq0PfNy6hnMWkHt3nQJhR0eN8Xgk+h4YlWAo9zC7MVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V503yscL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4822AC4CEEB;
	Mon, 18 Aug 2025 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755517342;
	bh=oC5vZnztnlIcER5pgvEzBD+Ze82XllsXn8EMgCLpIMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V503yscL+OdWMGhcI5jZ6ao7SgIQiZy5m9+pRerk16nT3qlNc1x+/59nlIqp+SP2v
	 7OkP1cuptCAOSnN5p601ml5vawmYA3jTQiM3XrokheL6rsAkafQmuGvgpAXzkCLlWG
	 Frd3rhr07h1EYMy/hSgMmZDS3h/iszFoOUo4YgS0=
Date: Mon, 18 Aug 2025 13:42:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wangzijie <wangzijie1@honor.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, adobriyan@gmail.com,
	rick.p.edgecombe@intel.com, ast@kernel.org, k.shutemov@gmail.com,
	jirislaby@kernel.org, linux-fsdevel@vger.kernel.org,
	polynomial-c@gmx.de, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v2] proc: fix missing pde_set_flags() for net proc files
Message-ID: <2025081810-hulk-polio-097b@gregkh>
References: <20250818112428.953835-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818112428.953835-1-wangzijie1@honor.com>

On Mon, Aug 18, 2025 at 07:24:28PM +0800, wangzijie wrote:
> To avoid potential UAF issues during module removal races, we use pde_set_flags()
> to save proc_ops flags in PDE itself before proc_register(), and then use
> pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.
> 
> However, the pde_set_flags() call was missing when creating net related proc files.
> This omission caused incorrect behavior which FMODE_LSEEK was being cleared
> inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].
> 
> Fix this by ensuring pde_set_flags() is called when register proc entry, and add
> NULL check for proc_ops in pde_set_flags().
> 
> [1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/
> 
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al)
> Reported-by: Lars Wendler <polynomial-c@gmx.de>
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
> v2:
> - followed by Jiri's suggestion to refractor code and reformat commit message
> ---
>  fs/proc/generic.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

