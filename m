Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BF25AC886
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 03:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiIEB3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Sep 2022 21:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIEB3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:29:35 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 954D02721;
        Sun,  4 Sep 2022 18:29:30 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0DBB31E80D74;
        Mon,  5 Sep 2022 09:28:37 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RecJVu1hqtca; Mon,  5 Sep 2022 09:28:34 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 65B7E1E80D59;
        Mon,  5 Sep 2022 09:28:34 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] proc/proc_sysctl: Modify the order of scheduling function calls
Date:   Mon,  5 Sep 2022 09:29:25 +0800
Message-Id: <20220905012925.3117-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the ctl_table_header object is judged to be valid, the scheduling
check is performed again.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/proc/proc_sysctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 50ba9e4fb284..36921e2ebeb0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1729,11 +1729,10 @@ static void drop_sysctl_table(struct ctl_table_header *header)
 void unregister_sysctl_table(struct ctl_table_header * header)
 {
 	int nr_subheaders;
-	might_sleep();
-
 	if (header == NULL)
 		return;
 
+	might_sleep();
 	nr_subheaders = count_subheaders(header->ctl_table_arg);
 	if (unlikely(nr_subheaders > 1)) {
 		struct ctl_table_header **subheaders;
-- 
2.18.2

