Return-Path: <linux-fsdevel+bounces-55233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BA8B0891A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359AF5801D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A82877E4;
	Thu, 17 Jul 2025 09:17:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9D4260590;
	Thu, 17 Jul 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743879; cv=none; b=mHCKD1AHt8YIpj9bXZGHpsKvW5yZAu/VBkzT/9Hqs0M3/VEaVEVpruixQXRwSO7dinRqhTglI0/ScTL2vLKk8tlrOZnlS2RpQLwTjrDB0RfdE5XNaIDH7mvqM5z3ERA9nMBR9qMScOsBhKolw3lkeBk43q4z3rPmrXF/e3tWIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743879; c=relaxed/simple;
	bh=TFQvGPlZdyuG12zsrvtzhTTnD8Pu2WUNbg8XKZaoLyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M++GB0I0AfInYXhBGEWxEStcPOfgxj8K5zKM2o4RR8PCU3pMjeZyHs4+GTyGPxJzI7nI2DJjVeATomQ75aGehI6zTM8kNzF9UdzxoN8rrRgxluSfgLdlSHX5K/CPRGYvXhQEthVH5du65FPPHYwrzwnjgLZyAlFa9w7BGcHzly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bjS0B1TcCz2Cf6y;
	Thu, 17 Jul 2025 17:13:46 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F4C2140123;
	Thu, 17 Jul 2025 17:17:53 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 17:17:52 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <jack@suse.com>, <brauner@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <yukuai3@huawei.com>, <yangerkun@huawei.com>
Subject: [bug report] A filesystem abnormal mount issue
Date: Thu, 17 Jul 2025 17:11:50 +0800
Message-ID: <20250717091150.2156842-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100017.china.huawei.com (7.202.181.16)

Currently, we have the following test scenario:

disk_container=$(
    ${docker} run...kata-runtime...io.kubernets.docker.type=container...
)
docker_id=$(
    ${docker} run...kata-runtime...io.kubernets.docker.type=container...
    io.katacontainers.disk_share="{"src":"/dev/sdb","dest":"/dev/test"}"...
)

${docker} stop "$disk_container"
${docker} exec "$docker_id" mount /dev/test /tmp -->success!!

When the "disk_container" is started, a series of block devices are
created. During the startup of "docker_id", /dev/test is created using
mknod. After "disk_container" is stopped, the created sda/sdb/sdc disks
are deleted, but mounting /dev/test still succeeds.

The reason is that runc calls unshare, which triggers clone_mnt(),
increasing the "sb->s_active" reference count. As long as the "docker_id"
does not exit, the superblock still has a reference count.

So when mounting, the old superblock is reused in sget_fc(), and the mount
succeeds, even if the actual device no longer exists. The whole process can
be simplified as follows:

mkfs.ext4 -F /dev/sdb
mount /dev/sdb /mnt
mknod /dev/test b 8 16    # [sdb 8:16]
echo 1 > /sys/block/sdb/device/delete
mount /dev/test /mnt1    # -> mount success

The overall change was introduced by: aca740cecbe5 ("fs: open block device
after superblock creation"). Previously, we would open the block device
once. Now, if the old superblock can be reused, the block device won't be
opened again.

Would it be possible to additionally open the block device in read-only
mode in super_s_dev_test() for verification? Or is there any better way to
avoid this issue?


