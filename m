Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78F687C42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 12:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjBBLaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 06:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjBBLai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:30:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60254577;
        Thu,  2 Feb 2023 03:30:32 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 78CF16602EF0;
        Thu,  2 Feb 2023 11:30:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675337430;
        bh=vLKWj5//Zawv0HDUOAPz3B4soyCTnmWzd0wVrOxevEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckNO74WBHEGIncMfejSOR510T/8wB9MB00CaiU+blSg51WPIaE4wcPwxMUkwzV4UU
         WskrW7Z1biJhLEWhZDkS5uw5BMj/OGVnp6R39bOyPfbFmHnJVsjK9xOgn18wE6hSL5
         W2yR+C4iW7Rcblo243JSxZXDeJrZ4OwiyFa9fYu5QkaPtkoEcFTsjfiAlDn4GCegZV
         opgp6A/vMjwx1Mez8Ebxw++3S/20ewAru2kuXyL0Gn1bOy11bvDbB7FuP/ZfRKXmms
         SR7wT1jyG9A/JueueH/Yy5/cYdnBqSq4kXb2KMIJR7FyF76zuzTKTTE8b5SM38ww0e
         awUF+YVxh0iRg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v10 2/6] userfaultfd: update documentation to describe UFFD_FEATURE_WP_ASYNC
Date:   Thu,  2 Feb 2023 16:29:11 +0500
Message-Id: <20230202112915.867409-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230202112915.867409-1-usama.anjum@collabora.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Explain the difference created by UFFD_FEATURE_WP_ASYNC to the write
protection (UFFDIO_WRITEPROTECT_MODE_WP) mode.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 83f31919ebb3..4747e7bd5b26 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -221,6 +221,13 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
 you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
 used.
 
+If ``UFFD_FEATURE_WP_ASYNC`` is set while calling ``UFFDIO_API`` ioctl, the
+behaviour of ``UFFDIO_WRITEPROTECT_MODE_WP`` changes such that faults for
+anon and shmem are resolved automatically by the kernel instead of sending
+the message to the userfaultfd. The hugetlb isn't supported. The ``pagemap``
+file can be read to find which pages have ``PM_UFFD_WP`` flag set which
+means they are write-protected.
+
 QEMU/KVM
 ========
 
-- 
2.30.2

