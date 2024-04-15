Return-Path: <linux-fsdevel+bounces-16968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962588A5C14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 22:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67CB1C210BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DED156874;
	Mon, 15 Apr 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p9BtAhI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F95155A59;
	Mon, 15 Apr 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211854; cv=none; b=eSssNRoS3pyyP71W0r5bAI8kUaAgxcfcsbaK7cyEQWh3E69wpnePHKBJwukHTJ3whH9AiBN++uFP4q0uqunkFfLMbJkCRcSVZmVCehod/9CrHEmxg/bVFUGbBGA5sPcW/SfDfJjPN8x+9pJ4gPo/R+e1IqiePuQMXOMY/LIo6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211854; c=relaxed/simple;
	bh=aWdxYWRN/nBfBV1tH9YLKEGEQx3ZqnlPrMKuTLZAq1w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=stT7GNkOSoV0qiSbNii52fy0Yla38oSz2BkGzbQZ2LMcvOxIYX97gJgONHaRVgFQddxmIfgmK0hHwW/I/eZANm67QB3/TlU2zXwsU9R57bqDbZlf1HnE0uyO2UvNgu8PSDLhZt1M5aWuNrFWreV9nxidNREEM1Bz1LGoAnLc9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p9BtAhI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F884C2BD11;
	Mon, 15 Apr 2024 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713211853;
	bh=aWdxYWRN/nBfBV1tH9YLKEGEQx3ZqnlPrMKuTLZAq1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p9BtAhI638jOjA3IZmIfyUqBzRGmJKbdYK9m/p6+wipCIRpGZrdy6CgRuPY+mTq/C
	 IoAuc4UKAwfqKOxQKXEMbfsDiwTCWQ+Q7KueRDCueUAZzjvSwLGFzz8nxrvMr+Qja5
	 Pph7AZBKJFhNqJ5G+j0FJluDBpIJU1SK3kZFDmRM=
Date: Mon, 15 Apr 2024 13:10:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Long Li <leo.lilong@huawei.com>
Cc: <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
 <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [PATCH] xarray: inline xas_descend to improve performance
Message-Id: <20240415131053.051e60135eacf281df6921f6@linux-foundation.org>
In-Reply-To: <20240415012136.3636671-1-leo.lilong@huawei.com>
References: <20240415012136.3636671-1-leo.lilong@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 09:21:36 +0800 Long Li <leo.lilong@huawei.com> wrote:

> The commit 63b1898fffcd ("XArray: Disallow sibling entries of nodes")
> modified the xas_descend function in such a way that it was no longer
> being compiled as an inline function, because it increased the size of
> xas_descend(), and the compiler no longer optimizes it as inline. This
> had a negative impact on performance, xas_descend is called frequently
> to traverse downwards in the xarray tree, making it a hot function.
> 
> Inlining xas_descend has been shown to significantly improve performance
> by approximately 4.95% in the iozone write test.
> 
>   Machine: Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz
>   #iozone i 0 -i 1 -s 64g -r 16m -f /test/tmptest
> 
> Before this patch:
> 
>        kB    reclen    write   rewrite     read    reread
>  67108864     16384  2230080   3637689 6 315197   5496027
> 
> After this patch:
> 
>        kB    reclen    write   rewrite     read    reread
>  67108864     16384  2340360   3666175  6272401   5460782
> 
> Percentage change:
>                        4.95%     0.78%   -0.68%    -0.64%
> 
> This patch introduces inlining to the xas_descend function. While this
> change increases the size of lib/xarray.o, the performance gains in
> critical workloads make this an acceptable trade-off.
> 
> Size comparison before and after patch:
> .text		.data		.bss		file
> 0x3502		    0		   0		lib/xarray.o.before
> 0x3602		    0		   0		lib/xarray.o.after
> 
> ...
>
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -200,7 +200,7 @@ static void *xas_start(struct xa_state *xas)
>  	return entry;
>  }
>  
> -static void *xas_descend(struct xa_state *xas, struct xa_node *node)
> +static inline void *xas_descend(struct xa_state *xas, struct xa_node *node)
>  {
>  	unsigned int offset = get_offset(xas->xa_index, node);
>  	void *entry = xa_entry(xas->xa, node, offset);

I thought gcc nowadays treats `inline' as avisory and still makes up
its own mind?

Perhaps we should use __always_inline here?

