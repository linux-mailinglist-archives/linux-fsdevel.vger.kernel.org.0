Return-Path: <linux-fsdevel+bounces-42702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924FFA465E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A51142783F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9EB21D5A0;
	Wed, 26 Feb 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X9R6tMc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C321D587
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585018; cv=none; b=P1wCVD3Euo8pw4N6WvsrQdz+o29XJuFWuZjI7S8kKp5/rG9WqT4ck7A8i/FXz8OrvqbzuLbSb145FpH2NMjiUOS28kY42Tqx25Dhg48Dmu5WLiOZLLNBJwSam2Tp1+rl6YJITRcU2aOVPhUKmxFiNChiPtC5kTbb86VLO1DXbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585018; c=relaxed/simple;
	bh=7wquOLJ64CItLfTQ+ZYX7+VOg4jVc7P8pVnyDeuA0a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auRl3nsUxnfTx5s6yI7lTFgKdzCa1xBRALh75Jz46/ZrVgZjxaMsxJIP2kRa71u+e5SiklcN3C9aooACzvtowu/UWDcn5hUQhBoXlcoxy+6nk1Xl+SwKfvlbNHeY9L6Ov1tjdlh6xX92Mim8Q2LdBsc0MaveGO6sWG+UhchI8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X9R6tMc+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p6t2pXsT8L89RCnW7OioZG1B1/5FfU8lDVVMgwIFUyQ=; b=X9R6tMc+ZzS/9Y4FnM0jaBbG8n
	WxyTYn+kNw9Dv9xY2o7Gd76xaMUIGCBrTBSJXtAb9PSRXQh+BGaqZbJnhEwvZmOO67MpEhftMZwkm
	noQij/xjGF4ENF2YbJIiaUZO1dA/uryJ4LrGch/CjHA6QZwZdA3kbacdhDFkjHsqMMn2g9Nhv4y7S
	i9C/AbHhpjcViTsYdFl5SN2TWhUiYtyDeagYfyUQGOJuMZbk0UHDeF0elCHgQ8eUYMULElyk/tdRP
	62qjNQoPG8dUxCAKjw5Vt9odEzlNvwHnRagaxciJJAUc00JoSaelhy0NVOaR9WJbPH7tfDuHQjPwm
	AJKWjQZw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJfn-0000000FrNi-3UJ7;
	Wed, 26 Feb 2025 15:50:11 +0000
Date: Wed, 26 Feb 2025 15:50:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/9] orangefs: make open_for_read and open_for_write
 boolean
Message-ID: <Z784M93R_Job-UOm@casper.infradead.org>
References: <20250224180529.1916812-1-willy@infradead.org>
 <20250224180529.1916812-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224180529.1916812-4-willy@infradead.org>

On Mon, Feb 24, 2025 at 06:05:21PM +0000, Matthew Wilcox (Oracle) wrote:
>  fs/orangefs/file.c         | 4 ++--

please ignore vvv all those changes.

>  include/linux/mm_types.h   | 6 +++---
>  include/linux/nfs_page.h   | 2 +-
>  include/linux/page-flags.h | 6 +++---

I'll take them out locally in case I need to resend

