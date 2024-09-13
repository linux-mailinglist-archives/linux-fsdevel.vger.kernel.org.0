Return-Path: <linux-fsdevel+bounces-29286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DDA977AB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51D3B259B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3941D58A8;
	Fri, 13 Sep 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABuq6HTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415E13D625;
	Fri, 13 Sep 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215092; cv=none; b=cb4wJzSvyRAVbya+q1djdHCzl8iwvdRnftI1DgxYgRG2NSBD0m7zl68HRmGPLD5+gf+PMuXbP8tS574y+GBuChGLGGZ+m7n1saArhHl96c2HS1KLV6LX5Nlm8dbV6ESTz2vj7Vg83vGaF1R50rXC8VD5PawvaEdiFlp9MjG/SpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215092; c=relaxed/simple;
	bh=AIKqGRT9z6TNOCU+Dxb1n/JCJbKQDW7PvIqp4JjiXGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bukgTim3gaciBhKkYCCfdRfYot4nYMLfbRwmAUtgN+WNCb3o/r3+jZK2+zjmSY7eDtnsz+Ubo80BsWFP+uIANlIZgoIhAxUwmo1jmP5tqmdhGoz2ORkGuqq+1uJlUCQopsbG/8NqKBA/+eJ7SUnFduiWa2fPEfrflBBT1u08r6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABuq6HTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AE4C4CEC0;
	Fri, 13 Sep 2024 08:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726215091;
	bh=AIKqGRT9z6TNOCU+Dxb1n/JCJbKQDW7PvIqp4JjiXGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABuq6HTxG/iCyFHmWishG138K96W6MpO9djxA1czxjfbuBBFg4fDWZalwjTT/Ae2X
	 DWgrcLEmjYeVBCN0EjfMQqCW8seJCMNFrBwMzKPfH9zVT2bJH46HMcMxf/fDYeFzXh
	 rGD7wuYjid9mqiRrj33ANoH0PtOXXxlffRaSKk4ZLTGrA5Rrrc29SxlhIf10xheaLN
	 KTMz7yicy16S+Cb0Hlt1B+34FFadTpdOIKsgDIIQ+9uMP6aoVR0CO052BVkx0x/BOv
	 fwAy+8AxdcAY9AcKl6fMrETWjDIHulvF1ymp4ha85lGM+68rrgWyRO9QrDh5jM0vhK
	 3VBqQGOjfPj3A==
Date: Fri, 13 Sep 2024 10:11:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [netfs] a05b682d49:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <20240913-felsen-nervig-7ea082a2702c@brauner>
References: <202409131438.3f225fbf-oliver.sang@intel.com>
 <1263138.1726214359@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1263138.1726214359@warthog.procyon.org.uk>

On Fri, Sep 13, 2024 at 08:59:19AM GMT, David Howells wrote:
> Can you try with the attached change?  It'll get folded into Christian's
> vfs.netfs branch at some point.

The fix you pasted below is already applied and folded into vfs.netfs.
But what the kernel test robot tested was an old version of that branch.

The commit hash that kernel test robot tested was:

commit: a05b682d498a81ca12f1dd964f06f3aec48af595 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

but in vfs.netfs we have:
cd0277ed0c188dd40e7744e89299af7b78831ca4  ("netfs: Use new folio_queue data type and iterator instead of xarray iter")

and the diff between the two is:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 84a517a0189d..97003155bfac 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1026,7 +1026,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
                iov_offset += part;
                extracted += part;

-               *pages = folio_page(folio, offset % PAGE_SIZE);
+               *pages = folio_page(folio, offset / PAGE_SIZE);
                get_page(*pages);
                pages++;
                maxpages--;

So this is a bug report for an old version of vfs.netfs.

> 
> David
> ---
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 84a517a0189d..97003155bfac 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1026,7 +1026,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
>  		iov_offset += part;
>  		extracted += part;
>  
> -		*pages = folio_page(folio, offset % PAGE_SIZE);
> +		*pages = folio_page(folio, offset / PAGE_SIZE);
>  		get_page(*pages);
>  		pages++;
>  		maxpages--;
> 

