Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB727F2F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgI3UEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 16:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3UEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:04:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3AC061755;
        Wed, 30 Sep 2020 13:04:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so1942542pfn.8;
        Wed, 30 Sep 2020 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fRxlphcyV5L+6kzJRgkcYTmAPfhDSCJRy7uL810DHvg=;
        b=JJJ4LUE2HM8QngeFWwn/lYALkew4LFitz+FSL4qyj48kRgIApIpUgB3erfhMXSwVVY
         HVnISKtaZyCK3FdsnQcIYfMaZK4uFrd4+ojb2RH0H93PfK45mkv1ZJpSsojbFiwz7oZL
         EHch64HQhcJaON1RqgVUGVCd5NDMZOQn+lmD67p1/TZPzjfL3vA5GmvHqdXpIkENo/L2
         2+KBTBHAqDKgCcb1atmtJwtic4ZAHe0CeysGLBTauTj2B19TkG52P9L+uvQ5BI4jtk0R
         xn1W/SV6P4CxFvtmGglN09Wf4FvhPKPNIamltClC7IyS9RMZxZEoikJGo8VsG/ss6NvK
         SLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fRxlphcyV5L+6kzJRgkcYTmAPfhDSCJRy7uL810DHvg=;
        b=GiRcK1zDS37p4PeExfpxOrKKrfE2u4MXa3QZUp6eCeVBuBjhZdw6ezt+nkGf2zRVNZ
         Q5UePbuMpXAnjd7OR4eT01VvAj5L0SBgIeju7AoJZwj0hoMrtkV8Kz8z6B8Ae/NMrxtT
         pk0CkLhFQltg/lBogXDNad6Vr0yckaDX8/uADJdoxThfJ6QVzNuED59Y6dwpQkmSNp6b
         xMfW4ASYb05Me7SXrQKnXIBpEa4o8RGp4cH/NbX7uGgGZWP9HzL0oe/5uWfXpISP6YJL
         boyd9e4/DEdodt6QE4SVYtdlAlMLKmIwJ8QOzmW84EQLll9+xalVXo/LbNr3l6pGgwxD
         +OTA==
X-Gm-Message-State: AOAM533R0MMfg6PZt6eym0sUw0z5GtVu37gAnITufynF9w5dIc5vhUcq
        +01wnLhX+1C1W9shFAqKkRw=
X-Google-Smtp-Source: ABdhPJzNEfUPI/vsckvfZ/3Qh6VsaBOY5er1Qfs/1HH6uA0+ftRR4Ae3Fcc9D6fUiwTjF5I3P/fUEg==
X-Received: by 2002:aa7:8812:0:b029:13c:1611:6537 with SMTP id c18-20020aa788120000b029013c16116537mr4350626pfo.9.1601496277332;
        Wed, 30 Sep 2020 13:04:37 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id v21sm2992881pgl.39.2020.09.30.13.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:04:36 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        fllinden@amazon.com
Cc:     shy828301@gmail.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: nfs: return per memcg count for xattr shrinkers
Date:   Sun, 27 Sep 2020 04:42:20 -0700
Message-Id: <20200927114220.141530-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The list_lru_count() returns the pre node count, but the new xattr
shrinkers are memcg aware, so the shrinkers should return per memcg
count by calling list_lru_shrink_count() instead.  Otherwise over-shrink
might be experienced.  The problem was spotted by visual code
inspection.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: Frank van der Linden <fllinden@amazon.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 fs/nfs/nfs42xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 86777996cfec..6e5f34916937 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -882,7 +882,7 @@ nfs4_xattr_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	unsigned long count;
 
-	count = list_lru_count(&nfs4_xattr_cache_lru);
+	count = list_lru_shrink_count(&nfs4_xattr_cache_lru, sc);
 	return vfs_pressure_ratio(count);
 }
 
@@ -976,7 +976,7 @@ nfs4_xattr_entry_count(struct shrinker *shrink, struct shrink_control *sc)
 	lru = (shrink == &nfs4_xattr_large_entry_shrinker) ?
 	    &nfs4_xattr_large_entry_lru : &nfs4_xattr_entry_lru;
 
-	count = list_lru_count(lru);
+	count = list_lru_shrink_count(lru, sc);
 	return vfs_pressure_ratio(count);
 }
 
-- 
2.26.2

