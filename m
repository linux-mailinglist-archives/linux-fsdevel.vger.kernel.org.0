Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8283E593C46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 22:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbiHOUJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 16:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243242AbiHOUJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD883F0B;
        Mon, 15 Aug 2022 11:55:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 17so7108649plj.10;
        Mon, 15 Aug 2022 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=TcoNVDdeHBjRL/cgwoXp3ksLrjGTv3LMhMhYdWqOUwk=;
        b=ip3lNnuRVCkKTJpyHRzp+iY1wE94DuhoDhEvhy2tFyM0MQL201v5SEkPA+UV8sh9TQ
         I/tYbxzs13zwkDghMIwYShD0PlhCUsKMKVL5HQh/tKqD1rzj6EXWyH4zVwPgOk6w3wVX
         d1npJ3/rrsl3qskZgl40Wpt/2Nkm7uDW95Zk6B+dz0gFLJFm2YDbhm8yXhWV0A0Vvgdd
         AcJDbbzRGabl/HUPXwY2vCQZXK/yEKeSFf8Ybwqvh8uOq9MzANixeh/dAAq4xoM4mtd9
         rpKgcJBOcGdyevdujOPAEJ+NpMWqCUndMIfJHFsDlXjT5sympvogVbr+jDBb4R8o+u5g
         OPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=TcoNVDdeHBjRL/cgwoXp3ksLrjGTv3LMhMhYdWqOUwk=;
        b=aDC/yJ9MlVTREgYLYp5LSJFqAv6ne0c9MVyG9kdtKSio8uMysLX/TnIqjCXhr2UYUE
         LVofG52VFesPE3sPnK4+G3UltcknN/XNXRxmErKfQsQn4zyRSDGicCOOKMRNxzcH3hd0
         D4+nM1gPr5pOyyXOgSpzJRwv9tfPouSjdQNxD43vkhmX4fvXCfNCUHizNJa4muPdrNfQ
         KZcRpVrvXZtgOR7Ea+/6/Jqpvct3CPGumjz3VsLHi5DwKKLtICeVVOryilolmAhTuQSx
         Ogs6DKQL8kd36D6AoOxKfvwlutHwJjoSoEdU+7YsgMhdsxEXAJlPOUgI8s37xn4MaYM8
         RIVw==
X-Gm-Message-State: ACgBeo3SeLyQz9YZgOW9sGXjrqcsyWS2dzsO2dLgEXlTQEFefHayDkLM
        6z8evCpzVQ/zt68K/Ztkmd4T/bWLZzwr4tQP
X-Google-Smtp-Source: AA6agR6q3cK3IU3itRNZLUNBayOljpSXC+G907D9MuhlVHg/g+8N1sJcR4/YxfAqJ9bsTsVEhXzDjA==
X-Received: by 2002:a17:90b:3d8:b0:1f4:d5c4:5d76 with SMTP id go24-20020a17090b03d800b001f4d5c45d76mr29486811pjb.219.1660589757052;
        Mon, 15 Aug 2022 11:55:57 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm6858174pfx.167.2022.08.15.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:55:56 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/7] Convert to filemap_get_folios_contig()
Date:   Mon, 15 Aug 2022 11:54:45 -0700
Message-Id: <20220815185452.37447-1-vishal.moola@gmail.com>
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
 fs/nilfs2/page.c                 | 38 ++++++++---------
 fs/ramfs/file-nommu.c            | 50 ++++++++++++----------
 include/linux/pagemap.h          |  4 +-
 mm/filemap.c                     | 71 +++++++++++++++++++-------------
 8 files changed, 134 insertions(+), 121 deletions(-)

-- 
2.36.1

