Return-Path: <linux-fsdevel+bounces-24105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5023939886
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 05:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD351F2157E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631D13B7B3;
	Tue, 23 Jul 2024 03:03:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46CEC2;
	Tue, 23 Jul 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703811; cv=none; b=m7eX7N9o18dldgnsUns8sapl272EFU2Xa4gUBQZtnKiKjU8sOwLC0VuSBug74X13qTvQNAZbExD+NtgzA1PnbvF31NT6rDC2vfa9eq1H29Jagn6hCGWE0pVMVT0hpOePveQ3iCciBU0YLY2szzQ6peN7xOQBKlxI4Bg8t8bb3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703811; c=relaxed/simple;
	bh=vz8NZV0J24MqlKQ6GuY6C74injV8xf7mS6Cf59vuhqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U7ko0TTZSjbpP8EQzWX5cada0HoROTOexT37XPm1MAmd3hkSHXZEjXVf/p+TnW0Qy/54xPS86oZUQsivOveM7sSWCDrK+JA7yfZAM+f9Pn1WYRgPLJJiiulYC8VHkCtVeTL0YeIf9SPtrDFSjv7Ed+ZOrEkRjYI8Olw2UsE8x54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WShfp57dLz1JDb8;
	Tue, 23 Jul 2024 10:58:26 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id F25AF14037E;
	Tue, 23 Jul 2024 11:03:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 23 Jul
 2024 11:03:25 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<david@fromorbit.com>
CC: <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH v3 0/2] Introduce tracepoint for hugetlbfs
Date: Tue, 23 Jul 2024 11:08:32 +0800
Message-ID: <20240723030834.213012-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Here we add some basic tracepoints for debugging hugetlbfs: {alloc, free,
evict}_inode, setattr and fallocate.

v2 can be found at:
https://lore.kernel.org/all/ZoYY-sfj5jvs8UpQ@casper.infradead.org/T/

Changes since v2:
  - Simplify the tracepoint output for setattr.
  - Make every token be space separated.


v1 can be found at:
https://lore.kernel.org/linux-mm/20240701194906.3a9b6765@gandalf.local.home/T/

Changes since v1:
  - Decrease the parameters for setattr tracer suggested by Steve and Mathieu.
  - Replace current_user_ns() with init_user_ns when translate uid/gid.

Hongbo Li (2):
  hugetlbfs: support tracepoint
  hugetlbfs: use tracepoints in hugetlbfs functions.

 MAINTAINERS                      |   1 +
 fs/hugetlbfs/inode.c             |  17 +++-
 include/trace/events/hugetlbfs.h | 156 +++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/hugetlbfs.h

-- 
2.34.1


