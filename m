Return-Path: <linux-fsdevel+bounces-53789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F9AF72D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246303AD7B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 11:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0872E7640;
	Thu,  3 Jul 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SdzgeONL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4022E267B;
	Thu,  3 Jul 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543170; cv=none; b=tSAg8wfjB6bABj2GxhnR+stvn5FzA0hISUcpF6seFkLcVnHQ/x0PlR8DB6pBS8B2LA0ATipWff0JpXoN5ML73y50KpxkuGsOqREpEmWOD7Z1hT6CqWt13WPfGRQWOAQMB9GEY3oIhlyzATBxCwrSRUlXwRG/BgEkknKgtyZ4DTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543170; c=relaxed/simple;
	bh=SaOLZYAvxBJHY9SXYKJzXOhjVc8dEjGQSwYhkSs/WXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADiRyuFnRMaA6LJK3y9GYMFBHoj2ITQczJ7IHYGY3p8adHAWpYTgPLpcrg6jIoOGfrOdv0todnPDp5dL8Bd3HcOJJVrhTAkn7+UmbYPjkf7+TtWtu1qoBBM2xifluAEBvMErEneLbl0h5M08gJ2cp+9srEinbbh1kiW9xzHTiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SdzgeONL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LVjnHK2a2/GS8JYOQqAkvsSJ569rLPDcokWUDEILfso=; b=SdzgeONLE0Cs/spa7Ech+FjeJR
	uUtVmD7cSnZ+6KeETxIeGJ0LCoLK580X2oh6bF3SdRoFLS9qASFrCRLqkuU8kF6S2ACiwM7IiOmiu
	oBoszR+/N1SUVPi7YNRMxU4uJtkfnXpcrxOPlR13goCBbbNOenZLqK62kfj9sGUBHTcbF5g3FTVxw
	n11VCCHII9HBNq41D32dMXZ9Fb7qBP0hL4b6s7oAcTeL2Bu0h4/MjCioH7Ztg72L0Euz6vKk6S1fn
	IsDFZLUIoXwX4dv7bzSbFJsPiqNInlB60/tAjzguvvt+6wWAoyIzSL874/4HpJNxsguwpae0OdnVS
	XWKn310Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXIO1-0000000CwiZ-3tcP;
	Thu, 03 Jul 2025 11:45:53 +0000
Date: Thu, 3 Jul 2025 12:45:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "hch@infradead.org" <hch@infradead.org>
Cc: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>,
	"tytso@mit.edu" <tytso@mit.edu>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chentao325@qq.com" <chentao325@qq.com>,
	"frank.li@vivo.com" <frank.li@vivo.com>
Subject: Re: [PATCH v3 4/4] ext4: support uncached buffered I/O
Message-ID: <aGZtcSIryAj4zJtF@casper.infradead.org>
References: <20250627110257.1870826-1-chentaotao@didiglobal.com>
 <20250627110257.1870826-5-chentaotao@didiglobal.com>
 <aF7OzbVwXqbJaLQA@casper.infradead.org>
 <aGIxiOeJ_-lmRmiT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGIxiOeJ_-lmRmiT@infradead.org>

On Sun, Jun 29, 2025 at 11:41:12PM -0700, hch@infradead.org wrote:
> On Fri, Jun 27, 2025 at 06:03:09PM +0100, Matthew Wilcox wrote:
> > On Fri, Jun 27, 2025 at 11:03:13AM +0000, 陈涛涛 Taotao Chen wrote:
> > I think this needs to be:
> > 
> > 	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
> > 
> > because it's legit to call write_begin with a NULL argument.  The
> > 'file' was always an optional argument, and we should preserve that
> > optionality with this transformation.
> 
> write_begin and write_end are only callbacks through helpers called
> by the file system.  So if the file system never passes a NULL
> file/kiocb it doesn't need to check for it.

Sure, but some of those helpers are non-obvious, like page_symlink().


