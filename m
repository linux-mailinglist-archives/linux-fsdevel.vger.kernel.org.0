Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7614E745F08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGCOt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGCOt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78CB2
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 07:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF9F60F76
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 14:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B163BC433C7;
        Mon,  3 Jul 2023 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688395765;
        bh=S7ynZDHNRfOylrLH0bd1ZaN32Y+8ksu/dATn2QJtyew=;
        h=From:Subject:Date:To:Cc:From;
        b=SBzNjAXtWwhrUuiM1Ofzif32Hsn1HHhImzis9siMcqF5sUUs9drXOgj32Os+et1eU
         LUpfqVbzArQq+xUhocjpIn+pvZ5LkbDMIOv1MahLlP6VXxLAG7ogVzxIDtzwsbfeB2
         rZEqJud4ZO3pulBHzLb4K35NgfjwJ3SKqle5HVpcPSbo2BKAFw4XSwiq6doTlT4Rra
         RNKZ/HjODayFtognAxpbac3z2GWEFF8K7IcCOOYIRiTrUazYH7i09C0IUH0pc4Kdxk
         Cz7LCCvIpasR72GSbejTlIv8FyDHfb343j9RunrlD89XmiXx0XXWzc4bN+JahMW/7l
         H4xNFiwtEzW6A==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] fs: rename follow-up fixes
Date:   Mon, 03 Jul 2023 16:49:10 +0200
Message-Id: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAObfomQC/x3MQQ6CQAxG4auQrm0yMgEzXsW4KOOPdMFgWiEmh
 Ls7uvwW7+3kMIXTtdnJsKnrUirOp4byJOUJ1kc1taGN4RIib6OzocgM9mW1DJY+pJilT13qqHY
 vw6if//N2rx7EwYNJydPvNIu/YXQcXwf1mYh8AAAA
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=319; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S7ynZDHNRfOylrLH0bd1ZaN32Y+8ksu/dATn2QJtyew=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsuv95l9C84xnay/bzy7J5322fvNS4U9t61ccmFpdpH2cw
 5X9I6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIUQIjwyn2czFSSzS+LEkKvfjr36
 eJL2bIS3+3Xvo3MuW4jZtIvRgjw1+e0Fjlsoh9OVxO66yUmm0ldmx9Mlvb18Xw7OKrpgolrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

Two minor fixes for the rename work for this cycle. First one is based
on a static analysis report from earlier today. The second one is based
on manual review.

Thanks!
Christian

---



---
base-commit: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
change-id: 20230703-vfs-rename-source-a6093ca69595

