Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F289878DAE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbjH3SiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbjH3K7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB6A1BF;
        Wed, 30 Aug 2023 03:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5259662775;
        Wed, 30 Aug 2023 10:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40988C433CB;
        Wed, 30 Aug 2023 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693393155;
        bh=Z+sH4YtcXtJl1iB0CzUJffwIgkuuQjmeTsMDGAxYurQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=N1g2gcUuq9SCKE67r/wEzSpkeUshul5yRa/daTiw8trO5ZIhQpA6+qW2rT/ScL0mw
         JMvDhqLyKHm/3wdxVm3+WI/GZkA52tdFyZLDRINx/FH6wFL1oppRROO0F1IJabBrc9
         seMJS5+eDvVldFU2yyvbgpN0H7uVzXXOXL49c/dgyMfmk9GWZKx0LnEWp++3JF26Hj
         Noh0ylaAM9GF5q19d0Mbxd93EvjCo7YCtCdbbro+AbVsTccSc5PSCTT9HFXBejt2Zl
         zgxZ2mAnmVKAoHM1sOImW1y93tKhFkii7KnevhVhWrjd3WRZwnZzdUNJa5lAnFM+nx
         w4aMmmERVZcXg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 30 Aug 2023 06:58:51 -0400
Subject: [PATCH fstests v4 2/3] generic/578: add a check to ensure that
 fiemap is supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-fixes-v4-2-88d7b8572aa3@kernel.org>
References: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
In-Reply-To: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Darrick Wong <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=587; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z+sH4YtcXtJl1iB0CzUJffwIgkuuQjmeTsMDGAxYurQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk7yEBOTrNXtJs+RBCImWCTfg5thvoJT3fQ4Xa6
 cH91dK//AqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZO8hAQAKCRAADmhBGVaC
 Feu7D/4gVKPg4qN6wCxRi11dCm67IvUwWAWdLRLyblHVY5ulOfV44p/qOU34JY0guZ0VS4yMlUY
 4erLoIhzPKJzM+NKenYNl4p1UCJ3ZpGqMWUE/cqADHal79Q6mBbYgihD2GZxhxpxseOJwV+r7pW
 ywXBiDpq6J4poRKrPnp4Q/3hSKT+Wfos40VxuQDlojcmvsQ/yX+Wfbyp3n0LdZ4QrxFiI7W90W9
 IljRvn9UFBsBgm0/YgbOlXAUemME9oh9Odw1hUt01BhFN2zfYt8SRFlTkQp7j6histjCaPHw/aS
 2WYnackx7Iwt+0iYudVauv0p56SL6Z1AXan1bc54Dk0pCN5/AsveFZat2KJHeAZ2qU7fTfXBetc
 DeBHm3tyaq05o/pAw62Vme1z/NABGA3xQrSO+vZnXvGX9ZNpqJ8Y+1AGa99BFSTrdtcyP6i5DAw
 7Ha+veKHAG53cQL4InaNdxUl3bmGkr85zahTcvFSQU8zlTK3y03k7Gq0S0TA/3kd4dAGHEYrKni
 6CjE28crji9zwoP7coxzk9Oe+BNgXMbscbnn5giIlRatOhJMDLinKGIo52M9VUfRQNa3XaEvEL6
 SwnFQsF8OTO4ezOcLjyjG7hGwAy/1bpkIElcZ35wYWcr7JzQmEbE+JUX4DJrmBod6oR6E63Ng82
 DbeHHVokgV402EQ==
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

