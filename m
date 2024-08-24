Return-Path: <linux-fsdevel+bounces-27022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC595DD25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 11:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52742282F5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247D15573B;
	Sat, 24 Aug 2024 09:26:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE914290;
	Sat, 24 Aug 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724491610; cv=none; b=BHvn5r90tpLUh8jVXXaTZF+R5krAS+vEpURjCOpkgIODp69ayGw6d2zIwuU9/mcu6ZoRYFl3AApDzk8UH1WCmpVkypUAkEf9wneQ5dea5zFwDqDDksJ497hGhbtq2hYgMsbVzkTh54Ziib7DkXavTzQPqr9dUe3Q+NDmlMxqjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724491610; c=relaxed/simple;
	bh=twc8I6wUXDHEln3CbTyIlvMUPnH4vHWVKr67ANsU5BY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qeowFQbPLb0amsPo2PyileVLt/pZCf3HymFmoi0z42eRP8P2oMlveXIe0X/V1rGaVHpUzKc8HpOOJbR22XV7Fk3hhdK3D0iZLnWyYJ38hEPKv8Btb3JusrTyX4ZhaAVSienihRR/e7PtJi9P7tbKQVZXN8MpZ9KuDwuRG6A3fFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WrWlb04cxzyR4h;
	Sat, 24 Aug 2024 17:26:19 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id D8DC9140118;
	Sat, 24 Aug 2024 17:26:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 17:26:44 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lixiaokeng@huawei.com>
Subject: [PATCH v2 0/2] fuse: add no forget support
Date: Sat, 24 Aug 2024 17:25:51 +0800
Message-ID: <20240824092553.730338-1-yangyun50@huawei.com>
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
an impact on the system. So add no forget support.

---

v1: 
https://lore.kernel.org/linux-fsdevel/20240726083752.302301-1-yangyun50@huawei.com/

Changes from v1->v2:
- Still use fuse_queue_forget in patch 1 (Miklos)
- Simplify function name in patch 2 (Josef)

yangyun (2):
  fuse: move fuse_forget_link allocation inside fuse_queue_forget()
  fuse: add support for no forget requests

 fs/fuse/dev.c             | 14 +++++++--
 fs/fuse/dir.c             | 63 +++++++++------------------------------
 fs/fuse/fuse_i.h          | 34 ++++++++++++++-------
 fs/fuse/inode.c           | 43 ++++++--------------------
 fs/fuse/readdir.c         | 37 +++++------------------
 include/uapi/linux/fuse.h |  3 ++
 6 files changed, 70 insertions(+), 124 deletions(-)

-- 
2.33.0


