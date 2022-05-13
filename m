Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228A6526A82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 21:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383857AbiEMTik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383849AbiEMTii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 15:38:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE6712EA;
        Fri, 13 May 2022 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iGO39EDVjPnTYXbXk4m8oqTPwLMaY1sb1Vley0Ob2Bs=; b=xpbCJEZVFLojPYYKLedVllObpJ
        sIKinKb0p4nX/oHMltMoDAc0PB64XIfu2HYPQe9s403D2iryESyykHgKMjzr9inJ9W0jGRh6n0o8U
        yaP6pEuyLGdK2XhsBydQKxUg5VkoD41qsPkLM0zM4tONyTXoFz066JnV872EBNQQ0CkqPK16Zq0PX
        usWYLbFworSaNvmRhDJYjn2h1guPnX5ON2Wx/pk+MLUWFOE74lypAvvcuHZGNmyEA/xXfMkXvbQVS
        X8e/cARTNoRnDpEU1nuCZ9TOLinymaY/TjPbXgJewdSLmXghwq1DboR0x77p8hLTKCawb2v9AGsxq
        Pzvcnmsw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npb7T-00HM1x-Fl; Fri, 13 May 2022 19:38:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     patches@lists.linux.dev, amir73il@gmail.com, pankydev8@gmail.com,
        tytso@mit.edu, josef@toxicpanda.com, jmeneghi@redhat.com,
        jake@lwn.net, mcgrof@kernel.org
Subject: [PATCH 1/4] workflows/Kconfig: be consistent when enabling fstests or blktests
Date:   Fri, 13 May 2022 12:38:28 -0700
Message-Id: <20220513193831.4136212-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513193831.4136212-1-mcgrof@kernel.org>
References: <20220513193831.4136212-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have two kconfig variables which we use to be able to express
when we are going to enable fstests or blktests, either as a dedicated
set of tests or when we want to enable testing both fstests and blktests
in one system. But right now we only select this kconfig variable when
we are using a dedicated system. This is not an issue as the kconfig
is a kconfig symbols are bools which are set default to y if either
the test is dedicated or not.

But to be pedantic, and clear, let's make sure the tests select the
respective kconfig for each case as we'd expect to see it. Otherwise
this can confuse folks reading this.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kconfigs/workflows/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kconfigs/workflows/Kconfig b/kconfigs/workflows/Kconfig
index 7e5c518..7f71470 100644
--- a/kconfigs/workflows/Kconfig
+++ b/kconfigs/workflows/Kconfig
@@ -133,6 +133,7 @@ if !WORKFLOWS_DEDICATED_WORKFLOW
 
 config KDEVOPS_WORKFLOW_NOT_DEDICATED_ENABLE_FSTESTS
 	bool "fstests"
+	select KDEVOPS_WORKFLOW_ENABLE_FSTESTS
 	help
 	  Select this option if you are doing filesystem development and want
 	  to target development for a filesystem and enable fstests so that
@@ -146,6 +147,7 @@ config KDEVOPS_WORKFLOW_NOT_DEDICATED_ENABLE_FSTESTS
 
 config KDEVOPS_WORKFLOW_NOT_DEDICATED_ENABLE_BLKTESTS
 	bool "blktests"
+	select KDEVOPS_WORKFLOW_ENABLE_BLKTESTS
 	help
 	  Select this option if you are doing block layer development and want
 	  to run blktests. The git tree for blktests will be git clone and
-- 
2.35.1

