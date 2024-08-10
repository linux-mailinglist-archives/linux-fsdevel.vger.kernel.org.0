Return-Path: <linux-fsdevel+bounces-25601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15994DE81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 22:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D56282C1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 20:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A78013D62A;
	Sat, 10 Aug 2024 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SGSnLHds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A340870
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Aug 2024 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320380; cv=none; b=o58P22LZv/3XY/rFMVzKMY46Yfrdmri2l0ET+1DZuZYgJ69uo1OkMi8uwZFGbF4Massmlrm5hK0wTu2y4wKkxVYaxTuPA2CG3fFdqxxVdpwYfqg+iw5krzslyyb2l5L6wNG+k5XrgpYRYp7M4ooOpaNs5lbYS6qKx20cFjd6OfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320380; c=relaxed/simple;
	bh=0UjAByiaV0eB2+VMMPaN1Ny7thgGU+R/zZJgYCdJrHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA3LDvE7nXZXXX72t4dw0GQgfP32lZkObHcfI+0jktixI6gxedFCYCtB5Qdcturfn7Jmva4T+1PACy2yJCKk5t36Ekc8IFM+cMXSzj9vzxq/5uCoqpPb/U2UJbt0ATjr0HyZwgTM4RuFd1jrwT2c2jCr+ytBgV3IItXyic4yCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SGSnLHds; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 10 Aug 2024 16:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723320375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LeBZWdCN8kSjWpt8gCYfww5FgSViw1IoXXV04Dmrz5A=;
	b=SGSnLHds2uCnmW+s/Jl74nsI9Kufhm4WPqMtbPpxLZBre627GhymsJy4iZ4TLnRul0CdZd
	Jyqu/D1jQjwF5XlcyN+WlNqs8NFbrJhwfdchBj/9FOsQy6gV5kLqMC5n89zf2eU0sYmj0U
	+9qp7Sy67xX825xo6qiqRGmNjHT2LYM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v3 14/16] bcachefs: add pre-content fsnotify hook to fault
Message-ID: <vcolzzrnlun6rrtm54bnrwd4cwlhz2n2xfc25jkkxfk56q5de2@3j44632t4z63>
References: <cover.1723228772.git.josef@toxicpanda.com>
 <b3fc6d63e23626033ff2764a82d3e20a059ac8a4.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fc6d63e23626033ff2764a82d3e20a059ac8a4.1723228772.git.josef@toxicpanda.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 09, 2024 at 02:44:22PM GMT, Josef Bacik wrote:
> bcachefs has its own locking around filemap_fault, so we have to make
> sure we do the fsnotify hook before the locking.  Add the check to emit
> the event before the locking and return VM_FAULT_RETRY to retrigger the
> fault once the event has been emitted.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

Josef, are you testing this on bcachefs as well? I'll get you an account
for my CI if you want it (which has automated tests for more than
bcachefs).

> ---
>  fs/bcachefs/fs-io-pagecache.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
> index a9cc5cad9cc9..1fa1f1ac48c8 100644
> --- a/fs/bcachefs/fs-io-pagecache.c
> +++ b/fs/bcachefs/fs-io-pagecache.c
> @@ -570,6 +570,10 @@ vm_fault_t bch2_page_fault(struct vm_fault *vmf)
>  	if (fdm == mapping)
>  		return VM_FAULT_SIGBUS;
>  
> +	ret = filemap_maybe_emit_fsnotify_event(vmf);
> +	if (unlikely(ret))
> +		return ret;
> +
>  	/* Lock ordering: */
>  	if (fdm > mapping) {
>  		struct bch_inode_info *fdm_host = to_bch_ei(fdm->host);
> -- 
> 2.43.0
> 

