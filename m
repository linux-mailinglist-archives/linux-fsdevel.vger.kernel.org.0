Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C367875D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbjHXQpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbjHXQoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF9B19AD;
        Thu, 24 Aug 2023 09:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E780467410;
        Thu, 24 Aug 2023 16:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23B1C433C8;
        Thu, 24 Aug 2023 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692895466;
        bh=+EGk3NTklNsc2mqEzAy8hcuNClQWSDUYGoK8D+J3qxI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NU5nWWAVtr4ePAFN93WmpBz5lR9ie6QuqwGUgu4hUi4o0JQPq7am87jWXyI/GDu0o
         q5UOTiKP9FJaaiViAH2slqzM38fG/cAard9L5O9FfHB1gO33xJlI9oC89x6y6Zakb2
         hmyo4r4hzE9PZTtQWa8b+NWLCQQ+uMJlm9ZWG+t6et7n4KQp1RN9fJpl/rV5ZfEVDL
         aWuNUj9BqYRs+Fm6GTb+bJk4Y4Y+S1G01Db3dciUld7dJnwd560oy1qxD5BlPs47SJ
         FkQwjUOz5qlcGnfsEMGe6nIk2kNGW/TWdWTxNck7WaoU8IyDsWWmArUZIboroP8qbX
         9JeIstUTIUdyA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 24 Aug 2023 12:44:17 -0400
Subject: [PATCH fstests v2 1/3] common/attr: fix the _require_acl test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-fixes-v2-1-d60c2faf1057@kernel.org>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
In-Reply-To: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+EGk3NTklNsc2mqEzAy8hcuNClQWSDUYGoK8D+J3qxI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk54joGY9vv7QFu77TER6OBeiKBvdU71CkoVp3R
 +TgNv6C/FmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZOeI6AAKCRAADmhBGVaC
 FVk2D/kB4JyVPfRLiDWxq7hMNLfU8CeMcIQXEb3sbz2w6Y3bym5FrwWphsOOURs3t+NIkeuFEVX
 9b7sR/0hL3Pc7dZALNpXIMKVhzOtYAIavGqR5m3tMIL2hb9qYhdPLlBsliW2EotCGOpXSn6F9Hg
 LgfRS+aDYX9+eoy2xmuEJUiaWlSCUXPmD5A+5vlOliBADWgvQfhdYl45R1Zrt4zlItj86wZ2D1t
 L8cO8ccWVRXAwCu2KOUgHeEwvbCtJghJ5xYKGPFfWkpm48bfoMWY90dht+U7tUVOqVew3BIuiVg
 1OXNOBrgm4qDBgYUwMd5GMQHEcPmA/YGn7KWJPumOCeTb4Caav+7OtDBcDk9aemWGOfQHA1Rhz8
 fHQiiX4Wq5YVHpqGGE+27diVnEU8rP5PC0MpJtLbkfYGco1cW+xAq3qIXO+/eangF7U+c+np/qD
 emYDQuXv8ovcVZtpV5Mh8dll6LwfuUzvaUjMkEY/rgrsgD64hjWFQOrJtNpVZaGMXx6rTHGAS7L
 0bszgw3QSOpSjIkSEpeD508/mwfcsCA+AGDZ1PajL6/8wGIwpuv6AkB1zN+gEpwGfy4QlpX2r9m
 3sn8RQ11n+/zp7FIj+rmqmrOW6uQprtJEdXmYXPWYfz7KotGjtD7zKN3LRt+Mf4LD1ht7iXKvKL
 SDY/6lbLyRSvGCQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

_require_acl tests whether you're able to fetch the ACL from a file
using chacl, and then tests for an -EOPNOTSUPP error return.
Unfortunately, filesystems that don't support them (like NFSv4) just
return -ENODATA when someone calls getxattr for the POSIX ACL, so the
test doesn't work.

Fix the test to have chacl set an ACL on the file instead, which should
reliably fail on filesystems that don't support them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/attr | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/common/attr b/common/attr
index cce4d1b201b2..3ebba682c894 100644
--- a/common/attr
+++ b/common/attr
@@ -163,13 +163,12 @@ _require_acls()
     [ -n "$CHACL_PROG" ] || _notrun "chacl command not found"
 
     #
-    # Test if chacl is able to list ACLs on the target filesystems.  On really
-    # old kernels the system calls might not be implemented at all, but the
-    # more common case is that the tested filesystem simply doesn't support
-    # ACLs.
+    # Test if chacl is able to set an ACL on a file.  On really old kernels
+    # the system calls might not be implemented at all, but the more common
+    # case is that the tested filesystem simply doesn't support ACLs.
     #
     touch $TEST_DIR/syscalltest
-    chacl -l $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
+    chacl 'u::rw-,g::---,o::---' $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
     cat $TEST_DIR/syscalltest.out >> $seqres.full
 
     if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then

-- 
2.41.0

