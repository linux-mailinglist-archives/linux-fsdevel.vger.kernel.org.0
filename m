Return-Path: <linux-fsdevel+bounces-43815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95912A5E0E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89B4174251
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3412505CA;
	Wed, 12 Mar 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dKOoPqLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756E242935
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794474; cv=none; b=KNFnt7xf4t9ZS6e0yJIGL8a7wLKgdjBh6VrWbck+5R3KCoeGW3kPULyXW9A37xNmh5wzMlvgmT9unZYuzLmxfS2b4m2ZmhO05h1vAbkZq+tZ60gpDRSWsV6nDh3q7KPVX3ZJLYFhwcACtuzlXhTIsSKsDb5tpize2xOQeBJ8R7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794474; c=relaxed/simple;
	bh=EgWSUdaCI5vRax1uKDpzRUAsKc7aukmAJretm2UifBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq9e5Cci0Rw29a/F0LCgCeZs4DMGqwiwxmC0Ti1QgHZ+tP6VX3xwPHct3MJzYKW4mR9eduJgKm3FyPsbhz7YSQonifeyiRLDWOHUDCcVI5fJUJoq+5a5R05tgHehk21CfuZSHUEpUdKN6MWNlGSD1lH6/A35xyC5hEoY2Q9t9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dKOoPqLP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wC2yRLSP9SzCk747Gzjysf5OwHWjvsWZePbtllJ+RrQ=; b=dKOoPqLPN+WlytGcPISI6ZZ0Ja
	oFzJBX4AtfSXxNUYYO4amoM5s2ZavFiK7NlXD9mamh9Q+9VeCamIgT6kBe/0RW20iDT1IkC+zZFoq
	lUg7nZPFM7OQDw6CeTSm8yHYhppawJcYuGoxOUy9j7mf9KqfNrpyJ1enCC/jHBhXu7TbANV1rfSyZ
	F8GIRDlWjkI5VbKU31ISSOa9BRzIdypGwdovZjYbb0Jlh+ygX0bhL/82kn7qMWeM8rqDDcnXJmWvu
	MyY7WKf7JZE8RVblKUYkN+69ipKp18Lx8rV9ukEd7nuHKTzKHUGZIIu+IkDCvR/VxGp5eEGO7HqEO
	xp3FBBjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOJC-00000008v49-1Fy4;
	Wed, 12 Mar 2025 15:47:50 +0000
Date: Wed, 12 Mar 2025 08:47:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Sun Yongjian <sunyongjian1@huawei.com>,
	linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
Message-ID: <Z9GspnEyvYzrJGWt@infradead.org>
References: <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
 <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
 <20250311181139.GC2803730@frogsfrogsfrogs>
 <2fd09a27-dc67-4622-9327-a81e541f4935@oracle.com>
 <20250311185246.GD89034@frogsfrogsfrogs>
 <d0dc742a-7373-4e1e-9af4-d7414b1d3f4e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0dc742a-7373-4e1e-9af4-d7414b1d3f4e@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 11, 2025 at 03:39:32PM -0400, Chuck Lever wrote:
> It's not possible to guarantee that the next entry will have a higher
> offset value.
> 
> Suppose the "New offset" value wraps. So the current directory entry
> will have a offset that is close to U32_MAX, but the next created
> directory entry will have an offset close to zero. In fact, new entries
> will have a smaller offset value than "current" for quite some time.

In fact even for on-disk file systems (including XFS) it often has a
lower value - most file systems try to fill holes in the d_off space
created by previously deleted entries.  The big exception is btrfs,
which just uses a monotonically increasing 64-bit counter (which can
create problems fairly quickly on 32-bit systems, as the seekdir/telldir
cookie is a long and not a off_t and thus 32-bit on all 32-bit systems).

> The offset is a cookie, not a numeric value. It is simply something that
> says "please start here when iteration continues".

Yes.  This then places into the next mine field about reporting
entries added between getdents iterations.  Which can cause all kinds
of issues when done wrong especially for rename()d entries.

> Think of it as a
> hash -- it looks like a hexadecimal number, but has no other intrisic
> meaning. (In fact, I think some Linux file systems do use a hash here
> rather than a scalar integer).

A hash is actually kinda dangerous because it can trivially place
multiple values at the same offset with hash collision.  And given
the hashes use for directories it isn't that hard to introduce them
intentionally for many file systems.


