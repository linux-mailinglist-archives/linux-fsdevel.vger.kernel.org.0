Return-Path: <linux-fsdevel+bounces-46178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 144B3A83D75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2027619E2BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C83C20C027;
	Thu, 10 Apr 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1LYIR2Bh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662620371C;
	Thu, 10 Apr 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275031; cv=none; b=VJ1MhoXWzpTvZ5bEL3eKcvjCGbCO2dmemNIQhwSwoi1qY3U6P6g1J1gqcA9YQ8jPkPg3iUFmyKtkfVs1+u6cII7nhU2NJz5hOUsDMMAEWsdPVCD11rsMSKFg7qSwV5QH8usbZLPkmLn2eMdTKfsmI1O7W9RCBJRz4EXiMTTcaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275031; c=relaxed/simple;
	bh=T8jEW6Tu0rhckzJnDNtqWX7UlY4n2k5d/yabCD/iHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGZkYo5ORRtZoEDfRRLMnIKv3Be1ijGacvSxCXqco5FJlWvlSkdKXv6EzRZ4/2FXypxeCNpBQcNbr5snjfy7UvpKKNv2dWgXBQjHhf2hZ5R+5pLuxIdHNv72R7qJFq9kzASL9cb6dztS2UbZuA9JRJ2r578NTZBKA9nqOtNXDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1LYIR2Bh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r1HPCRcWQ3mWERn6wLp9oiHne/42gET65G0EeDFgTNU=; b=1LYIR2BhtY+dJNfAJvxXmVQ4SG
	6gfWJvAhb8lCEBPYYAcgbVrdKTKVlWWNRqZ4GBfEVURZldNskJ1LpU66au7qN0PswAPLNLWnJW+Ng
	pU/OWFZ0PYMV+j2ow8ETvlq3c9EdVuWaP5z0S4vOIKq+ZWEjNmFJhPqy3dvNDlm91SIX3Ya5ZkxHm
	y10hjCh+RrPS4kMIAmG4vCjjBTyvx6EGRg8GhciuqagzVVDm2ILcdHw2Wrq+DY1WxBNZbKAlwXSxc
	r1ueFI7Sq0flJK9QcWLCTybUE8afIF74McqKWfPhqeBK62th+JC8MIBhC7TtKk81hm5wCTytt80/L
	96qCmU+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ncD-00000009oQq-0lLv;
	Thu, 10 Apr 2025 08:50:29 +0000
Date: Thu, 10 Apr 2025 01:50:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cgroups@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>, Rafael Aquini <aquini@redhat.com>,
	gfs2@lists.linux.dev, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] gfs2: replace sd_aspace with sd_inode
Message-ID: <Z_eGVWwQ0zCo2aSR@infradead.org>
References: <20250407182104.716631-1-agruenba@redhat.com>
 <20250407182104.716631-2-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407182104.716631-2-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 07, 2025 at 08:21:01PM +0200, Andreas Gruenbacher wrote:
> Use a dummy inode as mapping->host of the address spaces for global as
> well as per-inode metadata.  The global metadata address space is now
> accessed as gfs2_aspace(sdp) instead of sdp->sd_aspace.  The per-inode
> metadata address spaces are still accessed as
> gfs2_glock2aspace(GFS2_I(inode)->i_gl).
> 
> Based on a previous version from Bob Peterson from several years ago.

Please explain why you are doing this, not just what.


