Return-Path: <linux-fsdevel+bounces-40761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82ACA273DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23D03A5139
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78028215782;
	Tue,  4 Feb 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0UDr1/sK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41AC211A32;
	Tue,  4 Feb 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677045; cv=none; b=fguStKXIbaHKQN/MesAq5xmEZ4EMjj4p7Wha12MM5IHPX5wWybnC2rM8HeYUfs2bVsvQK0zGRoplgTwiHukN+uDAZ3UCjN+sEaUDifI9N9Cgy5g8WjjXiK+AwzlQksOH+uVDdjrFJRg0q6VUVZZn3g+eLCf/uvWP4xN/z0b97gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677045; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQLR8tKs+Z3zH7+Cd54IbfPPBSJ+ws+sW0IJL+Zcbv4P+JH3u9wv73BMJByYlS9+h1GEJxwai/qti5htm75CwA8deU/Ow9wTY84pqnsDXmcJJmajvkg7UuAd9Hq2zVBXjnZxYoWJparsNZw1wyrhoE81Pe3f1gwKu/xADvdFCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0UDr1/sK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0UDr1/sKi4oWcNatRjDYP02YH8
	N5TIbrfYbRYggRJWTJEqmgS6rY/XQcJiF/b5DYs7ILpIHYvpBnjkw7R+5ohpDPUwp43p9TDXh9E50
	QUhpkw1zIQCRP5ZEPwPZ5/NICCS2qTAD4TsqiQAIBrOmktqfvgTg34ta4weFeN4t8bYY3XotETGqH
	s24Raz1Ec3JiS9W1ohwkDBoLurqX+rX//Fq4nI++uIyxLu8XDEOpp0jlspBlm+QoSegSTDpPGf8bd
	o7fwXtq1ZQWuKeKXm9OZtuPiQnl1tDoEm8BbSvc+ySojhX765CRrte4cDDRhW+5KxSJN8qLpUBsNS
	aUjp2D9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfJK7-00000000aHH-1eXK;
	Tue, 04 Feb 2025 13:50:43 +0000
Date: Tue, 4 Feb 2025 05:50:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 03/10] iomap: refactor iomap_iter() length check and
 tracepoint
Message-ID: <Z6IbM1kYiFtuTnzF@infradead.org>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204133044.80551-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


