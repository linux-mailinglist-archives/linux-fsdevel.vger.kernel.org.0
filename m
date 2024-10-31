Return-Path: <linux-fsdevel+bounces-33329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 039ED9B75A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 08:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C8BB23924
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 07:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD915667D;
	Thu, 31 Oct 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JU9NToMG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A76145335;
	Thu, 31 Oct 2024 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360794; cv=none; b=Pe8Tj0fLpK3nuBoMNM9mICSZJONQWkd6LE74s4CpnU5x8tT1UxQyOG2BS3/C3Z88nqonnNZNgNwh4fKUcuTHW6IYwaf5wNVz3WEaKXcHX1x7tmFCIyvf61IEOTpzLWzD/1o5YDTAZZOdHaZuVhbcdgkA31HmK4KKeFcxB43uWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360794; c=relaxed/simple;
	bh=LO8Ci0ae9Y8Y0UdUGzx5luX8NEoGnj562SvJpkzsmdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIcH9N+F+a/LAHYo/SoOm3+MzYhzW6PM30Lmns51B10O7yJ8HiVDkPb1lPfW8BTXc3IbY6olnGMqhT6e6gmeZK36UsGYJJiAHcl0IeM6GIlu0slIc5vsourvfjBApKe5PKN13X376KncvBcZ2uE1ALq4TUoVsAg/mYbC6eIHE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JU9NToMG; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730360781; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HcJhglacALWuErvFcSYaoS/PumrISEPMTBp9tpEVtaY=;
	b=JU9NToMG1NE7dhLQugwOCUH+LDb9TZJJBrcUimBaTXgPIY02Sx2eesIXcRCiUxapEKrGMRjxP++wdYXg47e5GXn5aE63wLuxuQDjC1jHONKfnvWay1eQRjZ2K1i7aYj2QgSDlPOiLiPQgEXJiX6x+sb52ne6p/Og21jBYlwL9g0=
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0WIHa4Ov_1730360778 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 15:46:19 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: corbet@lwn.net,
	axboe@kernel.dk,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu,
	tglx@linutronix.de,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	bp@alien8.de,
	xiongwei.song@windriver.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: guanjun@linux.alibaba.com
Subject: [PATCH RFC v1 0/2] Support for limiting the number of managed interrupts on every node per allocation.
Date: Thu, 31 Oct 2024 15:46:16 +0800
Message-ID: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

We found that in scenarios with a large number of devices on the system,
for example, 256 NVMe block devices, each with 2 I/O queues, about a few
dozen of interrupts cannot be allocated, and get the error code -ENOSPC.
The reason for this issue is that the io queue interrupts are set to managed
interrupts (i.e., affinity is managed by the kernel), which leads to a
excessive number of the IRQ matrix bits being reserved.

This patch series support for limiting the number of managed interrupt
per allocation to address this issue.

Thanks,
Guanjun


Guanjun (2):
  genirq/affinity: add support for limiting managed interrupts
  genirq/cpuhotplug: Handle managed IRQs when the last CPU hotplug out
    in the affinity

 .../admin-guide/kernel-parameters.txt         | 12 ++++
 block/blk-mq-cpumap.c                         |  2 +-
 drivers/virtio/virtio_vdpa.c                  |  2 +-
 fs/fuse/virtio_fs.c                           |  2 +-
 include/linux/group_cpus.h                    |  2 +-
 include/linux/irq.h                           |  2 +
 kernel/cpu.c                                  |  2 +-
 kernel/irq/affinity.c                         | 11 ++--
 kernel/irq/cpuhotplug.c                       | 51 +++++++++++++++++
 lib/group_cpus.c                              | 55 ++++++++++++++++++-
 10 files changed, 130 insertions(+), 11 deletions(-)

-- 
2.43.5


