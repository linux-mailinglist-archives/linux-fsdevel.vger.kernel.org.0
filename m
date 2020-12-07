Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E592D1DDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 23:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgLGW5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 17:57:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:54197 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgLGW5t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:57:49 -0500
IronPort-SDR: 7zKLOhtyxhEYBUi48Qi1kkQvaizdQ+yFxqtrVFibpjueHWK2wEpgQBfUl1Yu3Sy3rjyE7ld1tp
 7zazYKAIAFbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="161561964"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="161561964"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:57:08 -0800
IronPort-SDR: zrK7N13f0547j6HUqKFTrPIBK5St3oJ2fDzMKbb6+BPw0XKG8JNCxz/onBIap5+rFNlbzyL0gG
 Rc4ZzAHEnpoQ==
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="407363009"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:57:06 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 0/2] Lift memcpy_[to|from]_page to core
Date:   Mon,  7 Dec 2020 14:57:01 -0800
Message-Id: <20201207225703.2033611-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

These are based on tip/core/mm.  As I was looking at converting the calls to
kmap_local_page() I realized that there were a number of calls in highmem.h
which should also be converted.

So I've added a second prelim patch to convert those.

This is a V2 to get into 5.11 so that we can start to convert all the various
subsystems in 5.12.[1]

I'm sending to Andrew and Thomas but I'm expecting these to go through
tip/core/mm via Thomas if that is ok with Andrew.

[1] https://lore.kernel.org/lkml/20201204160504.GH1563847@iweiny-DESK2.sc.intel.com/

Ira Weiny (2):
  mm/highmem: Remove deprecated kmap_atomic
  mm/highmem: Lift memcpy_[to|from]_page to core

 include/linux/highmem.h | 28 +++++++++++++-------------
 include/linux/pagemap.h | 44 +++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c          | 26 +++---------------------
 3 files changed, 61 insertions(+), 37 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

