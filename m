Return-Path: <linux-fsdevel+bounces-17997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118FE8B49BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928A7280EB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5653BE;
	Sun, 28 Apr 2024 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tmqO8hUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71D2F29;
	Sun, 28 Apr 2024 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714281159; cv=none; b=oIZgX+B9i/3b1B0w/0rSE5gnYb8UhvUH2bcHh8rtowiFiG7CFnv5X8LNzWFADHM+IuzfsjVjaupPhKzvQ5RG9TzgaSwmhDq3/hP125YwClZcC++GoZqSVSmbK/+7VCSG9T4Xk1st35bh4GSNk8poZziaUMnW3SgTlMFOn3YtTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714281159; c=relaxed/simple;
	bh=r9Ho+KlDjxV0rLDyAx8eIy/g9Dz8gIdf00skoYWcs7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qybfHUJcmmnYVtTKsku+d3YvWNSgcA6+Fpl6yLdCHyUDkiQTWw9nbUtg2Endu+uYX7jV/I4blAR+Nx5LdK/Q7JL+W5HW48sbX5v3dRfkd+3qXh5LS90ote55v4fLiZl0HRResnDGxjzw73gD4J6CVsp67/s4fELfyfG3n7XxxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tmqO8hUn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=f4+wgDKEDvq7+H7eHvKqVqQR5ySiP6zL0PAvsf8UskI=; b=tmqO8hUnMKUrKzBvG5tFyc98zO
	4tAqJdZNzb1KQCWAvLaqU6p8pCsD0VlruORLz8KllYfQbQhmPSn6YC8Eg8U9QVqNcxwpmihOqVBm2
	ldsDbXFZjHWW9DO3DzXOMV8Rw3YvPgcQZCu7wChyQzgBQcElneRO423H+voP5vIh+jAK1zD89xIWm
	JnZigouBN23x078oro7PVED0suB4QTIwRXvIHHI/zqE83xhdWHjT8Na+87gMvEivJKkEIEtr204zA
	DcbijkpDW63FjWoecMbVM5nFKBai95PB1PSFdpAHbQ8fm2yEDi6OqwerxKypZsoalVSDXaH2p/AwV
	EQ9SrFLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0wq0-006V7a-0Z;
	Sun, 28 Apr 2024 05:12:32 +0000
Date: Sun, 28 Apr 2024 06:12:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCHES][RFC] packing struct block_device flags
Message-ID: <20240428051232.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	We have several bool members in struct block_device.
It would be nice to pack that stuff, preferably without
blowing the cacheline boundaries.

	That had been suggested a while ago, and initial
implementation by Yu Kuai <yukuai1@huaweicloud.com> ran into
objections re atomicity, along with the obvious suggestion to
use unsigned long and test_bit/set_bit/clear_bit for access.
Unfortunately, that *does* blow the cacheline boundaries.

	However, it's not hard to do that without bitops;
we have an 8-bit assign-once partition number nearby, and
folding it into a 32-bit member leaves us up to 24 bits for
flags.  Using cmpxchg for setting/clearing flags is not
hard, and 32bit cmpxchg is supported everywhere.

	Series below does that conversion.  Please, review.
Individual patches in followups, the branch is in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.bd_flags

Shortlog:
Al Viro (8):
      Use bdev_is_paritition() instead of open-coding it
      wrapper for access to ->bd_partno
      bdev: infrastructure for flags
      bdev: move ->bd_read_only to ->__bd_flags
      bdev: move ->bd_write_holder into ->__bd_flags
      bdev: move ->bd_has_subit_bio to ->__bd_flags
      bdev: move ->bd_ro_warned to ->__bd_flags
      bdev: move ->bd_make_it_fail to ->__bd_flags

Diffstat:
 block/bdev.c              | 17 ++++++++---------
 block/blk-core.c          | 17 ++++++++++-------
 block/blk-mq.c            |  2 +-
 block/early-lookup.c      |  2 +-
 block/genhd.c             | 15 ++++++++++-----
 block/ioctl.c             |  5 ++++-
 block/partitions/core.c   | 12 ++++++------
 include/linux/blk_types.h | 19 +++++++++++--------
 include/linux/blkdev.h    | 42 +++++++++++++++++++++++++++++++++++++++---
 include/linux/part_stat.h |  2 +-
 lib/vsprintf.c            |  4 ++--
 11 files changed, 93 insertions(+), 44 deletions(-)

