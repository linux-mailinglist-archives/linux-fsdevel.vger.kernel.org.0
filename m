Return-Path: <linux-fsdevel+bounces-21489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF2904827
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 03:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12A9B22F07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEFF1865;
	Wed, 12 Jun 2024 01:10:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB71C2D;
	Wed, 12 Jun 2024 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718154607; cv=none; b=ubAzvefRmi++ByVn/3DuaO4QUEFkFKVzi8ogEEk/zP9CvgzvYsslCMThakD1P9MDUeEhGieM9G7OamqMYUg4hzGjVd6cegXvyPnqvl/4LJvhRjum+7gh4U0YBLlO9qAdtned6C8yn8wcG03QDwLNwywXBlrs0qkrKAreshoWOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718154607; c=relaxed/simple;
	bh=iq0WtoDJl5RmYn8pcEnqBbg1PURQTXEs1hmyCzkoNBs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jrHayHbsCAkgr3g3mFe60pioakSvf0lfKtOUXduwrj0gRL7/Va7+/bbRoXLgKKtEDkntfIYq90qlkPcz9WLCu4rXYDZOWCYftmDHhjf7fX8tVCMrQGA6deXPN5I2uX/x/0gmAFWrPJKPXppnlqhiGKXvCjvz2DR0J4/+4QnWofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VzS5v5VBBz1SBp3;
	Wed, 12 Jun 2024 09:05:55 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E3D65140257;
	Wed, 12 Jun 2024 09:10:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 09:10:00 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC: <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH 0/2] Introduce tracepoint for hugetlbfs
Date: Wed, 12 Jun 2024 09:11:54 +0800
Message-ID: <20240612011156.2891254-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Here we add some basic tracepoints for debugging hugetlbfs: {alloc, free,
evict}_inode, setattr and fallocate.

Hongbo Li (2):
  hugetlbfs: support tracepoint
  hugetlbfs: use tracepoints in hugetlbfs functions.

 MAINTAINERS                      |   1 +
 fs/hugetlbfs/inode.c             |  21 +++-
 include/trace/events/hugetlbfs.h | 164 +++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/hugetlbfs.h

-- 
2.34.1


