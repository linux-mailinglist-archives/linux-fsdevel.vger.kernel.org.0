Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369842D0F63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgLGLgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgLGLgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:36:22 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F203C0613D4;
        Mon,  7 Dec 2020 03:35:42 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f17so8656765pge.6;
        Mon, 07 Dec 2020 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=01Z5fklCLxTkAgFCaz6nAUEBM28bmnYK87yE7XDoghk=;
        b=Ow37ASksRvhh9CbdtCHIUcexMF92+y/fcxUo4cp1Hcu1OVAkm4VgeqQuRQn3wk6HYw
         HBIvMgI3NhxdwdBCKwt5Iq4O8LCN4Ax1wiG4DsCvRan0q4fRQKL8bzXsSjED1ZZnfPtW
         i2fYicNCYucP2yFhvKqZO390HegOf8okFuF473TH47NWnU5wevHxKx8xWUmYQMv1OtGt
         0lIXeFTqGZWaY2z+qKMSdfJnMGbGjjHGIm7bp+KVSSw1iX8dSHyykquckNwiMQ3vazJb
         w8osDFx9fg+nq686wIqW3v7PfEnSUS4MCwgVJ3Vx8c8qTcTONTPefKk36TylgEAY+cPI
         pfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01Z5fklCLxTkAgFCaz6nAUEBM28bmnYK87yE7XDoghk=;
        b=PR0MrBiA9//P1Ma7RKw7i/yhY1UhpcAh980wx1c3fqfEF5wF0Xjdlgzmnvm+W3aWwR
         f2KSBT+r0OuyDsYCKs18bjudL6dqBgs88wVbf4AisVEgtvr3zPLqIASAwQoADNqcPV+d
         RXktpWd8Ww6jlCNmaIIdiNDrXXydbWalOQ13JxgFEt7KpTpoM9mnt2ktkVp3gBxhplbk
         kQ8LGcgo7/ebm/CDLykjb825w8tKL695Cz1zzVYzRBX2z6+3UM7vnnH9cBfK8cMFhlia
         RUJrBnkS2AUgQOIcqGGO27voFpPivp20rz6mWJXhL4HCNW9vGS5pRA2/F5FLgvsRPq9S
         Hulw==
X-Gm-Message-State: AOAM5322XJ3Lvmry8oFXCykZNgd1cpJ2fCGY/YU0BX1rGZt0UTeHEk+X
        6H5k8XGOGbqupDhdPo4au3Q=
X-Google-Smtp-Source: ABdhPJyc0QahNAcq2tXM9yV1P4tXgagCj+zgpJi+Q0nk6M3KkIQ/sHcL91OhO1SYZDhkmBDra3QOpQ==
X-Received: by 2002:a63:a551:: with SMTP id r17mr3001298pgu.13.1607340942035;
        Mon, 07 Dec 2020 03:35:42 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:41 -0800 (PST)
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
Subject: [RFC V2 36/37] vfio: support dmempage refcount for vfio
Date:   Mon,  7 Dec 2020 19:31:29 +0800
Message-Id: <0e5dd1479a55d8af7adfe44390f8e45186295dce.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Add get/put_dmem_pfn(), each time when vfio module reference/release
dmempages.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 drivers/vfio/vfio_iommu_type1.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c465d1a..4856a89 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -39,6 +39,7 @@
 #include <linux/notifier.h>
 #include <linux/dma-iommu.h>
 #include <linux/irqdomain.h>
+#include <linux/dmem.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -411,7 +412,10 @@ static int put_pfn(unsigned long pfn, int prot)
 
 		unpin_user_pages_dirty_lock(&page, 1, prot & IOMMU_WRITE);
 		return 1;
-	}
+	} else if (is_dmem_pfn(pfn))
+		put_dmem_pfn(pfn);
+
+	/* Dmem page is not counted against user. */
 	return 0;
 }
 
@@ -477,6 +481,9 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 		if (!ret && !is_invalid_reserved_pfn(*pfn))
 			ret = -EFAULT;
+
+		if (!ret && is_dmem_pfn(*pfn))
+			get_dmem_pfn(*pfn);
 	}
 done:
 	mmap_read_unlock(mm);
-- 
1.8.3.1

