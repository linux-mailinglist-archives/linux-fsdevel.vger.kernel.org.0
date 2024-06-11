Return-Path: <linux-fsdevel+bounces-21368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA72902ED9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288C2285B16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E4416F912;
	Tue, 11 Jun 2024 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1nxKK6ma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527F16F8E9;
	Tue, 11 Jun 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074928; cv=none; b=lSszpcUw6DQ/NoXCMkmlormpLtdzDkPishOGd/8FLPYQX8lmrepD+rs/WnvZnuBug28B0/NOH6dVStthLUId0KVUqxACk8x6LY9Y87WP6y5CX9ZQ4Bf9X/aka476bxf1WXmVfRanCRwJaLYyxfzTtDybcBpN9Z+xiG57bc0Jt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074928; c=relaxed/simple;
	bh=vrXcT+ygfo3v0hnWVSCWdT/lMLn3DQKVimBc32psqlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk3kIMSdqIooBlVuN9g1IcfsduepUiyNWI/hoWt70dkAwmy/bvBbgV9SnefhQuC+bPcKGpG7+YXpKgBl3jtslYSM4D1A8N1Sj+Tli8JbaexoRRsiaczJgzVI1xA+YO0uZ1JON9I4tYLoGxFYx56YPorcxgp2ZOniZIxVhqAZBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1nxKK6ma; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wq48ve+ETB2Mn5jcdAIJQV5YnUUyrMAbtjA78ekOIig=; b=1nxKK6manx1sElDBoPJ7VtBtTY
	bUl6Pc/MH1Qn6kwApk0hinVfqNSWdsKqIzlEM2p3EQzLx3+mdr64EEK3kTORBMs/wLbe+JwHSlqPw
	7K2R0BYtlhBN1yrZm01DqMGfYW6gCs1I1Fp83HBuwL+ZKzyFBQzugRo5+bmGx4EEbPZcuCYDis51/
	9NV7/SzoPtC++6KbL6T+xSZGXzIepu+cBx9E+VVrXDlLfs68ICpUjBBHggFw1nHVOMMvb6MRv/Pb2
	bOLDveyc4g0PU3iWVttzZCynRA+DjXsCMNyBXzUf2J568Zh2aFYS/YqXR82J2UPRKGdpiaIY7LZ6k
	3e2inVsA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGrls-00000007DDM-2LZP;
	Tue, 11 Jun 2024 03:02:04 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: patches@lists.linux.dev,
	fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	vbabka@suse.cz,
	seanjc@google.com,
	willy@infradead.org,
	david@redhat.com,
	hughd@google.com,
	linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	mcgrof@kernel.org
Subject: [PATCH 4/5] _require_debugfs(): simplify and fix for debian
Date: Mon, 10 Jun 2024 20:02:01 -0700
Message-ID: <20240611030203.1719072-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240611030203.1719072-1-mcgrof@kernel.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Using findmnt -S debugfs arguments does not really output anything on
debian, and is not needed, fix that.

Fixes: 8e8fb3da709e ("fstests: fix _require_debugfs and call it properly")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 18ad25662d5c..30beef4e5c02 100644
--- a/common/rc
+++ b/common/rc
@@ -3025,7 +3025,7 @@ _require_debugfs()
 	local type
 
 	if [ -d "$DEBUGFS_MNT" ];then
-		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
+		type=$(findmnt -rncv -T $DEBUGFS_MNT -o FSTYPE)
 		[ "$type" = "debugfs" ] && return 0
 	fi
 
-- 
2.43.0


