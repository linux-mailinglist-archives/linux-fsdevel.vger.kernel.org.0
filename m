Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880802D0F66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgLGLge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgLGLgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:36:31 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A56AC08E85E;
        Mon,  7 Dec 2020 03:35:45 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so9603841pfb.9;
        Mon, 07 Dec 2020 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8dMrBUV0z9hLgybDV1qAgRrexcK6XcuJtlWOIrJYhH0=;
        b=QSXG0JhfnoAGvVBFx63sba2FOkjDtHFQBx/E4eY2XASWrdpLT0Ew5Lxo9DejGl9h++
         5V2/EM/2abVeCbQe6r6uVAcXu38nGBRW5kLnKtZtrVY4TlxWPSKHSY/zlUjObVbTs+wL
         x9eXcsTw9I5f8s7ws9VtyPX5JLLnZOlJuXOxZXXyCPUjoqPY9XoS104KOPsvqi2TP9Qr
         dlnqXrw19GS6AKRnSVxl8hUOIkMKM9yyU4zUfq/dJvLXMP8hln1Ay82xzQkUBHKSwNDx
         ejDThi/5DYZ0I6J/39QFbRF3Y/8kvDD3Eiy1+tKCQcQLGzMn2NiZ6exaemi55aBwIr5D
         oy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8dMrBUV0z9hLgybDV1qAgRrexcK6XcuJtlWOIrJYhH0=;
        b=rqDUjrk9EBFzosUBsLuEIPuUifylOKbqG4xu0KnAcUBzOy52Ay+soY4tZnJT5N+z77
         eQjSsKS/umKVTqH9EKIiL0cK2uj6ZAswIDoAVYNHt7q1iGhDOy5J17WqgTkq4tAIwE5g
         11DIOBna0vQ+yc6PKw/0J56Kv2Z4jKHmi4qAWEVbfj6AaaVvJoTeYT26IrHBcO6OtcBF
         evcUGCW2HvHV9RgQLQY2ZPsdnFJgc+3qvBRZYcENziJk6fwoXkbV2d2uhg1TTlS6lvxe
         kTaPkSUUWQeEECWNnXPaKsd+3bZVfKPZirbkNz5O2tYXPvCL4A2dPTot8Ho7nfidu3j3
         DLtQ==
X-Gm-Message-State: AOAM530EPFOaGZ/Nf+uduxfYSpksR9a+B35ZKeM7LDqKIKvxiLuxSyaq
        Pyp/WuKryd9hicpkKI1IvP4=
X-Google-Smtp-Source: ABdhPJxr+/fznfTo2BDgJytsbTQDDtDhOhsgkc3XiXicQdpt2zupWpmvamPhl7LZ72PAGPtdf/AUSg==
X-Received: by 2002:a05:6a00:7c5:b029:19e:2965:7a6 with SMTP id n5-20020a056a0007c5b029019e296507a6mr2120711pfu.60.1607340945089;
        Mon, 07 Dec 2020 03:35:45 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:44 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC V2 37/37] Add documentation for dmemfs
Date:   Mon,  7 Dec 2020 19:31:30 +0800
Message-Id: <6a3a71f75dad1fa440677fc1bcdc170f178be1d8.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Introduce dmemfs.rst to document the basic usage of dmemfs.

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 Documentation/filesystems/dmemfs.rst | 58 ++++++++++++++++++++++++++++++++++++
 Documentation/filesystems/index.rst  |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/filesystems/dmemfs.rst

diff --git a/Documentation/filesystems/dmemfs.rst b/Documentation/filesystems/dmemfs.rst
new file mode 100644
index 00000000..f13ed0c
--- /dev/null
+++ b/Documentation/filesystems/dmemfs.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+The Direct Memory Filesystem - DMEMFS
+=====================================
+
+
+.. Table of contents
+
+   - Overview
+   - Compilation
+   - Usage
+
+Overview
+========
+
+Dmemfs (Direct Memory filesystem) is device memory or reserved
+memory based filesystem. This kind of memory is special as it
+is not managed by kernel and it is without 'struct page'. Therefore
+it can save extra memory from the host system for various usage,
+especially for guest virtual machines.
+
+It uses a kernel boot parameter ``dmem=`` to reserve the system
+memory when the host system boots up, the details can be checked
+in /Documentation/admin-guide/kernel-parameters.txt.
+
+Compilation
+===========
+
+The filesystem should be enabled by turning on the kernel configuration
+options::
+
+        CONFIG_DMEM_FS          - Direct Memory filesystem support
+        CONFIG_DMEM             - Allow reservation of memory for dmem
+
+
+Additionally, the following can be turned on to aid debugging::
+
+        CONFIG_DMEM_DEBUG_FS    - Enable debug information for dmem
+
+Usage
+========
+
+Dmemfs supports mapping ``4K``, ``2M`` and ``1G`` size of pages to
+the userspace, for example ::
+
+    # mount -t dmemfs none -o pagesize=4K /mnt/
+
+The it can create the backing storage with 4G size ::
+
+    # truncate /mnt/dmemfs-uuid --size 4G
+
+To use as backing storage for virtual machine starts with qemu, just need
+to specify the memory-backed-file in the qemu command line like this ::
+
+    # -object memory-backend-file,id=ram-node0,mem-path=/mnt/dmemfs-uuid \
+        share=yes,size=4G,host-nodes=0,policy=preferred -numa node,nodeid=0,memdev=ram-node0
+
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 98f59a8..23e944b 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -120,3 +120,4 @@ Documentation for filesystem implementations.
    xfs-delayed-logging-design
    xfs-self-describing-metadata
    zonefs
+   dmemfs
-- 
1.8.3.1

