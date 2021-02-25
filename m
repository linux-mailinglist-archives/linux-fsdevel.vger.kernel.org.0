Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59203324D10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 10:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhBYJkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 04:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbhBYJjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:39:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D5C061A2D;
        Thu, 25 Feb 2021 01:33:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s16so2869111plr.9;
        Thu, 25 Feb 2021 01:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRc8kqJLiL0cteqcYhIFKGNwREHFOWiYv8Q/pdnFteg=;
        b=AmZ474y7XCT4XraclC/jEJxomJg/vBDaJUYqXxEJoefw9gvSG4N8lBO+mxzfF+Xzf4
         6ZMxr9k4p30eGwEWBrbnnAS3mHMFjRk1zrb5POjmbNZNG5TyoGVl3U6mXaaZ/4jLOjvs
         qum8SjWgrmStNpAY2fskdVM0Ei3aEmiKJPSboTMxw6eVx8moQtdVvEU4+TQxbWnRM1IW
         fdVC7bsySkGjH2U4juVkVWcqah1u6u7WUq0G1+d/lz/B33js5Br/IDo6znUhr+j1VD3v
         8sehKoVY8l+AZI/7bQ4oiCc3yqoBSw1sWKwWxugv6M3lLEO9jzKI84Q/i1DreHTlqbbt
         efEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRc8kqJLiL0cteqcYhIFKGNwREHFOWiYv8Q/pdnFteg=;
        b=nQePnFomOw1x0u/1nxrGj5gx/rVhkY3Pr4SvBRMVqdt9st7CJRJWiNhVJM2K27GwYS
         fPgQwOO7ODhLU6OP4FdfUPmhg4xZJZ1hxv/P+4cKh6mXkkXg3WnP8xZLSpGhQM5lbbWD
         YWIoD+gi29YRcC4ki/NGBRtHzPQbMjg1kpl3iKe37ymMEiXVuWs0rz4FuXYAI8fVgLJ6
         /KiuZ9qVXoWeq/SfJOjWYua1Pssf1xZNuY5gmdI9eFaAQAvXnYIaGby2sVXMwXbcGDio
         Aq6zQLzA/nNVkOtSRm6lLPLkVvxHEUDKlc6xfex0j+9ggHAn9AgM++dLrZAEoRplCBUI
         4/CA==
X-Gm-Message-State: AOAM5313F0tqYyP6SkwwUX02uWSXJDKH6HS4PsJq9ftBxkzxaAf/ls6E
        ONnNKeKddj04uEUy94G7OPY=
X-Google-Smtp-Source: ABdhPJxk/XyvL7WKQtCwfaruntT3KsHzZP+/PIMi0gxdtO8oWzzDTbjFpJKksuieb7w9MumbQvP9Jw==
X-Received: by 2002:a17:902:e54e:b029:e1:2817:f900 with SMTP id n14-20020a170902e54eb02900e12817f900mr2139481plf.15.1614245624464;
        Thu, 25 Feb 2021 01:33:44 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id e129sm5739463pfh.87.2021.02.25.01.33.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 01:33:44 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH] exfat: fix erroneous discard when clear cluster bit
Date:   Thu, 25 Feb 2021 18:33:33 +0900
Message-Id: <20210225093333.144829-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If mounted with discard option, exFAT issues discard command when clear
cluster bit to remove file. But the input parameter of cluster-to-sector
calculation is abnormally adds reserved cluster size which is 2, leading
to discard unrelated sectors included in target+2 cluster.

Fixes: 1e49a94cf707 ("exfat: add bitmap operations")
Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/balloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 761c79c3a4ba..41a1dfd9d98a 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -186,8 +186,7 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 		int ret_discard;
 
 		ret_discard = sb_issue_discard(sb,
-			exfat_cluster_to_sector(sbi, clu +
-						EXFAT_RESERVED_CLUSTERS),
+			exfat_cluster_to_sector(sbi, clu),
 			(1 << sbi->sect_per_clus_bits), GFP_NOFS, 0);
 
 		if (ret_discard == -EOPNOTSUPP) {
-- 
2.27.0.83.g0313f36

