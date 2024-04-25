Return-Path: <linux-fsdevel+bounces-17831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3968B29AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB6D281E20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277F615381B;
	Thu, 25 Apr 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lPp7XSJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D015351C;
	Thu, 25 Apr 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076681; cv=none; b=MMTYBaxtS39hzrxzvmMAD2Ge8Pt6eJq34iEr5wKtF4eNx0wyOsFAGwMqCZti2iFbHeNuT/95aGrDVYPzS6PqAlN/1cwiMClVOmOO1qKMeIL5EtgIDtso0eEvyiE6qykONE6V9iD9qNDqsQj8HkfosQS4gJ41CYzP6u25BlKcoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076681; c=relaxed/simple;
	bh=t6MvdvHbsofObq/f2/jeAEInKWwAadopbL4fZZZ0i0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E913dmKVFu5FfkWw5w8OHzCcP0runs6f7+SsJ3V4aBoqgz/KePBm7yQF3ZvSXURNioELAL8rXFmg3Daviy8ykDM2MRtrYxs0XqV3+dN4iRwBXauG7W7RkLaVLEcapOWVgg9PKGQVKv7rUVxyFBv5f26LWPTOg3ofkcgDuWd4/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lPp7XSJg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aPI+REeR7ehD8uzT6D6XxnDHOJihS/G4o6C/kIyX9uM=; b=lPp7XSJgb/pOL8V98kRsv6/EMT
	VnAqT4WFX66hgjwwHp579W67Kn5pgqbXose2hro4ga/tmMpIvCjzPxkkszCs62Rjn5NJZ4q2NtHGg
	0fwyAVq3Fx/4Z77NG5R5bl9iphq8ysrV98J5TRiOYw0V0mmdDqwN/FW2vmuagAn45zyNLEgyPxVWo
	Na6lmOD/qa0TAIMy/XB4XbH1kM8arNUL2Jj8e5p2Oc4rX8Z3W3uLhQtF+UVnvXMIsdvKCQueKTBbS
	unv3oEdxTgSlktnSzxyRxn58CG9uqb30ArVUZqXybllM6te6cMMlaOvwB8XZj9580fYaE432aQW5v
	gdRmykOA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s05dx-00000003jQX-2rsR;
	Thu, 25 Apr 2024 20:24:33 +0000
Date: Thu, 25 Apr 2024 21:24:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 06/11] filemap: cap PTE range to be created to i_size
 in folio_map_range()
Message-ID: <Ziq8ATyM_c5zEOkd@casper.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-7-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-7-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:41PM +0200, Pankaj Raghav (Samsung) wrote:
>  	do {
>  		unsigned long end;
> +		unsigned long i_size;

Usually i_size is the name of a variable that contains an loff_t, not a
page count.  Not sure what to call this though.  Also, can't we move
this outside the loop?

	pgoff_t file_end = DIV_ROUND_UP(i_size_read(mapping->host),
					PAGE_SIZE) - 1;

	if (end_pgoff > file_end)
		end_pgoff = file_end;


