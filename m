Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F659B053
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiHTUOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHTUOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:14:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82722AE29
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jij4gGIu/9MC3WTRmKg7/qEVttspVOOd9biZwQejFIk=; b=EMAS06HzyVOJPTLH699fcgZ4xA
        zREapKzrQbXxpuRgo6+TwGqWUgHB/tlE6yg6N36HYhydjmfWqO6NSDnyroqMb397pj783hJi9TTSv
        3WHd1GtMMvx3Hbw8byMknGXPkx9wIDPWd2Zv8NlRhA23bRezRAUTIvV5F9AF0WwA3qIt67FAXNBVS
        z7jk/dWtq4KKY66bX5C2M378KfDCWIXZ7kj4Idhql6Pop1ls+Q08Ab5MVuB8W7OytubBZKg9g7WiK
        bsTOZX28DtxEzI8+8IF5s+ECxety1zWMv79tQskP9Kg30vr+jOdL1uYC+gqUodV5SE8JgjxrnM4WK
        +2Oqj5GA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUrF-006T6w-8n;
        Sat, 20 Aug 2022 20:14:13 +0000
Date:   Sat, 20 Aug 2022 21:14:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Brad Warrum <bwarrum@linux.ibm.com>
Subject: [PATCH 1/8] ibmvmc: don't open-code file_inode()
Message-ID: <YwFAlWnn2M8j2kSd@ZenIV>
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

badly, at that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/misc/ibmvmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index c0fe3295c330..cbaf6d35e854 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -1039,6 +1039,7 @@ static unsigned int ibmvmc_poll(struct file *file, poll_table *wait)
 static ssize_t ibmvmc_write(struct file *file, const char *buffer,
 			    size_t count, loff_t *ppos)
 {
+	struct inode *inode;
 	struct ibmvmc_buffer *vmc_buffer;
 	struct ibmvmc_file_session *session;
 	struct crq_server_adapter *adapter;
@@ -1122,8 +1123,9 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
 	if (p == buffer)
 		goto out;
 
-	file->f_path.dentry->d_inode->i_mtime = current_time(file_inode(file));
-	mark_inode_dirty(file->f_path.dentry->d_inode);
+	inode = file_inode(file);
+	inode->i_mtime = current_time(inode);
+	mark_inode_dirty(inode);
 
 	dev_dbg(adapter->dev, "write: file = 0x%lx, count = 0x%lx\n",
 		(unsigned long)file, (unsigned long)count);
-- 
2.30.2

