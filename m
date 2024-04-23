Return-Path: <linux-fsdevel+bounces-17538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B68A8AF5D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3B51C22D73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220213E025;
	Tue, 23 Apr 2024 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gv+5iNz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD313CA96
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894710; cv=none; b=tF/UHHo7xZpoKVJN1ds5tGOAFxnldqIJK54OTVEnHxCGtWqXfaec1gymJ3FhJ1G5NBHDYFXn9296i7ZsGo8tYLpOl1KDJ5feG4ZlYo6RYDYEA328so9vJiHBsHPj/cIzbTnAHGl3H3fbTpx8HIWuXXvOuVbwNIECmWzTkenHTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894710; c=relaxed/simple;
	bh=lzMCofUrBtiCd85Pn9j/lkrnhAbIbQ1LevdnDjceIhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deiNVDLhOkXgsVwoWc5QOSSwHO+EowAarH0irMnG7sBNAdvKWpx8LWwV/yXyP0oSF1AtatF3gygMAeHlkfk+zMLfBotmemH9u5xpWikv1TYn3H4lnS0VSMdJZnvGFhk2WCocZUhRVzTffVjkT9CSu4IO7QR0G3vbb5CQrvWbqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gv+5iNz3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lc5bqQFqZSsZ78bpdOtRW0AxIet8z5GhQ/uv0eK9fxk=; b=gv+5iNz3d7DEocofj3tcimPX2b
	9e5Wai8zBHxGKW+N8IfhT3Y2fSTIrU2OSHsg8NzzalprFsMAwIy8UoDo1EYlqqBxDr4VbBjis2qJD
	7X3QFqmluUXrvaJ9sIOgmYUlcGChbW45EsLdcg5eBHKmRIpOUVZWHIinfwDdtQ6bjESN9zou8lQM2
	qWcIu+sKQOO2C47MqJdEB8pD9EKyXXZTog5L06Eg0eTzcSNenAULCCxd53oCtqO1Kf4AzRvXJM41X
	h6x//NU+3x/dMBip74Zop+5tx2OWDL9CIoNIOjuSQ2hCUfjf8cfb8lF1p2Fd0LE8hAizBd6L+cskg
	8JcFVh1g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzKJ1-0000000Gnuu-0ATf;
	Tue, 23 Apr 2024 17:51:47 +0000
Date: Tue, 23 Apr 2024 18:51:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/30] isofs: Remove calls to set/clear the error flag
Message-ID: <Zif1Ml9oFhrfCb8p@casper.infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-14-willy@infradead.org>
 <20240422215753.ppmbki53e4yx7p4p@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422215753.ppmbki53e4yx7p4p@quack3>

On Mon, Apr 22, 2024 at 11:57:53PM +0200, Jan Kara wrote:
> On Sat 20-04-24 03:50:08, Matthew Wilcox (Oracle) wrote:
> > Nobody checks the error flag on isofs folios, so stop setting and
> > clearing it.
> > 
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Do you plan to merge this together or should I pick this up myself?

Please take it through your tree; I'll prepare a pull request for the
remainder, but having more patches go through fs maintainers means
better testing.


