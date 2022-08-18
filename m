Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC41F5990AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 00:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbiHRWk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbiHRWk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C67D807D;
        Thu, 18 Aug 2022 15:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E531861722;
        Thu, 18 Aug 2022 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39063C433C1;
        Thu, 18 Aug 2022 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660862424;
        bh=d+VDi/Gzjo7yfZhsFUe9vStU/58Sblx/+MTOZeGGqpU=;
        h=From:To:Cc:Subject:Date:From;
        b=aDe2BXsT670C0wZrctN/G+XD90FBAsK5JzzZe6avmEOs57eTdIEdPU8gOWBtl3cKd
         WBc5QJBTeMHNjPuWoGUplKNGpG3PNC5V6vQSjUEQIhLFOPXcIklBxRlSYAfFd5kzQH
         TcHT1H4675Ufov7Ec+aWGad5tzDxdClTNQIRJY0nKenp6dyF2AXrTrOR+DUCTsdSeA
         PNyd1OEC80Ri2N1NijnTgusm/XSoDguB1Kgz84ruhTqYzYj/9fE0VJ6xviuxhdZQme
         myCCywE62Wgd+Vqo5kbf1+fEpCJW7ehXtzJzXaNIyQ7f4E79f8cXuvVlj5//kkq7nC
         7dPRgRDBPybJg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] fs-verity: use kmap_local_page() instead of kmap()
Date:   Thu, 18 Aug 2022 15:40:10 -0700
Message-Id: <20220818224010.43778-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Convert the use of kmap() to its recommended replacement
kmap_local_page().  This avoids the overhead of doing a non-local
mapping, which is unnecessary in this case.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/read_metadata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 6ee849dc7bc183..2aefc5565152ad 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -53,14 +53,14 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 			break;
 		}
 
-		virt = kmap(page);
+		virt = kmap_local_page(page);
 		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
-			kunmap(page);
+			kunmap_local(virt);
 			put_page(page);
 			err = -EFAULT;
 			break;
 		}
-		kunmap(page);
+		kunmap_local(virt);
 		put_page(page);
 
 		retval += bytes_to_copy;

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
prerequisite-patch-id: 188e114bdf3546eb18e7984b70be8a7c773acec3
-- 
2.37.1

