Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5121E688875
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 21:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjBBUoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 15:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjBBUof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:44:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F7746A5;
        Thu,  2 Feb 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7vw66D2vDIhBX9oEFJWgWei9pEvFRsbTDrfadEvnVH0=; b=LI7K/fD5Vk/tdkvyGHcHCHPIn3
        ki8YM6I42VIZSzQNTxPrzW20eQcMlMiBbgoAoAw8253XrGoeMklOlEKMUxU2uC2X6XcBepRXQM2wQ
        YATyAgvwBIxy4fzWAmTKtS8Uj2OY3SvCwtjfcCu15kPUtBjNTOq46bndEOSVGF8Ub11cNCBl93Vg9
        SWkM5MsQ0M+rvDWlwv+bSz97kX6B7VYPTSLxZ9dgDzRfutfB6502mkCo5mEQs0xsV8HA8rHlCRSdS
        KOTUidRSNdF7Zes+5Cdj1siYfhphWwyw25V0So6hp97947mMQ7zwQbXNCDbg4RdAq7LzH3UQO0x0G
        oB6KKg6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNgRb-00Di7X-Bg; Thu, 02 Feb 2023 20:44:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 3/5] tmpfs: Zero bytes after 'oldsize' if we're expanding the file
Date:   Thu,  2 Feb 2023 20:44:25 +0000
Message-Id: <20230202204428.3267832-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230202204428.3267832-1-willy@infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

POSIX requires that "If the file size is increased, the extended area
shall appear as if it were zero-filled".  It is possible to use mmap to
write past EOF and that data will become visible instead of zeroes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0005ab2c29af..2c8e8b417b00 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1124,6 +1124,8 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 			if (oldsize > holebegin)
 				unmap_mapping_range(inode->i_mapping,
 							holebegin, 0, 1);
+		} else {
+			shmem_truncate_range(inode, oldsize, newsize);
 		}
 	}
 
-- 
2.35.1

