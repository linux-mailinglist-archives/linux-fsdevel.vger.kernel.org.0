Return-Path: <linux-fsdevel+bounces-41630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC4A33839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 07:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE411679C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 06:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243F207A37;
	Thu, 13 Feb 2025 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Os7TFMWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A002063E3;
	Thu, 13 Feb 2025 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429514; cv=none; b=RUlffbIpZL7jk5qt1MftHxQlIvSaIvzVaanpL/KYGu4mFt63IGABeaNGqP5fgkbDK0E9LvhEF9SEjZ1ZbOgjGqTfXzoePYzICfHjoNOBx4LDG1hza257lRx4TTbM6Kr3gyqhkaqQqV8BDvQP4Oy5x+vAVKWV/7WaKk0TwcqjnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429514; c=relaxed/simple;
	bh=Aevx4BmNd0JBDw0xhhXmhDtqPIB+Bk1/Ktco3A5T8bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMvjmYM+UolVLtnmjb7lZvHvt8sjKiUzz91zeBJ35UkJEBI3bE0RwRhuHWspT6nmArISaES8C1oXIisaVlFQJo+Xr+86v/yWXIkzb9A5clmcIOvAZYtS7re4QxcYLC5RsMwmpxwWoL+pvsvmK8GGYH0wvZ36Aoid6WHLVwdHJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Os7TFMWq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Aevx4BmNd0JBDw0xhhXmhDtqPIB+Bk1/Ktco3A5T8bc=; b=Os7TFMWq9OT2X4yhfa2KQt5WPn
	wB3MnMdhHXfLhKi/0zUXu6lW2OMPn2zUoJfV74HvZ9f4i9iMArBUPiDvWs/BSIIwSmojQfOdjbreY
	VHT8jy4xsUKepq2PfqB4Cm9o8hAQ03irYcfXcfMjTPzBzlAT64HKL5xSP46GEgFz+SrN5p4BjIP2A
	KKyGLvB/lxjmpxMonUObNGqbuVPKg6BUnz8rRokyXJcIn5FTCYtqZtEuc0GnNxfrz7TdIwW8Wy/r7
	SlQT41sLhRNQXUjspdGHOTWAsooclZCKx9fOSnyT42dNYAINbfy7IRq21HwQbQK3QzLyAGRpohznW
	pO15KRtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT4i-0000000A08X-0RCJ;
	Thu, 13 Feb 2025 06:51:52 +0000
Date: Wed, 12 Feb 2025 22:51:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 02/10] iomap: advance the iter on direct I/O
Message-ID: <Z62WiAHDVL_pDPOa@infradead.org>
References: <20250212135712.506987-1-bfoster@redhat.com>
 <20250212135712.506987-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212135712.506987-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 12, 2025 at 08:57:04AM -0500, Brian Foster wrote:
> Update iomap direct I/O to advance the iter directly rather than via
> iter.processed. Since unique subhelpers exist for various mapping
> types, advance in the commonly called iomap_dio_iter() function.
> Update the switch statement branches to fall out, advance by the
> number of bytes processed and return either success or failure.

Can we push the advance into iomap_dio_{bio,hole,inline}_iter?
It think that would be a bit cleaner as I tried to keep them as
self-contained as possible.


