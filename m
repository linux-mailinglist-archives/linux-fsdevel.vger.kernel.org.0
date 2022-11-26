Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D686393A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 04:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiKZDRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 22:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiKZDRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:17:22 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167BD56D5F
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 19:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=c6vAtXpMwwQjsNI1RJFBytbOB6avT11Kf3RnBobY/ZY=; b=YFOZh0JWMREMjjV2VH3lxfVpKb
        rButYTqw7qertwat651C4xU92pFe9NGn5ns4LE9W8QyEBLW6l0lWH7kH8M3BaynxZMMay4+1hhWwc
        ceoglVMtXYMOZzAm4phJBpxBjlxjSWfdzAf+xCCjDhqY33YiCfauc52RXg6s3IAP8hSY+48Ado1a4
        mMCBi1xTR815uDuoE7OWsG24G1irRnRz4LbjJk7j5pS7zu9Uu2C3ctH/g+FfEW96D7Ve0yTpS1IqK
        Qkt7pZd6OdDEJWu4Y4beaXQ4bWLpw5BpkZpQZGKVsinK4e5gRpCxv695c+80OG/wdraFNzoU84xMG
        xB//qy/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oylgr-006oRJ-1M;
        Sat, 26 Nov 2022 03:17:17 +0000
Date:   Sat, 26 Nov 2022 03:17:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] unbugger ext2_empty_dir()
Message-ID: <Y4GFPajUjIBOa5i2@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	In 27cfa258951a "ext2: fix fs corruption when trying to remove
a non-empty directory with IO error" a funny thing has happened:

-               page = ext2_get_page(inode, i, dir_has_error, &page_addr);
+               page = ext2_get_page(inode, i, 0, &page_addr);
 
 -               if (IS_ERR(page)) {
 -                       dir_has_error = 1;
 -                       continue;
 -               }
 +               if (IS_ERR(page))
 +                       goto not_empty;

And at not_empty: we hit ext2_put_page(page, page_addr), which does
put_page(page).  Which, unless I'm very mistaken, should oops
immediately when given ERR_PTR(-E...) as page.

OK, shit happens, insufficiently tested patches included.  But when
commit in question describes the fault-injection test that exercised
that particular failure exit...

Ow.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 8f597753ac12..5202eddfc3c0 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -679,7 +679,7 @@ int ext2_empty_dir (struct inode * inode)
 		page = ext2_get_page(inode, i, 0, &page_addr);
 
 		if (IS_ERR(page))
-			goto not_empty;
+			return 0;
 
 		kaddr = page_addr;
 		de = (ext2_dirent *)kaddr;
