Return-Path: <linux-fsdevel+bounces-30723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A257998DEA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15BC1C23ADD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FAA1D0B91;
	Wed,  2 Oct 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjUa6Ca+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3057F1D0B8D;
	Wed,  2 Oct 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882089; cv=none; b=aFn3KaxVMSNAoiml3vBsbd4fFvlzJihbdhwXQW0UukuiEn5UEa7wAlqX0JWl+DO2tzLgjycyfvZTAw3F0YXyXKAg66y2Hut3uuSRGWa2lG3G5isiPW7cdBgOx+8+fAP/CNaf8p1IfPf5vzrUZ3fUhQcUkm7vBoh14u/tlh9fi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882089; c=relaxed/simple;
	bh=oGg9VhDgI+SWJP1RAKLnjLcADS1LF0CQqxQXWKUcrbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEqGw3MlqJzA1fnF8xaJmzncMYfbELM430VnTcWHr4565b3wj47BmyJKFm7Fhuq/y+LlDfwqVkaxUHBXU4556UFbxpblRU5c+W3UQgyvA3NEYFp65P6YYdaQPo7uGiz3uL8R00xb6ocz+lT/3KXv7uHefhMbQUw0yNPOlZ+KuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hjUa6Ca+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uDmYxLeXoO9Dy5oZ1ZLKRakEVrj2vTGHT495+npa05g=; b=hjUa6Ca+N4fM2eOA5a01dBW7fB
	5bgheaPp+UgDF6gqT/5HYNZe/uK0Dh0RkeXLZHLCj+j101Se/TsnQY8CAIhHDbI2zo1Eskn73065M
	1N95vMZkLNzbZcHpqRu5huM8/uAiNocuwRQ80vwE12LD8jwdQOeRktWBi7cHNvMVmXs/lVhjtGzVV
	Df9XaPADYto1vHbC/vVPouRHvRepm68lMk3O/f51OxE8qZVdQ37sxNqE9KydUnjQGRS9YyOJvwpqL
	3OIpYVQZq8yA1a84eDBqNQF/HsLxmUwP9s5Z7m93fGK0NtN3EW9a85jUbf20tuVX1Wh/8wP9opwfU
	NL5ysJJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw13v-00000006Zyc-3G9w;
	Wed, 02 Oct 2024 15:14:47 +0000
Date: Wed, 2 Oct 2024 08:14:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] iomap: don't bother unsharing delalloc extents
Message-ID: <Zv1jZ-1tg2jOnw21@infradead.org>
References: <20241002150040.GB21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002150040.GB21853@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 08:00:40AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If unshare encounters a delalloc reservation in the srcmap, that means
> that the file range isn't shared because delalloc reservations cannot be
> reflinked.  Therefore, don't try to unshare them.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


