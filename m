Return-Path: <linux-fsdevel+bounces-9815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0584537B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7291F29164
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3198715AAAA;
	Thu,  1 Feb 2024 09:13:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B515A4B1;
	Thu,  1 Feb 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778794; cv=none; b=oG1S4DnbpHp0tVuxnkzlZ4WpqgPkoa2d7TRU/ayTHUv+ovXVqi4S+w7X4xy74Z9FBtjpo27N+CkDa4aZiFZjfusD2o3w8CqNB8UYZ9fNGlH2ciHGLZvTMIFIsp27h8XzLtbuYgME8ws6xWUkSjHOxlLl+sP7HPtWwFdQAZlf/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778794; c=relaxed/simple;
	bh=vdcjgpSSe3vHkaNcPGjjlLa0vhqVfEdHpZMs8SYg4f0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvGA8mjN8vkMyuEcNAqD4aAt5YmZi+UFKAyb1ihKkgCPIdqTDb95WgwyvbRKjF9pXbxnqb9wLpIBqGR0FeX+n6CS8t+PtmKSZ/voAmYHQwjisWlcqUNic1bXnqGKVzigaXnW8fGONF8m9KHxSD744QnRv8/D/gsy46Jxw/VPprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TQY6s3h8Bz1Q8Ks;
	Thu,  1 Feb 2024 17:11:17 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 205971400D4;
	Thu,  1 Feb 2024 17:13:09 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Thu, 1 Feb
 2024 17:13:08 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH 0/2] Fix I/O high when memory almost met memcg limit
Date: Thu, 1 Feb 2024 18:08:33 +0800
Message-ID: <20240201100835.1626685-1-liushixin2@huawei.com>
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

Recently, when install package in a docker environment where the memory
almost reached the memcg limit, the program have no respond severely for
more than 15 minutes. During this period, the I/O is high(~1G/s) which
cause other programs failed to work properly.

The problem can be constructed in the following way:

 1. Download the image:
	docker pull centos:7
 2. Create a docker with 4G memory limit and 6G memsw limit(cgroupv1):
	docker create --name dockerhub_centos7 --cpu-period=100000
	--cpu-quota=400000 --memory 4G --memory-swap 6G --cap-add=SYS_PTRACE
	--cap-add=SYS_ADMIN --cap-add=NET_ADMIN --cap-add=NET_RAW
	--pids-limit=20000 --ulimit nofile=1048576:1048576
	--ulimit memlock=-1:-1 dockerhub_centos7:latest /usr/sbin/init
 3. Start the docker:
	docker start dockerhub_centos7
 4. Allocate 6094MB memory in docker.
 5. run 'yum install expect'.

We found that this problem is caused by a lot ot meaningless readahead.
Since memory is almost met memcg limit, the readahead page will be
reclaimed immediately and will readahead and reclaim again and again.

These two patch will stop readahead early when memcg charge failed and
will skip readahead when there are too many active refault.

[1] https://lore.kernel.org/linux-mm/c2f4a2fa-3bde-72ce-66f5-db81a373fdbc@huawei.com/T/

Liu Shixin (2):
  mm/readahead: stop readahead loop if memcg charge fails
  mm/readahead: limit sync readahead while too many active refault

 include/linux/fs.h      |  2 ++
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 16 ++++++++++++++++
 mm/readahead.c          | 12 ++++++++++--
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.25.1


