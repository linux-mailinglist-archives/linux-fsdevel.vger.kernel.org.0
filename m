Return-Path: <linux-fsdevel+bounces-24614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6459E941587
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209061F248F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677421A38C6;
	Tue, 30 Jul 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OjhQt4h0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E6618A92F;
	Tue, 30 Jul 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353934; cv=none; b=BgcQgUH6fvWU+Zcfs4a6DMx5wkvafao4DUnoV56MdAbp0UgAfUQXieolf1LDP0ff/0ZKqBl3dw2SaI9StE0A1osqevL2Bnp5zm7nwYTxxOTLD0Uas8edGseQSuyh3qs4mnXZ0YgO04AQUb1KEGtMGKT9Gfvtwr0LBtC+uxj7nvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353934; c=relaxed/simple;
	bh=i6pgSMEHg/5xofzxdXM7OtXe7jLNxbJqEOi3Np4nYq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfWazsiyOhblmabNXS0r9FQeNLg+9cANo4LuvrYIfFdkt5I9IjhyRpFyS0m9dV3QVtwOmbWZb6rEhsXtLzlHvj1Cf52qJlbi4hYvLXCySQgKV1rROswzwpYdPv7qMXGXh4ZetInX+ccL07YVGVVgRXzg+amRP83eA7IqXDZuKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OjhQt4h0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sxsFs2hPLHi+XqCwIbcUXSHtwWQihjmSFt20iDztleY=; b=OjhQt4h0nWplLdqdaBJKPJppSY
	cSJWuAlirS4GclWJ3YnUNRh3NnpDmzridD9l932mbQPIX6Qmbv2aoU73rv3Rc/K6+dYwv7dPLXBQV
	KVoCjXC04w1jOAHjbKwbPiuMcf7tkPIBxXtnUF1SkxRnjZTsiN29RNFSRvFF8FBUu2mdHCwN7q8YQ
	5nq9tcdmlHik+0XAOBL6woxEVuiKWtst3bxa+VX+7KJVNeYTC/ESAy+/egk4AqAW7DDN28Tjxwvat
	kanQBisv5IMMxDmcZ7upF8Cyaja2+HkdHjrmglHnvlUG5xoenvgqAZLrREjKzBMjuV+bP9BOrZQi4
	3dWxqSBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYow7-0000000Fgnv-0KNB;
	Tue, 30 Jul 2024 15:38:51 +0000
Date: Tue, 30 Jul 2024 08:38:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Mateusz Guzik <mjguzik@gmail.com>,
	Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <ZqkJC5vPKRUkIH6m@infradead.org>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <20240729133601.GA557749@mit.edu>
 <ZqhQnWQSweXgffdD@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqhQnWQSweXgffdD@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 30, 2024 at 12:31:57PM +1000, Dave Chinner wrote:
> There are at least two different "is this inode identical"
> use cases that {st_dev,st_ino} is being used for.
> 
> The first, as Florian described, is to determine if two open fds
> refer to the same inode for collision avoidance.
> 
> This works on traditional filesystems like ext4 and XFS, but isn't
> reliable on filesystems with integrated snapshot/subvolume
> functionality.

It's not about snapshot, it's about file systems being broken.  Even
btrfs for example always has a unique st_dev,st_ino pair, it can
just unexpectly change at any subvolume root and not just at a mount
point.

> That is our long term challenge: replacing the use of {dev,ino} for
> data uniqueness disambiguation. Making the identification of owners
> of non-unique/shared data simple for applications to use and fast
> for filesystems to resolve will be a challenge.

I don't think there is any way to provide such a guarantee as there
is so many levels of cloning or dedup, many of which are totally
invisible to the high level file system interface.


