Return-Path: <linux-fsdevel+bounces-46179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2EA83D81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEF4466EF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D320C030;
	Thu, 10 Apr 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eE/YC5E2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22F204594;
	Thu, 10 Apr 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275134; cv=none; b=Ul5pXpH8ED7MRV+ufQ2Y6jyvB+8pBlkUTT1yAZe2emcxz84gz8byK3cxRR4UYX9OLys5lZmHE4CkdRieWblHMqOovwa9KoTv2yvEPi78yClzE5Hkq3+A07tiXk/SG5Dm6+cxDHegTtdRJ8qcJ0yQBckO47PSq+meGOfyiJkrPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275134; c=relaxed/simple;
	bh=PRmOwVQY4mQ4FeHq7l3WjbcSkZBDQ417JMaKDhWqaCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+uLJwfD1RRxixXzTi6Jgjx28ZoznuUsgQiQhOTCl04T67yIr5bTckm+5jQGRegS1kjzGGe1Ho8ieuTBSN2nHrF1GI+XS8Wts+ziKN+6mdbbit3c0DMdgtVfDowkwtED4LyT74lEfzegh4c+9CqZoDpxe1z1msShZ4gFi5SvYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eE/YC5E2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w734qNmfPjjUyGK5AWYk6ZTdyX4jI/1lrU4xryLiCiw=; b=eE/YC5E2w8IJoZ1kxYYSZVgzrB
	Q53hcFgxyxr4xUIElq7H8YiFX3SuRuSYIDEwc0fNqiBHzWjuVCzDP5l0g6P7kx74Q69Pp/Xwq8NNz
	x2j/rlIO63W1W7Gom7VYfDEg/1GD7yVgxiCpOjIxKzvxMvdJNjD46EheIuUsc7v4Z4ntunVg3dUGC
	3GTiiMU2R0DEXNZ3EhbvHpqqlNAj/UxeY3qPOlK7wKZm/mhq/jhgBkZ+U1ublE0T454IE0aneSmhn
	1Cy6XOP3J35VJWgJK0NPiOn51jKZXn2hC7ezc04wpbevU9M2HvlWZSjUch2JM5cRXItB47IeXroCU
	LVQI+ZJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nds-00000009osm-17wQ;
	Thu, 10 Apr 2025 08:52:12 +0000
Date: Thu, 10 Apr 2025 01:52:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] writeback: Fix false warning in inode_to_wb()
Message-ID: <Z_eGvBHssVtGKpty@infradead.org>
References: <20250407182104.716631-1-agruenba@redhat.com>
 <20250407182104.716631-3-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407182104.716631-3-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 07, 2025 at 08:21:02PM +0200, Andreas Gruenbacher wrote:
> -static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
> +static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
>  {
>  #ifdef CONFIG_LOCKDEP
>  	WARN_ON_ONCE(debug_locks &&
> +		     inode_cgwb_enabled(inode) &&
>  		     (!lockdep_is_held(&inode->i_lock) &&
>  		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
>  		      !lockdep_is_held(&inode->i_wb->list_lock)));
> -- 

This means that even on cgroup aware file systems we now only get
the locking validation if cgroups are actually enabled for the file
system instance and thus hugely reducing coverage, which is rather
unfortunate.

