Return-Path: <linux-fsdevel+bounces-17405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CED8AD034
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631071F21018
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647C152516;
	Mon, 22 Apr 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJgGU6IF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138D5025E;
	Mon, 22 Apr 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798362; cv=none; b=LkvK34iHif0H3LUHNvnC8PREW94LD9qa3lk9Ndrpj66Ky8xkSbYJ3BFyZ68aNIGbAfVlVTaZprFEepJslYU+bzOTZ1jEeY2DtFJ9GTVpcF4lG7Apiph+MO6ARzZ0/j8kimH9agtJlGiRnSB6JZrPAbIiPwMFIJNHUjv837uXUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798362; c=relaxed/simple;
	bh=+tT5CpLQSbfb+GnV7AjBNAbCe+DNRb8pl9mqYATcFI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS7kRQB+7K0txyMp7M049lEmo/3PmnkPeFfeclMJG5XHFZDvoZfw82jHlcOxFpRZgn+ZYAH9U5FQ0EsPtZbraVBjnW1gwdf8SKTl5w6hmkS62ncbQItte6UfrBBfFgXNvNPgtFBYskKAR7oi12ZiQZd4xMaMMw8R57gHaJ5jT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UJgGU6IF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SdGbli3Pqf6JteNjQOYUU85KOuP1lXDMOKXjEa9EaPQ=; b=UJgGU6IFytHavvZ9tqXUDCc7A1
	/jCBXYYxsup19RcDU4HQxiP3dP+dLr333uOq4Z+6mhKsTRG3D3j88SNO0bYrbXDFPgZ1s8mHkPYlQ
	NGhxXzc4NE/nhzb97U63wexm/5o2DQ+GgDM9afAzJCnKR0gl6gTZggIlYp6SEJ3hPMpb/XucSbYow
	a2h+hxvKStlA8S+u2P4Fn9A9W1It37CKLghukF7AxuYadSfFpfkNAfO+1X9k0uLa43gS524b2zFgL
	J0Z7umIyez0T27xYCCIOjOcSL45rs3kaPxHfzGqSLmcFqZ1JUj+2Msl/yABAJ2EZoMYPFDUNuNDWc
	r1owiZgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryvF1-0000000ERWG-1xkp;
	Mon, 22 Apr 2024 15:05:59 +0000
Date: Mon, 22 Apr 2024 16:05:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <ZiZ817PiBFqDYo1T@casper.infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
 <ZiYAoTnn8bO26sK3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiYAoTnn8bO26sK3@infradead.org>

On Sun, Apr 21, 2024 at 11:16:01PM -0700, Christoph Hellwig wrote:
> On Sat, Apr 20, 2024 at 03:50:22AM +0100, Matthew Wilcox (Oracle) wrote:
> > The folio error flag is not checked anywhere, so we can remove the calls
> > to set and clear it.
> 
> This patch on it's own looks good, but seeing this is a 27/30 I have
> no chance to actually fully review it.

You were bcc'd on 0/30 which fully explained this.

