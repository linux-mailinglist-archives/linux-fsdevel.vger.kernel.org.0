Return-Path: <linux-fsdevel+bounces-27769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA500963BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E422823AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD006157488;
	Thu, 29 Aug 2024 06:33:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE981B813;
	Thu, 29 Aug 2024 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913195; cv=none; b=ajTi3IB/qpXFYCZ22gHlPckGykde6UxmWQHma6UIofws9kJLhA07s2chOXhaa25u3NsEY3dleYDZMuw8ac7Prh00sK6znUs/6gQvDIgTrXOCmIORUOHiOY0Bw1vaqENrQBYcvjgKFevLOWVi4WbeNN9c4ucUVrBRYaHoLqDowC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913195; c=relaxed/simple;
	bh=vz8NZV0J24MqlKQ6GuY6C74injV8xf7mS6Cf59vuhqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WsWSCE+3gEa7K330Qwg9JPAeK7sSrS45x3epbZmyZA1SzYBb6TVQyMkiE2BvBKtPgBwU+b6sNBFl6D+lfC6MOKZWKKmDqL8qCV8SHM6eGIXSPd0rWm8/fkLMhXOuuI930U70KDP025ZotCYI13MoGBG0FswUIlAQ0LaH7A3lrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvWd74PxgzfbVg;
	Thu, 29 Aug 2024 14:31:07 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E38B5180105;
	Thu, 29 Aug 2024 14:33:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 14:33:11 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>, <david@fromorbit.com>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RESEND v3 0/2] Introduce tracepoint for hugetlbfs
Date: Thu, 29 Aug 2024 14:41:08 +0800
Message-ID: <20240829064110.67884-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


