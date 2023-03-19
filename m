Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5E6BFFAD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 08:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCSHJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCSHJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:09:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A35C5B93;
        Sun, 19 Mar 2023 00:09:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o12so35399009edb.9;
        Sun, 19 Mar 2023 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679209778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7CWAvSEY2TydX64pSxRJDmGgnmPbocGy/UbjjMMCMo=;
        b=bvHAjrvZeVHCFpT6C21GJEBkh64oyOiWKAEW6g437+AAjXVbxgtn6a2VBqW+bTjTX4
         g+mix3ktiYBfYozJwhsdakbwyl0JpWu1+btjJ2G3qaT7Q1fePW2moy5gWQU8dbVouKoa
         Ru71nCX9aipl2GAW58MVQu4wnUXr4xri4E9s6eJo7DfdAjw4t6zcNGqIGp1X8hr2xkG3
         qKvI42XXzOL8C47Gyf99en3XyCojwP4Y4YSos/qOV+Ke1T3WZ8Rv+mYXTbApfK6jIbeB
         vaOTQCkuD7D0To2mA9ptXXIZI7R7BimpFDrr68WvSR25MtbQAzjEz00gNGBG12+83U4/
         s9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679209778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7CWAvSEY2TydX64pSxRJDmGgnmPbocGy/UbjjMMCMo=;
        b=AWoZOzaGD+GMbUDIFv8rzvrzGAppVWqd4PhBC7SuMvdPUaEDApjFk3kZtCUl+tkrfs
         ttHl4Im2mIFhHGsigFDeD0IZuUXhkHjMclBFROrq8r0HE4S8wn8U8ka7nHb8xnYnXHod
         PBh853NndPZpebIcRsP1wv5XAjsRMfdoybC5Imm+xzxIs4sDgXx+CIIve/ZVIxv2tEJQ
         ZHNzE3SrITx+mRLuUOig4uRUhu5XDsgVA44qfbYLwj8wZucDBQ6Zdg79Q4FTiI9RL1N/
         bWdir0YBcK6C/hmJQRZfa8taH1SX4GZ6dcawMitZU5LfaT0tWf5lWwJ++iOx8Bho/KJ5
         orWA==
X-Gm-Message-State: AO0yUKWbAO3KBIk3DW7SRN4HicP6PZECRMJFSnfGh+ea9AaWj2TOTrRM
        iDTq5/QvReOG5zvcE7EYEH9hSXddT3E=
X-Google-Smtp-Source: AK7set9ZN+6uFMowb9J0E6bteotuhvTBs9uIxHBv3SH3j1p97abVzqScTMPB0+fmCXdaFw5LvkZb+Q==
X-Received: by 2002:a17:906:884:b0:878:61d8:d7c2 with SMTP id n4-20020a170906088400b0087861d8d7c2mr4831312eje.39.1679209777677;
        Sun, 19 Mar 2023 00:09:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23ee:1938:1bcd:c6e1:42ba:ae87:772e])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170906b10800b008c9b44b7851sm2943920ejy.182.2023.03.19.00.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:09:36 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 0/4] convert read_kcore(), vread() to use iterators
Date:   Sun, 19 Mar 2023 07:09:29 +0000
Message-Id: <cover.1679209395.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reviewing Baoquan's recent changes to permit vread() access to
vm_map_ram regions of vmalloc allocations, Willy pointed out [1] that it
would be nice to refactor vread() as a whole, since its only user is
read_kcore() and the existing form of vread() necessitates the use of a
bounce buffer.

This patch series does exactly that, as well as adjusting how we read the
kernel text section to avoid the use of a bounce buffer in this case as
well.

This patch series necessarily changes the locking used in vmalloc, however
tests indicate that this has very little impact on allocation performance
(test results are shown in the relevant patch).

This has been tested against the test case which motivated Baoquan's
changes in the first place [2] which continues to function correctly, as
do the vmalloc self tests.

[1] https://lore.kernel.org/all/Y8WfDSRkc%2FOHP3oD@casper.infradead.org/
[2] https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u

v2:
- Fix ordering of vread_iter() parameters
- Fix nommu vread() -> vread_iter()

v1:
https://lore.kernel.org/all/cover.1679183626.git.lstoakes@gmail.com/

Lorenzo Stoakes (4):
  fs/proc/kcore: Avoid bounce buffer for ktext data
  mm: vmalloc: use rwsem, mutex for vmap_area_lock and vmap_block->lock
  fs/proc/kcore: convert read_kcore() to read_kcore_iter()
  mm: vmalloc: convert vread() to vread_iter()

 fs/proc/kcore.c         |  84 +++++++------------
 include/linux/vmalloc.h |   3 +-
 mm/nommu.c              |  10 +--
 mm/vmalloc.c            | 178 +++++++++++++++++++++-------------------
 4 files changed, 130 insertions(+), 145 deletions(-)


base-commit: 4018ab1f7cec061b8425737328edefebdc0ab832
--
2.39.2
