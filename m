Return-Path: <linux-fsdevel+bounces-37988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D72F9F9CB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 23:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7410A16BE32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BFA227565;
	Fri, 20 Dec 2024 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JD8uPrOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E43155342;
	Fri, 20 Dec 2024 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734733185; cv=none; b=S7eMsu5PKs0jxMFo3wre62wMyQCNMj3R/e64iP46ETOfIdD/mS/h1d0bZ6tACCQU4TUr/0z9c4U62VpKRtbki6QFnFszxscBlO480f9Ap+G7FwqBMAl72PaBq6L9LNbs/RdYi6DA75FMY60LkVgSkXSoX9MeLK/7Df1gNs+awJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734733185; c=relaxed/simple;
	bh=YxgJqPKaNgBjWRHZz2knk1IKZ9j6M+BCC2f+qx3AzU8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YDWCuCTp6KpiNQPlbav2752fpPo4SwZUWrtmpPzYBfmnc1+o/52SxkfCzoVC4U8o3FUVCisYGU7R1RheHN8ZG8oiMXocJSS2v5MOufNaIc12z1MPqM0eHPIl06pGVEvUbEBnZFZFnU3jLHrQ9n69Ss2q6XOqZ0xPQSzJWfh1TD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JD8uPrOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91206C4CECD;
	Fri, 20 Dec 2024 22:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734733184;
	bh=YxgJqPKaNgBjWRHZz2knk1IKZ9j6M+BCC2f+qx3AzU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JD8uPrOsIrfU0+gnjrEvbD3R5+22Tw//QTdEDJNMrDYX0UhTzp96U2T6IR3iVaY7T
	 e3E05HzJbi93CCiT1Xh3PMZ/ZXG12ospk/P0GXtyLI3vgk7VyBMCNpx7aWwR7rnbGT
	 4xIHqGOwiFJRXXU2E5FRH2nG1hnvmGBhStp9cPPY=
Date: Fri, 20 Dec 2024 14:19:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
Message-Id: <20241220141943.8e63906eb73da5f29979eae7@linux-foundation.org>
In-Reply-To: <7a9355eb-810d-4f5b-90ed-bf4f4ae7e161@squashfs.org.uk>
References: <20241216162701.57549-1-willy@infradead.org>
	<20241216162701.57549-5-willy@infradead.org>
	<ac706104-4d78-4534-8542-706f88caa4b7@squashfs.org.uk>
	<Z2W2Z2Tq4WMNluWU@casper.infradead.org>
	<7a9355eb-810d-4f5b-90ed-bf4f4ae7e161@squashfs.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 18:42:57 +0000 Phillip Lougher <phillip@squashfs.org.uk> wrote:

> 
> 
> On 20/12/2024 18:24, Matthew Wilcox wrote:
> > On Fri, Dec 20, 2024 at 06:19:35PM +0000, Phillip Lougher wrote:
> >>> @@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
> >>>    			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
> >>>    		struct folio *push_folio;
> >>>    		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
> >>> +		bool filled = false;
> > 
> > ahh, this should have been filled = true (if the folio is already
> > uptodate, then it has been filled).  Or maybe it'd be less confusing if
> > we named the bool 'uptodate'.
> > 
> > Would you like me to submit a fresh set of patches, or will you fix
> > these two bugs up?
> > 
> > Thanks for testing!
> 
> Np.
> 
> Andrew Morton is kindly handling Squashfs patch submission to Linus for me,
> and so I can't easily fix them up.
> 
> Andrew what you like done here please?

I think a v2 series would be best, please.

