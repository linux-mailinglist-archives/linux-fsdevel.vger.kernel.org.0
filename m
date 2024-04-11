Return-Path: <linux-fsdevel+bounces-16680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCE38A1515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC8F1F24DB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7040C09;
	Thu, 11 Apr 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uyvIsNzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23F2A8CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839995; cv=none; b=TLkNWjz/XAKsuVxaByDqKNcaO7oQPTG2rNWjipkmi4oJC+HcJTYPF2c3jYaxi4p+j67lQfq+Xf2eDFLF8WS/zXTbSMm/n66D8+v5YGe5N7ywrz8EMCQyFmklYv2j3mlUeYYbZDYIXtgOApH8PfUbftb9Pclxu4ooylZwhuv+6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839995; c=relaxed/simple;
	bh=UZYFs1GYNhQv4HWrQKWwlbZD7Sw8m/UdQ9xpg4voM0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZhHwd1Y1kuh6eXRcuOsdiWX/W/1YWxDr8ddk5uEML0G9P4qZuEFsG4xSaoSj43VM1c9eZjpPa9Kng8vzdseWSLs6hQ2SHoPBFJzzDn2F3Ml8SDfw397pHYQT1RM2hI/Kpe/n4bij8RXRjqWUYtlSu1g6utwnAU4Fj2RPnufkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uyvIsNzM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6KEd/vOAcnw6j9QcgZoIhf9EMwJjW8sVx3QjpW3jwMk=; b=uyvIsNzMhAXWzrDoyj5T4dpAP/
	0SeFBWWeiGSPLT3p9o20AdPBhcPCrrbMbmaH9uE3ExBfFLp2e5IHbzGAMt1dcLXj0KcGmHewVzZGB
	TkcfGZE0QWernnPG9Gyi1glwfD1Q5K53KPPO4DP7HqVOLzePYUcNGuChw/tssudYkEHuA84AmuI45
	PlfBI6Ewyq7B8e6Oz3npfNS4C9heKycsPFyXhfA90MZRfGc9z2q/CEKYAD9Kp+lALW1XWOUyfaCHY
	G+X1CsmbWHJS4YNE1DvUPr1jYWfpeKDYLfor4PjRSbrrWi1mwhF6VCoHO8EFxrr7o3UcLXTQXPbnD
	B9pnoTag==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rutvQ-00000006yoc-34oj;
	Thu, 11 Apr 2024 12:53:08 +0000
Date: Thu, 11 Apr 2024 13:53:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: move mm counter updating out of set_pte_range()
Message-ID: <ZhfdNL4kbAtsWzBI@casper.infradead.org>
References: <20240411130950.73512-1-wangkefeng.wang@huawei.com>
 <20240411130950.73512-2-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411130950.73512-2-wangkefeng.wang@huawei.com>

On Thu, Apr 11, 2024 at 09:09:49PM +0800, Kefeng Wang wrote:
> In order to support batch mm counter updating in filemap_map_pages(),
> make set_pte_range() return the type of MM_COUNTERS and move mm counter
> updating out of set_pte_range().

I don't like this.  You're making set_pte_range() harder to use.
It's also rather overengineered; if you're calling set_pte_range()
from filemap.c, you already know the folios are MM_FILEPAGES.


