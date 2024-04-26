Return-Path: <linux-fsdevel+bounces-17860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C779A8B3077
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C1B1C22F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1313A41C;
	Fri, 26 Apr 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H8O1GNoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0478B4E;
	Fri, 26 Apr 2024 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113185; cv=none; b=C9n85loFyIOb3QSC8ywWmARCxpc/HQkFrNd9uLq8dNg9Kp0iye9bZ6Gh5Ssr3nt9lRkH/tXhPVkLZljkknyshyZZyP9kbTYgurKlf5dlY0R3T3Eg0WompxOppdfY8ZF+85PGOHCVT0SEO/jzp+9dzh3QYFX5hIQM7djyTM3LwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113185; c=relaxed/simple;
	bh=61TPekQLyaOIOjoKBhnNUMKT5hkW0pS5woJJLrZe9Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxGvnYyhJDbiVadhk8MVtpbsMnIdv0k1Hyis8X5eO5eyWMb6/tCWg4Xbd+coLsgOkNLKbX37IMEKejEXypNhHaAdVced4ARYXv7V2UBCNm/uupes7szMI6J5hS0OYlsSXAz59NOY0Mn64uR2NAnjLRHJHlv674pP2alNlVe9HMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H8O1GNoV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bAMm3w5OCb4CaHr+pTFnD6QYi8dnap8rwYOnceQqfgY=; b=H8O1GNoV5d5tOu8ofQ66OvzgnB
	9zlCjZj3G7pXBTVrJlH3AWeOT08OKaADMHTWQGWNkG+jWPhGP71jJOoMuwIJ92hsTZpC2SW/Mk1CR
	EK24rdXJWEEdfAn0BYX61Jt0jxIYi3i/T+05WLAjfHYannrIvfEWuC3+JSBINpz0NS2DuoUetd4tF
	rWYEwLZwvE6+5Oe5fbuzb81Q3N/0S8ZbRFFgW3Ohn4qnuBOQzCYok9Hr2WosOClzOLblSro9dUZFW
	SIy2vMWWdh75bDLJlbL/psJXrdsO8VU25joJDxV8ZPMzu+jKaId3zciHqRq5zsJQBTpKrqxFWfjoJ
	kT6Dcr+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0F8n-0000000BJiq-1cRt;
	Fri, 26 Apr 2024 06:33:01 +0000
Date: Thu, 25 Apr 2024 23:33:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandanbabu@kernel.org, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <ZitKncYr0cCmU0NG@infradead.org>
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
 <20240425182904.GA360919@frogsfrogsfrogs>
 <3be86418-e629-c7e6-fd73-f59f97a73a89@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be86418-e629-c7e6-fd73-f59f97a73a89@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 26, 2024 at 02:24:19PM +0800, Zhang Yi wrote:
> Yeah, it looks more reasonable. But from the original scene, the
> xfs_bmap_extsize_align() aligned the new extent that added to the cow fork
> could overlaps the unreflinked range, IIUC, I guess that spare range is
> useless exactly, is there any situation that would use it?

I've just started staring at this (again) half an hour ago, and I fail
to understand the (pre-existing) logic in xfs_reflink_zero_posteof.

We obviously need to ensure data between i_size and the end of the
block that i_size sits in is zeroed (but IIRC we already do that
in write and truncate anyway).  But what is the point of zeroing
any speculative preallocation beyond the last block that actually
contains data?  Just truncating the preallocation and freeing
the delalloc and unwritten blocks seems like it would be way
more efficient.


