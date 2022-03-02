Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2798E4CAB61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbiCBRTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 12:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiCBRTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:19:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E23FC8FB1;
        Wed,  2 Mar 2022 09:18:37 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 12so2223951pgd.0;
        Wed, 02 Mar 2022 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wH+95IPbGU7LsO+nMed5iXzS0Pw2Zt/UPlRhOF3gCdA=;
        b=M8852nDZ1BX27cpQ3GBheX66KgLAxHQ2VbwYXmnN/wc00WoT/ShdkUbs4JmmPfQXBc
         IRj444RvI2d1RIP1sijylV3cK48mstE+tFzjLNADlSjmjPMGI5r77Pit1CJmPnwRwBpL
         pDTCIfUpSweQMwKO2gpix67Grp64NkH3Fc4hC+bCiRD9Ao0T6JfsKAqtUoncp3/NWzJl
         Rn2o+D1uMSzY4SbYLyECFAiUP/5ByvEzJtAUMNHt2h/5gp4VbhKa0tpTJBxlYv5IYZf/
         9MeckTiYKNIS/Fj1aaG3eFeGePDqLn7UNkQoh4RFTx5xXT/R517HvFnqqDJBjCeG6MER
         kD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wH+95IPbGU7LsO+nMed5iXzS0Pw2Zt/UPlRhOF3gCdA=;
        b=7qw07SUWw74pt3vnorcOkd8CPk4Bu4TZZV2erBivdEFQ4cZE05SpRlBvtFBGWbFysz
         TUn8xqfAmW+PSTSRvnGmlZ/IjuId0MWgdEq9A+/hXk+jkmJapwSGgq4HYx6W+zR0g0co
         13wtpqzWG7cdTbt1l9wfJgCxgr3v0yt5pDGIWvGj+Fi4c8x2ox5kXgPXj7rpGm5RAvXY
         xmxHVW+IpBFbpifMih3z/vc8wWnFypQKQbLolOqKrry9BRSFnbWd45mdJOYfVeTaaRf8
         zkhYJyYBK+1LT3krt5bkHmu9Ea1mg78AwJVI9QHLnxDJJcIMeY5JRlli7w2yOMSS/C2H
         nkFA==
X-Gm-Message-State: AOAM531lrFC/NDp2/I2+V7u9emsjYYUYwBObH6SSJ6T4gSjokmB4zRmN
        ajToiA2n9UDqSm90eDQMWAQ=
X-Google-Smtp-Source: ABdhPJw/Vg1GZgRtifAmdYbWBTQSaZflWGmOwq3YAOBtD53njeZS72iIwbBx0Yl8ByT/lN86yhMrBQ==
X-Received: by 2002:a05:6a00:b52:b0:4f0:ff67:413 with SMTP id p18-20020a056a000b5200b004f0ff670413mr33920452pfo.61.1646241516606;
        Wed, 02 Mar 2022 09:18:36 -0800 (PST)
Received: from kvigor-fedora-PF399REY.thefacebook.com ([2620:10d:c090:400::5:d6ec])
        by smtp.gmail.com with ESMTPSA id c63-20020a624e42000000b004f414f0a391sm10339965pfb.79.2022.03.02.09.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:18:36 -0800 (PST)
From:   Kevin Vigor <kvigor@gmail.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Vigor <kvigor@gmail.com>
Subject: [RFC PATCH 0/1] FUSE: allow drivers to increase readahead.
Date:   Wed,  2 Mar 2022 10:18:15 -0700
Message-Id: <20220302171816.1170782-1-kvigor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Summary:

Allow FUSE drivers to increase readahead setting.

Details:

FUSE drivers can set a max_readahead value in the fuse_init_out value.

However, this value can currently only decrease the readahead setting
from the default, which is set to VM_READAHEAD_PAGES in bdi_alloc().

Add a flag which causes the kernel driver to accept whatever
max_readahead value the user provides in fuse_init_out. Note that
read_ahead_kb_store() similarly allows users to set arbitrary ra_pages
values.

Kevin Vigor (1):
  FUSE: Add FUSE_TRUST_MAX_RA flag enabling readahead settings >128KB.

 fs/fuse/inode.c           | 8 ++++++--
 include/uapi/linux/fuse.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.33.1

