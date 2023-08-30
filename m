Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3278DAD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbjH3ShR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbjH3K7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C9CC2;
        Wed, 30 Aug 2023 03:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92BBE627EA;
        Wed, 30 Aug 2023 10:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E576C433C9;
        Wed, 30 Aug 2023 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693393155;
        bh=+EGk3NTklNsc2mqEzAy8hcuNClQWSDUYGoK8D+J3qxI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HJKkPYl+80xt3cr3ksqLc9vrQLf0AMttch+vwqRR1UXmGCizQ8kRBAdNY1XT5kLu8
         /t3aFnH16twgpM1rS/lX/TK6E7tuaRZigY9ffSZ6xn1mviiMeXfvndX1ftgrSLtxZY
         xaeR+pAki01BEY2NBH3R7jXQvclq1cfeYerzHTORPPb/iwgm5nTVn1qhlnG0BOdA5K
         QkC+RHdiYLCS/Zk7uB3ztCPP4hnCCrEtiil2HmsASPn1VrOtwRKmi/dgo++0PXtUua
         VMkrqhiHUivuJAskvyziwKL74esK1K1gqJoKUeh3FEyZnYGlhNSqrGZ/YzUOxzrFL3
         igFqVAVV0sw4A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 30 Aug 2023 06:58:50 -0400
Subject: [PATCH fstests v4 1/3] common/attr: fix the _require_acl test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-fixes-v4-1-88d7b8572aa3@kernel.org>
References: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
In-Reply-To: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Darrick Wong <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+EGk3NTklNsc2mqEzAy8hcuNClQWSDUYGoK8D+J3qxI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk7yEB+KrnLZBnmvDBQ6RkoJULB2rLono8mikw6
 J3t/Z8cxaaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZO8hAQAKCRAADmhBGVaC
 FcLmD/0Se/EGHVSdAsXx108kCr6W5Dfog5bvWgnxi0875ZhLbwQ9Xl86/YdajGfNUZ1pjUCgjbz
 AQ1hph5OHQoW4h/fGjMmKPqOSG6ibLzZ6DwnndKE3OWevXAX63E4lMSfmkWQMrijO5p1GpH97Dw
 rqf2eLIEkvh99ujTPtw1MJSjQw0XDHFDN85GGjSSyMDlucaHx/rVos7CPdhAeIKAnkXt6H148Aa
 nIKrP7+vlGK3RXpNQ/T1nv9AfbDS4rcG9QDR2p+NpV+iotk5vypydn5Kb+OlY/GEp95/yDIz42U
 JN7KdmJ4iG5SvmjB8AzZeT8IUwwlmTaP/sg2+aWaK53KotY4c1QRF4pQMGHayKEsxpDX0aRGkIf
 Nyzlnnt7TK8AWg11vTe5286wbxHQEBxb6o/4Th5Qpki2501w/kf3dQ337hBPUkC0c4V/fx04LH+
 OX6+WNT0Op5TU3KMg2coIdEX8x8Snkciu0+bTj60Nih1vuo8Ch6nsakFibFMN322XacW5ZqSUUa
 aoXcXQn9h96M+q2Oe+wTgXXoqRmk78e2m3CWfVnR+6f9c2br/Kq0DOPycbwEHcDm5H8GKeZMLQ8
 Uyx9yq9FPOXGkBerWpg2I80MCK9TYdhi5wXZkjNfArn+gFHqtv2g1nGNbE9Q3JImn6DLxA7OAF5
 gKcHogIng2ShkaA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

