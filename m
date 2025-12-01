Return-Path: <linux-fsdevel+bounces-70294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C834AC96078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9FB234397F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C402BFC85;
	Mon,  1 Dec 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l59r+q3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C32BE02B;
	Mon,  1 Dec 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574589; cv=none; b=XnYiaYEFAx2rSXSXzZZsCAP3oXaCzCaucd+l0NRBQpVL7EOfWnl/5iKEe7uBq871qpqGCuw2aSuoM6Pi4i5jor1aWSBA5Vn+jk4pus5BDRHO7bUBwuuRWUNco2JJNiA4QgUgT18F/x2RysKcNM4CoHmRFYcfm+GROSY/b+XX3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574589; c=relaxed/simple;
	bh=IXe16+GZG4CyWLQboZ1PF01sSDo7ZtiVwyhlhIsg2Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br4Yfm0cH5XN8eTAqWbI8o2+2RYMzfxbXWKdkSZE7t1RCGgRGp9pAsaizJiUJvSUTj65tUUvgKyfKcB4yJh+xEuvaV/fv9z5aWkXtIJHTiVYJd/g7/c9f7eUth0uWFjxwaGOo4W5OWZslvves05Xs3vm5kjhimeq1zts6L6yGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l59r+q3d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IXe16+GZG4CyWLQboZ1PF01sSDo7ZtiVwyhlhIsg2Lk=; b=l59r+q3dUuG8aVq/LVD+0qvffP
	WCu8u+H90GBbAUiE0yTbZuhNjwWZDp0vsz4AwODIpu3t+s0nKklkR1hmhLwF8XgSi/3pwVYoXzSDd
	wQwPkyyfJmBVveudoci/JkP/WWtuIdRtdQmzows/n7H/KRCV3ssTj0O46bAlhyn0IUzTvzUkDzHG6
	nnUxZ9gG6CCiJsgQhtmtM3J90hRgBv7+EPPipTXG0EEeY/H5vWm+RF0AZRmy/oQ+RB8MUqDNYI2D9
	0+kIghlwfD4VJ4rtMCisD6zBNmyYrbL7UJA/to6/y5WZiJjCvvXw0afkTVQWZP4bkl/9vDjiwGpTA
	b0JqJqcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPySL-0000000346a-0mYq;
	Mon, 01 Dec 2025 07:36:21 +0000
Date: Sun, 30 Nov 2025 23:36:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com,
	Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v2 07/11] ntfsplus: add attrib operatrions
Message-ID: <aS1Fdci9qsw_kDay@infradead.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <20251127045944.26009-8-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127045944.26009-8-linkinjeon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

s/operatrions/operations/


