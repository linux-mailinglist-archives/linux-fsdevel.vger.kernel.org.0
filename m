Return-Path: <linux-fsdevel+bounces-23086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BD926DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 05:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6071F2639A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AC18AED;
	Thu,  4 Jul 2024 03:03:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B151CA84;
	Thu,  4 Jul 2024 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062212; cv=none; b=tOs1Vw4urOUf9calOC4iA+StECnUDlJ8ENfd98Y0xQusZjqmOCSiisD6ETXSjgOdocMArPCazl8M3CiilN50DSr/KY/orJRukcEztbNb8X6tP9S8j/Zpw4ofo+r0tLcef+JbLab7k1ttpEED+/3CIzGiBcBu+YEcARAzXFYzgd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062212; c=relaxed/simple;
	bh=gJgmr8iquJwncRQAJ9hj3W/YzioCZdhjL08I9J5UPt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H2wCf/eUl9mXKaid2ES9j7t2i74xOx7z5lUy7mwmTpjzRaw/KVq/ynXmrB0lqCwMnIUpQZNjO65c6OG1LaOTF8dAUaHLhA0ZRyC4XqIFAdUHZEikX4ac/uJexhSsvLSWmPKNBKEIPohr2zLai5yiiutdSO67C2tUWH1kWqwuwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WF1ZB2hMHzxTF6;
	Thu,  4 Jul 2024 10:58:58 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F06F180A9C;
	Thu,  4 Jul 2024 11:03:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 11:03:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>
CC: <linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v2 0/2] Introduce tracepoint for hugetlbfs
Date: Thu, 4 Jul 2024 11:07:02 +0800
Message-ID: <20240704030704.2289667-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Here we add some basic tracepoints for debugging hugetlbfs: {alloc, free,
evict}_inode, setattr and fallocate.

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
 include/trace/events/hugetlbfs.h | 160 +++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/hugetlbfs.h

-- 
2.34.1


