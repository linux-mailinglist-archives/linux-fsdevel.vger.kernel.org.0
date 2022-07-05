Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98816567AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 01:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiGEXWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 19:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiGEXWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:22:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B2193F0;
        Tue,  5 Jul 2022 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657063333; x=1688599333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X3Cp7WNefgqvD2vUfXjmNNUWqDvy/vYXCkMcRrUovEI=;
  b=cbERZAIOydj2QyO9FewOIsbniiOmpqU61VHMCq++eWRyQE8+2uj0rwCO
   26o1FVj7PKEmY598gBu+tJ7WTG/nK3YvxbZQwaAevRdEK0pSQeRajD0KX
   KVHFQePjmWJ72b0PbpWx9ebMiGDEP1aJFp+F0wX7RZqFKLqD8JpV4evpo
   4kWD3hJj3dnBGtfBXhoZ6lYelTohSjVYSAxnqsA49wwI33xOFRWQZdoFd
   rNSFh3nSSvfvZFE2Y8v8yvDZoYQtu6VmzbFxyhKu1osmN8IORvGpvG2b1
   eRiCGIOdDqxY/KM0SsOOw4A09oJhje8UX/e4K1m44ZZohnTNhz02XIVI4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282320888"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="282320888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:22:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620052149"
Received: from adiazinf-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.103])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:22:05 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/3] Introduce devm_xa_init
Date:   Tue,  5 Jul 2022 16:21:56 -0700
Message-Id: <20220705232159.2218958-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

This is submitted RFC for 2 reasons.  First I'm not quite sure where to place
the call in the headers.  Second the use of the new call is dependent on some
CXL code which was just been submitted.[0]  I want to get opinions on if this new
call seems useful or just more confusing to the XArray interface.  If useful
I'll respin after the CXL stuff lands and perhaps it can go through Dan's tree.

While converting some CXL code to XArray a pattern emerged which seemed useful
to codify.

In two different situations[1][2] an XArray was initialized in such a way that
using devm_add_action() could be used to call xa_destroy() automatically.

In the first situation[1] the XArray was storing long values directly and in
the other situation the pointers were allocated using device managed functions
(devm_*).

In these situations it seems that a device managed xa_init() would be useful.

[0] https://lore.kernel.org/linux-cxl/20220705154932.2141021-1-ira.weiny@intel.com/
[1] https://lore.kernel.org/linux-cxl/20220705154932.2141021-4-ira.weiny@intel.com/
[2] https://lore.kernel.org/linux-cxl/20220705154932.2141021-5-ira.weiny@intel.com/



Ira Weiny (3):
  xarray: Introduce devm_xa_init()
  pci/doe: Use devm_xa_init()
  CXL/doe: Use devm_xa_init()

 drivers/base/core.c    | 20 ++++++++++++++++++++
 drivers/cxl/pci.c      |  8 +-------
 drivers/pci/doe.c      | 14 ++------------
 include/linux/device.h |  3 +++
 4 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.35.3

