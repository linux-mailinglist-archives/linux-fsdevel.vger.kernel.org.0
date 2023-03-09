Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27646B2615
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjCIOBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCIOAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D89F28AF;
        Thu,  9 Mar 2023 05:57:51 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.145.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A8945660304F;
        Thu,  9 Mar 2023 13:57:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678370270;
        bh=9oFwL3f6YkfzcALLDj4AoV5PtSOwgfu6T9QXZoMtKjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHJXZ9aklc385OAP63KNxa4u90d+4zhFaDd0ssuVCleaV3TR2OCZtOcf5YQhpQ5vp
         qhDVbdJiT0XCCOObbEdnJbrpOR7lENU5O97hDcH71ZOsws/FCLYghPKrukK6xrYEBy
         xSp/XwmoKYHwntSWtW+Sn+UBDUN6DiLoJ25UXbkuYB1urxqDhctrLTdgoHzHQzczzd
         NYMuOYjcvkU8x6J1nwzGhxfOV1fR9qfdaJhiPOfyHM13xnbjMD3Rm0gdojiF7BJqpe
         VZ8DL/Jsw80n47fKZbxKnITBB3P9alebvmgAOWjA9Y3uR1O4Vz4KzuXqbcSUpZnD34
         fG8C27zfuo8jw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v11 2/7] userfaultfd: Define dummy uffd_wp_range()
Date:   Thu,  9 Mar 2023 18:57:13 +0500
Message-Id: <20230309135718.1490461-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309135718.1490461-1-usama.anjum@collabora.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
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

Define uffd_wp_range() for the cases when CONFIG_USERFAULTFD isn't set.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 include/linux/userfaultfd_k.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index b680c0ec8b85..fd1a1ecdb5f6 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -182,6 +182,14 @@ extern int userfaultfd_wp_async(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
+extern inline long uffd_wp_range(struct mm_struct *dst_mm,
+				 struct vm_area_struct *vma,
+				 unsigned long start, unsigned long len,
+				 bool enable_wp)
+{
+	return 0;
+}
+
 /* mm helpers */
 static inline vm_fault_t handle_userfault(struct vm_fault *vmf,
 				unsigned long reason)
-- 
2.39.2

