Return-Path: <linux-fsdevel+bounces-31537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D313B998488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F0B22C38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFFD1C245C;
	Thu, 10 Oct 2024 11:11:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE331BDAA5;
	Thu, 10 Oct 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558676; cv=none; b=lNGtKTSQs6LuBxKWW9CBq4QAwQZcWkYQl6o0KqN8dX5CYIUjlgeH3h9RyEreBJe1unbuzm8J6EzMnjE2b1YYi+WKnX+ev2tPScS0rKLBZGeinHyXCU1rtdjaFhXccP4C4dvRVP2IkROPPTp6fXTk9imqgAk4Aqb+zxvWV7i2M6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558676; c=relaxed/simple;
	bh=tioH2+Nu0/O0BVQptKPKvWiYwH+xyZ2L4a0+gMS1QYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ca9XIPXl91PfQfLY23OLg/WL20UHvpHqJa/ZcOSetrzBcUe7fPkuu9O/I8Xf3hK3vHTJAr69zK11xY6QmJtKyFoH8mU67NCuidkAf8QTyjKMl+naBnA5aeg2f8QM696FsKhY/9N5KqZLOAC/U+Hj8n1TZipsWgscd1CNF5lBgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPRrf4h3jz4f3k6M;
	Thu, 10 Oct 2024 19:10:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 705371A0A22;
	Thu, 10 Oct 2024 19:11:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sZMtgdnmHXPDg--.37048S4;
	Thu, 10 Oct 2024 19:11:10 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 0/3] add support for drop_caches for individual filesystem
Date: Thu, 10 Oct 2024 19:25:40 +0800
Message-Id: <20241010112543.1609648-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sZMtgdnmHXPDg--.37048S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1xtF1DGF4kur1DKryDJrb_yoWDKrg_Z3
	WfXrykWFWxZan7Jay7KFnxCFZxKrs5GF1DZ3W5JrWDtFyjvFs8Ja1DXry5uw1UWrnagFn0
	kw1vqrnYqr17CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

In order to better analyze the issue of file system uninstallation caused
by kernel module opening files, it is necessary to perform dentry recycling
on a single file system. But now, apart from global dentry recycling, it is
not supported to do dentry recycling on a single file system separately.
This feature has usage scenarios in problem localization scenarios.At the
same time, it also provides users with a slightly fine-grained
pagecache/entry recycling mechanism.
This patchset supports the recycling of pagecache/entry for individual file
systems.

Ye Bin (3):
  vfs: introduce shrink_icache_sb() helper
  sysctl: add support for drop_caches for individual filesystem
  Documentation: add instructions for using 'drop_fs_caches sysctl'
    sysctl

 Documentation/admin-guide/sysctl/vm.rst | 27 ++++++++++++++++
 fs/drop_caches.c                        | 43 +++++++++++++++++++++++++
 fs/inode.c                              | 17 ++++++++++
 fs/internal.h                           |  1 +
 include/linux/mm.h                      |  2 ++
 kernel/sysctl.c                         |  9 ++++++
 6 files changed, 99 insertions(+)

-- 
2.31.1


