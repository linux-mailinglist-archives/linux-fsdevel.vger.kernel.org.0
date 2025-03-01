Return-Path: <linux-fsdevel+bounces-42873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFAA4A7CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 03:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF863BA776
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 02:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B934CF5;
	Sat,  1 Mar 2025 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qEWhBr6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CE41C7F
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794487; cv=none; b=uwu4NkziSYlRV/Nqih/7sCI+LxBJmy4zA7HVdhvPEZDPNDl5xzUNZMU9pjrjvIrEj6Nk+4nVuTiJ5srgciDNZ6NAVriyDXUVQzTmAhxM43FIYkl+UAfn0PQioQNzqJyL3+BL6CxRM+Ox/b9KOPSwr6ZU3PvsVpEV+Gdc4hLlh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794487; c=relaxed/simple;
	bh=JD+8dEumvDdiv5egyl0cefpEifWnjT/UqeOrFtNjGCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGboKEpRQBPT0YZIxXa2RuI4kkn2U1Q0EunX6qIMQxh8tNMeP8PwqotTzbY0y0isA9RazXidCjm5t2X2oO126oktTA2fPg/gST5Om7R0XksGLolNTj3yzt3739X+bRKnKYV0HRG8SRFwroHCtmcunIoT5Gy7dt3Frd5Fzjc6Y/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qEWhBr6m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xo19L7w+lw8PFKKTrx0paOs9dT4WS4dg25huzJ6jJdE=; b=qEWhBr6m4hrTfJ0D46CoZfaw3c
	stU3yin8yI4savDw9jhiJGpPm1pnUN9JTk4LOIt9gU4UmZgsUEsuUtgAzqC4EOEE8IG1YQ3k6Ldei
	ZxniKt77YPWtpSdStAqQzQepIwYPTqhi5m76zVGqFL3/U6rzNT1CwWTbjjyUQhRU+TN0sqvgt34m3
	tD2xSKQZNZlPCy+rAn9mFTeC3zs7S5hYJPmEZoKJm4k9szsgtnplYLziYKj8yDH4Tt9aftwUi4qXA
	NebRu/qtinF90tub+hJ+tI7zL9xHX5M0qVlDNjd8TBXwL3yms5Qm6K5WzW+OqxJrszxuEjIv46uCh
	aM1+Ovrw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1toC8a-0000000Cinm-433i;
	Sat, 01 Mar 2025 02:00:15 +0000
Date: Sat, 1 Mar 2025 01:59:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/27] f2fs: Add f2fs_get_node_folio()
Message-ID: <Z8JqBAxLr6bWQ1xT@casper.infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-18-willy@infradead.org>
 <39268c84-f514-48b7-92f6-b298d55dfc62@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39268c84-f514-48b7-92f6-b298d55dfc62@kernel.org>

On Sat, Mar 01, 2025 at 09:15:53AM +0800, Chao Yu wrote:
> >   struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
> >   {
> > -	return __get_node_page(sbi, nid, NULL, 0);
> > +	struct folio *folio = __get_node_folio(sbi, nid, NULL, 0);
> > +
> 
> 	if (IS_ERR(folio))
> 		return ERR_CAST(folio));

No need.  It's the same result, we use this pattern extensively, and
this is a temporary wrapper that has to go away in the next six to nine
months anyway.


