Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8435FF753
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJNX6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJNX6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:58:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD4BE2F6
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791901; x=1697327901;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1aq+/q+FuOiZcIjOjX1lseJ32olR7LP6wPKxMz7epE=;
  b=WUuca+n4lMWeTc33xoNsYRrswvGkanVlUZukT2YbO778D+0rXe0Shk81
   u410fbHTDxg+MAfxnveyX1smmVgtLf1jwZbgwKxjbXvPEFaXskxb6anUu
   5LDEG9Jd/iuGiIK9Lcr3WGogpPoCPPyfsSsQ2lFGnLyGe/m7yih1EZ8zh
   19i7nWL906tQP5T0eS/rv+gpthaaXNbgLFfnXAo7TlNkyWOO85LwycTyZ
   f0Ow4g2RvA3ZLAV9o07McjeuKPPxJ1TofWYZoH9F24lRa8MDWXXDlIY9N
   B9vqt7ZHBWUI4bCZrSMSF+2JV1sLqF1U97db0bmTdN/00gX/cS3cYr22l
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="285887847"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="285887847"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113492"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113492"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:20 -0700
Subject: [PATCH v3 14/25] devdax: Fix sparse lock imbalance warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     kernel test robot <lkp@intel.com>, david@fromorbit.com, hch@lst.de,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:58:20 -0700
Message-ID: <166579190012.2236710.846739337067413538.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Annotate dax_read_{lock,unlock} with their locking expectations to fix
this sparse report:

drivers/dax/super.c:45:5: sparse: warning: context imbalance in 'dax_read_lock' - wrong count at exit
drivers/dax/super.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, include/linux/pagemap.h):
./include/linux/srcu.h:189:9: sparse: warning: context imbalance in 'dax_read_unlock' - unexpected unlock

Reported-by: kernel test robot <lkp@intel.com>
Link: http://lore.kernel.org/r/202210091141.cHaQEuCs-lkp@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/super.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 4909ad945a49..41342e47662d 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -42,13 +42,13 @@ static DEFINE_IDA(dax_minor_ida);
 static struct kmem_cache *dax_cache __read_mostly;
 static struct super_block *dax_superblock __read_mostly;
 
-int dax_read_lock(void)
+int dax_read_lock(void) __acquires(&dax_srcu)
 {
 	return srcu_read_lock(&dax_srcu);
 }
 EXPORT_SYMBOL_GPL(dax_read_lock);
 
-void dax_read_unlock(int id)
+void dax_read_unlock(int id) __releases(&dax_srcu)
 {
 	srcu_read_unlock(&dax_srcu, id);
 }

