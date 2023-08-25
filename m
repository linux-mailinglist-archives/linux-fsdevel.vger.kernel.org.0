Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8C788E1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjHYR5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 13:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjHYR5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B87128;
        Fri, 25 Aug 2023 10:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F261A62CB5;
        Fri, 25 Aug 2023 17:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2ECC433C9;
        Fri, 25 Aug 2023 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692986225;
        bh=+EGk3NTklNsc2mqEzAy8hcuNClQWSDUYGoK8D+J3qxI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nB5DRLhskOL1exhTojx8NKkLNBfkEyEtLwE8jt51STWfGiYCKWyN9OycWLgE1x/7o
         VMINBdDMQIIw9wGVJ1d42FjqTD0TNvPNb/yNnMsQveCexORhy4I6B7+/rhgYN1dpXk
         8F2lERfHgjkUPLGxgl6jSPaE84wg5GPGrEISnBZeQRuGwSvaEZwK588ssgzJXSSfIT
         ETG0fhpgJlFGIHC1wUXPujiYyQmUQxszR4I5Pczh0ey2qAc5ujV8YKizExooQZ6pVc
         M1KGmMB/5dQvv+FcTvOfpRInO1EPi09sFcbTj/ap78jXn6k6DH1ivjBN0UzIKsOzsx
         EpRRPkbC62MgQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 25 Aug 2023 13:56:54 -0400
Subject: [PATCH fstests v3 1/2] common/attr: fix the _require_acl test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-fixes-v3-1-6484c098f8e8@kernel.org>
References: <20230825-fixes-v3-0-6484c098f8e8@kernel.org>
In-Reply-To: <20230825-fixes-v3-0-6484c098f8e8@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Darrick Wong <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+EGk3NTklNsc2mqEzAy8hcuNClQWSDUYGoK8D+J3qxI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk6OtvgraKz1sQ55kr+e1bkH/jXKby65uFw3W1H
 41t2e7hHnaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZOjrbwAKCRAADmhBGVaC
 FeH2EADNQ5eryxky0WlL9uZE9W3ZuD/OsKLJo5MlwwSKdsQfb/glRxvtInPQ/foeW48ByRz2FiH
 D8N3f22F2xko3bxjIwn2mG67RYp1ozJvXuNBhoJFnjTR8B1Sb7JSYdfTbdMmGlNNjxJLYNEN52g
 HBmwQjrYSRyBQzId59waC0aLMb0j8gJri1RoNibcd67bHuao/IAQxKVrowLTShOEieYrzrI9gVS
 i+qQE3IGoLx/8qZrHy1AdHopdWBOv3gJs7FZRmdrTQH2kJW8B3366Q8hrlF2ZinKnrxt5J6/ITP
 1+sRTwIYIe9uh0g5ymXA3c4h/ePqAPeG1f9XhSdoDko4+ZhNWjPzCI2Eum6Bstz7NO5lVZ2n+DA
 XNbNrBjP/WtC6372c+jBfsqB4c9gp9fracjkmMADhA4bQcH+jzKll98BM+wpDFY9o3eYCUWgMFE
 akq/qxsG7ZQy5oG3qjfq+nKU0lUxgdx9XTADZkNvgFH2lpg3muqsFDGGAlrTKcxcdn1MIKikYqs
 HW0N0+am9TxSXO9i6N1rYwUDcukQYgo7eGdb+FTFfwMiZ+oCesYndsD/kTssZ/H5S2T+dJZb0H5
 jTx093tNzvK7/u/UsH2yoXXuCVhnhlkNWcTbsYrAnlix9U/ZGRh6KJu4ficfXcpdVDbeIizeGpf
 GAolJ4ChkSVylAg==
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

