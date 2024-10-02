Return-Path: <linux-fsdevel+bounces-30649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC798CBE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 06:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E00B20D7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 04:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7577F2F;
	Wed,  2 Oct 2024 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u3ne0mRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59A768EF;
	Wed,  2 Oct 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841689; cv=none; b=TLloeQWYwcUANQ7UlBteRn478sFIneyZz9Q7Kn5dsCr3ls5nECSX3wpIKU2S5Tjr+M+0vYWunSosFrnv2p61sy/osAO8olEegKm6px5W6hrOQpvYOguw/x9gtm9gkwEs6tJQhXXd0ckQlHu7UzhD6OHIXjiS7r9QheQ4bUddnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841689; c=relaxed/simple;
	bh=upH05SPZeWf3z1O+76BUkauJESPuE1nir0WyLWgMRzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/+kUQ5MP1RAEA+gtf/fRcMtYe2UgTP/Sjj357fiRNu8A1Y4ay4MGdnSM58JBoblZO+2HIjFoT119yt/QiqvD+DodMgAh7WRRiRg9rtJY+9XnNgCZXd9fgUtaBkXbjqyi1Key8kNHnedghsYZ/quTvY8G6QpBUoMHKGkCfWU5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u3ne0mRn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=qTWDk1kkUMgIeurTOmfPiKAXAhCJoEcgc99PRps0kpM=; b=u3ne0mRns7ELZRkXZZ0jsFAjuU
	9+UEoQPPJlCYC4s1DwoHihZRglidPbi2TdC6hcczvJrklY/XKcU6UHezyYhcmNBkAvQJKMFf23TI5
	nds1YNcN3LtfSg5nBh+hdqMY3xxjCDoASaBTzeG41AqejoxwgtNE91pKitGXRP9F4w87aLDHTJ2MF
	lagBzpCuwBHm56k9X74oZnO0YAQp/mHId9wqXjKlzwEiXNl7fTY6GcdLOrCuwpeo5ehL7N4lfpj4Q
	WluO+DaW5YXrw/ucf2Z/PFFSUP3ny/YpeTYfHxCy4TEmLHDfLlZGwBQ8bBomzavO6Be33E5CVTipC
	DoPq0jqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svqY5-00000004I8R-2GZW;
	Wed, 02 Oct 2024 04:01:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] Filesystem page flags cleanup
Date: Wed,  2 Oct 2024 05:01:02 +0100
Message-ID: <20241002040111.1023018-1-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think this pile of patches makes most sense to take through the VFS
tree.  The first four continue the work begun in 02e1960aafac to make the
mappedtodisk/owner_2 flag available to filesystems which don't use
buffer heads.  The last two remove uses of Private2 (we're achingly
close to being rid of it entirely, but that doesn't seem like it'll
land this merge window).

Matthew Wilcox (Oracle) (6):
  fs: Move clearing of mappedtodisk to buffer.c
  nilfs2: Convert nilfs_copy_buffer() to use folios
  mm: Remove PageMappedToDisk
  btrfs: Switch from using the private_2 flag to owner_2
  ceph: Remove call to PagePrivate2()
  migrate: Remove references to Private2

 fs/btrfs/ctree.h           | 13 ++++---------
 fs/btrfs/inode.c           |  8 ++++----
 fs/btrfs/ordered-data.c    |  4 ++--
 fs/buffer.c                |  1 +
 fs/ceph/addr.c             | 20 ++++++++++----------
 fs/nilfs2/page.c           | 22 +++++++++++-----------
 include/linux/page-flags.h |  4 ++--
 mm/migrate.c               |  4 ++--
 mm/truncate.c              |  1 -
 9 files changed, 36 insertions(+), 41 deletions(-)

-- 
2.43.0


