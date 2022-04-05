Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A44F4D16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457861AbiDEXi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573591AbiDETXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7E64BB9E;
        Tue,  5 Apr 2022 12:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8C9618CD;
        Tue,  5 Apr 2022 19:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F01C385A3;
        Tue,  5 Apr 2022 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186471;
        bh=jKwrnkur/UZMWNKLAXoBHYovRwFcYZx33jY+OjyVk3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPdd6h+UwAmG5ptt3N35Odgi0Sooj/kK0G16AHRqHv8TZlXi147IQ4ahU1akYUygP
         Vqr5OVJt0PsE/dtEc68wxF6mXwNpdMLn7vKQImajKbCCdNw3gtsyoDWVOXzKU10OnM
         IMXtG1oQ1+LpDIs4zFpHdt1IqTgJ8ullm1HdOE0GlHqN1ISu6dwNvbe+d2u9A99uPx
         XHSRP8R4wTkdJ6nb4xVoAXfZBRMXmk9kYEhdiCf60k4jbr9CNPH3iddgP22SjkQ8XE
         lVS96ElhxKCb6rfdRV/2wiT/Tcy7JjNfVPkAOPaBhLyo/exVWmrPwwQRxRDkcCTlOx
         zbho0Ojtgx3Xw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 43/59] ceph: update WARN_ON message to pr_warn
Date:   Tue,  5 Apr 2022 15:20:14 -0400
Message-Id: <20220405192030.178326-44-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
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

Give some more helpful info

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1f3a2135214c..cb2c18d43946 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3473,10 +3473,13 @@ static void handle_cap_grant(struct inode *inode,
 		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
 		     from_kuid(&init_user_ns, inode->i_uid),
 		     from_kgid(&init_user_ns, inode->i_gid));
-
-		WARN_ON_ONCE(ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
-			     memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
-				     ci->fscrypt_auth_len));
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+		if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
+		    memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
+			   ci->fscrypt_auth_len))
+			pr_warn_ratelimited("%s: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len %d new len %d)\n",
+				__func__, ci->fscrypt_auth_len, extra_info->fscrypt_auth_len);
+#endif
 	}
 
 	if ((newcaps & CEPH_CAP_LINK_SHARED) &&
-- 
2.35.1

