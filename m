Return-Path: <linux-fsdevel+bounces-71608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F7CCA49A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3D793020CCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D4301037;
	Thu, 18 Dec 2025 05:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZfVbHT7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D92221578;
	Thu, 18 Dec 2025 05:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766034829; cv=none; b=LdFaPmuWNiYvDjk17PBcuNJPQlNbEpPAJbckwwScKpE+7HiyIcjXPx9/wX1ksEKITUKb5n6o8QNyceFPVqso5RZSkZfT/HG193aBxbZc/0Z3Wc6LJl1NciQRFIhi+AFVpsSkG0HMCcRpJalcliA2oBRmWy+r+7A50olpHcQobf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766034829; c=relaxed/simple;
	bh=JAPDhglGxZmOnLgTh9dl7N81r8bD+8xh9U9yWQwFyE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajcsf/5xTTibi6zsWrezPHFNSjWo47Zz38BRHjOh9BUDWq67ESKMpnADDym8aOjRhpdyh+kt1xZ5mUmf3kAAn4eLPy04vy2FKVVeRFovdxckgQe7TLpb6IoMuWpqb4ZVDzWP9EuzSimXUELq2MmyROl8Q7acmE+EMG2v5o9efjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZfVbHT7u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GKdeVclK2uAfbECr6jMqcrbkke7TdalyNlKxJmHUZhY=; b=ZfVbHT7uvm0T7Zbv4odhHEhUTA
	oy6iyi0Fj7mtQmUZGMX77vEyp1noc11UQchg6JoGTah6qKn6UOjxeYYHm0YlG49cKWtGOamj1c6SI
	Yxdnc0ub8jElBDCBtf1RNzGxZQ0KYVcDtNi6KR8BixRM2Q3OxcClFGx6oAXQaB/sm8O7JabIwTuXL
	Pr00aJIVAXv4WrWzy2G0IQeo50ISRKw7DH+aP1fCawgoBBRsnzKEPtX2/dQUPIUb0x34uKFP1387C
	NbUO5F7FHCeDbw9VUawXkULBxC3yFbbgY9xcNQY9FblKLqNlKf3bfCSHjxvsn9gwfQpawDFOpK21m
	kcYls0nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6Kg-00000007onM-0YhA;
	Thu, 18 Dec 2025 05:13:46 +0000
Date: Wed, 17 Dec 2025 21:13:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [External] : Re: NFS dentry caching regression? was Re: [GIT
 PULL] Please pull NFS client updates for Linux 6.19
Message-ID: <aUONisRlqEKd-1ht@infradead.org>
References: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
 <aUJ4rjyAOW3EWC-k@infradead.org>
 <aUJ9hliJJarv23Uj@infradead.org>
 <d272dc63-a157-4dea-966f-003cefa28d2d@oracle.com>
 <e2a365a2-67e4-4703-b635-d828a5c57e75@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a365a2-67e4-4703-b635-d828a5c57e75@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 17, 2025 at 05:03:06PM -0500, Anna Schumaker wrote:
> Does the following help? If so, then I'll probably split it up into a couple of
> patches before sending to the list.

Yes, this fixed it.  Thanks for the quick response!


