Return-Path: <linux-fsdevel+bounces-21970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC19106B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163CD1C20C1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57071AD41E;
	Thu, 20 Jun 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mx5MLcEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4091AD4B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891377; cv=none; b=hBlrwoTXl05IVvQOFY9AXgN6qQ/9jQqxaSsyzpVszBqx1QxVJcvXLGL5EgnF6xmuAhUkkwSQNRRYwg95I/1e/o1cHj/KB7MHy/5lXmv38342XQ0jdDBlWHrGEDPDua5e2+6G1obyYA6nwJLz8KWl3fVbDoFdkdSuVDtQwg2rxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891377; c=relaxed/simple;
	bh=7YdStU7WjZ2Q91KYU7ABPZRptGhI/hfMsBOfmGhfjnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAjYbDGS2OuR+FswhNfqZPqPkG5gVFD7D/a9kvzkQ9c/H1IxtXSFitRV1pOmmvrlczfPHdUxBpucUP/rUlh0ONuzG2ryGOEb/Y7RM5SHDTTWPWZZAq46rdirYRjhYD8z3sSWrDWmPIg5TiI+cpirx/4Jzb6PUNcCsLXSdHzN05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mx5MLcEX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LFDEs6yzwudbzAfESzFFhvH2nVhaMpY/YU9oSxNJ4VM=; b=mx5MLcEXqa063zE0u3kNi42Zv/
	oOlRxDl4Rp7ZvMl7Frf/igQnqzbNmqHgStx/39tZRFaH+qz8bvKpx7+/TNLlEJ0HEMPKEmBdS5it7
	me4GdFjQseE7wAKSCjqSZl9NTokXqCSkuOjr17c0rjl+XF86/b1zvf5UQKQtZIAPy8QaxjzgOgPx1
	e5EU1pN/LgcEGCnystNilJwlVX2h1gbnw1WmG0wJGXw4N8qFaYKwBYAHB+JQrztTZUAtCy3zyy+Gc
	Gf5VKGd0MQ9S59Wq9K5b0hWLgun0Nw19bv7tMoxkySUz7/GMCuFNUe46PFjWI4DpO4FYzHOX1ALoL
	Q+ffxaNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKIAM-000000067Sk-1WA2;
	Thu, 20 Jun 2024 13:49:30 +0000
Date: Thu, 20 Jun 2024 14:49:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] udf: Avoid excessive partition lengths
Message-ID: <ZnQzaimw_oeM1se6@casper.infradead.org>
References: <20240620130403.14731-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620130403.14731-1-jack@suse.cz>

On Thu, Jun 20, 2024 at 03:04:03PM +0200, Jan Kara wrote:
> +			udf_err(sb, "Partition %d it too long (%u)\n", p_index,
> +				map->s_partition_len);

s/it/is/ ?

