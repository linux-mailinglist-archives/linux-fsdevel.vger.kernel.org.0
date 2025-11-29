Return-Path: <linux-fsdevel+bounces-70231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E72C93CD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 12:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EA714E132F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624B30B527;
	Sat, 29 Nov 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="GQyIMp2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345D256C8B
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764415040; cv=none; b=ttL0cJfTE6lqDbOq5r+8CIohvGFqCh7ubngjIzsLXwDOaXZt+RjOSIjUXceIzWKdRre0J70BWCgPBlLdb2U6PbvxTTJwYqQc8X1AesOQHwNMO/vOYj8Vta5anqg5EzI5PpTU2fqn9jcGULsfpqJ3bhbXQhb/t8IHZooKFU/3hh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764415040; c=relaxed/simple;
	bh=uYjPK8CKKz3E68KMRGOxI99pfBo9E+BleAofHz500ws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vchj+RNuFiPletEtJ2y6wMSzRn45kUR8Gjk4aJ/YyG1BPjL2ID9I1J2enaq8cO0kI3U5PNcWtzLIe4FZHEyXJNQ0ACftlD2ZJBEix8Dpska0w5PVPoYvGsMoqZHY2dld3vrVu9Ok5vFREn7wr0+JAxTPUmB89LWupCFQrxHgO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=GQyIMp2T; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=34bSrCuEP2qDKZg9to35LeO7IpMvvzjgbg6Ao7rsgA4=;
	b=GQyIMp2Thupg4LVnVf22d37ndCD9sHZ5D8pWqvs5NlgmZJjpcmIiAvwR+LADjG18UlYycaUJw
	ZqzZknUl0RMXCrvHybNHn7mp2r8nT1vQcXVaVFaTIutEknKkLCavA0pT4QjFYPSs+FhOieoyWXc
	tzkvShvBzj2zrJ2/nyXvPjk=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dJSHb5WKHzcZyW;
	Sat, 29 Nov 2025 19:14:51 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 78296140144;
	Sat, 29 Nov 2025 19:17:12 +0800 (CST)
Received: from kwepemn100013.china.huawei.com (7.202.194.116) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 19:17:12 +0800
Received: from huawei.com (10.50.87.129) by kwepemn100013.china.huawei.com
 (7.202.194.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 29 Nov
 2025 19:17:11 +0800
From: Long Li <leo.lilong@huawei.com>
To: <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <bschubert@ddn.com>,
	<leo.lilong@huawei.com>, <yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: [PATCH] fuse: limit debug log output during ring teardown
Date: Sat, 29 Nov 2025 19:06:53 +0800
Message-ID: <20251129110653.1881984-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100013.china.huawei.com (7.202.194.116)

Currently, if there are pending entries in the queue after the teardown
timeout, the system keeps printing entry state information at very short
intervals (FUSE_URING_TEARDOWN_INTERVAL). This can flood the system logs.
Additionally, ring->stop_debug_log is set but not used.

Use ring->stop_debug_log as a control flag to only print entry state
information once after teardown timeout, preventing excessive debug
output. Also add a final message when all queues have stopped.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 fs/fuse/dev_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5ceb217ced1b..d71ccdf78887 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -453,13 +453,15 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 	 * If there are still queue references left
 	 */
 	if (atomic_read(&ring->queue_refs) > 0) {
-		if (time_after(jiffies,
+		if (!ring->stop_debug_log && time_after(jiffies,
 			       ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
 			fuse_uring_log_ent_state(ring);
 
 		schedule_delayed_work(&ring->async_teardown_work,
 				      FUSE_URING_TEARDOWN_INTERVAL);
 	} else {
+		if (ring->stop_debug_log)
+			pr_info("All queues in the ring=%p have stopped\n", ring);
 		wake_up_all(&ring->stop_waitq);
 	}
 }
-- 
2.39.2


