Return-Path: <linux-fsdevel+bounces-54104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C307AFB3C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 15:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFFC4A35C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9382F29C33F;
	Mon,  7 Jul 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="40eDqH1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2129C326;
	Mon,  7 Jul 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893210; cv=none; b=skJW/lpa6R/6NsnvX/rEdHbSIpzBsX+Pw1O+unm0YjRIbsRT+ADIFvO7x6zaoA4SgmZ+KEUpU91HdWWYh2x25TObuXYCubVQxiAPkiiqa2Tyf9hD7fHs1cSn17Ceea/WwUi3BysJEBwt5A7bDZOvH13eg1rycev6fNbOsWbZqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893210; c=relaxed/simple;
	bh=vzpqH7cwAvt5EfB3DXmRzC/6/YWTutXwvmvDN5nphew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZI3Ky4QYKxsoiyveMV+k/ELw6iEdledTVnYwDHf4ZLtJbqPOQGFyVTwMUXainkJaTapxT806MIdyXS1Qe4BZATYqeBKj5qext7FS7hVwxIwlkdOqgAR/Lb0JGO3+tl/llKz6vxLnaCf5LS72zYnXGBHpS6FuZmSpYBqmdv4FEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=40eDqH1T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l9BqN9JWYSkSCj4ALm0oMo2ahkDITzuK7PJIB/RwV+Y=; b=40eDqH1Tpt6pqjoWJoqMb+ZDZ8
	Eix80QnvxzoKWTucgItsK2bvEHjme85duJ1+kEmPHlqgjO84oY/2HqYd7IgOMciEjhJqvnxIpWTpR
	rZjW/suaXWN7HijOpVBHlONAUpd91WWK4Mn+6nQ92h7Tnks181om8Jk6o1Jm6AMvrzJ2C74DazQT4
	9B5LTdFzE1q/kBjA7KSPuS3yX6AAbvVhyQ8NTBqI7lk4NdxcoXWQdWLhFh1/f/Ezk3dP3YMtqzchH
	ITqXuQeuhtiC6lM0myVIN28zZ+JedOWRLK3XaL9yNaqNBmkLQ5yxLytFzICC620Lnl03PhrGMsHiA
	u+Txu/ZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYlS3-00000002Tjh-2VBZ;
	Mon, 07 Jul 2025 13:00:07 +0000
Date: Mon, 7 Jul 2025 06:00:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+a5d1c9dfa91705cd2f6d@syzkaller.appspotmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH] Revert "fs/ntfs3: Replace inode_trylock with inode_lock"
Message-ID: <aGvE1_yre9ayskxu@infradead.org>
References: <20250707124738.6764-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707124738.6764-1-almaz.alexandrovich@paragon-software.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 07, 2025 at 02:47:38PM +0200, Konstantin Komarov wrote:
> This reverts commit 69505fe98f198ee813898cbcaf6770949636430b.
> 
> Make lock acquiring conditional to avoid the deadlock.

This is not a very useful commit message for a locking change.
Please explain the problem this solves, and why the original reason
for the locking change isn't valid any more, or less important than
the newly arising issue.


