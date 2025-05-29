Return-Path: <linux-fsdevel+bounces-50042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5151AC7A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 10:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF235010F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4E21B8EC;
	Thu, 29 May 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DCrdjF0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D627701;
	Thu, 29 May 2025 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748507055; cv=none; b=XxElF5pLZF+h8xbMnF27v9rnkg1N+DWoXNeI+ZtWkRZNBYbRIzvV8cL4x3V32mfK6ip0SzU/6BKwIk2Tnl1UeLV8zeRG8PYa728eLHsU2I2axl7DngEhGjHRnWvBwJdZi/9r3wGP8YOTPeZmURLFxzMKnINr6oBHzl4s9ysVCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748507055; c=relaxed/simple;
	bh=vrGVMqD8oiYUI5fgZIyes0Vtw9CoDW9M0YlqZ8DsACM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRFj+E9K8d1PmiM0ZCfHqrszrB2K82ef/8YG+GRNEoofC37eoF2RkWtdOtQOm/28Qksi5nJ0IYp0SUpzpV9EoxSKT5eYhYiEtfB8OdiWQICuQ5v93Y8vcUNJKauQuBtCi3ifjdXUs90JL8NwTlUVzlGJv2uc7QcolkUfFLnWBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DCrdjF0z; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748507043; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rHQ5IFMFz26jdO9u/LuyDZaGGbuCphbm2pbt0cuoQG4=;
	b=DCrdjF0z3/NrGHav3kEEJsLu0AscTGw1dH/LAWitr7Vu7gfS6DlnM9EjniSN4z92e4tyb+DS/iU0s+TKQP60Dae59GGB9u+G3K9ghpqx1OPkAfO2bCIf27MOM0c6sSHeRHtNhO1i3uMnpyG+ipElO2fTQDwoz2S9WlXnPXnDMks=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcGcFjT_1748507041 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 May 2025 16:24:02 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix MADV_COLLAPSE issue if THP settings are disabled
Date: Thu, 29 May 2025 16:23:53 +0800
Message-ID: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we discussed in the previous thread [1], the MADV_COLLAPSE will ignore
the system-wide anon/shmem THP sysfs settings, which means that even though
we have disabled the anon/shmem THP configuration, MADV_COLLAPSE will still
attempt to collapse into a anon/shmem THP. This violates the rule we have
agreed upon: never means never. This patch set will address this issue.

[1] https://lore.kernel.org/all/1f00fdc3-a3a3-464b-8565-4c1b23d34f8d@linux.alibaba.com/

Baolin Wang (2):
  mm: huge_memory: disallow hugepages if the system-wide THP sysfs
    settings are disabled
  mm: shmem: disallow hugepages if the system-wide shmem THP sysfs
    settings are disabled

 include/linux/huge_mm.h | 23 +++++++++++++++++++----
 mm/huge_memory.c        |  2 +-
 mm/shmem.c              | 12 ++++++------
 3 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.43.5


