Return-Path: <linux-fsdevel+bounces-28985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9A3972864
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7213B2306D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0602166307;
	Tue, 10 Sep 2024 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3JPY3lT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06C20314;
	Tue, 10 Sep 2024 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943195; cv=none; b=u15KYg9KR6Yro8qAqoFrz6Vk7tS/vpPKqPQuibeD8NsFoKQbk2cYE0A0AQ3E3InmmzsTpIGY4U7NiSQpLIGvP2DR9lDsnZEac0SD8LIj2wZ736sg9JJ+n+NxD7HUA4M0jkQRAUD6x5fzyKlkEqAPRga+EfrhGfMzg1iMyssZVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943195; c=relaxed/simple;
	bh=M3chPi4G/IZvE01DCKGYVq68tmqvS9cOOYbeCMTKzK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nO/xd0sK+OgDWUafKs7VNO84OyHT1miju5qQ8vePCEWpTaabGi9pszmRqAgVnJ9/2h9WT3BGOSWQm+QR8hii6J+7TSBac4YJ+VM3VfCFYDC6Snxk39fJKUmqJgtBlN2Ld7xw+HDJVVixL50AVGKzyHoTvDhsyzFDHfppsvTyRlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3JPY3lT2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VnaOMhbIJFQXiqVO4M9L4Hf7Y5aAX1c2h310HADF22Q=; b=3JPY3lT2ZiWcIUYfD7b+AwL75A
	+qLJB7KQ16xtanP6t3+SU+zPBoN2jg3pesQLy3jViFLi1ICKv7iwnfheDint7PnJE/RPVHCrzvtcH
	rLJweVXQ8oEUyh0JZ9vZM/zotKUgELGhDi2atYa/omRjrcCOiVU4/JzldhHnXN7tSsNM9Cl6ZJEor
	3XjYSIqi82BE3rRmrC9sURcoXerxhoDwX1fcbGlL4gRVJMbc/P8m0KYgIjMnUMx8/uzKQazbZ+GOR
	hjgzfTm0Kw2fMggie1M8tITl44iF6gBxLORueEelRaLdMJiV7j2hD5xCmlWAWTWVs9lRlIxSymZws
	+81YNyNA==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsfQ-00000004El2-1L6Y;
	Tue, 10 Sep 2024 04:39:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: fix stale delalloc punching for COW I/O v2
Date: Tue, 10 Sep 2024 07:39:02 +0300
Message-ID: <20240910043949.3481298-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is another fallout from the zoned XFS work, which stresses the XFS
COW I/O path very heavily.  It affects normal I/O to reflinked files as
well, but is very hard to hit there.

The main problem here is that we only punch out delalloc reservations
from the data fork, but COW I/O places delalloc extents into the COW
fork, which means that it won't get punched out forshort writes.

Changes since v1:
 - move the already reviewed iomap prep changes to the beginning in case
   Christian wants to take them ASAP
 - take the invalidate_lock for post-EOF zeroing so that we have a
   consistent locking pattern for zeroing.

Diffstat:
 fs/iomap/buffered-io.c |  139 +++++++++++++++++++++++--------------------------
 fs/xfs/xfs_aops.c      |    4 -
 fs/xfs/xfs_bmap_util.c |   10 ++-
 fs/xfs/xfs_bmap_util.h |    2 
 fs/xfs/xfs_file.c      |  139 ++++++++++++++++++++++++++++---------------------
 fs/xfs/xfs_iomap.c     |   59 +++++++++-----------
 include/linux/iomap.h  |   11 ++-
 7 files changed, 192 insertions(+), 172 deletions(-)

