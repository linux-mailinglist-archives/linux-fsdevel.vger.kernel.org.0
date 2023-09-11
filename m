Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85A879AD5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjIKUxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjIKLVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:21:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8FCDD;
        Mon, 11 Sep 2023 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431293; x=1725967293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+I5yoxhnq9XTmgsh71v3IPq8MLK5vdTB+aRt5bb4Pkw=;
  b=QqY0VN/S6CTEv6tVzjUPZulxbUU3fG5uGri+OPzmCq00G7I2t8JOC81R
   HFja1Cv6FauQO0osZdnmOx1UHdkvM59HuHAmxBM0j7N09aCbdyR4wcIMV
   I9Pf78D9/sdWEdWkqVPtQCKiTSo6ApN++QTxtaYuc1u8LTu9rFBtTPkhb
   4wkz4ePZx2EMpjVIWdTLmZjRai7YEOFmvztnqlQ4rT1G6EHTvkLPa1TiQ
   smIp08T63btG2b8/866lOmLzFhTHYM2kszuJiqoLbbhR270oG4ySXV7BD
   3EOB2ZXskyNs4KldOwtEgsFxGVZ/5v2gMC5c98QkbJPtppDGqHF1hYPpZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358358396"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358358396"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778356390"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778356390"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.216.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH V2 0/2] Do not try to access unaccepted memory
Date:   Mon, 11 Sep 2023 14:21:12 +0300
Message-Id: <20230911112114.91323-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

Support for unaccepted memory was added recently, refer commit
dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
a virtual machine may need to accept memory before it can be used.

Plug a few gaps where RAM is exposed without checking if it is
unaccepted memory.


Changes in V2:

      efi/unaccepted: Do not let /proc/vmcore try to access unaccepted memory
          Change patch subject and commit message
          Use vmcore_cb->.pfn_is_ram() instead of changing vmcore.c

      proc/kcore: Do not try to access unaccepted memory
          Change patch subject and commit message
          Do not open code pfn_is_unaccepted_memory()

      /dev/mem: Do not map unaccepted memory
          Patch dropped because it is not required


Adrian Hunter (2):
      efi/unaccepted: Do not let /proc/vmcore try to access unaccepted memory
      proc/kcore: Do not try to access unaccepted memory

 drivers/firmware/efi/unaccepted_memory.c | 20 ++++++++++++++++++++
 fs/proc/kcore.c                          |  3 ++-
 include/linux/mm.h                       |  7 +++++++
 3 files changed, 29 insertions(+), 1 deletion(-)


Regards
Adrian
