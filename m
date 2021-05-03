Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7484D3721E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhECUtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:49:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:53596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhECUtt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:49:49 -0400
IronPort-SDR: YcVajbMePFOVsBM3LbJOX44iaEGchYCjcD+gu3pI3krHu5RCYxHG9/EfmbicnA38fnjoj5xYmz
 VE/tUU36AJSg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197888950"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="197888950"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:48:54 -0700
IronPort-SDR: tnjWwfmLZU67Se0Tsk1xCFkgIUHlD9fFCrc1V2r3gWWcsYz/AFZwcSuyTvXVq7fg62CpkRNpjA
 I7xb/lFDL9FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="388536668"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2021 13:48:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1295AD9; Mon,  3 May 2021 23:49:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 00/12] lib/string_helpers: get rid of ugly *_escape_mem_ascii() API
Date:   Mon,  3 May 2021 23:48:55 +0300
Message-Id: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get rid of ugly *_escape_mem_ascii() API since it's not flexible and
has the only single user. Provide better approach based on usage of the
string_escape_mem() with appropriate flags.

Test cases has been expanded accordingly to cover new functionality.

Andy Shevchenko (12):
  lib/string_helpers: Switch to use BIT() macro
  lib/string_helpers: Move ESCAPE_NP check inside 'else' branch in a
    loop
  lib/string_helpers: Introduce ESCAPE_NA for escaping non-ASCII
  lib/string_helpers: Introduce ESCAPE_NAP to escape non-ASCII and
    non-printable
  lib/string_helpers: Drop indentation level in string_escape_mem()
  lib/string_helpers: Allow to append additional characters to be
    escaped
  lib/test-string_helpers: Print flags in hexadecimal format
  lib/test-string_helpers: Get rid of trailing comma in terminators
  lib/test-string_helpers: Add test cases for new features
  nfsd: Avoid non-flexible API in seq_quote_mem()
  lib/string_helpers: Drop unused *_escape_mem_ascii()
  MAINTAINERS: Add myself as designated reviewer for generic string
    library

 MAINTAINERS                    |   8 ++
 fs/nfsd/nfs4state.c            |   8 +-
 fs/seq_file.c                  |  11 ---
 include/linux/seq_file.h       |   1 -
 include/linux/string_helpers.h |  31 ++++---
 lib/string_helpers.c           | 102 ++++++++++++---------
 lib/test-string_helpers.c      | 157 +++++++++++++++++++++++++++++----
 7 files changed, 235 insertions(+), 83 deletions(-)

-- 
2.30.2

