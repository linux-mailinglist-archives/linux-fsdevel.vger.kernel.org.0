Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8D2B84B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgKRTTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgKRTTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:12 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDA9C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:11 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q34so1847910pgb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYWJRMKbUtIw9wn+lQz4lq4B6TtPUTRJxtYsp8IVtUs=;
        b=P+TeFcfjPu71imXbMcYBwDzoqWey+0zWEIUwcvdfflet/BxNWCaSv6kLmRFW/E9yyl
         6eKq9y57pzSB292X++K1y2HCqg70YkCI6TKrc8GWvBc3LZvzVDkawgBzpdXNt/i1j9fn
         pCYAcoJy/B2WLKOTLoHJeNUmSMEbJb2EWY/+vV1s4xNM7pPkSGVs0Zh5k6CP9qAGr08u
         UQdil4LvrkKYhg8oKpOVkfRh5yu0pWN/bGHqa2PvGxZmVia+1necn5ik3ryvhnr3YZnI
         QKkX/5VANN4wUr27qECdPYkiaogoIK4S48a5q/FLnnu2Ld6hvlEW9FSR9t1qS1Qfggch
         oKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYWJRMKbUtIw9wn+lQz4lq4B6TtPUTRJxtYsp8IVtUs=;
        b=WaIWGcRqVNFDokXwPiUj33lYcpUljj9HiLs7Ykzbi+7jxG0Avr+YyM8gJ3QH51T6jF
         qdh1ZBf+tEDJvNLpMVMLu40SBwysNT7j27Tl4agK1G59M0GclPdU7fEpWTzADrHw7sW2
         fUOc7F0eQvr4oNXF5k42QBxPy6LRjtNVb/gFHkZagzTNhJLI8Q9L3JsFUw6gYC3z21gv
         I/FdoxzXRyVfaT2AX88VzIXIp8juOeBHWxRKHECCfo3JFKPoS9+Lsp/OxoUcS5iC0Rtw
         FZjStg1vRY4slN7YwNgIEXT5xfWwDyod/k5f1om3Tuqhb9SlITHnB4WyBHIjl7erfi3t
         LZcA==
X-Gm-Message-State: AOAM530eCprhTm3LIeXy9v6QULGRkpdBDVTHT+VAuz+/4SyQnlMktkOG
        dLmgjkdd1sFohJyW49bpQccezg==
X-Google-Smtp-Source: ABdhPJzIDUz8a5nuon9F5p++Ob7zX7/TXpDTPdqKVfXzc+qVORDrdOD8p/eqjNeY4cxMYQ+Qa45OvQ==
X-Received: by 2002:a63:2045:: with SMTP id r5mr9243326pgm.6.1605727151031;
        Wed, 18 Nov 2020 11:19:11 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:09 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/13] btrfs-progs: send: fix crash on unknown option
Date:   Wed, 18 Nov 2020 11:18:44 -0800
Message-Id: <e0aff7fddf35f0f18ff21d1e2e50a5d127254392.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The long options array for send is missing the zero terminator, so
unknown options result in a crash:

  # btrfs send --foo
  Segmentation fault (core dumped)

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/send.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/send.c b/cmds/send.c
index b8e3ba12..3bfc69f5 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -496,7 +496,8 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		static const struct option long_options[] = {
 			{ "verbose", no_argument, NULL, 'v' },
 			{ "quiet", no_argument, NULL, 'q' },
-			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA }
+			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA },
+			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "vqec:f:i:p:", long_options, NULL);
 
-- 
2.29.2

