Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB74A3B74AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhF2Ov3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhF2Ov2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:51:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C080C061760;
        Tue, 29 Jun 2021 07:49:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a127so17338727pfa.10;
        Tue, 29 Jun 2021 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hH3BEmirKSuCMG+otrkbrO7MFlVhUAOTXc8+tfT2ViE=;
        b=CmsSoVHisxtL5wc2dRYcuv3RXt4YJoTRY52jbBO/cfouxzT1cktadnQlTTtjdfV7eX
         XrRdmBBiy46aMtnlrPIg4PPrZ0omLn0BBW5I+JFHQ/9jifHfyYABH5AvFf4M1Tj+8rXB
         xHdwqRXTBSkDbaNDF91QBdigZcnvfGBo6yAi+8IbUs4kGvCx7mhlxeixVcmssgl+8Jp1
         AP+6BLvcjEZoX9zn7/uevMb+zdVbW0yO6ROdePvGIke7MjpynFvkCOzaqqiATaK5fzPG
         cH1DIVKtev4ztg8AwReRgMihYw7yiAWFlRxCKNPaA1GRAr3NoUPyjmv/VQIiVUQNw+0T
         6teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hH3BEmirKSuCMG+otrkbrO7MFlVhUAOTXc8+tfT2ViE=;
        b=D01yCRnYu83Q1hwMqFofM8GcfLmqqr8Pr6tDHoaAcdnUgqgTSoTVwGGRmYG2UNdJ9U
         28t1Ni8HEak2QnX+Mv/ZH5iZwrUh+zEdvhhXnJ4nDJhr4zmfj+dK3zOSuV7Ck8KwCG+E
         CuAtY4lGxl3yBMyKYwmkNYC/M31GCTv0HoTACn7jqCdUQm9gcalyM8hxJ409wfs98wZJ
         kDwki2mMCeiDiZ7YseOCSOjY2auXOYCWPCN03TGObNUK5NNwMP2clxtluLZM/PSW2Fm/
         aTfjEjwZh0HbkDKL/8sWAgXP8Bi0IYmF3SrWptpnzPodaaJr7pOvAkFY5albfSN4LLYH
         wERw==
X-Gm-Message-State: AOAM531yynsCumX7plqkKZExLUOHHDjzRBPNDWIBtLLGnedHl2TU5hR4
        l5x3Rmu0vnqPGItLe9HNkJI=
X-Google-Smtp-Source: ABdhPJwyYmOtahkEBc/yRLHUGc0/q8zi0UJFuXJbXkMG/kOJ/BHpsIiVZwqyh9W58qN0z9sWu++LBA==
X-Received: by 2002:a62:1408:0:b029:304:1caa:dc36 with SMTP id 8-20020a6214080000b02903041caadc36mr30701779pfu.8.1624978140983;
        Tue, 29 Jun 2021 07:49:00 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id i2sm3417262pjj.25.2021.06.29.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:49:00 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gustavoars@kernel.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/3] hfs: add missing clean-up in hfs_fill_super
Date:   Tue, 29 Jun 2021 22:48:01 +0800
Message-Id: <20210629144803.62541-2-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629144803.62541-1-desmondcheongzx@gmail.com>
References: <20210629144803.62541-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On exiting hfs_fill_super, the file descriptor used in hfs_find_init
should be passed to hfs_find_exit to be cleaned up, and to release the
lock held on the btree.

The call to hfs_find_exit is missing from this error path, so we add
it in to release resources.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 fs/hfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 44d07c9e3a7f..48340b77eb36 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -419,6 +419,7 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
 	if (!res) {
 		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
+			hfs_find_exit(&fd);
 			res =  -EIO;
 			goto bail;
 		}
-- 
2.25.1

