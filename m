Return-Path: <linux-fsdevel+bounces-44158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA0A63D02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 04:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03B1188EA50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 03:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2839207E19;
	Mon, 17 Mar 2025 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVkdirYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7361207E14
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742181765; cv=none; b=teG4vSO3KGxjNSkXrJkC6TZVpbCvrYqfz4mGzjafpinvD1SMi+Zav+TNxwHg4ETlBqQxZ+syCH9Bk5MBw557+yxAA4/mb0epmXRPZIjxtUmGvjFKFIQFQXX8Zy0GG/keF+dpCy/01tdY5OBcToZSK9gTvPe1R+9SlbgUi3zV1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742181765; c=relaxed/simple;
	bh=m+Un1YcguakIqu6hpaHxT/etPwm2QIAGZuR7yw9IWC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/iKqB4nVTIBzF39PmKiaXHJpugXkp1yD/0GrC0TPKDyp2cZ7U3Uuz2Ii99EoDbmCtgmZD92DkjKq7nTboWX3m6U9x+xeAdCbKUxyBOOVhfcUYFKKqMbXv+KyR6uACZLQk+/5MZ6vzoUlsj3ACMLV59PqdjpDqWfUPU8Ho7NdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pVkdirYH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vYT3SBm9OApcKhO8tAbEbIrDwgI7CdNQazUfl8IYf1w=; b=pVkdirYHfWLQaKIN7ktDZAhWTK
	MaLt54W36sDuBHMl6zI3wqQsNmqUlyvQRKHYQA9q03mSYnYh/HtGzAao5TLl56ZtOm8EfbkIbnivl
	3foYeY5J+4kbZM7udB5HwMuX2UzwpXIFklEMphnqCrESoPjBoFdTTFYvHCYSUGC5WXu05TNYe1BG2
	k2CFyueT54exsXAw7amrdIpcKsgZzEEr5wAHaf2LnIP9GLjF0z25uYmlmVwt4bNaPvPV3Odcd96Qq
	Hyj/8+Bm0VP+OHxVURQZVf4hPuqB6SMiyZWFyesjVzsWv7MpBAUtqt1GaH9Flq6AK+DbPrR3zAArn
	cR1mnB7A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tu13f-00000001Fxa-0NV9;
	Mon, 17 Mar 2025 03:22:31 +0000
Date: Mon, 17 Mar 2025 03:22:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Fan Ni <nifan.cxl@gmail.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 11/11] fs: Remove aops->writepage
Message-ID: <Z9eVdplZKs2XVB9J@casper.infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-12-willy@infradead.org>
 <Z9d2JH33sLeCuzfE@fan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9d2JH33sLeCuzfE@fan>

On Sun, Mar 16, 2025 at 06:08:52PM -0700, Fan Ni wrote:
> On Fri, Mar 07, 2025 at 01:54:11PM +0000, Matthew Wilcox (Oracle) wrote:
> > All callers and implementations are now removed, so remove the operation
> > and update the documentation to match.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> 
> Hi Matthew,
> 
> Tried to apply the remaining patches in the patchest (Patch 5-11)  which
> have not picked up by linux-next. It seems we have more to cleanup.
> 
> For example, I hit the following issue when try to compile
> ----------------------------------------------------------------
> drivers/gpu/drm/ttm/ttm_backup.c: In function ‘ttm_backup_backup_page’:
> drivers/gpu/drm/ttm/ttm_backup.c:139:39: error: ‘const struct address_space_operations’ has no member named ‘writepage’; did you mean ‘writepages’?
>   139 |                 ret = mapping->a_ops->writepage(folio_file_page(to_folio, idx), &wbc);

Looks like that was added to linux-next after I completed the removal of
->writepage.  Thomas, what's going on here?

