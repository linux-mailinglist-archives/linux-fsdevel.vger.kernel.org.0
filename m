Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74A28C6CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 03:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgJMBeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 21:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgJMBeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:34:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2795C0613D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so19909115wmj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaxIr5597WF0kxpEElTZVLTN61vAhnpO/2r1W4YxrO0=;
        b=J2rOTWZ8Lr5Wf2QMpwxeIwTk31F0CcPsxAE+ecneTuceI94efNcmEIgFo7sgQ5lmkn
         zLqcJTHbLpzPMw8OtVmyeRDaSk7WV69pJ35WU8S/Ni5BQSLXCGOMFKIr7yCZ95uiklXu
         AhGmVvlhf//oWpBLnP9Pbi9S9Pwm1hZ5YPKuv0zyUoCV3Fn+Aha/78ZfCxKT06boM6hV
         CEQgE4qDGlvBcUzSZvJQRXYHTypYqNFf9/hCzW4zFumXGHjPHoQ4nsxJGEqUsifC9zB+
         ggvSzmzm+sUfR8KHUE7y6WLZ12vUAGmWR+1sz/qeHvP3y5XGFPLwNBoyR9cfLfWhG3fx
         qTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaxIr5597WF0kxpEElTZVLTN61vAhnpO/2r1W4YxrO0=;
        b=KHtkoywqTUKxB/Sm4uyPcwBAlxgE3SnglzHixc03eTfyb10TOYb9ndC2u72TdT2hBY
         rg1Ig2nHJRmbS+kBKkm3kGGQWEpr2wKm1UejQ/6DkVaVQAPtCVPEFpsl6VS7BwQ1PNR5
         a6oQhUlfX0ARL5Gqocw7IcZ80h6+ntcyjyDqeaJORsylLgBNl7+80TmxyKVgy4u3hz4L
         lmSUH0aX+afdnNdaiDXVZ+Us+mcKmsA6Gf4b+oQVAB5mIe56J7PeZ5dKaD6zOY1ioWaN
         J/IdXhFJtbQUv6FwgH8691GuODcoADrvEaGXtGjIMhjnhWMNeIJx9ygnmjWOx098c480
         3kMg==
X-Gm-Message-State: AOAM531zrwy8mm1zyBrsFAoA9q240V0v6Dh/muqrvZMX4tacc0Eg6AM4
        9xgubjXpqPykBQ/2vMHRLbFKgA==
X-Google-Smtp-Source: ABdhPJwGpJy4DdZ/eC/fCwJjqmeUbVJXNMLzWnkwR0hTzvknEAdfYsGaIbJtZWKk1I+xy8WZjoA44w==
X-Received: by 2002:a1c:48d4:: with SMTP id v203mr10067253wma.122.1602552860468;
        Mon, 12 Oct 2020 18:34:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d23sm24825325wmb.6.2020.10.12.18.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 18:34:19 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/6] mm/mremap: Account memory on do_munmap() failure
Date:   Tue, 13 Oct 2020 02:34:11 +0100
Message-Id: <20201013013416.390574-2-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013013416.390574-1-dima@arista.com>
References: <20201013013416.390574-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move_vma() copies VMA without adding it to account, then unmaps old part
of VMA. On failure it unmaps the new VMA. With hacks accounting in
munmap is disabled as it's a copy of existing VMA.

Account the memory on munmap() failure which was previously copied into
a new VMA.

Fixes: commit e2ea83742133 ("[PATCH] mremap: move_vma fixes and cleanup")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 mm/mremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..03d31a0d4c67 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -450,7 +450,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
-		vm_unacct_memory(excess >> PAGE_SHIFT);
+		if (vm_flags & VM_ACCOUNT)
+			vm_acct_memory(new_len >> PAGE_SHIFT);
 		excess = 0;
 	}
 
-- 
2.28.0

