Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6179159F251
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 06:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiHXEAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 00:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiHXEAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:00:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F8348EAF;
        Tue, 23 Aug 2022 21:00:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r69so13961350pgr.2;
        Tue, 23 Aug 2022 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=y2ItLojeupF+41y/feOT7mcA+lNVl5+uk3WTfRgyZWo=;
        b=FZm6pjZLVHvTwnOaUhU87KMumo1jutVo6gkEY2lR0Hdgr6FEDGj9E769Iph2zWzXym
         KWavclQXfvDAd1YXfNIV5to34Rhb0rLlhHp79jh8Vw4qaGXX6bA3DOSGPL5Lf23QtI4o
         Bh35da9WTrqsSneZmzDGOoKlSqnNEOrD/0nzJQxl58BVFOls0l29WpQyTohHDONqskjq
         nQsVbQY+lldeJ0tu6rrufGfgF4eJPJSErd5BLtl+Oy4CZDWYx963fP1SBYS7UmHSV5Qb
         0NiqknwHXI0ttdB+xzqeDipWCIVZ4Ot790jCWhypPMytaxf82CbT0WiOOilm867YabUr
         brNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=y2ItLojeupF+41y/feOT7mcA+lNVl5+uk3WTfRgyZWo=;
        b=TkerpBRgxf55o10G5PkfB3Rsv6I3c/grr9zA/bOdxo/n9LSiW3/JFoF7yVD3fFBsCy
         ZMwtbOhBBfdMfSWNOkbTYytFOxNjd6RA+ALA1Z7zx+EMnbGYaXi8c9iQueBui/bNGQY3
         tU7TSPrDX2qzf6gzN9KYD2oEWI/tUsehwy3KN6pn3GUWoKvHEONzI5YA2ux7E8sAj5km
         fyD70NLaIZCmS5dK+Vd9dehGr6rktiWoHTdCT04Q1kbTLxI2/1ftJv8807EzWy956m36
         Xp8Sqb2ga7XycNSXOtaRn4WlZC/G8GZfp15JqusB9o4AhGIkqcWn+fPIgYY/GRWHY7mH
         i63Q==
X-Gm-Message-State: ACgBeo0Vk8iMyqJ3qInSXMnfIKAQG0+VGn8r89X0iI4uBJPOT7dcpNmo
        Nr0Vy/MDEpX9PguQN9uckrA=
X-Google-Smtp-Source: AA6agR7BFFtGaiF3KEjPSXTdPFldV3Lk76tXgaS+fwLQVAxrPvgd+9bAmRB0oLczDQazU2nnVmb++w==
X-Received: by 2002:a62:7b14:0:b0:536:b424:3780 with SMTP id w20-20020a627b14000000b00536b4243780mr11246867pfc.63.1661313642206;
        Tue, 23 Aug 2022 21:00:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n3-20020aa79843000000b005368341381fsm5883011pfq.106.2022.08.23.21.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:00:41 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH v2 0/2] ksm: count allocated rmap_items and update documentation
Date:   Wed, 24 Aug 2022 04:00:36 +0000
Message-Id: <20220824040036.215002-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

KSM can save memory by merging identical pages, but also can consume
additional memory, because it needs to generate rmap_items to save
each scanned page's brief rmap information.

To determine how beneficial the ksm-policy (like madvise), they are using
brings, so we add a new interface /proc/<pid>/ksm_alloced_items for each
process to indicate the total allocated ksm rmap_items of this process.

The detailed description can be seen in the following patches' commit message.


*** BLURB HERE ***

xu xin (2):
  ksm: count allocated ksm rmap_items for each process
  ksm: add profit monitoring documentation

 Documentation/admin-guide/mm/ksm.rst | 36 ++++++++++++++++++++++++++++
 fs/proc/base.c                       | 15 ++++++++++++
 include/linux/mm_types.h             |  5 ++++
 mm/ksm.c                             |  2 ++
 4 files changed, 58 insertions(+)

-- 
2.25.1

