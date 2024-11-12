Return-Path: <linux-fsdevel+bounces-34393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DBE9C4E89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 07:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7273B251AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA24209F5A;
	Tue, 12 Nov 2024 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bcEPxDRO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC501AB51B;
	Tue, 12 Nov 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391589; cv=none; b=iWyAV7sgOoQvYHps/laVnZrIvJ68YCptdvQyILAsln08PoCtlK39VhCgNpgL95CxFBgPIiU/7CaAIxyG0pfHf3edLBePneqyAlabPmjdbggMMI9t5SENxjeom25Qad72dUKgHrN0EzuajzmAXilfp4nAlFNr/sKfgh0Jpve1fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391589; c=relaxed/simple;
	bh=tYLg3HaRxWkEadXowA8H1tI1mH7WxKlIkhebmaaIWF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEbjnMEU4qRSSsPO9GcKAV2WEdxWC2YNIf1tNUWubzWmaFJcx3b3Z/Zoy7cMcqM4SiHK+8rhCBsVWpgK0bfQakIIVLw50Q7wWUNyX2LX3lV0VfaUxPmDxOulwYQH81ewP5FzNjp5rI2zhyJERZjfivIYdFKx8ShvJMyxrnbYMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bcEPxDRO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=anho48CP2mVHZz1O0N0+y4hGlYTsiEfpVTm65DsffZI=; b=bcEPxDRO4cvm6YLY+6MltWIi1y
	o6GNL4ytpwEivVL/gASdEv0SZTrIG5EyqBz31vo3dZzfcB3IqeBIMskd2eUv5W7FZWUD3aF30S33G
	CNCa7KvWkJeE1q2ByLOQWn2L7itDO2nl48UQmzcvT0Cy4lT2RUpOVDUd0jzbGGu0KgXb/GD0M72x9
	YA7ISl4XifUU/69e/xyAIcDCfr9JT3oA5Ug7dGGoZtcRiFwgOnDiiH2guu40OtYDprtNq549EPBiP
	uOg2km5rKXOZ3Rh9EXmxXzTaSfQ/ZmRfWP5kjJJtSIAeQjthvx409lH1g9/8taDGgnqt74xrnG+aV
	pCPT7Q7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAk2j-00000002JOE-3ULV;
	Tue, 12 Nov 2024 06:06:25 +0000
Date: Mon, 11 Nov 2024 22:06:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: About using on-stack fsdata pointer for write_begin() and
 write_end() callbacks
Message-ID: <ZzLwYZqwf7k5GlRV@infradead.org>
References: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
 <ZzGbioLSB3m7ozq1@infradead.org>
 <d5dca4eb-2294-4d24-9e36-dac8be852622@suse.com>
 <ZzLiBEA6Sp-P7xoB@infradead.org>
 <b595203e-c299-46f8-b79a-185276d53d89@suse.com>
 <ZzLqb5o8JsUdBGUu@infradead.org>
 <03f86d46-0de3-4c7b-901f-1ae16b554186@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f86d46-0de3-4c7b-901f-1ae16b554186@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 12, 2024 at 04:33:56PM +1030, Qu Wenruo wrote:
> IIRC it's related to the get_user_page() shenanigans but not 100% sure.

While there might be a few stragglers left, everyone should be using
pin_user_pages when manipulating page contents.  The long tolerated
just pin and mark dirty is officially a bug now.

> I'm talking about the iomap_set_range_dirty() call inside
> iomap_writepage_map(), for the "if (i_blocks_per_folio() > 1)" branch.

That does not set the page dirty.  It propagatates the per-folio
dirty state into the per-block dirty bitmap allocated in the line
above.


