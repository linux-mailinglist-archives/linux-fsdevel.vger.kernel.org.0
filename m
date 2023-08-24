Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C817875CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbjHXQpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbjHXQog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330819A0;
        Thu, 24 Aug 2023 09:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58923673FF;
        Thu, 24 Aug 2023 16:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5639FC433C7;
        Thu, 24 Aug 2023 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692895465;
        bh=bjiCHH8T4ZSk8GdvMhD5NLseCcS+3y2//Zo3l+5rSNc=;
        h=From:Subject:Date:To:Cc:From;
        b=SDTZeUM+wf+EN5V7gw2KGnVervVG4s/2SfFxIcvU57yrxuIhYEGdvFFyUDqy1/Dde
         sf+q7wRH9/YxrPFfRTOHEUjkmY6K/K1beJ7OWnylSkiEBGSGckb/30JvolHnPTqft9
         jT/XGepCoBXG73cX9EYtgEMIwlgAabikJKK6PDqxztqVB3ZBNdHaVVrZZNlzxGKTLP
         XMm4kyJkxo6Bh3pqoXZ28JvSrp5MYkTt8o4/e8cz2I2O9zCFs5q8e/AWvToZmf5O58
         US39gmues/EjRGC96u5i1RCUn4p8GKmZC1p+HEwgmjoa/fsnQvC92ydf2AHReXZ9D/
         m2X9B9B0wqRpA==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH fstests v2 0/3] fstests: add appropriate checks for fs
 features for some tests
Date:   Thu, 24 Aug 2023 12:44:16 -0400
Message-Id: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCI52QC/x3KQQqAIBBA0avErBNsFMquEi3CxpqNhSMRiHdPW
 j7+LyCUmATmrkCih4Wv2IB9B/7c4kGK92ZAjUZPaFXgl0S5wXpvgqMwIrT3TvSHti4QJJNkgbX
 WD+4mQ3NgAAAA
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bjiCHH8T4ZSk8GdvMhD5NLseCcS+3y2//Zo3l+5rSNc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk54joE1eo0lNVakBBgdryNA2+Yg2963NuxH3+s
 6kDbu1mU2+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZOeI6AAKCRAADmhBGVaC
 FcOkEACE7WhSnbjV1abljNdcuP8DwPlZ17sXB78VNEQqChxkJoOqbBCKQ6ZbWW5WEEujTjx8H6I
 tcXMMS3nWqyF7CElVMaHQ/4B6WHG/ll6ksYGRmAE+rhfO7slHnQ7M+PBvBfvM0dzSbR4zy1kjI/
 dDSzpYROG94yf1QMpnhfu+0OZoA59mCvdpi/Ts5HC6UrKQpU6e0/Hp6EIoG0ODCRZF1/O+p/pXH
 It04/anXxaUCLP1BOitmyu7RsK0TZExg0lM1/HygNPisaWaclk5WbkakmrQ0jXxqmL6hHIPtqFy
 nnYkARpzH+yHU9eDg486QdyUCDvJwlnQye+Mj7MVa8BnrMRTmf3kYBaJtFE0Z+beMNi8PGim0KS
 aOPSsulHzXce2oJQOP1ECsR4pRLGF5Ic3GCQBdbgVk6FaP0TuZVAwSmV1bqWl8fteNjOnl4zUm+
 qmp1k2W9+vrDuIoP24zqwPTFV9hWE9UrDSjGUoD0WudhuUZRWroRqIXdG07q6f1j9lHtnebK8FA
 JyPFPSygWiPfdc9jOdgBhAt5lC5gm6ozm1GTlQrrAhJllQb0x3a9zmXcm/CR17Cf5OcBIMDJl0t
 HPcWYq0764WnYjxvwz0a+RLo+uUuhfHiumOWHBYMOXaENArlgaFsGBgNt/w4S1b31pYg7N04W3P
 HqvZSrjnqSAgvCw==
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

A number of fstests fail on NFS, primarily because it lacks certain
features that are widely supported on local filesystems. This set fixes
up the test for POSIX ACLs and adds new checks for FIEMAP and file
capability support on tests that require these features.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      common/attr: fix the _require_acl test
      generic/513: limit to filesystems that support capabilities
      generic/578: only run on filesystems that support FIEMAP

 common/attr       |  9 ++++-----
 common/rc         | 26 ++++++++++++++++++++++++++
 tests/generic/513 |  1 +
 tests/generic/578 |  1 +
 4 files changed, 32 insertions(+), 5 deletions(-)
---
base-commit: 8de535c53887bb49adae74a1b2e83e77d7e8457d
change-id: 20230824-fixes-914cc3f9ef72

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

