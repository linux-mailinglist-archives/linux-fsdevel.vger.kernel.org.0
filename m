Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BB55826A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiG0Mb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 08:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiG0Mbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:31:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1598645B;
        Wed, 27 Jul 2022 05:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00D83B82079;
        Wed, 27 Jul 2022 12:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CED4C433C1;
        Wed, 27 Jul 2022 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658925050;
        bh=dbeMVDU2zgOX/s6r4mczGFsedi8I9ZJL8wahifAzbcs=;
        h=From:To:Cc:Subject:Date:From;
        b=S8mm+PeaJXSXQb+R9FZZU/157hvLOKG0p8iI52AXrljMVq+WUUgdOO813JvWQK5LT
         zA1nPjdKqGyiLMjrxDyXBmjl9uheSAcQxpgg2IYC4rrUXikcuHRwo67b3x26VVEZBd
         Pb5FdPjI9To0Cvq0m4+qc7klCrNa+RdSeUWrDdamk6NeZty2fCHzpqKp3tzJ/NY+df
         gLUmH/P52Da+vfgX68LWjRfTypgp9bSoHmUkXgCZSb1HDQsOWHXyhqULLoMuR4c/3U
         GD4pSkeE6MxzKZmZwjHg4h9LmT2+hLTq8EZ4mtbL9vTugiaCeJyY4j5QqZ7yXAk7Uu
         r/F9bJQcuE75A==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yongchen Yang <yoyang@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] vfs: bypass may_create_in_sticky check if task has CAP_FOWNER
Date:   Wed, 27 Jul 2022 08:30:48 -0400
Message-Id: <20220727123048.46389-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NFS server is exporting a sticky directory (mode 01777) with root
squashing enabled. Client has protect_regular enabled and then tries to
open a file as root in that directory. File is created (with ownership
set to nobody:nobody) but the open syscall returns an error.

The problem is may_create_in_sticky, which rejects the open even though
the file has already been created/opened. Bypass the checks in
may_create_in_sticky if the task has CAP_FOWNER in the given namespace.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1976829
Reported-by: Yongchen Yang <yoyang@redhat.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..170c2396ba29 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1230,7 +1230,8 @@ static int may_create_in_sticky(struct user_namespace *mnt_userns,
 	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
 	    likely(!(dir_mode & S_ISVTX)) ||
 	    uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
-	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
+	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) ||
+	    ns_capable(mnt_userns, CAP_FOWNER))
 		return 0;
 
 	if (likely(dir_mode & 0002) ||
-- 
2.37.1

