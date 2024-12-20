Return-Path: <linux-fsdevel+bounces-37967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945A69F961D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E208716900B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42F21A43B;
	Fri, 20 Dec 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qe6QYvwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F1219A77;
	Fri, 20 Dec 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711173; cv=none; b=AvQG0LZ90ZQq74FTmzS2pwM5MLtAiYsm2M9Uv7FbpqyV/Pp89GWbEzpVmC38Tup6Baid+XIUgclqKDUAjrWDhCUQ8QrVM7mD4ReQ0/T1qI4VePG492MZh3nWBxHPtAw/SBaQNE7edxzTdh/mgvOq7xbECGc+CmicTdBr+/31QsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711173; c=relaxed/simple;
	bh=EAZVlz+eB9EhgHrp68xF8YHCbJIfz3nSjgR0stHRoCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZroSqmqq8cFPO5k2oQDMfbNB6MiEaDZUc37z/CNGjXHqWL3fqCiUzvnmCtqt/T5TOyZI6paUJls1N1GV7CRe1LffIqE6C8Gg0aspb1saGEENE+SxTwdTWQv0lk5+UgKFXHmYsvunqODoJKYBliU5mc3kgt00PblqgWUTNo+3S4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qe6QYvwN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iib20JIEZQCKW7Pf9wUzbD+GySObznQR8lUwX6YqtOI=; b=qe6QYvwNnTfDr3EwuLlD5oiZtl
	sH+K4TyhgezWkyEwGXeIN6YJ+6W6qd4MgK7WNMwvkHs1mfCS7YD/VfQ2Z7cI0iw6o9jWY/KdHlJX0
	cFppFy/LE6AHSNBiTwzrsOv4F8cySwyocCqSTz0ofbLUDSBmHtx4mYvtpmq2kt13qcbneSFODoPll
	yPCooJ8FuBYPFirUxNsgX5MZb8pifKxC5rWtCLxdnIK30d+2+tpjQuTy3oTl0KKqZigCN5mchSOji
	6EDURIdjtj6bXDxsKkfq+pGGnvq52uZxwtAzqa9xbCACWEp/sEG2LPzWEKL38bIOMA8GnKNwLBj5K
	FQcnRy+g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOfcP-00000001YNl-11yh;
	Fri, 20 Dec 2024 16:12:49 +0000
Date: Fri, 20 Dec 2024 16:12:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, kirill@shutemov.name,
	bfoster@redhat.com,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 03/12] mm/readahead: add folio allocation helper
Message-ID: <Z2WXgUQ0QfCBra6i@casper.infradead.org>
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154831.1086649-4-axboe@kernel.dk>

On Fri, Dec 20, 2024 at 08:47:41AM -0700, Jens Axboe wrote:
> Just a wrapper around filemap_alloc_folio() for now, but add it in
> preparation for modifying the folio based on the 'ractl' being passed
> in.
> 
> No functional changes in this patch.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


