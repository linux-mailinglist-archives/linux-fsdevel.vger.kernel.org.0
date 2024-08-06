Return-Path: <linux-fsdevel+bounces-25073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980DF9489C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D6F1C23233
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 07:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244C166313;
	Tue,  6 Aug 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="unbbSOzo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F115FA72;
	Tue,  6 Aug 2024 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928029; cv=none; b=b+CXoUXIErQ7YiKtY2UhagwC/La44axodtVr2PXt4mHRqvsxI1I+3gDEZepXOpywWr9ap8MDaAyo3nyfv+WMd0JwoZi7ETvGe+G9JeD9M6w+nSOA1aLTrKyrkXLNBUuFwkU8U5og/UXBL3L7FYnlc6UVYDD4weQO3vul0o66yPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928029; c=relaxed/simple;
	bh=Kd9RZyd8Cx9jeGbceSUchY3xhyvcFczTBh/ypsuBa64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up86icRjrpN/YPVOqHxUlH7djejGDJ5JIMaIvezfb9UBSHSlE1JstzhZZSEiGK/XWzvZ2eYzhk4oKk4g+IQJCS2apEXIjAwKhSq7ZpiZrO7BHLUH+dg51esnO26qKzVOUy/LKtmtgvPspweltlpwdQsMPX3rb5K7zUek2LPz4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=unbbSOzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B40CC32786;
	Tue,  6 Aug 2024 07:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722928028;
	bh=Kd9RZyd8Cx9jeGbceSUchY3xhyvcFczTBh/ypsuBa64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unbbSOzoso4THNLMhmtdCBAOLCj0wWSRplx1Em8N/Nk2ZhFYyK5hxfvzR4dBS0B5e
	 oxmijPR/EkL3lFrS0KY3S+MfzVFTtRUl+20IfyMx5Io48KryfCHT2AoDxuiyNRn6Mg
	 iJjVPwhrEI7XR+o3zLHgO+g8+GMLoIF9Q8cYL4+0=
Date: Tue, 6 Aug 2024 09:07:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, maple-tree@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
Message-ID: <2024080635-neglector-isotope-ea98@gregkh>
References: <20240805100109.14367-1-rgbi3307@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805100109.14367-1-rgbi3307@gmail.com>

On Mon, Aug 05, 2024 at 07:01:09PM +0900, JaeJoon Jung wrote:
> Implementation of new Hash Tree [PATCH v2]
> ------------------------------------------
> Add spinlock.h and rcupdate.h in the include/linux/htree.h
> Add htree_root structue to interface locking.
> htree_root.ht_lock is spinlock_t to run spin_lock.
> htree_root.ht_first is __rcu type to access rcu API.
> Access the kernel standard API using macros.

Why?  What is going to use this?  What needs it?

> full source:
> ------------
> https://github.com/kernel-bz/htree.git
> 
> Manual(PDF):
> ------------
> https://github.com/kernel-bz/htree/blob/main/docs/htree-20240802.pdf

These obviously do not belong in a changelog text :(

