Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A50526A81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383853AbiEMTij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiEMTii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 15:38:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B76FD36;
        Fri, 13 May 2022 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GAZcGk03ehrHc5Dtxk7odt4Ht5+ef2Nl5pEGHuLhXTc=; b=o1Xegp6GbvaEkEIroQaEaDuJbO
        2zmGch5vozo3M0a8yTt7EHCU0DiarL2Ecc/pGhadzqhihoMrvMA/UnuhfGRNLraCmW9/o34DKzN49
        ZmbWrhS09pw8kvvEkHw9EAOA2JFVUIP1ag3FXllW6g1dSEQPS3fFRrBj3n/niwLkP3co8XQBkG9Su
        /0u+ggTYZKC9F8Db/gZkKRKDsnIueDBlSksFHNLILEgfAU5yRm1yxjPS86xaCFE1XIgmEPnyF1aV3
        jLugS7RYjt+DaoPY7z6DyT1iH4ZWWGjXZ/TT/hBuG96asJomP91qLFFwLNb+VJvBfMONMVt4UOTm4
        RVNNI4kA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npb7T-00HM23-Nh; Fri, 13 May 2022 19:38:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     patches@lists.linux.dev, amir73il@gmail.com, pankydev8@gmail.com,
        tytso@mit.edu, josef@toxicpanda.com, jmeneghi@redhat.com,
        jake@lwn.net, mcgrof@kernel.org
Subject: [PATCH 4/4] kdevops: make linux-kdevops the default tree
Date:   Fri, 13 May 2022 12:38:31 -0700
Message-Id: <20220513193831.4136212-5-mcgrof@kernel.org>
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

At LSFMM 2022 at Palm Springs it was discussed that we should
*strive* towards a shared expunge list for fstests / blktests. Although
that effort requires splitting out the expunge list from kdevops to a
new git subtree, sharing a git tree for commit work for kdevops seems
also innevitable and desirable since some of us are already
collaborating on at least one shared test runner, kdevops.

So we can start by using a shared organization for what we need
to share, we call this organization linux-kdevops [0]. This encompasses a
few usual suspects git trees which can be used by both fstests and
blktests picking a "stable" sort of git sha1sum for each and always
striving towards the latest:

  * fstests
  * blktests
  * dbench
  * ndd

We'll be using the linux-kdevops organization for what trees we use and
trust that those in the organization will communicate what is needed before
making controversial changes.

This is perhaps the first controversial change, but it only applies to
kdevops, so if you are not using kdevops as a test runner you probably
won't care.

Those using kdevops should become aware that they should change
their default upstream to use linux-kdevops URL now:

So we switch from:
https://github.com/mcgrof/kdevops
To:
https://github.com/linux-kdevops/kdevops

Users which change this on a live environemtn would also then just have
to change the CONFIG_WORKFLOW_KDEVOPS_GIT on their configuration so
they'd just run:

 make menuconfig # set CONFIG_WORKFLOW_KDEVOPS_GIT to https://github.com/linux-kdevops/kdevops
 make
 make kdevops-git-reset

Those who have commit access to the organization linux-kdevops can
then just commit as needed to help move baselines forwards and if
and when something comes up which really seems controversial we can
use the mailing lists as with this change.

[0] https://github.com/orgs/linux-kdevops/

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kconfigs/workflows/Kconfig.shared | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kconfigs/workflows/Kconfig.shared b/kconfigs/workflows/Kconfig.shared
index 4cccfbe..4a2ecf6 100644
--- a/kconfigs/workflows/Kconfig.shared
+++ b/kconfigs/workflows/Kconfig.shared
@@ -47,7 +47,7 @@ endif
 
 config WORKFLOW_KDEVOPS_GIT
 	string "Git tree of kdevops to clone on targets"
-	default "https://github.com/mcgrof/kdevops.git" if !GIT_ALTERNATIVES && !HAVE_CUSTOM_KDEVOPS_GIT
+	default "https://github.com/linux-kdevops/kdevops.git" if !GIT_ALTERNATIVES && !HAVE_CUSTOM_KDEVOPS_GIT
 	default "https://github.com/linux-kdevops/kdevops.git" if GIT_LINUX_KDEVOPS_GITHUB
 	default "https://gitlab.com/linux-kdevops/kdevops.git" if GIT_LINUX_KDEVOPS_GITLAB
 	default CUSTOM_KDEVOPS_GIT if HAVE_CUSTOM_KDEVOPS_GIT
-- 
2.35.1

