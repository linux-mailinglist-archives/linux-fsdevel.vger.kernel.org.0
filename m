Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553EA742203
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjF2IV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjF2IUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:20:53 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 01:19:15 PDT
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666935BC
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 01:19:14 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="122675962"
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="122675962"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 17:18:10 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 72FA4DB4C2;
        Thu, 29 Jun 2023 17:18:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B97E8D9692;
        Thu, 29 Jun 2023 17:18:05 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E94226C9C4;
        Thu, 29 Jun 2023 17:17:59 +0900 (JST)
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Cc:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, djwong@kernel.org, mcgrof@kernel.org
Subject: [PATCH v12 0/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Thu, 29 Jun 2023 16:16:49 +0800
Message-Id: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27720.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27720.005
X-TMASE-Result: 10--9.126200-10.000000
X-TMASE-MatchedRID: hVaMx/vKxVQoSt6MGxonhwrcxrzwsv5usnK72MaPSqdujEcOZiInj57V
        Ny7+UW/9bDnaZmit5bheZNY97UagkJpOjqlsrZgYKsurITpSv+MQhNjZQYyI3Jsoi2XrUn/Js98
        n9dYnJNNQSFbL1bvQASAHAopEd76vRWXiIgS5n2V4xdTY+QAKe3yk+v4CROBMf8DjiQCwSeDQ86
        vbNAcB2g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is to add gracefully unbind support for pmem.
Patch1 corrects the calculation of length and end of a given range.
Patch2 introduces a new flag call MF_MEM_REMOVE, to let dax holder know
it is a remove event.  With the help of notify_failure mechanism, we are
able to shutdown the filesystem on the pmem gracefully.

Changes since v11:
 Patch1:
  1. correct the count calculation in xfs_failure_pgcnt().
      (was a wrong fix in v11)
 Patch2:
  1. use new exclusive freeze_super/thaw_super API, to make sure the unbind
      progress won't be disturbed by any other freezer.

Shiyang Ruan (2):
  xfs: fix the calculation for "end" and "length"
  mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind

 drivers/dax/super.c         |  3 +-
 fs/xfs/xfs_notify_failure.c | 95 +++++++++++++++++++++++++++++++++----
 include/linux/mm.h          |  1 +
 mm/memory-failure.c         | 17 +++++--
 4 files changed, 101 insertions(+), 15 deletions(-)

-- 
2.40.1

