Return-Path: <linux-fsdevel+bounces-15467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775F88EE99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 19:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBEDFB2224A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BFE14F9E5;
	Wed, 27 Mar 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NrGU0z+z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5A1514FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565599; cv=none; b=XOazBjNE0vYQR7bGFUFumAaUuwLdB12IkgG33TM7ofKACSAf7tjWVmvtwr3GJlqG4eOZlsD8oA0gkyMYFVslGBYn49BFVPlglxKDUeY3vRhMKAIQSMMUlrv3n6Ea2QPYxpN7mom09ja1NRATYwPhGQ5/KHdyekd2YDAnZVJ+1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565599; c=relaxed/simple;
	bh=Jtccu7UzJToa9o4RH7l5v8KO+oSXLf0FlMxRK9HtvuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TafEWpKlryw+vxtdpmegqMR6kGQiFazz85FgaSmktaM8eQ6qtRZBctudeoPgCWY5HcT4kqg4h7eUi6X2j38muqqtx77p4QcsZCTnxUJ1P7rLL8no6Q8S1L/hvjMNP/0Hxvjm5IXhpx2jhoaPvljBpkUr3zbeaistDaA0aKWeKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NrGU0z+z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2gpiYoX81ux2JVxazaRUF8idqOkP7INSc0VwgF0Pp9A=; b=NrGU0z+zggHEwTsmZsGhiWa47b
	7so4aCaCXIFeMT2DTE2XfggxBfUlvUKikTVq4DZ0jzQHfPaMy40CeYOilK9+mlCXgBnUy2UGGZ1Hp
	tfYVgxGAuuKz0JsDeCcZwSPQfhy7g4fW6rIOPSPIlpdVGl7HMx+t3GIo0Nj1W0vqLBO6FL4SEnzkr
	j20vjJDcKQL+peLroPK2pFf6cm3zjAGUx1dPJTObqMUJA/EaBVjQ23+wiVVIhWyTZaYMZvpPlJR5j
	ZXPJA73xOlKbTa78VOOn64AgXUDF4yVCdl5YDWzq8GrXOd2bdVu8tkPoNMWvBDiYv2XwJNCPrz+A3
	U5ZL4ETQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpYOf-00000004W0G-1diN;
	Wed, 27 Mar 2024 18:53:13 +0000
Date: Wed, 27 Mar 2024 18:53:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove __set_page_dirty_nobuffers()
Message-ID: <ZgRrGdsmlf2pRvVd@casper.infradead.org>
References: <20240327143008.3739435-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327143008.3739435-1-wangkefeng.wang@huawei.com>

On Wed, Mar 27, 2024 at 10:30:08PM +0800, Kefeng Wang wrote:
> There are no more callers of __set_page_dirty_nobuffers(), remove it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Yes, I have this exact patch in my tree, stuck behind a mess of other
patches for the last two months.  It had to wait until the ubifs patches
landed (which removed the last user), and as you can see I've been busy
submitting other patches first.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

