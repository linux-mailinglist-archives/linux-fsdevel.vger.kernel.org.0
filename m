Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB42A5CB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 03:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgKDCau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 21:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgKDCau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:30:50 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113CC061A4D;
        Tue,  3 Nov 2020 18:30:50 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r10so15240409pgb.10;
        Tue, 03 Nov 2020 18:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=04L8R9f2Gx+AmkCjZy4qEyOdrMXDoh2NWWiRBE44Otc=;
        b=mJnN2UfYqY43eDrfQsbEZORdEow/OoODbX1+v6J5gNSu9F+4sB5ZmrZ8SSvXWlPqiv
         sN9difDihc4Whks/Prj/zwfZ9AzoOcViXSLL/757PMKauOTutMyAPgrqizaIQjmdUsq5
         0mtJvAbFjoOOLF+nRDXZxlVgLuMXngtHxxPs/zGRHueTwsPuI5tdZzBNPmQXfDXfuynf
         09fYvmMRCbXVzi/uWXUqGe7u2LBxkaio/1bHPHuJdqfYBX16PRZCjCGzM8X0E0ghrxIJ
         PG5/AZh6D7WDwy4I231AaygTy3Q8DljIUd7VDrOn/r9yf1iro4d7lz3/PLVmJxoJ/pYo
         T1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=04L8R9f2Gx+AmkCjZy4qEyOdrMXDoh2NWWiRBE44Otc=;
        b=mmHH3BCKYiQzRuTpNYyeUrRQTXUsTo3FBtNpj/bbVXgeXsny5hRxGaLnvf/I6Wb9lQ
         rgTzVbkV726aXngoAlXAnBO1jKIhInLlROj8Aa85r+NNJxVIyNJajJPg9cOuBk8guyh6
         iQsDLlAO1tKm28w+r3T7pEygESKxznhKQ0dkxEvNZz5N7JcyWMOs4qXlI7VocG5B0cU1
         dEZbh7ibnQyPO1c5Wj/av3TwfEJhc3PkPlVISLIfGnrV58Y9T90xKTVAsHeeLy81WDLg
         Ndmc41wk9fAie2Y8wa3ubnLRn6rT/BHen0T4krvk3QYUZbw0PROE0NRhwVbESTxfbL6j
         9IdA==
X-Gm-Message-State: AOAM533k/XhVrlHeWr27msXDtNkCyTG10D8Inl0dlG3sUjRYkFUdudtn
        0Xty/E6iqF0GEdDC3uJAjbA=
X-Google-Smtp-Source: ABdhPJxHLzphM1sp2oCBLcKx8rtkXtUAoybxScZnRXrGbyrhl4rFwCRO69HvQisX+eFlOV2XgOF21g==
X-Received: by 2002:a17:90a:ea93:: with SMTP id h19mr2209512pjz.107.1604457049852;
        Tue, 03 Nov 2020 18:30:49 -0800 (PST)
Received: from ZB-PF11LQ25.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id j19sm443238pfn.107.2020.11.03.18.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 18:30:49 -0800 (PST)
From:   "xiaofeng.yan" <xiaofeng.yan2012@gmail.com>
To:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        oulijun@huawei.com, yanxiaofeng7@jd.com, xiaofeng.yan2012@gmail.com
Subject: [PATCH 1/2] [xarry]:Fixed an issue with memory allocated using the GFP_KERNEL flag in spinlocks
Date:   Wed,  4 Nov 2020 10:32:12 +0800
Message-Id: <20201104023213.760-1-xiaofeng.yan2012@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "xiaofeng.yan" <yanxiaofeng7@jd.com>

function xa_store_irq() has a spinlock as follows:
 xa_lock_irq()
   -->spin_lock_irq(&(xa)->xa_lock)
GFP_KERNEL flag could cause sleep.
So change GFP_KERNEL to  GFP_ATOMIC and Romve "gfp_t gfp" in function
static inline void *xa_store_irq(struct xarray *xa, unsigned long index,
                void *entry, gfp_t gfp)

Signed-off-by: xiaofeng.yan <yanxiaofeng7@jd.com>
---
 include/linux/xarray.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 92c0160b3352..aeaf97d5642f 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -595,7 +595,6 @@ static inline void *xa_store_bh(struct xarray *xa, unsigned long index,
  * @xa: XArray.
  * @index: Index into array.
  * @entry: New entry.
- * @gfp: Memory allocation flags.
  *
  * This function is like calling xa_store() except it disables interrupts
  * while holding the array lock.
@@ -605,12 +604,12 @@ static inline void *xa_store_bh(struct xarray *xa, unsigned long index,
  * Return: The old entry at this index or xa_err() if an error happened.
  */
 static inline void *xa_store_irq(struct xarray *xa, unsigned long index,
-		void *entry, gfp_t gfp)
+		void *entry)
 {
 	void *curr;
 
 	xa_lock_irq(xa);
-	curr = __xa_store(xa, index, entry, gfp);
+	curr = __xa_store(xa, index, entry, GFP_ATOMIC);
 	xa_unlock_irq(xa);
 
 	return curr;
-- 
2.17.1

