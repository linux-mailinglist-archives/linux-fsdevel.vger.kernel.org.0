Return-Path: <linux-fsdevel+bounces-50803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68D4ACFBC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F94C170CA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B91D5AC0;
	Fri,  6 Jun 2025 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Uxg0PR9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1242AF10
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749182245; cv=none; b=iGrrOOpPxKnLe7wB1ydQH4iK5Am/TLPia/Ya04pFvuBCfCfA8FRupA0TE6Z8UWseQNY8bwzmIqbx+6wkTPWixWRRYXJ3PsSGIH4xntGf+VrF2qLTlfmiKj1WvfqKm5sakdl1ip/vod/2U8gUH+AkZ6WLMZcLLlPgg/j2duw9eOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749182245; c=relaxed/simple;
	bh=GtvmLocDDMq65xiq8APfbBmVrUNMu6H13gsM1LJioyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1XkvSRH9oPC3Mr0JLHXuCu++VJPhbxKV6o9EmxrPlxmniTV6NyEJMIPTXNGx2EK9OKBPcMWSedWd8gX1t7WLBDdsI+yyGfOT1GvS7sdUi0lcOlJSaMBDiBOG8rpkypnHmSV/pvWOLXPD2LqMOfCyjeRHln41ruzZTDI824gNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Uxg0PR9x; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k0ZpaKaEy4ZuW+8wZR9+ETsHoQ2q1hye0L/hk7wG7nc=; b=Uxg0PR9xl2VOiZF/bejfRCJq1R
	Vc0UajE7ETfTzoQWndjX0V6G8WHNzQXp0Ez3/P8snZFH4OJ93+j8dKi5Rr8aZtAP09sRWWKlkCAIz
	Hbl0/j5/6WuSOeSDp684twzhJhCMBsCz+14b7ci/jOLnSGcAtKEaZUCN1Yw8NzFJQ+x87+ONbef0i
	bBVoeP7uI/b6SS/zIX2Roxn2/6sh8jUw0IV5byC5GzJd+6teUpQFKbcFzaiK/C31RloXMeguPJiid
	QHa6/4ybD4F3OFfAplFNewHlcqWPCJhw/lrLBkRMPA5A/bb1D1xCepxkhl3TM8t7qH8kKk/lnAWAu
	9WgU9uzw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNOCg-0000000BR1q-3LmW;
	Fri, 06 Jun 2025 03:57:14 +0000
Date: Fri, 6 Jun 2025 04:57:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: wangzijie <wangzijie1@honor.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, ast@kernel.org,
	kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent pde
Message-ID: <20250606035714.GP299672@ZenIV>
References: <20250606015621.GO299672@ZenIV>
 <20250606023735.1009957-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606023735.1009957-1-wangzijie1@honor.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 06, 2025 at 10:37:35AM +0800, wangzijie wrote:

> My bad for making this misbehavior, thank you for helping explain it.
> commit 654b33ada4ab("proc: fix UAF in proc_get_inode()") is in -stable, 
> I refered v1 just for showing race in rmmod scenario, it's my bad.

I still don't understand what's going on.  654b33ada4ab is both in
mainline and in stable, but proc_reg_open() is nowhere near the
shape your patch would imply.

The best reconstruction I can come up with is that an earlier patch
in whatever tree you are talking about has moved

        if (!pde->proc_ops->proc_lseek)
		file->f_mode &= ~FMODE_LSEEK;

down, separately into permanent and non-permanent cases, after use_pde()
in the latter case.  And the author of that earlier patch has moved
the check under if (open) in permanent case, which would warrant that
kind of fixup.

However,
	* why is that earlier patch sitting someplace that is *NOT*
in -next?
	* why bother with those games at all?  Just nick another bit
from pde->flags (let's call it PROC_ENTRY_proc_lseek for consistency
sake), set it in same pde_set_flags() where other flags are dealt with
and just turn that thing into
        if (!pde_has_proc_lseek(pde))
		file->f_mode &= ~FMODE_LSEEK;
leaving it where it is.  Less intrusive and easier to follow...

	Call it something like

check proc_lseek needs the same treatment as ones for proc_read_iter et.al.

and describe it as a gap in "proc: fix UAF in proc_get_inode()",
fixed in exact same manner...

