Return-Path: <linux-fsdevel+bounces-38450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1182A02DA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36FD161968
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24EC1DED66;
	Mon,  6 Jan 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AGn8M1Jx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1741DED70
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180427; cv=none; b=BdZXS0+BPUR+h+/dO3oE0WwL4F4TwYvwfOrtYOKYqde/ZIsRN4ixyVItv5lvQ/SPQMNQi557bAwyeiC6qoDhPLJ+rVaWu2967y6i5/KQGvDAymkV1QfcX1fYZSpOvDKGignT6LFmV0FBpIzzgfH/nkklQu/+0UnnYLy4uGzeEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180427; c=relaxed/simple;
	bh=08CjTAXcNllOpHbngukcppmmfL3j5mHqq1F42ZY/Ay8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL/BXtJuLEIAFQOtClho7nFn3nqn1PNaZkHL6qmgdLNQdUAleDYWOUt8V6ZM2zduBNIvq1gTagTW2x0u0AyBGqZXHB2HD9TtHpkXMOR1pg7XeFD6BXvDWN/KkxRtJjzdqkXHeQhlEOAZ2MgzZmHBlaQHNoBwuAjWXgUZoPegfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AGn8M1Jx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-117-149.bstnma.fios.verizon.net [173.48.117.149])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 506GHW7k007725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 11:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736180257; bh=NXScXVaoAKvLqsWBqs7KdteOT3Hvubxucjt3/r7nXWo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=AGn8M1JxhpFdMe57olflxB4reH+1M7lV3Wbo91mwonjDIC8JDnbL0sHZHt5wljWG6
	 70R3qB1VU8unS/Vx3dXkKbDke06qPpu09r11wjKyTZ0z8tckXf9yed8XwDXzZBB2bj
	 HAYPmIs7U7rPqcGPL2j2j3bijHrYSC6XGgbYBDQoTJGZbbmoVz+ZFAc2qyjVcCV5tj
	 j5pZeNwyNSSw4CiYeU3I4m6KPBJt/uefIpM2SA45+P0LHo/pSTnpYpw2qQANu99xk3
	 2ZseTZ2jRfcUpcSEOS/Yh3UAiZTnohd8GoKpX4ruNFgyvzmQv49LXCqby3iUybw26j
	 pIWwzjSNLxZqQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 73CFF15C0164; Mon, 06 Jan 2025 11:17:32 -0500 (EST)
Date: Mon, 6 Jan 2025 11:17:32 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        djwong@kernel.org, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
        Sai Chaitanya Mitta <mittachaitu@gmail.com>, linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
Message-ID: <20250106161732.GG1284777@mit.edu>
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3u-OCX86j-q7JXo@infradead.org>

On Mon, Jan 06, 2025 at 03:27:52AM -0800, Christoph Hellwig wrote:
> There's a feature request for something similar on the xfs list, so
> I guess people are asking for it.

Yeah, I have folks asking for this on the ext4 side as well.

The one caution that I've given to them is that there is no guarantee
what the performance will be for WRITE SAME or equivalent operations,
since the standards documents state that performance is out of scope
for the document.  So in some cases, WRITE SAME might be fast (if for
example it is just adjusing FTL metadata on an SSD, or some similar
thing on cloud-emulated block devices such as Google's Persistent Desk
or Amazon's Elastic Block Device --- what Darrick has called "software
defined storage" for the cloud), but in other hardware deployments,
WRITE SAME might be as slow as writing zeros to an HDD.

This is technically not the kernel's problem, since we can also use
the same mealy-mouth "performance is out of scope and not the kernel's
concern", but that just transfers the problem to the application
programmers.  I could imagine some kind of tunable which we can make
the block device pretend that it really doesn't support using WRITE
SAME if the performance characteristics are such that it's a Bad Idea
to use it, so that there's a single tunable knob that the system
adminstrator can reach for as opposed to have different ways for
PostgresQL, MySQL, Oracle Enterprise Database, etc have for
configuring whether or not to disable WRITE SAME, but that's not
something we need to decide right away.

> That being said this really should not be a modifier but a separate
> operation, as the logic is very different from FALLOC_FL_ZERO_RANGE,
> similar to how plain prealloc, hole punch and zero range are different
> operations despite all of them resulting in reads of zeroes from the
> range.

Yes.  And we might decide that it should be done using some kind of
ioctl, such as BLKDISCARD, as opposed to a new fallocate operation,
since it really isn't a filesystem metadata operation, just as
BLKDISARD isn't.  The other side of the argument is that ioctls are
ugly, and maybe all new such operations should be plumbed through via
fallocate as opposed to adding a new ioctl.  I don't have strong
feelings on this, although I *do* belive that whatever interface we
use, whether it be fallocate or ioctl, it should be supported by block
devices and files in a file system, to make life easier for those
databases that want to support running on a raw block device (for
full-page advertisements on the back cover of the Businessweek
magazine) or on files (which is how 99.9% of all real-world users
actually run enterprise databases.  :-)

						- Ted

