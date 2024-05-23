Return-Path: <linux-fsdevel+bounces-20067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AEF8CD847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E161C20ECC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374718029;
	Thu, 23 May 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W8QPfVgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B4E545
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481198; cv=none; b=JCINNWhz6K1RnJt2gRemDnZxLQmK4hLO6AG2jULI3t8TQkE5t3Xw1EsD+4+3hznf6HnfoSvc+p7xU64lcapiLNVbH8os846LNSKy5+/Cw/oCGio1Q4+YLbMGdwsmF16maR4qW+zY+WwGV3kfIIUE35CJd5hjAKB399IiGD8cLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481198; c=relaxed/simple;
	bh=7aVlE5KuqYaRpy8CZCjowOqgnbhFDRF3tgZ8gDKmTFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2ZRoboKmerCaEc6yoFHaOV5IMeztdZsGZREs1FFdXYIqHlVRXK2y7iDghMVuU3HqNnF2eJ3nrKUc+kJW/9QC1LZa+Zp+ocbGgj6xzh7SNpkxtmfBFLe+KaYl0NgTSfvLyxJfQb49d2OJ1pIR/eZelBThF/W84tb8uQgXzBp22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W8QPfVgV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bIzFPsVpAZlsavE08LmrVbZPc+NesmBbb3gWmCCC+dA=; b=W8QPfVgVUDvJ8VVDDXhgksWddN
	34trh8HiJw0wdfZD/ISwGHQlH2LcWouexapWu5rtOQeH+SRy9ZNkxkjFCpgq09MnsZaABS0ab52r5
	IL442vd6CqHUDXQ+q31R/YpiTBExdQ1mrBnIXq6kQ44VvGr9B5QPv6km92+ObURBzwQKvr9WE3LGr
	nCo/91yLGRKwPI8+iO9rZGr16lPtXd8WAVxZ/XzwecPvXPYAKBP34om5CPAluawAVHICD0mjpWcb2
	9708NM/fX6vjQLIdAdCj7BAkKhXRhWLSJyqSgxpE58stCWk9DS+EfsCGeIaJWRutOKt9w9lBUmkX1
	QxMBSOzw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sABAV-00000001t5T-1GZU;
	Thu, 23 May 2024 16:19:51 +0000
Date: Thu, 23 May 2024 17:19:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3] zonefs: move super block reading from page to folio
Message-ID: <Zk9sp4-Ex3uoKMRF@casper.infradead.org>
References: <20240523150253.3288-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523150253.3288-1-jth@kernel.org>

On Thu, May 23, 2024 at 05:02:53PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Move reading of the on-disk superblock from page to folios.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

