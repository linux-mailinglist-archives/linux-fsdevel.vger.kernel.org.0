Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701756D8352
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjDEQOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 12:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDEQOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:14:36 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B411372A5;
        Wed,  5 Apr 2023 09:14:12 -0700 (PDT)
Received: from mx1.veeam.com (mx1.veeam.com [172.18.34.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 899BC41AA3;
        Wed,  5 Apr 2023 12:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1680711220;
        bh=aqBezH/TItv53h8zriybwSj1fO3L4xhtSNqGkkUsBIo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QVaBi6uLLL0vy286rAmPkG/r+IBkTEBxkh+cagf7nvUMyoTcQm76Sg37CK0oYTk2W
         hu/NKFW+nh6Wxd7fta9V2aTn0F1wzgkxMlfMGTEthMNpswO7TeD6mimJcMwjFM97FK
         sykcuKkjNB10FGXy4viUSR05YT99bdX+aLpKgIUme0uu42uON8KsrF/9E+UDNk4nV+
         q/AIwU9oMx7yWdUSOTyoB5ul/y7gtrbkjUWaRAWW/QxzIM6zuXNhlrI0tcvSFK0kYD
         RTzlb41ldDhWjTjb6l4haQeu8YGj3P+BMg0R615vDOTEHG8M2iiV7Z87OP8Hv4ZLgt
         j6oVGIzgj9Q0Q==
Received: from mx4.veeam.com (mx4.amust.local [172.31.224.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id CA0FA423FD;
        Wed,  5 Apr 2023 06:09:15 -0400 (EDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 4AED1C1A3C;
        Tue,  4 Apr 2023 17:09:02 +0300 (MSK)
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Apr 2023 16:08:58 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v3 01/11] documentation: Block Device Filtering Mechanism
Date:   Tue, 4 Apr 2023 16:08:25 +0200
Message-ID: <20230404140835.25166-2-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230404140835.25166-1-sergei.shtepa@veeam.com>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554657367
X-Veeam-MMEX: True
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The document contains:
* Describes the purpose of the mechanism
* A little historical background on the capabilities of handling I/O
  units of the Linux kernel
* Brief description of the design
* Reference to interface description

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/block/blkfilter.rst | 64 +++++++++++++++++++++++++++++++
 Documentation/block/index.rst     |  1 +
 MAINTAINERS                       |  6 +++
 3 files changed, 71 insertions(+)
 create mode 100644 Documentation/block/blkfilter.rst

diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkfilter.rst
new file mode 100644
index 000000000000..084340e4a440
--- /dev/null
+++ b/Documentation/block/blkfilter.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Block Device Filtering Mechanism
+================================
+
+The block device filtering mechanism is an API that allows to attach block
+device filters. Block device filters allow perform additional processing
+for I/O units.
+
+Introduction
+============
+
+The idea of handling I/O units on block devices is not new. Back in the
+2.6 kernel, there was an undocumented possibility of handling I/O units
+by substituting the make_request_fn() function, which belonged to the
+request_queue structure. But none of the in-tree kernel modules used this
+feature, and it was eliminated in the 5.10 kernel.
+
+The block device filtering mechanism returns the ability to handle I/O units.
+It is possible to safely attach filter to a block device "on the fly" without
+changing the structure of block devices stack.
+
+It supports attaching one filter to one block device, because there is only
+one filter implementation in the kernel yet.
+See Documentation/block/blksnap.rst.
+
+Design
+======
+
+The block device filtering mechanism provides registration and unregistration
+for filter operations. The struct blkfilter_operations contains a pointer to
+the callback functions for the filter. After registering the filter operations,
+filter can be managed using block device ioctl BLKFILTER_ATTACH,
+BLKFILTER_DETACH and BLKFILTER_CTL.
+
+When the filter is attached, the callback function is called for each I/O unit
+for a block device, providing I/O unit filtering. Depending on the result of
+filtering the I/O unit, it can either be passed for subsequent processing by
+the block layer, or skipped.
+
+The filter can be implemented as a loadable module. In this case, module
+unloading is blocked while the filter is attached to at least one of the block
+devices.
+
+Interface description
+=====================
+
+The ioctl BLKFILTER_ATTACH and BLKFILTER_DETACH use structure blkfilter_name.
+It allows to attach a filter to a block device or detach it.
+
+The ioctl BLKFILTER_CTL use structure blkfilter_ctl. It allows to send a
+filter-specific command.
+
+.. kernel-doc:: include/uapi/linux/blk-filter.h
+
+To register in the system, the filter creates its own account, which contains
+callback functions, unique filter name and module owner. This filter account is
+used by the registration functions.
+
+.. kernel-doc:: include/linux/blk-filter.h
+
+.. kernel-doc:: block/blk-filter.c
+   :export:
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 102953166429..e56d89db7b85 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -10,6 +10,7 @@ Block
    bfq-iosched
    biovecs
    blk-mq
+   blkfilter
    cmdline-partition
    data-integrity
    deadline-iosched
diff --git a/MAINTAINERS b/MAINTAINERS
index 1dc8bd26b6cf..2cbe4331ac97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3571,6 +3571,12 @@ M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
 F:	drivers/leds/leds-blinkm.c
 
+BLOCK DEVICE FILTERING MECHANISM
+M:	Sergei Shtepa <sergei.shtepa@veeam.com>
+L:	linux-block@vger.kernel.org
+S:	Supported
+F:	Documentation/block/blkfilter.rst
+
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
-- 
2.20.1

