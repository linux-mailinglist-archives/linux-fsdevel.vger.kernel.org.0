Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D51596184
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiHPRxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiHPRxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:53:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9C957E1F;
        Tue, 16 Aug 2022 10:53:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pm17so10367229pjb.3;
        Tue, 16 Aug 2022 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vqWu9nIMNs2OYllxNa/lgOV5pa8uiLhr0uktPZgpEhc=;
        b=JJCfNmBZtK7Rg0LXuekIXzocFyEbiUou4havkGQOMvUoSdfxVx8XppTLKJTOFqUZx5
         hta/gDv8tA7m2h/EMpdDQjY/WBac8uFD2WO8SklWF4kOI0kf2SQCzx7txtv3r2gE83u9
         r324iX+CFT0tepJ2GssUIre+HbXMmMh5tO6NODLP4obrp9z7fdBzbpA6465pvcUBO5DC
         ByknkvBBsLQh4zIdTwXT0OEHCt9ZiQ2srmS8ChuKTITaTBE/jBiXatN+/xfGvnEVOl+q
         uC40CwHcJ2i7TBvHjRD+vMrN1gNxcFfEJX0Mh8wFWqgJJn6xvbeN0VnyzqxL4qx0tnVV
         pI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vqWu9nIMNs2OYllxNa/lgOV5pa8uiLhr0uktPZgpEhc=;
        b=grhNIMja8eUfTHG5t8BsvzE8NvAaBryCld7vF2dwW6jEOVUa70UPiR006UBKadvX6+
         BAJ94HmWxBYyQtSfFanTm7aWIyRNW6uFjxoX/stOnwarsfICvOtr47y0j/uQjr/kSyoB
         UIZ1ya486kSUG1rZoYS806K1sh3hRpw+lglnXXyzUY0qRnKMCRUuSNdlY9v0DnBj6L+f
         XT8NIszd+Wr6ZjhF/87sK+vdgKgsh2EHIWQB6x/g0zIuCEJU7IW2S4ZW6FXVc6/ZKz/I
         eGdBZDDJzPGF+QJDBEtYQafDrsx2cgFk74/W2MI/YCJl43CVUsICHRY5YsOxCAPhpTIb
         ygmg==
X-Gm-Message-State: ACgBeo3gUTadX4IWnGSCb3FwR/jbKbU8n5uUVOhqzH5pc7cCgdAfvmDp
        lJHDo0XGOgxVyXRN91LaVuoctYh3C0Nhwhhg
X-Google-Smtp-Source: AA6agR4pvPuZRyprK3AmV9QelTNUf6H+/44KZsWrd1lsqcvOp2zgHzbSdnacVOmXxYl32Vqqvvnecg==
X-Received: by 2002:a17:902:c1c4:b0:171:38ab:e761 with SMTP id c4-20020a170902c1c400b0017138abe761mr23726924plc.65.1660672398038;
        Tue, 16 Aug 2022 10:53:18 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm3379963pjb.3.2022.08.16.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:53:17 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/7] Convert to filemap_get_folios_contig()
Date:   Tue, 16 Aug 2022 10:52:39 -0700
Message-Id: <20220816175246.42401-1-vishal.moola@gmail.com>
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

 fs/btrfs/compression.c           | 26 ++++++------
 fs/btrfs/extent_io.c             | 33 +++++++--------
 fs/btrfs/subpage.c               |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 31 +++++++-------
 fs/nilfs2/page.c                 | 39 ++++++++----------
 fs/ramfs/file-nommu.c            | 50 ++++++++++++----------
 include/linux/pagemap.h          |  4 +-
 mm/filemap.c                     | 71 +++++++++++++++++++-------------
 8 files changed, 134 insertions(+), 122 deletions(-)

-- 
2.36.1

