Return-Path: <linux-fsdevel+bounces-74440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49579D3AB74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6B003043FF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811A837BE63;
	Mon, 19 Jan 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ppE7BImW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C335B15F;
	Mon, 19 Jan 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832135; cv=none; b=fn5VkhYeVnGPnkA77c921JYUBOfNmFG/Ej/jTb5Ce4uxfD/9iHwAnsL5U2rSinwkhTE/EioJADC7JWiPvwKSV7M8neS/lAs7vmfkVlBNTO+CmQG/4szOaqE/TevULKJKyPE5OrvNYtxuqaAof4tWbKntA2r2vYtNqfTQQFaqOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832135; c=relaxed/simple;
	bh=JYvWH8YTbJlSun0TV+bSElZPcT0OtlFL33wmou6fm6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxIuXPQ4oVDe1/QCPyfoPOIrrNTj/HFdqO1d0pyw/7zoyUEeMLGlFwG99qXSJH+6F/g+HXysNDqZLm7GbqqCkRL8oBNJBZJUfDX2Tk7QOB3JYgMoUR1Ch4Op9bsWi35RzjGEjgIuQpO2Yah6LtSAnxVVh7aEF3jdMg0hLEuX5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ppE7BImW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9xgRfJpL28zXK/+9Mu0NkoRr9adKwzNEuyYL6hfZRhI=; b=ppE7BImW71CsJWjLVHwbleqLui
	SBUUNKziZnjCMKOroDlbZbRX7b2F15jXDrTclVlwPrKAny6Zfmno1y49CaWUDxPVOGsp1lWDIX3wA
	aLo5w5TkUAwOy+HYkY/MxnQ5nc1VO9KSHUMzYnDOY/yqhdBOuONkQSFy+HgB3etzRt4PHkFSC5+ID
	BJ9JyJ1DryXxZ3sxu1k85zRjFaShVdoAzKIShmvv0o9T/KA71mSV+W7fZPqpDFWLtxKFqxNr7cZpZ
	Eqjxg86c+e3BYlNc4xxVzr2UN7ce9TRkz+qiQ+D91UJ7mHz5ZdCmi8YVPLPIRizKtfynykkcHucy6
	3jw0GATw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhq2Q-0000000DOsr-1sAM;
	Mon, 19 Jan 2026 14:15:26 +0000
Date: Mon, 19 Jan 2026 14:15:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhiguo Zhou <zhiguo.zhou@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@kernel.org,
	gang.deng@intel.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, muchun.song@linux.dev,
	osalvador@suse.de, rppt@kernel.org, surenb@google.com,
	tianyou.li@intel.com, tim.c.chen@linux.intel.com, vbabka@suse.cz
Subject: Re: [PATCH v2 0/2] mm/readahead: batch folio insertion to improve
 performance
Message-ID: <aW48fk0IVus32QtW@casper.infradead.org>
References: <20260119065027.918085-1-zhiguo.zhou@intel.com>
 <20260119100301.922922-1-zhiguo.zhou@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119100301.922922-1-zhiguo.zhou@intel.com>

On Mon, Jan 19, 2026 at 06:02:57PM +0800, Zhiguo Zhou wrote:
> This patch series improves readahead performance by batching folio
> insertions into the page cache's xarray, reducing the cacheline transfers,
> and optimizing the execution efficiency in the critical section.

1. Don't resend patches immediately.  Wait for feedback.

2. Don't send v2 as a reply to v1.  New thread.

3. This is unutterably ugly.

4. Passing boolean parameters to functions is an antipattern.  You
never know at the caller site what 'true' or 'false' means.

5. Passing 'is_locked' is specifically an antipattern of its own.

6. You've EXPORTed a symbol that has no in-tree modular user.

7. Do you want to keep trying to do this or do you want me to do it
properly?  I don't have much patience for doing development by patch
feedback, not for something as sensitive as the page cache.

