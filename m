Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39CE287020
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgJHHzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgJHHzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A1C0613DA;
        Thu,  8 Oct 2020 00:55:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so3307863pfa.10;
        Thu, 08 Oct 2020 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DUrjITBbWyKSwaW9zQIzPOaWe1Yh8vSIfndNH38vsy8=;
        b=T1ETnzwey8YPOxGtwjIvQMYqUFJ6Yi/NeAmqkHW6jB3lhrgcCG4Ue66deFuERkIuY7
         uLRPF/PH/dxB+CW2GtBntMfdirk1/9pVZ3c5mbSRFS5rAS1OibLGFlxp6MzSGKUSSIxi
         HSZQlklFFfs6WYtYwx9ymKKaUEoiHE8qREXnZjP/raMIRdJqQCHQsXLsx2A9lTtJdoAt
         ASXT0kVDxP4bOL9EDNMcVv+7o8kwfgxJnwIfQOVEr7FXVkiML8VRGXCV5KAXNIbp7loI
         vJMykbF6OQ2wixFtMfiqnn5RWiSWcZyShzjh5RAFJ+fbv58G1WAMgnwmTpTX0jrV1i3l
         GYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DUrjITBbWyKSwaW9zQIzPOaWe1Yh8vSIfndNH38vsy8=;
        b=XraYdynveT4ha/z9+D4/5imqZJd2t/hxGtWd1pDKEGn5o6uRq4RjKJ94bbw0TkuYbq
         ZiEpz3jEDxn9K+Ettvzeyea+7i49AEOHXGt6Zj+/4e6sQK7PlqkiGzFh0f6c2Or7Osgk
         nCD6AztTTDpd59/zo48Sp+1Fvpq8ygFRjPOarlIRVf2XoMEqPQKsxmriF8igsflVjiGC
         oziQ7tPf25ycf6mlMt3dh3M8rC4ZgdRX1KNHIKLNa79auAUrtMIB1mxScmLzZ+zDB+8X
         OLuiXiXh9khucIjuZVCr2Ylg6uzJQnU1Lv/apPwYTfq1Ld0lmKsrRWBU09c7qUJnhb5e
         AeLA==
X-Gm-Message-State: AOAM532ZILlWlhWVBhlwXaZAWxDE0J+qz3IneyGCZ5VH6kdCzr8UCO5e
        xeSxjWlizbs0H2xD5ifLNfmE+HMmFheI3A==
X-Google-Smtp-Source: ABdhPJxn+zqF9duV6xKr3ksLqmnqartE3btzay1Xcm4zi3toaWYS9MK2OGf/BZtI53as57lPEh8HUQ==
X-Received: by 2002:a17:90a:9f8e:: with SMTP id o14mr6872630pjp.103.1602143710505;
        Thu, 08 Oct 2020 00:55:10 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:10 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 19/35] mm: gup_huge_pmd() for dmem huge pmd
Date:   Thu,  8 Oct 2020 15:54:09 +0800
Message-Id: <184340f563959728d5e4e3d23463f54b797040b6.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Add pmd_special() check in gup_huge_pmd() to support dmem huge pmd.
GUP will return zero if enconter dmem page, and we could handle it
outside GUP routine.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/gup.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 726ffc5b0ea9..a8edbb6a2b2f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2440,6 +2440,10 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
+	/* Bypass dmem huge pmd. It will be handled in outside routine. */
+	if (pmd_special(orig))
+		return 0;
+
 	if (pmd_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
@@ -2542,7 +2546,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 			return 0;
 
 		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
-			     pmd_devmap(pmd))) {
+			     pmd_devmap(pmd) || pmd_special(pmd))) {
 			/*
 			 * NUMA hinting faults need to be handled in the GUP
 			 * slowpath for accounting purposes and so that they
-- 
2.28.0

