Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5D5B343C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIIJkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIIJkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC6CC0B67
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 02:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C681F61F6A
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 09:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7508C433D7;
        Fri,  9 Sep 2022 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662716432;
        bh=RYuvHCPAGOBESwJIEJ3W9EdqiF+F+6PukpubuRQLFD8=;
        h=From:To:Cc:Subject:Date:From;
        b=HUUSFQogqchG6ytZt2I16NnV+h7tNgEw4Tc2kDC/8E+RDaGneXpDar/Fsl82kEboR
         S1Nsd+SmCYwSwP6SaHn/0AaJTyMnrEo0XUHCc3oCK0c5a9uynJ1woxV1MMrU/mKV+D
         bRTAUq1CTfOtTi02RgP7wY39Nbd+hbX5vDY+wjNshHC+VuS8dmxBp3WOjFbWQJpn8T
         I1gMnGXBACyCUjeJKi3Ty1rkhAmbPPpWxsTpsH0enGFZeIbewUX+kvA+uroJodq3C0
         FV29gC0e53gZxegiQ5SXCyYuFRO8L8mT0clp1g+pBcuzrfAkmSpvtWxadm9eZyC6D3
         DE31OUHnCIHOg==
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: port to vfs{g,u}id_t and associated helpers
Date:   Fri,  9 Sep 2022 11:40:21 +0200
Message-Id: <20220909094021.940110-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=brauner@kernel.org; h=from:subject; bh=RYuvHCPAGOBESwJIEJ3W9EdqiF+F+6PukpubuRQLFD8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRLc/4xd/U9r/1sa4qdwN3Kn2H5/ptrtQI4GqQe9Bz6d8Vj UrVgRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETMuxn+qadIfw4onvanQv7K5LrXWR ayV5cn7Ux+UOQUHadTX5xvyfDf7XDanpSmF2lB3w5M1rN4Vv3gRzffDL+UKKWZKp1dq3x5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

A while ago we introduced a dedicated vfs{g,u}id_t type in commit
1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
over a good part of the VFS. Ultimately we will remove all legacy
idmapped mount helpers that operate only on k{g,u}id_t in favor of the
new type safe helpers that operate on vfs{g,u}id_t.

Cc: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/fuse/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 337cb29a8dd5..84c1ca4bc1dc 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -98,7 +98,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			return ret;
 		}
 
-		if (!in_group_p(i_gid_into_mnt(&init_user_ns, inode)) &&
+		if (!vfsgid_in_group_p(i_gid_into_vfsgid(&init_user_ns, inode)) &&
 		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 

base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
-- 
2.34.1

