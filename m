Return-Path: <linux-fsdevel+bounces-15067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF76D88695F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 10:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EB028ADBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376B21370;
	Fri, 22 Mar 2024 09:36:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9E208DD;
	Fri, 22 Mar 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100183; cv=none; b=mryff4ezG8Hr2QyQLjCYH27oBr8McdUOvq6M8N4QjZG+CNtb1wKA7ICD0NePGP6fSuTXdmdeieo4rCT6e6MzqZIi/10vXcrivb6xpnYvOKS9c677etfKr7cQrDpRxaVaS/yCrurA353ihnyv9kacqQ9g60IW4cLkcnB26sBaZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100183; c=relaxed/simple;
	bh=w9Z3i0b5pe74kxTQVWjcv3AKhdTObu1bWsq0KMWECbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OKaZ2k8uvIII4g860eJWYfrXQ/Wp3j0R/Emq7zTbPe6d+SfmZwLv7paAItvF6QmsVgS5Izs8sT+xzNBSUT7nX6FviTArn6sBPXHhRQy7mNXUXnhAXd0HvcW/K1tmsYlcdS14JbrqaN7PKxeKzrgC+6/ay1mTclXtKG8mGOMHJ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1HGP0xK6z1xsQm;
	Fri, 22 Mar 2024 17:34:21 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F12C1A016C;
	Fri, 22 Mar 2024 17:36:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 22 Mar
 2024 17:36:15 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 0/2] Fix I/O high when memory almost met memcg limit
Date: Fri, 22 Mar 2024 17:35:53 +0800
Message-ID: <20240322093555.226789-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200004.china.huawei.com (7.185.36.141)

v1->v2:
  1. Replace the variable active_refault with mmap_miss. Now mmap_miss will
     not decreased if folio is active prior to eviction.
  2. Jan has given me other two patches which aims to let mmap_miss properly
     increased when the page is not ready. But in my scenario, the problem
     is that the page will be reclaimed immediately. These two patches have
     no logic conflict with Jan's patches[3].

Recently, when install package in a docker which almost reached its memory
limit, the installer has no respond severely for more than 15 minutes.
During this period, I/O stays high(~1G/s) and influence the whole machine.
I've constructed a use case as follows:

  1. create a docker:

	$ cat test.sh
	#!/bin/bash
  
	docker rm centos7 --force

	docker create --name centos7 --memory 4G --memory-swap 6G centos:7 /usr/sbin/init
	docker start centos7
	sleep 1

	docker cp ./alloc_page centos7:/
	docker cp ./reproduce.sh centos7:/

	docker exec -it centos7 /bin/bash

  2. try reproduce the problem in docker:

	$ cat reproduce.sh
	#!/bin/bash
  
	while true; do
		flag=$(ps -ef | grep -v grep | grep alloc_page| wc -l)
		if [ "$flag" -eq 0 ]; then
			/alloc_page &
		fi

		sleep 30

		start_time=$(date +%s)
		yum install -y expect > /dev/null 2>&1

		end_time=$(date +%s)

		elapsed_time=$((end_time - start_time))

		echo "$elapsed_time seconds"
		yum remove -y expect > /dev/null 2>&1
	done

	$ cat alloc_page.c:
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include <string.h>

	#define SIZE 1*1024*1024 //1M

	int main()
	{
		void *addr = NULL;
		int i;

		for (i = 0; i < 1024 * 6 - 50;i++) {
			addr = (void *)malloc(SIZE);
			if (!addr)
				return -1;

			memset(addr, 0, SIZE);
		}

		sleep(99999);
		return 0;
	}


We found that this problem is caused by a lot ot meaningless read-ahead.
Since the docker is almost met memory limit, the page will be reclaimed
immediately after read-ahead and will read-ahead again immediately.
The program is executed slowly and waste a lot of I/O resource.

These two patch aim to break the read-ahead in above scenario.

[1] https://lore.kernel.org/linux-mm/c2f4a2fa-3bde-72ce-66f5-db81a373fdbc@huawei.com/T/
[2] https://lore.kernel.org/all/20240201100835.1626685-1-liushixin2@huawei.com/
[3] https://lore.kernel.org/all/20240201173130.frpaqpy7iyzias5j@quack3/

Liu Shixin (2):
  mm/readahead: break read-ahead loop if filemap_add_folio return
    -ENOMEM
  mm/readahead: increase mmap_miss when folio in workingset

 include/linux/pagemap.h |  2 ++
 mm/filemap.c            |  7 ++++---
 mm/readahead.c          | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.25.1


