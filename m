Return-Path: <linux-fsdevel+bounces-38467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB1BA02F75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A297A1CC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314A1DF27C;
	Mon,  6 Jan 2025 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qUxY46Ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448C13665B;
	Mon,  6 Jan 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186800; cv=none; b=k3Uxar+zBJhbgC4UYc1NucumTe8/GAjhfbkTPauZZz/YVQhYspo+xPb3ZKYzHElXuZ/1tuDxrX4Vo5+uefH9PeYgkC0m/7GBINvsUdss5ZMuTL0jOSWa7Dq14SXht7JcDMKGd5fYwHD53bp8BJ9LXQaYd0TdN1fzQuwJE1h3lDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186800; c=relaxed/simple;
	bh=Is5mI3NZ7iUvYxbFNyrMCBtqp8Tq7tlQP0/chDnHOuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/naW8nzYX9iJv9wAcxI55v4owAntSvjDtkIvbadq8nuxxB8HrtrA9IB7sOq4dfHozkSWzT94y0AYDOhtdiy2mINJsAg9VXqaI3ApHKlHyu2+EOK0yGhpsRKo4Dt0qlr+pndBLqiRYKgnHu4kVr76r3Lvzb77Sepl1om63AaJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qUxY46Ks; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Is5mI3NZ7iUvYxbFNyrMCBtqp8Tq7tlQP0/chDnHOuo=; b=qUxY46Ksvs1yZZYTqfSx7aqs2i
	md/g1C/Fu+xkT+Ndw/T5hwQaas0fu77v6n0rVYtTIi2gkjmOc1BO6gvT5qaV6+tWdjeCm6L2FtlBH
	Dec8pkVLtp6P3WQ41ushZLKgLbMQ30W2HXjz+67JQt9oJqEsHputXmrhYEyOSn2tlNvnRpSnyCAoP
	Lcujubqykd9KWo04dmG2qpg+ubt+ir0w6CLJynfdd5QKUXuw1ptnNGguVa6TQ4mAGaBlAy4XYrAPP
	tBvcZuDvKnVJztHPb+bkHnUj4SgfH9Ok6Rq18YE+5AJVNxuAOXgFqFj8KX3igTShtKUIW+7NcS9wC
	o3vZWJig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUrUo-00000002Dnl-16CR;
	Mon, 06 Jan 2025 18:06:34 +0000
Date: Mon, 6 Jan 2025 10:06:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	adilger.kernel@dilger.ca, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
	Sai Chaitanya Mitta <mittachaitu@gmail.com>,
	linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
Message-ID: <Z3wbqlfoZjisbe1x@infradead.org>
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org>
 <20250106161732.GG1284777@mit.edu>
 <Z3wEhXakqrW4i3UC@infradead.org>
 <20250106173133.GB6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106173133.GB6174@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 06, 2025 at 09:31:33AM -0800, Darrick J. Wong wrote:
> I think we should wire it up as a new FALLOC_FL_WRITE_ZEROES mode,
> document very vigorously that it exists to facilitate pure overwrites
> (specifically that it returns EOPNOTSUPP for always-cow files), and not
> add more ioctls.

That goes into a similar direction to what I'd prefer.

> (That said, doesn't BLKZEROOUT already do this for bdevs?)

Yes. But the same is true for the other fallocate modes on block
devices.

