Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C959B05B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiHTUUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTUUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:20:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975FC25C49
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vrOGcY06Bzfj4+g/pY24tJGby+aT9BjRijwDm74xZ/I=; b=UMZKj4FdeWestIdr4k/xOAGOJo
        JNTKcKXqLQU9U6BkcDq7gB6qq0SZT/Nu5nWw4QwS6WWbViLYWgIoKkWKN+6L+OAtfYAYRanraOjBk
        z7sbnzHTdvllik1b4YImdlspXq5kVF3bRHjsIg9jzN8QbY9RKm8EKCKjLFcBQKETtIIa3gyDGJza+
        DQKgsHnU/O5qGeFQBR/ee4olvtO+g2a1IwiF0zIhz3xVEDmVAp15FKPUXW/uyWuxOGl5nPdRgO6Bg
        LJw2GwwXNi2Rx3zYw2ZCtW+hKFh5mQbs/igNKFT7kDG8CyauOgJx57rK7OUv3m8U78m5XBuZnR5tl
        1FyzBeew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUxe-006TCl-TW;
        Sat, 20 Aug 2022 20:20:50 +0000
Date:   Sat, 20 Aug 2022 21:20:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH 8/8] orangefs: use ->f_mapping
Message-ID: <YwFCIkDT7sFO1D9N@ZenIV>
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

... and don't check for impossible conditions - file_inode() is
never NULL in anything seen by ->release() and neither is its
->i_mapping.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/orangefs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 86810e5d7914..732661aa2680 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -417,9 +417,7 @@ static int orangefs_file_release(struct inode *inode, struct file *file)
 	 * readahead cache (if any); this forces an expensive refresh of
 	 * data for the next caller of mmap (or 'get_block' accesses)
 	 */
-	if (file_inode(file) &&
-	    file_inode(file)->i_mapping &&
-	    mapping_nrpages(&file_inode(file)->i_data)) {
+	if (mapping_nrpages(file->f_mapping)) {
 		if (orangefs_features & ORANGEFS_FEATURE_READAHEAD) {
 			gossip_debug(GOSSIP_INODE_DEBUG,
 			    "calling flush_racache on %pU\n",
-- 
2.30.2

