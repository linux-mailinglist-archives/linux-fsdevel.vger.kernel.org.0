Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4384B788E1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjHYR5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjHYR5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E56E128;
        Fri, 25 Aug 2023 10:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D17162BDA;
        Fri, 25 Aug 2023 17:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F270C433C7;
        Fri, 25 Aug 2023 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692986224;
        bh=Jv04+GJAsrSjCJYfOOwcKgif8bPHmexO1CMn8kUeFww=;
        h=From:Subject:Date:To:Cc:From;
        b=XGh2zalZL4hCOfGjf9vGqzQVCBba+bCENreWkgnT6n+12Jc9zcD/ERiRFdPHlIEYZ
         FtIDUM8+NGyjK8nLbSq30l6W1aPZqPV5M+CMcwYthvyqAWzwAFoi5U/TWfpw/msBc9
         WQOXAIdu8jxjEbWPrnwp6tMcQi+9i6HGMV8gsFRYqlstfmYFjtxq4zHHsxt4gxA8WG
         t9N6c2CRor5bwEKluxGzeHLgxUiimoIj+MfgCRIhwxE//3a91f8nOYDNiWdM9vCrBP
         zWa/IG4hmcpjzKLIFnaq3gcEDbEt6hpp6mHBYqDhQ8D9+bcTtkx2mbpD/yNx8eZWY1
         fYKsdDnYP1d2w==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH fstests v3 0/2] fstests: add appropriate checks for fs
 features for some tests
Date:   Fri, 25 Aug 2023 13:56:53 -0400
Message-Id: <20230825-fixes-v3-0-6484c098f8e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXr6GQC/12MQQrCMBAAv1L2bCTdVGs9+Q/poaSbNihp2Q1BK
 fm7IUePwwxzgBB7Erg3BzAlL34LBcypAbtOYSHl58KAGo2+Yaec/5Cooe2sNW4g1yOUdmeqoqR
 PcBJJosBYxOolbvyt/4RV/60SKq3mq7boJtfqS/94EQd6nzdeYMw5/wDnsrGppAAAAA==
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Darrick Wong <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Jv04+GJAsrSjCJYfOOwcKgif8bPHmexO1CMn8kUeFww=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk6OtvJKM5H1b++ViJQEjB085NVLELC8x3MA2yz
 5fLu9DeBdiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZOjrbwAKCRAADmhBGVaC
 FcFuD/sG5d3JJjpIW88UAqIBrAdtxtJXhvQ6VJKpUmGzaCZ1MF8l1s9yXj846QbRmvY0sKhcMiq
 Gzc1awJodbA4pWrOFz+Biw95f9K3gUi8mL3eeSIhaJKO7FeVMY8MQjw+Zk1kKTKbLPSpNVkJwPf
 XbsI+mBUoC0MZem7xhQofW9BkP+GEalknZ+ngZ42KyclJ91Oc47XgfWRLcBVsrGyEH2a+Mg9VL3
 v/+wfiWGhFGTpmwIFj5Un/mUDIARMFfF/ATSbCRksNPhcpHXwTc8GfJQreN/K1Df9C+xexwU910
 54+ui9ndaSQ8YI455+TzYZwUHJ4W7xcrhoafNGWR6dprHCdphJqptCxHL2TSynKKhjANEAccGH8
 iRz6L/rcpbbYz7TWbQpjHYvq59lQcSO5UZVJXsg8bu67xCfrNG0OlJOQsBrWTSyvyykhsCdmfJC
 Ib7U5sCKWw0dyzoceCutiL+emNuuzokDzNCl93rkj5qHt1ZVT6T1/eoEBgOuC6Xim6c3YDcq65D
 Z//tHcCBg4sVRUXwxVRbrddMxK4bez1ZWg9J3ynlatnEC/dlIR4nXZAmQkULz+Qusyd2f8wSE0o
 KeHm5koox/VZKCPXe9k3lDU/tKNWwPrJQNpPx9CxIBSIJ8mkMf26uLayZBonuO8CoGdzU5BheHp
 Xy7SiIBPcdd8ngQ==
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

A number of fstests fail on NFS, primarily because it lacks certain
features that are widely supported on local Linux filesystems. Fix
up the test for POSIX ACLs and add a new requirement for fiemap support
in generic/578.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- add new checks for fiemap and setcap
- Link to v2: https://lore.kernel.org/r/20230824-fixes-v2-0-d60c2faf1057@kernel.org

Changes in v3:
- use _require_xfs_io_command "fiemap" in generic/578
- drop the _require_setcap patch (Zorro has similar that adds a _require_capabilities)

---
Jeff Layton (2):
      common/attr: fix the _require_acl test
      generic/578: add a check to ensure that fiemap is supported

 common/attr       | 9 ++++-----
 tests/generic/578 | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 8de535c53887bb49adae74a1b2e83e77d7e8457d
change-id: 20230824-fixes-914cc3f9ef72

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

