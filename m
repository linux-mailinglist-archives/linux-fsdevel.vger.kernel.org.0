Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40DF62EE5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbiKRHbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiKRHa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:30:59 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64560205EF;
        Thu, 17 Nov 2022 23:30:59 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so4282313pjl.3;
        Thu, 17 Nov 2022 23:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtwS94zRRJyqTUvKtV8JHHAty8kXLov0sVlZCky11iI=;
        b=mvtdnCOo5EVJMRpl2n3mwZdHhT3J/8zAsxYxERhNghlOn9ojFKpKWI1nhf2RdT6WVx
         kwHNzOCrOADIuK28R7LCGLO++fAC3hTokxwFmthmscnPZS06qIqKk3jAaxEimDq8sPPb
         ONxKXwnaMQo4L46CWUiAaNODqPmazm96vgMHPxbBFSPzjFcjcxX0WpHqnSno5Qjl1TmZ
         HJHY6PIZRpuHauJReCRvbrbJdlfjBCrFJLf3206T8JI34fJjnj78wComVWR6vzSk/ZOd
         DD0mcGJ1wTmTJzvkotZbkgH2XTeFB2pZNfkozux4TAjo5MD2jaKGMmv3odz6UMnnhoYa
         ZzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtwS94zRRJyqTUvKtV8JHHAty8kXLov0sVlZCky11iI=;
        b=qOfT+/eGSVRQTw7iJdLCFhHX7Zd2SOKHnSRbqWXqomIZuxrA+80vyNeXY91VS6rwfL
         N4z1lH+Her8w2+FCaeLkDZs75H1RC0ObRQ1Lok+Fn8d1Gca3xZtAuwAa/S3eb5PbJZeT
         T9SGveWt0SaTwn5rftK3ik4ynsHM4V7ltXoxJPa/t5qHZvIqjXrgynpyUaTaPil+R6Sw
         EgFAjlYJyHoJ3JfUfMEL9RY9YFVAjDtP6kpQut6kohJXpLRC4iBWpX4Mp+P9jB/CHvMT
         J9HAkaMlFtG+naS2q1twUncZxiZUkdFvd6a1RSyH+BNqPXo7UEdkCXFdSljRY8RBcBzO
         Y/gw==
X-Gm-Message-State: ANoB5pmk7jSBP9kxdpRjdCI311Ivn65h0uMy6Jo3WzNsuzKxmVQjjV/6
        GDfLVMN0WqPfGwYiet1McMg=
X-Google-Smtp-Source: AA0mqf6eIoxfujWd5r39sBNB2JOJS6JTM5mgw21co0QA2sasxQsUBxlqwBDsbb98FAm/PTJrvzn4Zw==
X-Received: by 2002:a17:902:c385:b0:17f:cdd1:7ab1 with SMTP id g5-20020a170902c38500b0017fcdd17ab1mr6397755plg.86.1668756658748;
        Thu, 17 Nov 2022 23:30:58 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f7-20020a625107000000b0056b818142a2sm2424325pfb.109.2022.11.17.23.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:30:58 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 0/4] Removing the try_to_release_page() wrapper
Date:   Thu, 17 Nov 2022 23:30:51 -0800
Message-Id: <20221118073055.55694-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This patchset replaces the remaining calls of try_to_release_page() with
the folio equivalent: filemap_release_folio(). This allows us to remove
the wrapper.

The set passes fstests on ext4 and xfs.

---
v3:
  Fixed a mistake with a VM_BUG_ON_FOLIO check

v2:
  Added VM_BUG_ON_FOLIO to ext4 for catching future data corruption

Vishal Moola (Oracle) (4):
  ext4: Convert move_extent_per_page() to use folios
  khugepage: Replace try_to_release_page() with filemap_release_folio()
  memory-failure: Convert truncate_error_page() to use folio
  folio-compat: Remove try_to_release_page()

 fs/ext4/move_extent.c   | 52 ++++++++++++++++++++++++-----------------
 include/linux/pagemap.h |  1 -
 mm/folio-compat.c       |  6 -----
 mm/khugepaged.c         | 23 +++++++++---------
 mm/memory-failure.c     |  5 ++--
 5 files changed, 46 insertions(+), 41 deletions(-)

-- 
2.38.1

