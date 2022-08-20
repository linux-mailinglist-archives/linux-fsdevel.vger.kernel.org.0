Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4757559AF68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiHTSNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiHTSM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:12:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D80402E4
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=y9VDct1kNhpLVe0Vl2FQH64NuOQG8H10L8gy1eVYz0E=; b=Ic9xg4+gy8ptcvrCDMEtlTXY9G
        z6A9VEqQT9aZP8MyZG+goJQle6nXQV/FCDmQhITkGU0RK0tU+uX1XvL6QFfQvtBkSnIdYpMEy/lJc
        RogJWXKN5FdDDo8uk1v15FaM3xvXBSmVWE1KM2xGxzCUeYKIN25vFXp27bL2cfgtGvmBrA+ysZMD4
        uZYaQs3kIEXeNHpJP6+lOyvxMRBfb9PD/yCLAtrwpsDFsxfL6svlgj3ySMNWbX7IEXIeQSlb810l+
        w9GeR/ktCCevAF1zLRDCRIM+bW/qeeLodWU9DmU5STskCn2JUqEQNcNXIsQmHmI5y394O7q16lJq4
        BBo8355w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxs-006RVj-H3
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/11] may_linkat(): constify path
Date:   Sat, 20 Aug 2022 19:12:48 +0100
Message-Id: <20220820181256.1535714-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
References: <YwEjnoTgi7K6iijN@ZenIV>
 <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/internal.h | 2 +-
 fs/namei.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..c209b4838d68 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -62,7 +62,7 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
 int do_rmdir(int dfd, struct filename *name);
 int do_unlinkat(int dfd, struct filename *name);
-int may_linkat(struct user_namespace *mnt_userns, struct path *link);
+int may_linkat(struct user_namespace *mnt_userns, const struct path *link);
 int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
 int do_mkdirat(int dfd, struct filename *name, umode_t mode);
diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..6a5ab1a6f01b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1178,7 +1178,7 @@ static bool safe_hardlink_source(struct user_namespace *mnt_userns,
  *
  * Returns 0 if successful, -ve on error.
  */
-int may_linkat(struct user_namespace *mnt_userns, struct path *link)
+int may_linkat(struct user_namespace *mnt_userns, const struct path *link)
 {
 	struct inode *inode = link->dentry->d_inode;
 
-- 
2.30.2

