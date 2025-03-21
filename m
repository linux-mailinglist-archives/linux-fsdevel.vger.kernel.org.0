Return-Path: <linux-fsdevel+bounces-44674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B5A6B408
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA6D486E17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2981E9B35;
	Fri, 21 Mar 2025 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e7YNCppK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F41E1A18;
	Fri, 21 Mar 2025 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534619; cv=none; b=dyXSJazOEzlOHSAMuQHVibNmXcQ756UUuoVxOkZpyDK+kmxdZ8YBl9os+MEBMwK+TA1Opyd92muUJOjcjhyZxBA1eH8+NPnz055IBG4QoWbJfFKxi9PHFWB4mqSlUd2WJzIBkCb9cc+bUSznEMqQymzTczD1YsperlahFKddNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534619; c=relaxed/simple;
	bh=34NarvBI3/OFBmA+omarR4WyYQPix3PfW4NaIq2fEEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tElqwRXEidNxDLvE9iSxk+y52xH1ogIvfnlB1SDnbTuCFccxRXAIVDs5/qGK5NDOS/uNtO1gPddYDtZsRd6qzq1WPAtg3qC9wCNLmvEHVDb7Nk/TpnyMAD1MDC7rNcijUd+kX1rAVTAbBm3hkZGdGbTcMK2A5pGnLv5mvLFuSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e7YNCppK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kS+by7DzfHzQ8bGMun9P/TaQZveZzse+FJtttQBHQe0=; b=e7YNCppKFLNAT/lvMs7g7VVq+T
	WhUc7AZyXsvxyTZ8BPunT3UxiazE+0GoS5MDX6dXXTniN30oOSN7/00Q5WgLkK/V8CgGwnvd9S5qu
	xZGBP8CmtVsV6l+mxoIX5NrywKe60TIS4dKLwSlm31AIpbois1NCPLc6e6RusOUYHfY7ZPceWk5P8
	m/qAVwDpc2RuCmpHGLxAAwjvfEQDn/VqC3WGp0U+qItTWW8yBFK8W2NQkaNtJ/YUUWwjsA2x4vkJB
	q2Vq3TNUFUwuYH0f6bbiH7wZDr8aSeD8jGhHobm/Yp/39BLJ83TWR/EMHSMq3Ek8SfHcAsp/h6HOh
	upOPLiIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvUr3-0000000DtL6-2acm;
	Fri, 21 Mar 2025 05:23:37 +0000
Date: Thu, 20 Mar 2025 22:23:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <Z9z32X7k_eVLrYjR@infradead.org>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 20, 2025 at 02:15:15PM -0400, James Bottomley wrote:
> On Thu, 2025-03-20 at 09:48 -0700, Christoph Hellwig wrote:
> [...]
> > We finally got hibernate to freeze file system on suspend,
> 
> I was looking for this to see if I could possibly plug something in for
> pseudo filesystems that don't have backing devices.  However, I can't
> find the path where suspend causes freeze (at least the bdev doesn't
> seem to register any power notifier like the scsi block device does),
> where is the code?

Looking again I can't find it either.  On the internet I find a patch
adding it from 2006:

https://groups.google.com/g/fa.linux.kernel/c/dtxsNJ7ks58/m/mqU8SIAbvLgJ

But I couldn't see if it got applied or disappaeared again somehow.
Adding the relevant maintainers.


