Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906CD5A6669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiH3Ohq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiH3Oho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:37:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68877DCFD8;
        Tue, 30 Aug 2022 07:37:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w2so11347050pld.0;
        Tue, 30 Aug 2022 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=t61k1aDyx+L0f7vlPMo7+bBC9RRSVzzIXIA4hD1A+R0=;
        b=JS/iz1eHjkfvwh0KwIhrWF3jg/8QmyTBXsRsWI9YYnphfYdC2SuZpDyL4vuFccky+l
         kzmHZAvkQFjxIfZqHBnM9bGk/spFjMDePGupJCUPz8cFj7n8vOsZwR/29atoVs9k11XE
         IeSysBvsmay1S4D7imF23NwDhk238AV//yakTF5ilIZpEcO7+0balE03YJKC1THxwFUO
         +FaRv7SFNjdvpB+WmkfR+HRv62qMykrWIyzARwtucsC//rcXK4amlDgRI+AVm9ZzYw/w
         4iPOCJsfuwT5eOHgKg9IqDcr7geBpWKffwOztfT4KOU+iuwreu7aIpKQW0PD97wBP2my
         rcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=t61k1aDyx+L0f7vlPMo7+bBC9RRSVzzIXIA4hD1A+R0=;
        b=xNmwhvOu7MN3w2XfMNDnwMmDIrKc9kXz467e4J3D+F6uYIVfQqu+24j9OODDO2q6dA
         RaK7j6rtwabhG6njFWgiP7mJdbGxX5uUp/8IMR1IZefBtghykg+o1XwNJq6Ze5SO+8Wt
         vDK8EmI7I1X577a1ktKySWhnowxEd/G3ib0ZacaaEzzRCy/xnSIuraFknW71f4NhH0QX
         2MxB3cRLjBiZ5E+h73ldxEI2DlIxLqzMsQ0uTE+b8obFj28w0EDqQYvsgm7UPZ5A4OAx
         hJvr0JUjb5crPLVtGiP6x/CGhPWMgdclodqgnWiY93rV6V4q2vTVUZkpFZ7wCaQxPw6B
         Dn/A==
X-Gm-Message-State: ACgBeo0TpNcgBlyhxc8KoMXgd0P4mxty/Rpnl+ZXROuzOuPDEAMKgSOe
        MtEzU5M/AAamojWIQU+psfY=
X-Google-Smtp-Source: AA6agR7JqcQ8J8avBJm64d4QPLhOYCKbAqfKxE24KgoaM7z6CUkeA2jOmahZrPQWdd3g6oygwyaFOw==
X-Received: by 2002:a17:902:b090:b0:172:dacb:5732 with SMTP id p16-20020a170902b09000b00172dacb5732mr21376616plr.5.1661870261935;
        Tue, 30 Aug 2022 07:37:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y16-20020aa79430000000b0052e7debb8desm9327755pfo.121.2022.08.30.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:37:41 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, willy@infradead.org
Cc:     bagasdotme@gmail.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH v5 0/2] ksm: count allocated rmap_items and update documentation
Date:   Tue, 30 Aug 2022 14:37:31 +0000
Message-Id: <20220830143731.299702-1-xu.xin16@zte.com.cn>
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
brings, so we add a new interface /proc/<pid>/ksm_stat for each process
The value "ksm_rmap_items" in it indicates the total allocated ksm
rmap_items of this process.

The detailed description can be seen in the following patches' commit message.


-----------
v4->v5:
1. change ksm_rmp_items to ksm_rmap_items;
2. use /proc/*/ksm_stat as proc name rather than "ksm_rmap_items" and
   start filling it with the value "ksm_rmap_items" so that more values
   can be added in future.

v3->v4:
Fix the wrong writing format and some misspellings of the related documentaion.

v2->v3:
remake the patches based on the latest linux-next branch.

v1->v2:
Add documentation for the new item.

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

