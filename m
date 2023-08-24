Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5867875D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 18:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbjHXQpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242713AbjHXQoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1881BF1;
        Thu, 24 Aug 2023 09:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9F0673DC;
        Thu, 24 Aug 2023 16:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E003C433C9;
        Thu, 24 Aug 2023 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692895466;
        bh=HgZga3u8jfJfVDfYAnT9eS86IE3g/cFqBwD3YR8A1jw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=akexVYjV/f30iIixALyoykqsfVumj+pDnYrI6Fd75erChW/tLJndW24CoRKwuG0jN
         1zXNZpYViuJETvzNw5dHhTjYPZ7sJFkJgMARGLRS2RK8xvnKHv/p6nm2cshRGo6Evg
         yW3BjGNAvVK/RJbqLDKH5Sfh90/L1iEkAOdbf8U3zYxZPSMGNKkGV15AwwXNPpiRLS
         r278UQ9Gj8znTR0mTJAdu6DI/gtRWUhZpcZjbaTH2f+aCv6B31mD0/1JTsvSrHMjRL
         IcGeqCE+Ifjfdjf1HmKaQEdBnoHl0lKwPTVfcNa76tfQIvBwYnuZ4yk8sOAHRBx/3Q
         xZsy82dgHL0dw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 24 Aug 2023 12:44:18 -0400
Subject: [PATCH fstests v2 2/3] generic/513: limit to filesystems that
 support capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
In-Reply-To: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HgZga3u8jfJfVDfYAnT9eS86IE3g/cFqBwD3YR8A1jw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk54jp0vUrBuzaMm1UcUVs6NjZSpgzqQZa/Z5rR
 j3rOQDFiXKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZOeI6QAKCRAADmhBGVaC
 Fb1kD/0aKRi/+lc09u9wrUFPR6G4bpEMMjDGqMgkzpHVvID95IDyvn9WFf1qq8Gw7AvQEJztS5R
 /O//rR5bgPxphWwzglh4Lrq4HREvotJTPyHmmYyfE+W2WVEBXobck66kYkReL0E72rTuYxAk0oX
 d2FEd2cN0fG7p7dv4yhYUyvw4h7h0tMSlTHwGIKBYvYd7vG0Al0P2z/lVbcqGzSA7IV7ljNLOty
 PE2xrxyh6pSjQb0TU7cNF9BUjzBemKi5v0S2BO/dbypm5+TpWIKgVFBI7JIVJKEp//+QkDgehxn
 mekEjqOrNNuCo4AZlN4sBFTK8M8+Oy/Xb78I3Gvs2kbHKblY8ikzWqsDPt/Zscwhi/XWGqzp4sM
 smbDVwAgixw7GDy8XpG8rFVaxbmvYW1aJ+kVwRdAdspFdcRJwdcmUxE4BZ5Vd7O8WoECgj8yelb
 JJ2V08TcX3KVHYPNe7bFPj5f/84MxDIyJrSz/le6qQ9lsN9M4bylFz8kcLFZ/ICp68wEXCL9Ggs
 wSX1fK8aGa0BOQunLVzC+oM+EkQW7b9nhvaS+DXMtOG97zXKFxZBNfFLpHZt5UJQW0O4chZHin4
 fxkWlZkEX5KxluBDobsWzU5nPWPMsrO9MDYRBYaBtnTUXRMcVbu5Yx3iArqlc6sk0q0vUNKD7f1
 U2xYSlp5G/VsNaA==
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

This test requires being able to set file capabilities which some
filesystems (namely NFS) do not support. Add a _require_setcap test
and only run it on filesystems that pass it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc         | 13 +++++++++++++
 tests/generic/513 |  1 +
 2 files changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index 5c4429ed0425..33e74d20c28b 100644
--- a/common/rc
+++ b/common/rc
@@ -5048,6 +5048,19 @@ _require_mknod()
 	rm -f $TEST_DIR/$seq.null
 }
 
+_require_setcap()
+{
+	local testfile=$TEST_DIR/setcaptest.$$
+
+	touch $testfile
+	$SETCAP_PROG "cap_sys_module=p" $testfile > $testfile.out 2>&1
+	if grep -q 'Operation not supported' $testfile.out; then
+	  _notrun "File capabilities are not supported on this filesystem"
+	fi
+
+	rm -f $testfile $testfile.out
+}
+
 _getcap()
 {
 	$GETCAP_PROG "$@" | _filter_getcap
diff --git a/tests/generic/513 b/tests/generic/513
index dc082787ae4e..52f9eb916b4a 100755
--- a/tests/generic/513
+++ b/tests/generic/513
@@ -18,6 +18,7 @@ _supported_fs generic
 _require_scratch_reflink
 _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
+_require_setcap
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount

-- 
2.41.0

