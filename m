Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B035A1CA92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfENOkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 10:40:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbfENOkt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 10:40:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DDC09F6CE1E7655CB130;
        Tue, 14 May 2019 22:40:42 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 May 2019
 22:40:34 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <miaoxie@huawei.com>
Subject: [PATCH 0/2] block: add info messages when opening a block device O_WRITE and O_EXCL concurrently
Date:   Tue, 14 May 2019 22:45:04 +0800
Message-ID: <1557845106-60163-1-git-send-email-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Open an exclusive-opened block device for write or open a write-opened
block deviece exclusively cannot make sure it is exclusive enough. So
it may corrupt the block device when some one writing data through the
counterpart raw block device, such as corrupt a mounted file system.
And it is hard to find the bad process who corrupt the device after
something bad happens.

Although we can watch the block device in the user space, we still want
the kernel can give us some messages if that happens for some special
cases. So this patch set want to add some info messages to hint the
potential data corruption.

zhangyi (F) (2):
  block: add info when opening an exclusive opened block device for
    write
  block: add info when opening a write opend block device exclusively

 fs/block_dev.c     | 38 +++++++++++++++++++++++++++++++++++---
 include/linux/fs.h |  1 +
 2 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.7.4

