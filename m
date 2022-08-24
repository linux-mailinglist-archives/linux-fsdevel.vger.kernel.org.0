Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5699B59F055
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 02:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiHXAmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 20:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiHXAmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:42:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DDB84EEC;
        Tue, 23 Aug 2022 17:42:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p18so14276689plr.8;
        Tue, 23 Aug 2022 17:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SlBXFXTYk1JyGPv88MWJugtZv0AA300hEZIB82Z3nMg=;
        b=kDItX/cKhy/iYe03htpkysRohqwZ/5zX0XVJ+zwQsVsZAfS3KDz9Wf64U2JLd258x4
         7oaiHcFz4C1afU4v5L3syQDv30o1sxV7t3h7bu/zm+qpT2CHzbtjQvSfTqiWse1/lIiB
         eJqKDZu5WwSn4L5YIuuYtjB9XvRADjD2fQEVEdHDG2wM5qJjzxaJf6z2silC+pIuH0TG
         l5rxbIcMOLwYaO+fbk++0ZSSw0Qr82EF9XKtmjOaj4QWQjph60o2JFsZPE5hZ7XY2u20
         uqhOhcRE5SyGAb/9KLGxZ0K8NwihJ8a5c5dOl0yW5Vy5EvadUOPqLCFI4BGdLbmw/veW
         5XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SlBXFXTYk1JyGPv88MWJugtZv0AA300hEZIB82Z3nMg=;
        b=xJdE2pmb8O6uDhsgh2VXKJuVWBvmoHT73gNHsCs2U8/5oYJa4TxI4x0qnpFbo6i6Uj
         Wz7N+peGZbT6TlUtMjYcELlpk2a8mWztPZ74x46Gudst42fNov2CvZXJ5Tx2iGDQlM3p
         2912rBLgUsmGRnCHkYyxcYV5QKcTOratkWzTa+hDc3F0uSj6n6DrayO3xVKtgvAWZzM7
         gNd510tApOSxW5HFcY1xjnHZy9QDRVvQFyaYXgT2k+uMxXJCcaYzaZ6RUgB30xIQO6HE
         WK21sarLky8+bz9UXAWCxBgAg4tweLgoINN6L828W78CmTGlrOOJ3fK/uEpmsLA3u4eR
         vtJg==
X-Gm-Message-State: ACgBeo0P8ADSvWhWzoH6mpO003buAEjRwjPLiJXzYmKS+aEjLV9qeHL3
        JVntxzSNPAC1F7tmgq4xnKkuIVf9HCJoI42B
X-Google-Smtp-Source: AA6agR6kcETA4QF7wTZI1SAkPDXiOgfQ50WcUxlkByHBMLLdgQXqTEm6TL/MT/Syyab5/NNKoVYYvg==
X-Received: by 2002:a17:90a:7805:b0:1fa:bdab:7d59 with SMTP id w5-20020a17090a780500b001fabdab7d59mr5620708pjk.37.1661301763941;
        Tue, 23 Aug 2022 17:42:43 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id ij5-20020a170902ab4500b0016dd667d511sm11063319plb.252.2022.08.23.17.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:42:43 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 0/7] Convert to filemap_get_folios_contig()
Date:   Tue, 23 Aug 2022 17:40:16 -0700
Message-Id: <20220824004023.77310-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series replaces find_get_pages_contig() with
filemap_get_folios_contig(). I've run xfstests on btrfs. I've also
tested the ramfs changes. I ran some xfstests on nilfs2, and its
seemingly fine although more testing may be beneficial.
---

v2:
  - Removed an unused label in nilfs2
  - Reported-by: kernel test robot <lkp@intel.com>

v3:
  - Fixed minor style issues in btrfs patches
  - Fixed an issue in nilfs2 regarding the block index
  - "nr" renamed to "nr_folios" in nilfs2 and ramfs for clarity
  - Got some Acked-by's

Vishal Moola (Oracle) (7):
  filemap: Add filemap_get_folios_contig()
  btrfs: Convert __process_pages_contig() to use
    filemap_get_folios_contig()
  btrfs: Convert end_compressed_writeback() to use filemap_get_folios()
  btrfs: Convert process_page_range() to use filemap_get_folios_contig()
  nilfs2: Convert nilfs_find_uncommited_extent() to use
    filemap_get_folios_contig()
  ramfs: Convert ramfs_nommu_get_unmapped_area() to use
    filemap_get_folios_contig()
  filemap: Remove find_get_pages_contig()

 fs/btrfs/compression.c           | 31 +++++++-------
 fs/btrfs/extent_io.c             | 33 +++++++--------
 fs/btrfs/subpage.c               |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 32 +++++++-------
 fs/nilfs2/page.c                 | 45 ++++++++------------
 fs/ramfs/file-nommu.c            | 50 ++++++++++++----------
 include/linux/pagemap.h          |  4 +-
 mm/filemap.c                     | 71 +++++++++++++++++++-------------
 8 files changed, 139 insertions(+), 129 deletions(-)

-- 
2.36.1

