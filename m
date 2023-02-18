Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55E69B722
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBRAsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBRAsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:48:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA1193F9;
        Fri, 17 Feb 2023 16:47:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D01620AE;
        Sat, 18 Feb 2023 00:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938A9C433D2;
        Sat, 18 Feb 2023 00:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680445;
        bh=fE7TnKGk+7sECniXW1Co7rrNpfck1npdV3aCIbmWvVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnkqWYzFMTcdBZm4UR/n3WPvCPfwOaEkymB8fMNPzSu0yOxGLVyau2YonIEyaQqoL
         H1m4s4pnyONyULyAczlSbveBWREsET+3AZnQvVr4sFVPoAraoRstlRDW6lPMP7r6sW
         JRybBRGFFujDXu1tXKRT4axSewCYNlRcsbjD9pw8XxGl0dOkA0kU/UXUkV2npA5J44
         HpQr5oj/1qWUKUfbEVz5eb1EIRclPNLvl5RzZiDwy9Mp76CoaCttX1bgibxDb5KiUB
         d+3vnLsbMfPviaSfeaSy2zMxKTpYZxc5BKlfl7BtGImwSvyHie7kCN9dknVu4ClUGO
         IzO9GwMrSJcdw==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 11/11] fs/9p: Fix revalidate
Date:   Sat, 18 Feb 2023 00:33:23 +0000
Message-Id: <20230218003323.2322580-12-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unclear if this case ever happens, but if no inode in dentry, then
the dentry is definitely invalid.  Seemed to be the opposite in the
existing code.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_dentry.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 65fa2df5e49b..b0c3f8e8ea00 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -68,7 +68,7 @@ static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 
 	inode = d_inode(dentry);
 	if (!inode)
-		goto out_valid;
+		return 0;
 
 	v9inode = V9FS_I(inode);
 	if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
@@ -91,7 +91,6 @@ static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 		if (retval < 0)
 			return retval;
 	}
-out_valid:
 	return 1;
 }
 
-- 
2.37.2

