Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06D4793669
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 09:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjIFHjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjIFHjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:39:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FEACC;
        Wed,  6 Sep 2023 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985960; x=1725521960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9DWfOXctPMjyadaaUcywDcWCHVuND2DRm2KBk4DeAY8=;
  b=SYpAbwH6H1O0voyJXpKmnycv4wDM2s2Hao5sIA/KfF67AvgxszyYkZOH
   /G+5YLhBGq2T8GK5LjKyv1IJFTG/P7bL1LCEj/RRQD4J1Rzd9bwsiPbc7
   4KJ7RszGFxBC3m1lEcuva/sw6X5FHeF4oWvzEm2jxnUcpMWUt9aa+bkVZ
   A6aD0QeNOy3N9nRhKMUgsOYkRvmciq/wokWOPArj348EIbtwUfRtRPX/b
   ff8DuybYVokZHe/hzUtlF/HKb+rXAZHijIDsj5nOBKO4r2xmCZdq3TLV1
   iFrFNTxBFKg5S3/rYaW38noAEhuJd7ISA6VhJJbk/GEFjo169OKp7G4SA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375898434"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375898434"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988133778"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988133778"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:16 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
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
Subject: [PATCH 0/3] Do not map unaccepted memory
Date:   Wed,  6 Sep 2023 10:38:59 +0300
Message-Id: <20230906073902.4229-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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


Adrian Hunter (3):
      proc/vmcore: Do not map unaccepted memory
      proc/kcore: Do not map unaccepted memory
      /dev/mem: Do not map unaccepted memory

 drivers/char/mem.c |  9 +++++++--
 fs/proc/kcore.c    | 10 +++++++++-
 fs/proc/vmcore.c   | 15 ++++++++++++---
 3 files changed, 28 insertions(+), 6 deletions(-)


Regards
Adrian
