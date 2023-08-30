Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6826178DABB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbjH3ShA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243430AbjH3K7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B381BF;
        Wed, 30 Aug 2023 03:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52E6627B9;
        Wed, 30 Aug 2023 10:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA506C433C7;
        Wed, 30 Aug 2023 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693393154;
        bh=wYJq4N2YWcxC3zxarH9JteFYm6SgG77yA/UCDOnm3qM=;
        h=From:Subject:Date:To:Cc:From;
        b=SP8hXdfwFGAWsl+o+1KC2rwsEwUN9EaDmWRKs+zuH3zbKUeVcaa1KmiU5Et8SVBb4
         5tHBKWa80W28l5VJy3XN35qFpt2qa2IEDjZiGstjPHMvVsCTV3aQ8rJklDQMpKM46h
         m4KsmvV4XOK1O9xNj+4P//mF08NUitvradFDE4c2OMA7Mn31u/piDjai31U5JSA+2u
         w1cL6wfqH5bn7hgPpQJKl8cRvEng+YS+Z7LkZ8BP4MEyXSSqij38pY0d7uZUDd+hY7
         RimARwtNh0WCzAS9w9AbPuZFU41tnCGndhHoTfSqKJ24PMixbl1soflrWS79On0oQx
         XC/jZa4Y7W6lQ==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH fstests v4 0/3] fstests: add appropriate checks for fs
 features for some tests
Date:   Wed, 30 Aug 2023 06:58:49 -0400
Message-Id: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkg72QC/12MQQrCMBBFr1JmbSSdpG3qynuIi5JO2qC0kglBK
 b27ISCoy8/7723AFDwxnKoNAiXPfl3y0IcK7DwsEwk/5g0oUUmDWjj/JBZ9ra1VrifXIeTvI1A
 B+XoBx5E4MlwzmD3HNbxKP2HBf6mEQoqxlRbd4GrZdOcbhYXuxzVMJZHUt9Z8NJW1VhttZW+cI
 fOj7fv+BkvCq2rbAAAA
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Darrick Wong <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wYJq4N2YWcxC3zxarH9JteFYm6SgG77yA/UCDOnm3qM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk7yD8bOeZoKJMFfEptvIwbvbAY687tDs7TVOH3
 vtJE50rk/mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZO8g/AAKCRAADmhBGVaC
 FaN3D/95nz68PF+QEWyKvDmk1rUNczW0Eqb7mnzIVJbUoCk8wwpxZx8v9RZKF4AQ61Wx++n/0Bh
 JrS8twY63A5EWXM+85i37EISI++toVfdrIVSkf2Wv+8m/GxSUwtKe+GX+ZaSk1EiHw0GuRDlIzd
 Kn0F61ciHW9S94ptuhZABaHkfOrknrVKRn+h9hTL1YlOypbvQ68jBYqBASkVWmjguQMWqmcnzv/
 i6RE0YX7jKUCe7N7OglemzDO2Iz2QNUtnqZWHqyP0jYQH0HGZz+mxamr4JLsi96mCkiCo2GkjCs
 wstp7NIozzH6xDR/tsXvO63XXsNagv4VkC2rR5Dy1ylyYAPvLlksos+xBDrF3zcfOA21REyWj4H
 VBftbqHLi6vHqpWApSKiS+9J/jSDwZkAp253bI8VwYLcTh+WZOzr2nSNvFpisjxD29uLd5xPnOl
 62SqSjhkV3k2TRZNiwJ0ajCZlWojwJC1FdR4XsoYAOzqIB0cT8cOxI77dMmNl3eeU2wjPoML4DX
 prL0y0giIYyZozB72jR+2EhVj13s9RUgM4Ty7COAXlQzOQHJses0Yx077OhcPEwN1HRUX8vUd+J
 3cFIgIY2Qq6Sb/38hFDpT8Rrxrtrfq45mFKoeVOxC4vqC7Z8mR1i14A/5L2Ljh/FHfBFQTEsBWA
 tCBepxGl+DPC6Ig==
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
Changes in v4:
- use "_require_attrs security" instead of special setcap test
- use '_require_xfs_io_command "fiemap"' instead of special fiemap test
- Link to v3: https://lore.kernel.org/r/20230825-fixes-v3-0-6484c098f8e8@kernel.org

Changes in v2:
- add new checks for fiemap and setcap
- Link to v2: https://lore.kernel.org/r/20230824-fixes-v2-0-d60c2faf1057@kernel.org

Changes in v3:
- use _require_xfs_io_command "fiemap" in generic/578
- drop the _require_setcap patch (Zorro has similar that adds a _require_capabilities)

---
Jeff Layton (3):
      common/attr: fix the _require_acl test
      generic/578: add a check to ensure that fiemap is supported
      generic/*: add a check for security attrs

 common/attr       | 9 ++++-----
 tests/generic/270 | 2 ++
 tests/generic/513 | 2 ++
 tests/generic/578 | 1 +
 tests/generic/675 | 2 ++
 tests/generic/688 | 2 ++
 tests/generic/727 | 2 ++
 7 files changed, 15 insertions(+), 5 deletions(-)
---
base-commit: 0ca1d4fbb2e9a492968f2951df101f24477f7991
change-id: 20230824-fixes-914cc3f9ef72

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

