Return-Path: <linux-fsdevel+bounces-18587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113148BAA36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FB71C21A08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953914F9FA;
	Fri,  3 May 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z24PE1Ua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866014F9CC;
	Fri,  3 May 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730042; cv=none; b=U+0MPfqyA3SXlIDqbcmWiuhf8PN45b85Smye4ptnpx6E+9cwhL/FbjicpKK8cYLgaoUl852nxzd4i6LAeRx9nzkW3tqmahkxOJkyZU+oqxqQW7SOdD1RNJufar85ZBZ6ygandR53UZajmBxzkJrfHMWrA/fgD7POKzVAV9zbNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730042; c=relaxed/simple;
	bh=1vCU6aJJlRQ0buAURdJIfhxigxywJ79N5DnLFI7w28U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWWAliCigVdMuiqlZ94khQL7D+9NUjqv0NgpkqbR/t/R095P7loMSXhUvAko5UoVllrI6PnbLri2Qyn4FjThrWqHlnGC9UvD3FA/2jlDoEGNFkSmqoK8pAhITDRf5pJrZOvocWVTpgsbxQqcRqulLGcYiHxxmaL+LEae/vki0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z24PE1Ua; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GqWnKea6V0gAe+YJTg8s/r2wucoemkpF8ihTzX0zeiQ=; b=Z24PE1UaSm2BVNZHztO+sfNPrc
	uYg0JsBNtR0fS2ERaAtyGFe5ZFhVB7uzbOZ29sCbbLaoYPU0QfPNYZRHq2xeQBAvQg+uFjksklAnh
	sRYEEG5OxlUp7optRBlZA+rX6zNEY2gXRyeOgRZuaszLG+Fo5M8hCGarPoZoJ2eLipVytnwdAbbAG
	O8zbNPjHdjom1hRDzzuz5DQHIyGXeNS0Arp353WvJWIoYBEhvf4GoVtvpnu5p6KhZV2pvgWtqAb0J
	5YLrehzXKq2PaFVIwhFdWLf78DN/6lHffCnqjQVWHTBfqJ0OXCc0M5lArYSI11zkmTjV1MQCUpKOP
	IceeO7aQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2pc3-0000000Fw3u-2DAJ;
	Fri, 03 May 2024 09:53:55 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com
Cc: hare@suse.de,
	ritesh.list@gmail.com,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v5 10/11] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Fri,  3 May 2024 02:53:52 -0700
Message-ID: <20240503095353.3798063-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503095353.3798063-1-mcgrof@kernel.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Pankaj Raghav <p.raghav@samsung.com>

Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
make the calculation generic so that page cache count can be calculated
correctly for LBS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_mount.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index df370eb5dc15..56d71282972a 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -133,9 +133,16 @@ xfs_sb_validate_fsb_count(
 {
 	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
+	uint64_t max_index;
+	uint64_t max_bytes;
+
+	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
+		return -EFBIG;
 
 	/* Limited by ULONG_MAX of page cache index */
-	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
+	max_index = max_bytes >> PAGE_SHIFT;
+
+	if (max_index > ULONG_MAX)
 		return -EFBIG;
 	return 0;
 }
-- 
2.43.0


