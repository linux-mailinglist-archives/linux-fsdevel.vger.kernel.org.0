Return-Path: <linux-fsdevel+bounces-16731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A358A1E76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1331C241AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B664F898;
	Thu, 11 Apr 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eSXj3IR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709844F207;
	Thu, 11 Apr 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858934; cv=none; b=VEFOeKXqqPOzTvsaTQLOViHtQPghUuF8vJlTGIvWpR+oRmyfxcefZ7P3m/kJMcENbxOzdgSQABr3OnIemdzGg8XnynLfqGrplUUpS1y+JBMS4IkjQHQ+XreFm5My55ghyN/CxtxxzLkq4tDRgKHb5+sB6D9LFGH9PBI/7wDnsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858934; c=relaxed/simple;
	bh=rRyNSccZHfH0f+5W+sijgG+Lmm0KgphDgKf/XMGBP8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9jB/rEK89pn19nQ3YQWC6P2IyEchBQ/k/9lCxoV693bFi4mmczKZElIogbOWKT8MzJgDYpPjOujBs+caUS2Yy9AE2YqaVuVP9/pzyqmBEobVtxOQuMoilnhZLKXFNwDkTG23VyTpUxvnYeB1QSXg0WUEDaIM4vjEmvo2WjjXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eSXj3IR/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jj6v5wKjL5fXKGRUWtCJZj4xWXHygswUgan7QvTdTsY=; b=eSXj3IR/eMarnNnYuDHSc0B+p6
	evSgC3lGduUSpBhBXtauit7eHdh68OrTOYHxi+9tyx4/zT9JvsX49VbYb7HR89+oCRBQyu1me6Zth
	YGLJea0+IIK83wgqSptVSdOBwO39AX8yB0J5rc1BoYHDqxsGFPHMcjKbFGJf8fBKCAvwzRO6G0QFX
	oevUGRuLVSkO/ltPhX/uma7hdV0oI/Zgs5TBoARt+163x80yBJi1Vjx9oP0MHf7bxyn4LYwu7IMa8
	rCiU/jHLv88XeU6oWBaqk8eMpaJMMBhuhe3HCuaJdi2fW3QhEcshodVKfZFd7kMfV71F+t3YzNYjV
	d80QfwBg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruyqw-00000007TUM-1Zuz;
	Thu, 11 Apr 2024 18:08:50 +0000
Date: Thu, 11 Apr 2024 19:08:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: reiserfs-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] reiserfs: Convert to writepages
Message-ID: <ZhgnMsJ9AGAkgFXT@casper.infradead.org>
References: <20240305185208.1200166-1-willy@infradead.org>
 <ZedqFFiVyntHkxLZ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZedqFFiVyntHkxLZ@casper.infradead.org>

On Tue, Mar 05, 2024 at 06:53:08PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 05, 2024 at 06:52:05PM +0000, Matthew Wilcox (Oracle) wrote:
> > Use buffer_migrate_folio to handle folio migration instead of writing
> > out dirty pages and reading them back in again.  Use writepages to write
> > out folios more efficiently.  We now only do that wait_on_write_block
> > check once per call to writepages instead of once per page.  It would be
> > possible to do one transaction per writeback run, but that's a bit of a
> > big change to do to this old filesystem, so leave it as one transaction
> > per folio (and leave reiserfs supporting only one page per folio).
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This patch is not yet in linux-next.  Do I need to do anything to
make that happen?

