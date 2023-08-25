Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE38788E1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjHYR5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjHYR5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D3128;
        Fri, 25 Aug 2023 10:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B507063110;
        Fri, 25 Aug 2023 17:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DCFC433CB;
        Fri, 25 Aug 2023 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692986226;
        bh=Z+sH4YtcXtJl1iB0CzUJffwIgkuuQjmeTsMDGAxYurQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IagMv31i1KZM4mBwoC250VwUdGvVQeJNRKmNL9sPV0M0um3eIWRU/RHLKULu1q8+v
         lvVzj5MTCE4scWanO0fNQo6EfuSfYUnoFJUFuXLiHHgIbUh3r/ScZmZkAeZ2oKwTYK
         udx8CqvHJORTDzngmqQhqsKzxgra12lFlYM3IuxKoNamvXjDmDyqHewRRfS06HDttD
         MB0UMttDXmsd25ca0eiPhBNWDBr4GdhIwidMCd9l+zAzzprDPdCTQgu9Zjn/EbETOy
         7oU1TIegPZRdkPu3iRmHftYPeV59NpJcz7F1PQuv2MUfrU8NqIKmtFu8GSuFAuSlZM
         IePt+9M93vg7w==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 25 Aug 2023 13:56:55 -0400
Subject: [PATCH fstests v3 2/2] generic/578: add a check to ensure that
 fiemap is supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-fixes-v3-2-6484c098f8e8@kernel.org>
References: <20230825-fixes-v3-0-6484c098f8e8@kernel.org>
In-Reply-To: <20230825-fixes-v3-0-6484c098f8e8@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Darrick Wong <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=587; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z+sH4YtcXtJl1iB0CzUJffwIgkuuQjmeTsMDGAxYurQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk6Otv7Jc0esHnmgbNsPkYzQrwmUOPYqcqdnKoX
 PrPqj6ulVWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZOjrbwAKCRAADmhBGVaC
 FbT4D/oC/1l4b0pW1ns+mBe8zfPUaxuEa8ERdKDm+K/SMnPdjM2cmiWzuBczNA00YNDB2rMC2mi
 psfuj5p5N0DmN4Y9XjEDs8pN92tzlvD8q1KgQS+0Lc8C2blx6jRAiTqvyT6rJTfqLn4BXaAQvg7
 hFy32HH3ifF8e7wVmFcPutEm3qMIe9sr7zCIHQOc1mWnsSEbCWkBESQ0RfV4yekRuApdsIz5mt8
 DAWT3RSB9YF3D+erLfNaGA7GVQN6NcBsfpi+cp5XcQjVRYHfck/oSEhBtI9OqRAVFIAcT53n7aM
 XlamnFP85H0undLWkMRHedcyIaGrCX0UC66AM6/+9iJlzfXL4/YQ5PZ2ybFnNA6tJgL5BPcStRa
 ij9Ymem8bjGYIX3vztCte/1MZ/jN7rkwrBmw5d6NunDo6rRPjJw/LZ24ZHMd4ucW3luZ5tLr081
 wkPnc9o3arpI9LsOzAl2je3vyXBQrhIfKhuz3PqCqJbvsD0Sndf413HjgKh2X61XaJ/AOjZ88Ae
 zodDSGenOicCevZydORxxCc/XRq7HKwekF+LO7j9qtWSHXE3B7MG3HKP4j8OryM5uvtlnN2P6AU
 QCGb3aYDq9J5WQ6anFV7SQUS/Sb/nee+RcMt7v2VpQVvQZedAqFeU7kuUBn8nE5CntIhx9LVrcu
 QL26vjq51gri2oA==
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

This test requires FIEMAP support.

Suggested-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/578 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/578 b/tests/generic/578
index b024f6ff90b4..e8bb97f7b96c 100755
--- a/tests/generic/578
+++ b/tests/generic/578
@@ -24,6 +24,7 @@ _cleanup()
 _supported_fs generic
 _require_test_program "mmap-write-concurrent"
 _require_command "$FILEFRAG_PROG" filefrag
+_require_xfs_io_command "fiemap"
 _require_test_reflink
 _require_cp_reflink
 

-- 
2.41.0

