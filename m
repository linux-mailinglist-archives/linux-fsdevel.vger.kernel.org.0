Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B404F59B05C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiHTUT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTUT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:19:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B85E25C40;
        Sat, 20 Aug 2022 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZPsz5dCfQLAnDB+pK1pbWEy1wzXIPKzrGENaRg4Npy8=; b=oLe3AE/VDOyqmFmTlUDO8Z83R3
        WLIkM2ar0c3epxF37OyIYlYfZ6w3YxNMRlkIj3rYvjc/z/qi9wPzJsZeBU/lUQfKe8HRC8DsV4LaB
        mqMnTpcUeV1BEZwn1+2txnwzz65+jbhYZ+qFhPPRnKAHBa66CgMBNsfEPTpeKmb2oL2z2hw6uEq2G
        TKISRYHi70mzUe1bptZsepvnNZYYIzQtHVwhQUvzja5vtwjK4fJxCgmWWQJSZal05N3CUD0poQeh7
        dlNySbEXym4Ld+2XVYlRR3NwCvfhu/YV0NYQteYU8QKxxhnDjq4+zIo/oRt/+LH6Rq/6KMBP5MTOt
        mKaiq4qg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUwj-006TCE-Nc;
        Sat, 20 Aug 2022 20:19:53 +0000
Date:   Sat, 20 Aug 2022 21:19:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/8] _nfs42_proc_copy(): use ->f_mapping instead of
 file_inode()->i_mapping
Message-ID: <YwFB6aX5eJGuYTuK@ZenIV>
References: <YwFANLruaQpqmPKv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwFANLruaQpqmPKv@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs42proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 068c45b3bc1a..542502199005 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -336,7 +336,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 			return status;
 		}
 	}
-	status = nfs_filemap_write_and_wait_range(file_inode(src)->i_mapping,
+	status = nfs_filemap_write_and_wait_range(src->f_mapping,
 			pos_src, pos_src + (loff_t)count - 1);
 	if (status)
 		return status;
-- 
2.30.2

