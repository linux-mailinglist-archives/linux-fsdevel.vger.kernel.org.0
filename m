Return-Path: <linux-fsdevel+bounces-37222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9689EFC92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A3E16A286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71ED18FDB9;
	Thu, 12 Dec 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVOoqHUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A8748D;
	Thu, 12 Dec 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032134; cv=none; b=UmQpq629ST+YtZZxT93Zg1Cg3RbjVPr9DELHivou+2hr93cRkAHS9y+D5n156RbQupk6fPXkFDT4Rm13hP87eRWOcq49ahBszUMUHM1TosLxhex8l9w6mJYahb6+K5KXo7wKJkKWZzfebYYr5jcbjC9F39PVpynoXdZ14uT5L5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032134; c=relaxed/simple;
	bh=Z7yzPMHkmTT8PMtSrwYIaeODiYMstVNWdy5UiKGqgBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY7UYf6evQF1KYygzHrxkPpNwRSOg8IXtS8HC+m5FJUfhW9msP9JbPwJmGt77+G9uwbaqnyDxeuCv7La1oA9KCcBqW4nQtlrgGelEqBvSDrjQzxv/zW5OTCAsDyQuHcOnQ0B8WsQqkBX9MYKQqkFBCMyoU48OtoZdWrmTzSlgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pVOoqHUQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z7yzPMHkmTT8PMtSrwYIaeODiYMstVNWdy5UiKGqgBw=; b=pVOoqHUQ7Zt5Qsg9jSa9F5UTf/
	kpuW1kEPD71IH1+6jg/JcsyLGEJWTephj249UVVONq/H6AwnTzqTOy5fgI2logcAZFVxTi+jNx5Fl
	l9iKkz24J0ePCSdcLrIV2rd5uQFMaARprRnfyRQxlHQ09oGsPxqsIuBZP9hGt/k/+/E3cEc3+cT9v
	XJ4+17CDPv+vtcPXwlc/N0F3QnPl+IknzVzbC0BiqRw627FVPFaQv29Cy0qfV7f1uN6VzrkgpQsh4
	8brp/R0pvJC/AI/QWpbxkF7eNHXMykSdgHH5bAJnAinsaZB3MMXoy5k1HFpG4isAhAiFJAVoO6awn
	p4TD5owg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLoy8-00000007ga1-2emw;
	Thu, 12 Dec 2024 19:35:28 +0000
Date: Thu, 12 Dec 2024 19:35:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, kirill@shutemov.name,
	bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
Message-ID: <Z1s7AGxZKhK1V4qv@casper.infradead.org>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs>
 <Z1gh0lCqkCoUKHtC@infradead.org>
 <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
 <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org>
 <383d3adc-e939-44b2-9110-4db9b4477401@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383d3adc-e939-44b2-9110-4db9b4477401@kernel.dk>

On Thu, Dec 12, 2024 at 12:14:23PM -0700, Jens Axboe wrote:
> Like I mentioned earlier, the fact that it's cached for the duration of
> the operation is more of an implementation detail that developers need
> not worry about. What's important is that it's not cached AFTER. I still
> feel UNCACHED is the best description, but I'll change it to DONTCACHE
> for the next version just to avoid the overlap with other in-kernel
> uses.

Regardless of the user API name, I like PG_streaming for the folio
flag name.

