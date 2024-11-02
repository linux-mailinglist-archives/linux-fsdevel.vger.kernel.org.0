Return-Path: <linux-fsdevel+bounces-33515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF19B9CE2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA08D1C21873
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8BE1591F0;
	Sat,  2 Nov 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tOPao4rr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B11494DF;
	Sat,  2 Nov 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524112; cv=none; b=dICyLC514/K2TBOacqq+0AIrPOuLFOj6dOHhNF22rmkjx2NZ7bRf6SHtdwgf73Vw2plBZ1GAA6NZA8gm/hz/sLa2pA5FNv9GTVKrqVdlwf5xKtSfim3vy83VUnBzPw5HbBmUiJY0p1HZrikA7iid8zIXkMWwIEx71sysbuAt+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524112; c=relaxed/simple;
	bh=sGTcAUiGVLEDGqPSB8HmkSEtRH2WiNbtHwjWUKB+q50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWIcs8WpeM3q0of+r+6xaycMXJIpM0i4PAQ8CBm3pMRy/r3mtmfazoD+i3urYbixRt2jXlXQdwKSb7S3i1srF2ZMMIZK1GsgWMCUjeA/ka4jYxXGllLuGBQt/VV4EomVXAXUueLP9RxX+7lptsRhBmO2hE7F91vVFFILUhuQgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tOPao4rr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=flBzqqDxuxfyj/8d8RwBEQnk2fBHRBP88D+U/M93Ays=; b=tOPao4rr9xiS6qd73QTSbfPBOw
	2NnrzDyu0eFdCnljx4GLcRe2YTDsFgU8wHEmYnADEW8QCQN53N8wZJNtUgJyT/P44nP54a59vw3MW
	+ku8I4HSrWl0z70cDXUZfVU/QdX0JS41gaIhYgf9siMN1inzTBZsKcP68dQ2IuPKWVPVOCJoloa30
	o/I7/2+1nzoRShj7ny3j2TvstiViRDriyJzWCSaBJfbux731SdwqIm2ug/T4lVx4PKZeNteLxuQyN
	H8TpZLbitZYyxPInzp1wcvyXYseGgB7Pgld7Sm5VOeRRoFzaPA+f2RCc2A3LY85LET37L7eOJg81m
	cumyEujg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NA-0000000AHms-3HiD;
	Sat, 02 Nov 2024 05:08:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 12/28] o2hb_region_dev_store(): avoid goto around fdget()/fdput()
Date: Sat,  2 Nov 2024 05:08:10 +0000
Message-ID: <20241102050827.2451599-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Preparation for CLASS(fd) conversion.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/cluster/heartbeat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 4b9f45d7049e..bc55340a60c3 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1770,23 +1770,23 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	int live_threshold;
 
 	if (reg->hr_bdev_file)
-		goto out;
+		return -EINVAL;
 
 	/* We can't heartbeat without having had our node number
 	 * configured yet. */
 	if (o2nm_this_node() == O2NM_MAX_NODES)
-		goto out;
+		return -EINVAL;
 
 	fd = simple_strtol(p, &p, 0);
 	if (!p || (*p && (*p != '\n')))
-		goto out;
+		return -EINVAL;
 
 	if (fd < 0 || fd >= INT_MAX)
-		goto out;
+		return -EINVAL;
 
 	f = fdget(fd);
 	if (fd_file(f) == NULL)
-		goto out;
+		return -EINVAL;
 
 	if (reg->hr_blocks == 0 || reg->hr_start_block == 0 ||
 	    reg->hr_block_bytes == 0)
@@ -1908,7 +1908,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	}
 out2:
 	fdput(f);
-out:
 	return ret;
 }
 
-- 
2.39.5


