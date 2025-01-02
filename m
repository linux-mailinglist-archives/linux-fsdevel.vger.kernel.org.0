Return-Path: <linux-fsdevel+bounces-38349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C9A00117
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 23:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71D23A3991
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4D1BBBC4;
	Thu,  2 Jan 2025 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fGu0rQ/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B721487E1;
	Thu,  2 Jan 2025 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855817; cv=none; b=gYzMjfEQAdjtG0f0tXyOdrnxJaRhVtpS4ikY3bLFnbA3BtMxGsmMycXGuNV1l/CA4Bo/mmpHUCIXdlk76wCaDm8Maa05JJsZ8kM3R8ai/tW76OY1NVJ9wiVO8bgTXLotshCrMqZ2U6FgYTVXAjn0bgyos38V/nYcbCl7ChWDApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855817; c=relaxed/simple;
	bh=Op4QZsPD+mTAb796tVFKrpeJJG0x3oacxyD2i+fwgrs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RlszSNnt2FMxFYtuos8ggrmWx2fmEMMjbMWy727G9VtUq7wqiQ32gP5+4FnJz2U+ZYwpD4fCJAhJ00uxoBVcbZEqGFmiXwFI1O8Vbt/HyPkZXxQefjkR2mNO9zozBVl8+/g8OqjOK7dAMpb2M1w25KMS+NgelRhrDJPMax0FRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fGu0rQ/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5FFC4CED0;
	Thu,  2 Jan 2025 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735855816;
	bh=Op4QZsPD+mTAb796tVFKrpeJJG0x3oacxyD2i+fwgrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fGu0rQ/VQFtFCzJwHVuAD0Ld+u+M+CNUwur8gQsCzoOm/1VZrYO0xfrM2v9fO7naz
	 w3CI1Rsa8vKeYws8Qa/jnP4s2rgPcjac6vJkAP+Qlab/aOpt1/r9xXGR9QCQi4+CIn
	 seis59pc8XEirl6BWuUYGRw3MdpkvG0727rKDvb0=
Date: Thu, 2 Jan 2025 14:10:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Marco Nelissen <marco.nelissen@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] filemap: avoid truncating 64-bit offset to 32 bits
Message-Id: <20250102141015.bc8ef069a91cfd9664538494@linux-foundation.org>
In-Reply-To: <20250102190540.1356838-1-marco.nelissen@gmail.com>
References: <20250102190540.1356838-1-marco.nelissen@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jan 2025 11:04:11 -0800 Marco Nelissen <marco.nelissen@gmail.com> wrote:

> on 32-bit kernels, folio_seek_hole_data() was inadvertently truncating a
> 64-bit value to 32 bits, leading to a possible infinite loop when writing
> to an xfs filesystem.
> 
> ...
>
> +++ b/mm/filemap.c
> @@ -3005,7 +3005,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
>  		if (ops->is_partially_uptodate(folio, offset, bsz) ==
>  							seek_data)
>  			break;
> -		start = (start + bsz) & ~(bsz - 1);
> +		start = (start + bsz) & ~((u64)bsz - 1);
>  		offset += bsz;
>  	} while (offset < folio_size(folio));
>  unlock:

Thanks.  I'll add

Fixes: 54fa39ac2e00b ("iomap: use mapping_seek_hole_data")
Cc: <stable@vger.kernel.org>

The

	offset = offset_in_folio(folio, start) & ~(bsz - 1);

a few lines earlier is worrisome.  I wonder if we should simply make
`bsz' and `offset' have type u64 and sleep well at night.

