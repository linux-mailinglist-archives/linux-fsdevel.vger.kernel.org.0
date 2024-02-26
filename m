Return-Path: <linux-fsdevel+bounces-12779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9772C867042
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63E328DA8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E47172A;
	Mon, 26 Feb 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="X9VroBu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1D6F071;
	Mon, 26 Feb 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941034; cv=none; b=EjlDZjCEl9NtHR79vSHwMU85cSRYAyO8uTgbkdR7TbwU/pCqN6H8p1o9WWlSm3qZSL+1nkaBb1m9GDrzCjyi2JHLfF0iKogdpAQoHPUwEbRXggOwl9TDAB2nV1TCKF/QeO1LxmAs1EOZYK/sI+uBmt+gOmtYCqGl/TjGOKxbx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941034; c=relaxed/simple;
	bh=RKzUrbiIAwV//xUeCFeu109a33mJKvzhblm+B+JiUEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdZ7f9ba5FgZNBc6kwd0PZYI9CD0gyCLWNEDgQVNiYAbn8oPZi7dsTlRh/J99bwv2Nw7QKfyJt8Gs8LAbbqx0AkScHqgqA8CoIy9pMBfejNBf8Vo7M53OFhBOLGAMlUFaMPBjdUzmoPpRXKmaoLsZA60fBshlBPnslBKahAutzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=X9VroBu+; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TjwpY6Hqyz9t0C;
	Mon, 26 Feb 2024 10:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708941029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zh8crSzzd1QnmeV1OcknR37ATkgZhCAIPO7aiRL4a8s=;
	b=X9VroBu+3yO5IgXXT944eaTQlnsCiIDYHWBS+LxO8jDzLeA9zPRPzGeQfbvBJBDt8oQVil
	9z/Jroy3X9i5rjyglZl5s+1FojOZZK88Y+XGNkbBm8GWNmi28d75LAv2D11kpCozfKUKZs
	C/RtBKkXLZ42ChZZiXt/0ETwe/ylfB5qbLaywpGRm9QkT1pglMn9HnC2tkNPrKiyxtug7O
	zL8gNSCtEFROdxvnAcR3uWDZE1AYGHQUtXzOojhM9P4tfYwPQKgeUKqePIHm1/SFUPJKip
	94vDoTelo97v9/BKF2OAD9svWm7Ox8jcJAUWYLurePCPkDU98tjP1ggrHhzjSA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 11/13] xfs: expose block size in stat
Date: Mon, 26 Feb 2024 10:49:34 +0100
Message-ID: <20240226094936.2677493-12-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

For block size larger than page size, the unit of efficient IO is
the block size, not the page size. Leaving stat() to report
PAGE_SIZE as the block size causes test programs like fsx to issue
illegal ranges for operations that require block size alignment
(e.g. fallocate() insert range). Hence update the preferred IO size
to reflect the block size in this case.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
dd2d535e3fb29d ("xfs: cleanup calculating the stat optimal I/O size")]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/xfs/xfs_iops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a0d77f5f512e..1b4edfad464f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -543,7 +543,7 @@ xfs_stat_blksize(
 			return 1U << mp->m_allocsize_log;
 	}
 
-	return PAGE_SIZE;
+	return max_t(unsigned long, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
 STATIC int
-- 
2.43.0


