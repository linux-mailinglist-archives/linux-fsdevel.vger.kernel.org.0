Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148C7875CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbjHXQpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbjHXQoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0811BF5;
        Thu, 24 Aug 2023 09:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 186FA67416;
        Thu, 24 Aug 2023 16:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A090C433C7;
        Thu, 24 Aug 2023 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692895467;
        bh=vgCjAo17bP/S+WAkHjSMwOSP8aP1gii4DVtguCfIxhk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LwQ6ky+wrBhiLrYRhtm16extXmrh0SEWvVUEykXmMSAig9Dy2SNO4U19xSUVP3UF5
         fkKZ9GlGycd1oF0bZFXKVSa38tSqzBrDA2Ze7SbpLB0QrF8Gkv9CWMQPt4kiGokCfS
         rtvInLxK7lZf2bjnKYSYzTGrv4QOKLf76D7D0FXEfsPwgnvW2KIKy+8lfV4beTataJ
         Zc1KZxVdq+5U1c7J/vPd9IhXN55VEIXq1TUryfaUyCqIX9C919oCw3AdUU9rFYDyZY
         6iZHvVTM1yYO1NFiOf3Ol35sy0x3OkGVnUtxwsg2gE0eDGuv/RB8hSsY9fjLmL8HHo
         g7urIpwbY+WmA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 24 Aug 2023 12:44:19 -0400
Subject: [PATCH fstests v2 3/3] generic/578: only run on filesystems that
 support FIEMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-fixes-v2-3-d60c2faf1057@kernel.org>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
In-Reply-To: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vgCjAo17bP/S+WAkHjSMwOSP8aP1gii4DVtguCfIxhk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk54jp9AVkFjUDxXNs3vBVCjZlacHa7fmhVjLwt
 XR5Blhwm/eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZOeI6QAKCRAADmhBGVaC
 FfRDEACVFab+TNe59DWgztMlDBAXseE2lQE3Xoxl+5Z6L+reaig/yUc4BbHutfXtKGcerv6Z20N
 P8q2s9Dd8XBnAqjiUjqcdTEywSm/9bAyI280FukauyUtbl7QXwhYHW9pLYtLMzyryIXV6D36qla
 0vx6LzI0JC8OoV4cJU9dmOUWEooTTzZM4Y8r5X+Buh6tDifM3N6ggN1vsxqdH5qkTm9tJZP3bKu
 ukxHgOVIYkRCjiZQRMDHn/ZgbwYNsLSqxDdL5Rmr7qyizIwGXrcrWSPnY6iiW4Mr9rSnCR22XZi
 twXStNrYI53QSmspCMuTbWbJEYneab82aih9i3ZGQ7p2Z6wvqdL3lx4gY9t4skBR5Xev337vKuO
 wGi56sPIcIqVx9JKGOXZUp56sFahydftdSIi8fFvzcqvozKM7qs9gtc23JeaX0ezivAiFqctonP
 f6ik/mnwX86WNrQaCu3r4EfKgb8GVolPi1mku3nH/Wf59lzkk5rabCi8BwxrVLfRCcXjafcs3fs
 7LsXkjnjERJU+ocxrN62cznPRMUpYUlsm7GeTc1MspGOmfBGCudwq47cn4i1loC07RroiyMWVmd
 2GuYMIg9q2u7/V01R+ak0ZLQAF79/LZ+s7fWPNJ1PEYOQzZlxQrVwwt1CyCRPiB6QsqLr6H0Xvw
 AvFNhdV6TPO9W0Q==
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

Some filesystems (e.g. NFS) don't support FIEMAP. Limit generic/578 to
filesystems that do.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc         | 13 +++++++++++++
 tests/generic/578 |  1 +
 2 files changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index 33e74d20c28b..98d27890f6f7 100644
--- a/common/rc
+++ b/common/rc
@@ -3885,6 +3885,19 @@ _require_metadata_journaling()
 	fi
 }
 
+_require_fiemap()
+{
+	local testfile=$TEST_DIR/fiemaptest.$$
+
+	touch $testfile
+	$XFS_IO_PROG -r -c "fiemap" $testfile 1>$testfile.out 2>&1
+	if grep -q 'Operation not supported' $testfile.out; then
+	  _notrun "FIEMAP is not supported by this filesystem"
+	fi
+
+	rm -f $testfile $testfile.out
+}
+
 _count_extents()
 {
 	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
diff --git a/tests/generic/578 b/tests/generic/578
index b024f6ff90b4..903055b2ca58 100755
--- a/tests/generic/578
+++ b/tests/generic/578
@@ -26,6 +26,7 @@ _require_test_program "mmap-write-concurrent"
 _require_command "$FILEFRAG_PROG" filefrag
 _require_test_reflink
 _require_cp_reflink
+_require_fiemap
 
 compare() {
 	for i in $(seq 1 8); do

-- 
2.41.0

