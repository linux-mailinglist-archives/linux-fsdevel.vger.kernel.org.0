Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63766830FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjAaPMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjAaPLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:11:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C5153544;
        Tue, 31 Jan 2023 07:09:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F05361557;
        Tue, 31 Jan 2023 15:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104BEC433EF;
        Tue, 31 Jan 2023 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675177727;
        bh=Wo5hiX0qGQOtoQFDNuk/pDBVwD2wnAOpM1so7q5LdTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=fj374gCgukYg91MO0bhAA47Jz/S++bkN6RO9QnCXgL0itCGcqHZ8iPTnAa3VS+pKG
         71TsmJBnO/BsteP4I1EYZfbYoVr8iyYUrTAzWhimrL0PW2DYMG6h904NjQIydFPMe8
         W0yiiIUvX75dGUUR2OSNkhVkVpPGb2fDsYDy2v5agRp31Sdly/n2M5eIrT5Jq+1o0l
         SbvGb1iUoZxXqRc++vn3smbdXAwssN1RMh8f+2QPfoQ/W6Y4bmAS895HlaN5/mEvXD
         oCswUFnvxKRVrwiA7A7mmzMINW5Pv3NLB5gaskJcHfsmQYG7tuknZXalySM3S8PLuS
         DIh2PatG8KLWA==
From:   Chao Yu <chao@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] proc: remove mark_inode_dirty() in .setattr()
Date:   Tue, 31 Jan 2023 23:08:40 +0800
Message-Id: <20230131150840.34726-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
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

procfs' .setattr() has updated i_uid, i_gid and i_mode into proc
dirent, we don't need to call mark_inode_dirty() for delayed
update, remove it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- remove mark_inode_dirty() from proc_setattr() and proc_sys_setattr()
as well.
 fs/proc/base.c        | 1 -
 fs/proc/generic.c     | 1 -
 fs/proc/proc_sysctl.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..16236fe9b9fe 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -699,7 +699,6 @@ int proc_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return error;
 
 	setattr_copy(&init_user_ns, inode, attr);
-	mark_inode_dirty(inode);
 	return 0;
 }
 
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5f52f20d5ed1..f547e9593a77 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -127,7 +127,6 @@ static int proc_notify_change(struct user_namespace *mnt_userns,
 		return error;
 
 	setattr_copy(&init_user_ns, inode, iattr);
-	mark_inode_dirty(inode);
 
 	proc_set_user(de, inode->i_uid, inode->i_gid);
 	de->mode = inode->i_mode;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 48f2d60bd78a..4e71d18e610e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -841,7 +841,6 @@ static int proc_sys_setattr(struct user_namespace *mnt_userns,
 		return error;
 
 	setattr_copy(&init_user_ns, inode, attr);
-	mark_inode_dirty(inode);
 	return 0;
 }
 
-- 
2.36.1

