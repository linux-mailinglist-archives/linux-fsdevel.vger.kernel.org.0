Return-Path: <linux-fsdevel+bounces-14967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234A885912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0700D284782
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A777605F;
	Thu, 21 Mar 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQyIRrAB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE3576038;
	Thu, 21 Mar 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023992; cv=none; b=L4kpe7tWTQIhfsFVnccxHByhazlcvpWfpCRMrcN8Nf6xwKfL/xAbW8OLWlwrfk32+Ja9VkCZkKmHjgTLkCz6s5rqspGpLah6H5Xbxgz/JF7kZamyM8Dq2Vr8u3gzqevWtxXHJ6YqJ0CpKhVns76k6P4l0B4xtQL5nMKArT7v4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023992; c=relaxed/simple;
	bh=etOfsEzc1Kvmi7gMW+x+zHAqeY096Eoe+GEihPldJm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afiihtN024vLksRFDhTP3qZ2EzF/z2GOSykvUtp0++VsG9cMnZsLSa/Za+80X2VmiDHKBzMpIAT1ZyT156pHaiygguYrvSFWx0X3gFABlLZLUBmnRgrAqqu2wKq2OVVMtYRBpxZovnSGyulEE3UiLriNG1knXtuTda8zVPJY88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KQyIRrAB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P90udbt6DsGYuVjZV5zMYCt0yOohxZ0RgxbKXvtAJOI=; b=KQyIRrABQ3o8kVkUh6u+am24hW
	wCB6slDWPHN5gydoo1jpNt9oCpTsp+VDZXRJEzEsvv5yNk2ly+OaeaKDrHVaWcwUBIfs2FcM+T6G2
	PBvc9j9kSHB4yVPUM3UuxzBTRJD2T5MhGAx7zjnZorN7a4BUt6OSAhLE9KQ9XB7QbiCk69D+VCIVs
	U0/rPFGKzL4SY9tqJvtqBHSaTgP3Lh9A2SDzsxJNWtc5DCQ/IuNqrWTbmGMfjFS26uZOFCmd+NlHO
	YkCnRU/nLH3JrMQLu68QUp8sqXUyJocFY6Lu18afQ7/zuQgLJvJRotQeSL0y27rtgC7k4Z6wlVd6S
	oPyNny+w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnHV5-00000006i2S-0afw;
	Thu, 21 Mar 2024 12:26:27 +0000
Date: Thu, 21 Mar 2024 12:26:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: aio: more folio conversion
Message-ID: <Zfwncw6NrQc6K6ki@casper.infradead.org>
References: <20240321082733.614329-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321082733.614329-1-wangkefeng.wang@huawei.com>

On Thu, Mar 21, 2024 at 04:27:30PM +0800, Kefeng Wang wrote:
> Convert to use folio throughout aio.

I see no problems here other than the one you mentioned and the minor
optimisation I pointed out.  Thanks.

