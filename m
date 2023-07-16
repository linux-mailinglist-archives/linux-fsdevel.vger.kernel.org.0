Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE17975512F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 21:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGPTxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPTxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:53:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593C199;
        Sun, 16 Jul 2023 12:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97EED60EB2;
        Sun, 16 Jul 2023 19:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CABC433C8;
        Sun, 16 Jul 2023 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537218;
        bh=K5rHq1LfKc4VZBVAHSnPR42oWNHNTxIJfGEJlkEBi4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlTeRr3nQnyKkp6WCG8HyBdjR4h29WNNlwSta4f1Cv3798vWcznKPgqckh5Oa+VqS
         HIJi3AgJQpAQk4zah9chWfRQAPPPAZ/0c5Hpwjhf8nZSYOv7k1JbqAfGTM1a4jm5Td
         MzGmapLYg8XK0CRjzryjo0oIW843j5w9/eMZm7EQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 018/800] splice: Fix filemap_splice_read() to use the correct inode
Date:   Sun, 16 Jul 2023 21:37:51 +0200
Message-ID: <20230716194949.527681049@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit c37222082f23c456664d1c3182a714670ab8f9a4 ]

Fix filemap_splice_read() to use file->f_mapping->host, not file->f_inode,
as the source of the file size because in the case of a block device,
file->f_inode points to the block-special file (which is typically 0
length) and not the backing store.

Fixes: 07073eb01c5f ("splice: Add a func to do a splice from a buffered file without ITER_PIPE")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
cc: Steve French <stfrench@microsoft.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20230522135018.2742245-2-dhowells@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 83dda76d1fc36..8abce63b259c9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2906,7 +2906,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 	do {
 		cond_resched();
 
-		if (*ppos >= i_size_read(file_inode(in)))
+		if (*ppos >= i_size_read(in->f_mapping->host))
 			break;
 
 		iocb.ki_pos = *ppos;
@@ -2922,7 +2922,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 		 * part of the page is not copied back to userspace (unless
 		 * another truncate extends the file - this is desired though).
 		 */
-		isize = i_size_read(file_inode(in));
+		isize = i_size_read(in->f_mapping->host);
 		if (unlikely(*ppos >= isize))
 			break;
 		end_offset = min_t(loff_t, isize, *ppos + len);
-- 
2.39.2



