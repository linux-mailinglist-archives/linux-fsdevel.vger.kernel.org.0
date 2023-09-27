Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337687AFA98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 08:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjI0GEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjI0GDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:03:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27019F;
        Tue, 26 Sep 2023 23:03:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1657C433C8;
        Wed, 27 Sep 2023 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695794583;
        bh=01fluBx6Of2K/eByxUSW3CGmW9JZOv7Q2Sa2ea4VCTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bOTINPwqBFbxA86JbXopC7VwtUeZoBv2BDvOoR4G9bkSlczSxu7GtkCIEXi7UQQdJ
         Yh19cYWPAEtdmDrgqnyAuQxLXNDElCoNmE8r4fTDNvf4P1oQyYDlBrQ5ZR8AZ/okWi
         dgZP+gB71akdEEQA8rIe8E0556tvCSggxO0aqc6skpXrsJBIYZE9OORmthqvYZS90p
         PInHLs6psi/qkoCF1rs4vZmzVsAkgmmYvzc3QVzQ2FnwevNCve4MfzeeByUmBbgr9J
         G00Rh3/u+UtxBR5zzj1UDF3XU5WOjnBCp3y0g4z0GuPuADkvoA5q/vJJ6KEYJFo0g5
         I3Bo/S11+YPHA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: hide unused pagemap_scan_backout_range() function
Date:   Wed, 27 Sep 2023 08:02:23 +0200
Message-Id: <20230927060257.2975412-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function has two callers, each of which are hidden behind an #ifdef:

fs/proc/task_mmu.c:2022:13: error: 'pagemap_scan_backout_range' defined but not used [-Werror=unused-function]

Add another conditional to check for both options to avoid the
unused-function warning.

Fixes: 93538f467c0f6 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
A different fix "fs-proc-task_mmu-implement-ioctl-to-get-and-optionally-clear-info-about-ptes-fix-2"
was applied already but is wrong and introduces a worse result:
fs/proc/task_mmu.c:2105:17: error: implicit declaration of function 'pagemap_scan_backout_range'; did you mean 'pagemap_scan_push_range'? [-Werror=implicit-function-declaration]

Please use this one instead if no other fix has been merged in the meantime.
---
 fs/proc/task_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 27da6337d6754..f5d3f2b8fa944 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2019,6 +2019,7 @@ static bool pagemap_scan_push_range(unsigned long categories,
 	return true;
 }
 
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)
 static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
 				       unsigned long addr, unsigned long end)
 {
@@ -2031,6 +2032,7 @@ static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
 
 	p->found_pages -= (end - addr) / PAGE_SIZE;
 }
+#endif
 
 static int pagemap_scan_output(unsigned long categories,
 			       struct pagemap_scan_private *p,
-- 
2.39.2

