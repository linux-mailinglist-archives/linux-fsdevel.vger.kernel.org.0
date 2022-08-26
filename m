Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407FA5A2123
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 08:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbiHZGqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 02:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbiHZGqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:46:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C634D21D2;
        Thu, 25 Aug 2022 23:46:10 -0700 (PDT)
Received: from lenovo.Home (unknown [39.53.61.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 28ACA6601EC7;
        Fri, 26 Aug 2022 07:46:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661496369;
        bh=qFwfAW+YdGQMEoUt1Jsqu4meeyL+SBRRa4jSpOBxxag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqLhLBD000uR8bos55kq6B0zd6KcI+zVA3+3+1lh9CHVeLA7Xtm5TlApu0RsP5K6Q
         GaTS146h+PQSc60dfjK0trnYUuQOrRDaO9xp9SZwkO26Fwo6/AXsB68X7nL6ejn2xN
         sbI/9tPhriK2OPjmRvSqjE99pvEhHSjGwslyTNLwsJ3HTxVrAQVWKYgarxEMYKm+0l
         Sgty4ZQl62sAs2T9NeauCEYI6N5UOeifcCNSLx+EGyN5ZtKTej96u354C53osstFIm
         3A8U9UByjTVrOhh56q9iP0+NkyA9dw5QqnJ9qx6XihHoVtVxicMbVyfE8C40X1Q7TP
         ampV4YcnPyCtg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v3 4/4] mm: add documentation of the new ioctl on pagemap
Date:   Fri, 26 Aug 2022 11:45:35 +0500
Message-Id: <20220826064535.1941190-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826064535.1941190-1-usama.anjum@collabora.com>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the explanation of the added ioctl on pagemap file. It can be used
to get, clear or both soft-dirty PTE bit of the specified range.
or both at the same time.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v2:
- Update documentation to mention ioctl instead of the syscall
---
 Documentation/admin-guide/mm/soft-dirty.rst | 42 ++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/soft-dirty.rst b/Documentation/admin-guide/mm/soft-dirty.rst
index cb0cfd6672fa..d3d33e63a965 100644
--- a/Documentation/admin-guide/mm/soft-dirty.rst
+++ b/Documentation/admin-guide/mm/soft-dirty.rst
@@ -5,7 +5,12 @@ Soft-Dirty PTEs
 ===============
 
 The soft-dirty is a bit on a PTE which helps to track which pages a task
-writes to. In order to do this tracking one should
+writes to.
+
+Using Proc FS
+-------------
+
+In order to do this tracking one should
 
   1. Clear soft-dirty bits from the task's PTEs.
 
@@ -20,6 +25,41 @@ writes to. In order to do this tracking one should
      64-bit qword is the soft-dirty one. If set, the respective PTE was
      written to since step 1.
 
+Using IOCTL
+-----------
+
+The IOCTL on the ``/proc/PID/pagemap`` can be can be used to find the dirty pages
+atomically. The following commands are supported::
+
+	MEMWATCH_SD_GET
+		Get the page offsets which are soft dirty.
+
+	MEMWATCH_SD_CLEAR
+		Clear the pages which are soft dirty.
+
+	MEMWATCH_SD_GET_AND_CLEAR
+		Get and clear the pages which are soft dirty.
+
+The struct :c:type:`pagemap_sd_args` is used as the argument. In this struct:
+
+  1. The range is specified through start and len. The len argument need not be
+     the multiple of the page size, but since the information is returned for the
+     whole pages, len is effectively rounded up to the next multiple of the page
+     size.
+
+  2. The output buffer and size is specified in vec and vec_len. The offsets of
+     the dirty pages from start are returned in vec. The ioctl returns when the
+     whole range has been searched or vec is completely filled. The whole range
+     isn't cleared if vec fills up completely.
+
+  3. The flags can be specified in flags field. Currently only one flag,
+     PAGEMAP_SD_NO_REUSED_REGIONS is supported which can be specified to ignore
+     the VMA dirty flags for better performance. This flag shows only those pages
+     dirty which have been written to by the user. All new allocations aren't returned
+     to be dirty.
+
+Explanation
+-----------
 
 Internally, to do this tracking, the writable bit is cleared from PTEs
 when the soft-dirty bit is cleared. So, after this, when the task tries to
-- 
2.30.2

