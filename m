Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8BC5704AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiGKNwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiGKNwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B85361B17
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657547561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXxw8023X5Ng7EOWnmeS1q1VSSsbgfI4xN4bjScnx08=;
        b=CrE1fMtIRRXxtY4ZodSgT65A0bLr4PiYBkhZMr8xT6CIW07DPp3tyUXyBXRQWi5hoy/x7h
        4foQbUeKgvmsuwH7WWpl5oiTRe87roCLTJpetCfe8gljvShUaaJR2cc2tqONybwWrvSQBv
        LeRPjDLhehtSNZmqyoMnAY9fZstd3wQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-TJYriBkXMFySrijOEM6Z1w-1; Mon, 11 Jul 2022 09:52:38 -0400
X-MC-Unique: TJYriBkXMFySrijOEM6Z1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 555A938005C4;
        Mon, 11 Jul 2022 13:52:38 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22B8F18EA8;
        Mon, 11 Jul 2022 13:52:38 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com, willy@infradead.org
Subject: [PATCH v2 2/4] idr: support optional id tagging
Date:   Mon, 11 Jul 2022 09:52:35 -0400
Message-Id: <20220711135237.173667-3-bfoster@redhat.com>
In-Reply-To: <20220711135237.173667-1-bfoster@redhat.com>
References: <20220711135237.173667-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Certain idr users can benefit from generic tagging support of the
underlying radix-tree (or xarray) data structure. For example, a
readdir of the /proc root dir performs an inefficient walk of the
pid namespace idr tree. This involves checking the entry of every
allocated id for a group leader task association. Expose a simple,
single tag interface for idr users to facilitate more efficient
scans in situations like this.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 include/linux/idr.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..44e8bb287d0e 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -27,6 +27,7 @@ struct idr {
  * to users.  Use tag 0 to track whether a node has free space below it.
  */
 #define IDR_FREE	0
+#define IDR_TAG		1
 
 /* Set the IDR flag and the IDR_FREE tag */
 #define IDR_RT_MARKER	(ROOT_IS_IDR | (__force gfp_t)			\
@@ -174,6 +175,31 @@ static inline void idr_preload_end(void)
 	local_unlock(&radix_tree_preloads.lock);
 }
 
+static inline void idr_set_tag(struct idr *idr, unsigned long id)
+{
+	radix_tree_tag_set(&idr->idr_rt, id - idr->idr_base, IDR_TAG);
+}
+
+static inline bool idr_get_tag(struct idr *idr, unsigned long id)
+{
+	return radix_tree_tag_get(&idr->idr_rt, id - idr->idr_base, IDR_TAG);
+}
+
+/*
+ * Find the next id with the internal tag set.
+ */
+static inline void *idr_get_next_tag(struct idr *idr, unsigned long id)
+{
+	unsigned int ret;
+	void *entry;
+
+	ret = radix_tree_gang_lookup_tag(&idr->idr_rt, &entry,
+					 id - idr->idr_base, 1, IDR_TAG);
+	if (ret != 1)
+		return NULL;
+	return entry;
+}
+
 /**
  * idr_for_each_entry() - Iterate over an IDR's elements of a given type.
  * @idr: IDR handle.
-- 
2.35.3

