Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A394E2D0F74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgLGLhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgLGLf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:29 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6BC094241;
        Mon,  7 Dec 2020 03:35:05 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id i3so6030219pfd.6;
        Mon, 07 Dec 2020 03:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DlQnH7arXkpV3AxvylV8KPwG+QOIFG2k6zceWF8EMek=;
        b=slULaRgClfSRtlq6MZQolWl14N3WoKzCDl91aATl6tX8HOfVXd7kfIwWn5h47oBm3h
         xiPGbI6vPy35U0R/c4QR8TcprKIJDFu9YT12UcQuplY38vOUzuIMOUmOng8ftygUWfTr
         R1ZAIx1wp1N0xM3YOBmolFbpCccHmRq/UeETV4HjisGBwUXZHQZrrafX6WsVEOPwXQu9
         0N2lNLtp3gJavRT6Vww4WvELq4NKpp8UbezAjxjLamlZR2rUohbuyED91YZZx9c5W52C
         8RHuWAx0H4siG5FrBXMPIyV8dIchxJEE581mAM4LCKH+oYKBsM2HDcxznhasrQeZ1BcL
         O2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DlQnH7arXkpV3AxvylV8KPwG+QOIFG2k6zceWF8EMek=;
        b=PXIYBKFFvVghRkPHNXzdVcE9ivR57Ta2J1FYEX673hG7DjbHXODYzKrodgoir2Pyty
         4irQtt/ec8GYFVRAfA08c8415BrTei3Qd5dNqoRJfB77SvG8MnYY7x+UVnPBNGxMsiQI
         AFUvPgGRG9BHHt/bcrJ14iqBdajVZFKcUgj+fXrI+1EkTbyZR1BlWCTdjm111OUirCj5
         5t0R66dN0baYMVypnKXL2phGfXckO/drnHcUNTHiSVG/Xq6YHvyUKG+LqgD4FmNlLr0w
         X/MkoA3Op2ncZ3ZQMyIgX8HEkUzHz/7tN4E7AZhtlhVyhgVNLvigKDg7wr1GX4WNGpdk
         3CaQ==
X-Gm-Message-State: AOAM532WOuQg82k2N7Gl28h3Kija0jMiGlVBNkzO/78RTefUxsqaZ8yi
        QFjXRPdSpCy8iAcu9MSr5tTkxzb0DG8=
X-Google-Smtp-Source: ABdhPJzalODO+5vSfJ8urE4UuOEPrIa+ijmCZKRr1s/BpX28tmoQbHCWWrOgmsnDQaiZ1nRUpwNqDg==
X-Received: by 2002:a17:902:bc4b:b029:db:2d61:5f37 with SMTP id t11-20020a170902bc4bb02900db2d615f37mr99717plz.79.1607340905372;
        Mon, 07 Dec 2020 03:35:05 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:04 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 25/37] mm, x86, dmem: fix estimation of reserved page for vaddr_get_pfn()
Date:   Mon,  7 Dec 2020 19:31:18 +0800
Message-Id: <3bd3e2d485c46fae9eaeb501e1a6c51d19570b49.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Fix estimation of reserved page for vaddr_get_pfn() and
check 'ret' before checking writable permission

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 67e8276..c465d1a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -471,6 +471,10 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 		if (ret == -EAGAIN)
 			goto retry;
 
+		if (!ret && (prot & IOMMU_WRITE) &&
+		    !(vma->vm_flags & VM_WRITE))
+			ret = -EFAULT;
+
 		if (!ret && !is_invalid_reserved_pfn(*pfn))
 			ret = -EFAULT;
 	}
-- 
1.8.3.1

