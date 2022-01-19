Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBA49430A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 23:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbiASW1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 17:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiASW1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:27:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C64C061574;
        Wed, 19 Jan 2022 14:27:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so8838773wmb.5;
        Wed, 19 Jan 2022 14:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DewfwLZFcsnQ9ncpMxSujVRfw0OZIAPpjTixgbn7cO4=;
        b=FyWmTBJWfW4BZj88fk1zNS4Qk6/ciN00sglYtgb2SE6qohdf1AnadARKLw9ZcAfc/C
         cONhz7zFV5vSPQw2AVl+MlZ9fkWmw3s4m8YgOBFqoByk/49H6Lg8WlWrKW+S+5sKeqpI
         HeEu+JN/UVkrgyEhzl/RVbOWrUNKZHznXJZ7/hkw7HCVyNR2HAxGM5hJTYiVJoATCsar
         BJl3VM2dnTCo8gDSNUDvK/+IngGNdkjyK486MkdIq168GVGyCEBjyY3PlgwpaCpzMDJx
         cyWVUe+CRQzahl20+O4/S5WS5TSFQ3+LTJbSN1m0T0cFZ79O2PYnz10IRVFBODTQ26VT
         bFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DewfwLZFcsnQ9ncpMxSujVRfw0OZIAPpjTixgbn7cO4=;
        b=xrqxBFpG6s1189vslYo0F1ZAaQgp1TSYMWyNUYMyokJAfCFek+fGqTjE34a1AUd26+
         hOEpc+KiV8paMJUDEs/rRni39S3h5aTiBVcmYM9NO+qNTZ46Jw6lHs/fdjNQftIDLuno
         qyFJZNs5AVYuKo0ZYdBqM3tGv9D47UObBfJ+7jq6Y1zVyNXYVOWfvLiM6WwD8Lel6p8o
         IYWF9fbWw9CHCKx1mzw/ZzPLlEbju8Yf1yKsGPbtH51yGpP2Zs4MsPcGTr7io8n5mDDD
         ILMBxBVsex9v1AOlGN7+tVc75o4mbHfVgzQFNB5LiT2k9jy5P1xqjg7PkcuYpoQnYbBF
         iEeg==
X-Gm-Message-State: AOAM530AAEu3kaePl0eV2Rr0ssYi+yuu1URNr66N+Cjl+tuvmrrFlDIQ
        MMWYc0+CRijM5GeVi4H1jKJ9ieIxOn6ETg==
X-Google-Smtp-Source: ABdhPJwdHP56Fn/iianQoY6+zo6qivLJMovmcOBNiZlgtysy3YcqH7ISqcGIWhnB51NmGEt8inpFvA==
X-Received: by 2002:a05:600c:a47:: with SMTP id c7mr5776345wmq.23.1642631251405;
        Wed, 19 Jan 2022 14:27:31 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l13sm982203wrs.109.2022.01.19.14.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 14:27:30 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/coredump: rate limit the unsafe core_pattern warning
Date:   Wed, 19 Jan 2022 22:27:29 +0000
Message-Id: <20220119222729.98545-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is possible to spam the kernel log with many invalid attempts
to set the core_pattern. Rate limit the warning message to make
it less spammy.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1c060c0a2d72..2dadc1dcaa2c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -898,7 +898,7 @@ void validate_coredump_safety(void)
 {
 	if (suid_dumpable == SUID_DUMP_ROOT &&
 	    core_pattern[0] != '/' && core_pattern[0] != '|') {
-		pr_warn(
+		pr_warn_ratelimited(
 "Unsafe core_pattern used with fs.suid_dumpable=2.\n"
 "Pipe handler or fully qualified core dump path required.\n"
 "Set kernel.core_pattern before fs.suid_dumpable.\n"
-- 
2.33.1

