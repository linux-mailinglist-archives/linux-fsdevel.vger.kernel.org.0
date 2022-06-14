Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0F54B84F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 20:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbiFNSJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 14:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiFNSJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9D8D44A0F
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655230191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KrRV//rtrccNkJBTlKhGHOF/oF+ni+3ESEuTSMEs8E4=;
        b=Xczo7kSf+upM9cSuLA6zJZjKW2iO9IeA3pW4txMSIZhBrd16+Q+glxHOFeCKxQPtMkgXTE
        YYIrgjcaU1eUbK/ULtXwaXPCxRrze4ypJ+Rrj8ry6vgzX8G7vLu/qQGyqhT2OHF9cuJMeI
        Az1R8q+jEqwcdJYZkST1dKD1YSi82g4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-jt_LnJRONT2IvP9s2VjdPA-1; Tue, 14 Jun 2022 14:09:50 -0400
X-MC-Unique: jt_LnJRONT2IvP9s2VjdPA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BC38804196;
        Tue, 14 Jun 2022 18:09:50 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D17EF492C3B;
        Tue, 14 Jun 2022 18:09:49 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com
Subject: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Date:   Tue, 14 Jun 2022 14:09:47 -0400
Message-Id: <20220614180949.102914-2-bfoster@redhat.com>
In-Reply-To: <20220614180949.102914-1-bfoster@redhat.com>
References: <20220614180949.102914-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The IDR tree has hardcoded tag propagation logic to handle the
internal IDR_FREE tag and ignore all others. Fix up the hardcoded
logic to support additional tags.

This is specifically to support a new internal IDR_TGID radix tree
tag used to improve search efficiency of pids with associated
PIDTYPE_TGID tasks within a pid namespace.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 lib/radix-tree.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index b3afafe46fff..08eef33e7820 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -431,12 +431,14 @@ static int radix_tree_extend(struct radix_tree_root *root, gfp_t gfp,
 				tag_clear(node, IDR_FREE, 0);
 				root_tag_set(root, IDR_FREE);
 			}
-		} else {
-			/* Propagate the aggregated tag info to the new child */
-			for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-				if (root_tag_get(root, tag))
-					tag_set(node, tag, 0);
-			}
+		}
+
+		/* Propagate the aggregated tag info to the new child */
+		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
+			if (is_idr(root) && tag == IDR_FREE)
+				continue;
+			if (root_tag_get(root, tag))
+				tag_set(node, tag, 0);
 		}
 
 		BUG_ON(shift > BITS_PER_LONG);
@@ -1368,11 +1370,13 @@ static bool __radix_tree_delete(struct radix_tree_root *root,
 	unsigned offset = get_slot_offset(node, slot);
 	int tag;
 
-	if (is_idr(root))
-		node_tag_set(root, node, IDR_FREE, offset);
-	else
-		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++)
-			node_tag_clear(root, node, tag, offset);
+	for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
+		if (is_idr(root) && tag == IDR_FREE) {
+			node_tag_set(root, node, tag, offset);
+			continue;
+		}
+		node_tag_clear(root, node, tag, offset);
+	}
 
 	replace_slot(slot, NULL, node, -1, values);
 	return node && delete_node(root, node);
-- 
2.34.1

