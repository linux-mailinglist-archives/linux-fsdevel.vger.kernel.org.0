Return-Path: <linux-fsdevel+bounces-20445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC88D384F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535FDB22793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41386537E8;
	Wed, 29 May 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="CzeaDneB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA7535D2;
	Wed, 29 May 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990363; cv=none; b=GJo5Omu0ktYINl7fpjonBH1IlpBiGzN0pNosE0XuvXfyCgWX4n+Zr5FtWNyasXPHhN957v/kOx9gawt8fQYI7tdHoOsJ4TrHBATsf4LReO8dpzx30StCM6zicct/CTQ6wqpjur1eU+l2MxA6Ezit06r84uXXqpxCa4lLSbO+2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990363; c=relaxed/simple;
	bh=tYxgOZpL9wE9TtMvSNYEF6HkpD7oBPGV/0zfayQjdi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9IT4ZLx01UWYFnG7H5Vl1al+KtziIawXnx2G5DHxWOPhLfG2Abkm2jKdXGiia5QnppCLyErt8kQhJrkjNYferJYw7TZHjbHsQrbwpvZQlgOJqso2eBXUupiibWw1kFUa4QdwMQ9IJhHjgdeILmyBJfyozihLikevaWMubs0FAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=CzeaDneB; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vq9dL3YDrz9spp;
	Wed, 29 May 2024 15:45:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+RsMcbV5eI3QqbTnWxDqe2O4kUw7UzqHd/STS+Ml6s=;
	b=CzeaDneBn3N/GkSraY0dI6MZ/hR0flpo+tMra3TU1FhLWffBKR5nIK0+/3AuP2B8sHuMQd
	E3pHAlZBeUCfHAkyL8kSg6tKrD2S1hUXT09TkdM2nvJVLTwgPdLfox5AicjQlvSmX3wZCi
	NaaO0Ss4cU1CXsFLjfpYw1qUDOSyKBdILF5Ly3afcAZ7OdD0Gw44loPxSjUQ4eMuCP1AWa
	mrXmV5BHgtYyZH7lqKNoja9s+ZneW6O3a7L1VOEQDqEArXxIaPJbkTYPytPbMv0kXCQa+5
	v9WwG/lvUPRDn0Lo12NNwoedrZF8p74tK1SA3vPmGGsBKp1rDFqeIRfAptX+VA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 09/11] xfs: expose block size in stat
Date: Wed, 29 May 2024 15:45:07 +0200
Message-Id: <20240529134509.120826-10-kernel@pankajraghav.com>
In-Reply-To: <20240529134509.120826-1-kernel@pankajraghav.com>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vq9dL3YDrz9spp

From: Pankaj Raghav <p.raghav@samsung.com>

For block size larger than page size, the unit of efficient IO is
the block size, not the page size. Leaving stat() to report
PAGE_SIZE as the block size causes test programs like fsx to issue
illegal ranges for operations that require block size alignment
(e.g. fallocate() insert range). Hence update the preferred IO size
to reflect the block size in this case.

This change is based on a patch originally from Dave Chinner.[1]

[1] https://lwn.net/ml/linux-fsdevel/20181107063127.3902-16-david@fromorbit.com/

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/xfs_iops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ff222827e550..a7883303dee8 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -560,7 +560,7 @@ xfs_stat_blksize(
 			return 1U << mp->m_allocsize_log;
 	}
 
-	return PAGE_SIZE;
+	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
 STATIC int
-- 
2.34.1


