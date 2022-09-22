Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB35E66BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiIVPSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiIVPSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7526EFA75
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 437976150D
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D500C433B5;
        Thu, 22 Sep 2022 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859896;
        bh=ppC5rD+yKY0CEvALfPg0/ht46Zze/qKl/tdZkXhmtrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwAHNi3Hh/8TSnouglAO+q3YfDtqqozPulNr1D/sO2cAI1PIaZEg5UMbm6ogrjfPg
         apOfcLvY7AzthuDoqhpLeJ5GmgXDRQzLx6CkTHpbsGEAOlmCGeKCt7TZg4MRA0W34k
         N5gOrYYiW+kKZNB+1WNIBbK3t5/bthxNm4qAh4DkjrtiRSEP3Wbq7d53B5Adheu1FA
         TnJG2nz72/wrUp4Qz5SZT1V7exu1JssM70rfbxNDCKYqnF/V0khsAs6sRxvRFWoSqk
         w1csHInhdhbyUGR1PUC/TargVsjX/fdPzjFyfwcMQTEqr0qwjyEBLE2a1/lk+PIqOy
         qiiZoW6OlgZ+g==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 13/29] acl: use set acl hook
Date:   Thu, 22 Sep 2022 17:17:11 +0200
Message-Id: <20220922151728.1557914-14-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=brauner@kernel.org; h=from:subject; bh=ppC5rD+yKY0CEvALfPg0/ht46Zze/qKl/tdZkXhmtrI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1FRWvxb25bRiP79GqZiF69+zfZHf9pgx9STcDVnfm+ya cPlgRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESMvjH895559PB5OxYnplkK8ziElv pUO+TdWsuz7bDplWzPF2E3bjEyzF3S+N/5c92jg7N6xH/9LZNaqqPLrnkqd+2PHNsn5lvOcAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

So far posix acls were passed as a void blob to the security and
integrity modules. Some of them like evm then proceed to interpret the
void pointer and convert it into the kernel internal struct posix acl
representation to perform their integrity checking magic. This is
obviously pretty problematic as that requires knowledge that only the
vfs is guaranteed to have and has lead to various bugs.

Now that we have a proper security hook for setting posix acls that
passes down the posix acls in their appropriate vfs format instead of
hacking it through a void pointer stored in the uapi format make use of
it in the new posix acl api.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index f27e398e4de8..5ff0d8b05194 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -24,6 +24,7 @@
 #include <linux/user_namespace.h>
 #include <linux/namei.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/security.h>
 #include <linux/fsnotify.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
@@ -1335,6 +1336,10 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
+	error = security_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
+	if (error)
+		goto out_inode_unlock;
+
 	error = try_break_deleg(inode, &delegated_inode);
 	if (error)
 		goto out_inode_unlock;
-- 
2.34.1

