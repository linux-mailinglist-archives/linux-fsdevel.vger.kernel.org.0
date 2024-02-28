Return-Path: <linux-fsdevel+bounces-13135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E886BA9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001BE1C23552
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8661361CE;
	Wed, 28 Feb 2024 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GI/raViF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40141361A2;
	Wed, 28 Feb 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158405; cv=none; b=FMNbXMdkdVTxkaThLBAbkp1HVTnKwR5zFr2ufIMBkR1xuiJw4tzoQKQvbIyKya3bZp0JJHjUDWYTVfLgBAsaJrRfkbxbQgA5ibcnxU8V6Wg1ih075piKfffqSal14/nMFnaAS6anIQpvg4nuWofg7ehW5kTv+HJbouLNNT/jZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158405; c=relaxed/simple;
	bh=qevbNgNmR4geqRNA0PPjIf+hsr9mNI+FGtNQRvPTu6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF43HtLNGCbWuypcKWXg3Pv7G4ufakdVyaSFyiy9Kxh8eIQYGqaAqmCK4+o39+Md00n7hXeBcsIabfBBUmktDHOJxhRHuJXv54Ddiy4TK54mnFPJ3TkeNXagAep03z3ZrFHxb8sumFbeixl9iowdTm2tvoOuASDbh7FExwoeIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GI/raViF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LLkbzykmttVYzbp2D3VuqEYjbZw4cd1Nkxs+BldTop8=; b=GI/raViFDOZ9NZv3JyZyrTn6Cy
	ev1a9QtJ4WRg/ZTm2LMH/yw8pdW8rxyv+NB+wAz5WukIRkjjKPON+YyiDLngrKpOEX0KNVavlv3Qe
	uDW0GBTxbCB9Z3nDz+qwPhoXQtwnCTbkwhcm+C29pMuW42wklpOvQADJXj3G9Q13jgmZKw9W8GkMd
	5vueTw9Jhvo9cQ94i1kq4Uss7N2tv76sbrGLHQOYM7hrAZlCEqa/UXRU0UGEHdAlSNhnb5ikVPRXb
	gHSeMz5MI7aRO+j83dXn7Lv4k+htMkHVPZ+5hLp9EDrjQgk/itsU5Kc3uS4Nkqjvtb9HNlsdKNuAT
	I9XXPgbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfSAx-0000000B6TL-0oZz;
	Wed, 28 Feb 2024 22:13:19 +0000
Date: Wed, 28 Feb 2024 14:13:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, willy@infradead.org, zokeefe@google.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
Message-ID: <Zd-v_25DKYI1hn-l@infradead.org>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
 <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 28, 2024 at 04:53:32PM +0800, Zhang Yi wrote:
> So, we have to handle above case for xfs. I suppose we could keep
> increasing i_size if the zeroed folio is entirely outside of i_size,
> make sure we could write back and allocate blocks for the
> zeroed & delayed extent, something like below, any suggestions ?

Sorry for being dumb, but what was the problem solved by not updating
the size for ext4 again?  (for unshare I can't see any reason to
ever update the inode size)

