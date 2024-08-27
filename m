Return-Path: <linux-fsdevel+bounces-27336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342A9605B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025971F2314A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D8019DF61;
	Tue, 27 Aug 2024 09:36:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6319DF40;
	Tue, 27 Aug 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751362; cv=none; b=A2LBOs5xqczE8ot6DcrFeyLBDVsk4B/V7cUov0G8PSIzZECnQ1YiyIXaaxFOC8kYazaMAVo3KdZwQ790t4M19PMe8UP4KjjTbvp0OoVpBhp0uNI7qo5OpdyNOP4iBhFLY1mVuNEdgYPeBYiJo3ZHq5C2/o5wtNWeFZTBhr4lxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751362; c=relaxed/simple;
	bh=RGfuWuXORTqCxlSQ6u+6us/3p/DUYFfpTERGn7cV2lo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BcY52YxFlwskbPP/b2DIinkUQp2wTU4udOIRxN/EKswdARbooOq6IKPRpf8yOpPOGeLuMZHc/4MAo4KRnqxds3Rn+Rys/j1QrPczIuBeObLyUp0ndJNGvVNwFI+TGDj8nZtsrleE+q+CTCRszLzXnyumE6d/opTVMWKXF3LwoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtMq74vwQz1j7FS;
	Tue, 27 Aug 2024 17:35:47 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 738C81400F4;
	Tue, 27 Aug 2024 17:35:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 17:35:56 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lixiaokeng@huawei.com>
Subject: [PATCH v3 0/2] fuse: add no forget support
Date: Tue, 27 Aug 2024 17:35:01 +0800
Message-ID: <20240827093503.3397562-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100024.china.huawei.com (7.221.188.41)

FUSE_FORGET requests are not used in some cases (e.g., juicefs) but have 
an impact on the system. So add no forget support. The details about no
forget support can be seen in the following patches.

Patch 1 cleans up the allocation and the processing of forget requests.
Patch 2 adds the no forget support based on patch 1.

The link of libfuse with no forget support:
https://github.com/yangyun50/libfuse/commit/ef7061fef6f8c7154c975e1b0348dc9f12f945fe
It enables the no forget by default if the filesystem doesn't implement
the forget operation (i.e., se->op.forget == NULL).

---

v1: 
https://lore.kernel.org/lkml/20240726083752.302301-1-yangyun50@huawei.com/
v2:
https://lore.kernel.org/lkml/20240824092553.730338-1-yangyun50@huawei.com/

Changes from v1->v2:
- Still use fuse_queue_forget in patch 1 (Miklos)
- Simplify function name in patch 2 (Josef)

Changes from v2->v3:
- Still preallocate fuse_forget_link on the inode creation in patch1 (Miklos)

yangyun (2):
  fuse: move fuse_forget_link allocation inside fuse_queue_forget()
  fuse: add support for no forget requests

 fs/fuse/dev.c             | 16 ++++++++--
 fs/fuse/dir.c             | 63 +++++++++------------------------------
 fs/fuse/fuse_i.h          | 33 +++++++++++++++++---
 fs/fuse/inode.c           | 53 ++++++++++++++++----------------
 fs/fuse/readdir.c         | 38 ++++++-----------------
 include/uapi/linux/fuse.h |  3 ++
 6 files changed, 96 insertions(+), 110 deletions(-)

-- 
2.33.0


