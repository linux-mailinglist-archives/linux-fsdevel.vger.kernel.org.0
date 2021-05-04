Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5A3728EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhEDK2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:28:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:14053 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhEDK1z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:55 -0400
IronPort-SDR: gbY+O5WLdaF4fnY0JTB3FiKxgB3cYZjt0hK5VY6WtmBNNj0slaNC9m3tb+9j5LuHmN2R0GSqcA
 NUgmC1dWPMpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="185417066"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="185417066"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:00 -0700
IronPort-SDR: 2cOYoTWdNRu0BqEvVitCL1AyawKZNkhwAs5fzO9185Wi1skQfrjzlq2gOWoe4jfa4CHoLeJnQR
 Vb8e5z4M6TDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="621478726"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2021 03:26:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 58C3F2A7; Tue,  4 May 2021 13:27:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 00/14] lib/string_helpers: get rid of ugly *_escape_mem_ascii()
Date:   Tue,  4 May 2021 13:26:34 +0300
Message-Id: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
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

This is assumed to go either thru VFS or Andrew's tree. I don't expect
too many changes in string_helpers.

Changelog v2:
- introduced seq_escape_mem() instead of poking seq_get_buf() (Al)
- to keep balance of seq_get_buf() usage, convert seq_escape() to use above
- added missed ESCAPE_APPEND flag in NFSv4 patch
- moved indentation patch closer to the beginning of the series
- reshuffled series to be in two groups: generic library extension
  followed by seq_file updates

Andy Shevchenko (14):
  lib/string_helpers: Switch to use BIT() macro
  lib/string_helpers: Move ESCAPE_NP check inside 'else' branch in a
    loop
  lib/string_helpers: Drop indentation level in string_escape_mem()
  lib/string_helpers: Introduce ESCAPE_NA for escaping non-ASCII
  lib/string_helpers: Introduce ESCAPE_NAP to escape non-ASCII and
    non-printable
  lib/string_helpers: Allow to append additional characters to be
    escaped
  lib/test-string_helpers: Print flags in hexadecimal format
  lib/test-string_helpers: Get rid of trailing comma in terminators
  lib/test-string_helpers: Add test cases for new features
  MAINTAINERS: Add myself as designated reviewer for generic string
    library
  seq_file: Introduce seq_escape_mem()
  seq_file: Replace seq_escape() with inliner
  nfsd: Avoid non-flexible API in seq_quote_mem()
  seq_file: Drop unused *_escape_mem_ascii()

 MAINTAINERS                    |   8 ++
 fs/nfsd/nfs4state.c            |   2 +-
 fs/seq_file.c                  |  35 +++-----
 include/linux/seq_file.h       |  21 ++++-
 include/linux/string_helpers.h |  31 ++++---
 lib/string_helpers.c           | 102 ++++++++++++---------
 lib/test-string_helpers.c      | 157 +++++++++++++++++++++++++++++----
 7 files changed, 262 insertions(+), 94 deletions(-)

-- 
2.30.2

