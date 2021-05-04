Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADD8372F67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEDSJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:09:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:33853 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhEDSJE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:04 -0400
IronPort-SDR: EtqPIFhkmxZpVOklW3qUZwqjaVZiiDYeo14YQZueU69EXiiTcSIH17MKZNZ5zrt6zu6mzaRtA0
 GbEN18llBAdA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178258326"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178258326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:07 -0700
IronPort-SDR: ZOs4ravY0piKUp1Ka0hKuPCSa0FsG4d+sIwdq8iHZsIv7Ywcdvic0fX9hSZV2YKNaTG3fhnDCx
 LGiOBLNNpqoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="390052739"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2021 11:08:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8CDC714B; Tue,  4 May 2021 21:08:23 +0300 (EEST)
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
Subject: [PATCH v3 00/15] lib/string_helpers: get rid of ugly *_escape_mem_ascii()
Date:   Tue,  4 May 2021 21:08:04 +0300
Message-Id: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
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

Changelog v3:
- dropped moving seq_escape() to the header due to a lot of complaints from
  the (very) old code
- added seq_escape_str() inliner
- converted seq_escape() to use seq_escape_str() instead of seq_escape_mem()

Changelog v2:
- introduced seq_escape_mem() instead of poking seq_get_buf() (Al)
- to keep balance of seq_get_buf() usage, convert seq_escape() to use above
- added missed ESCAPE_APPEND flag in NFSv4 patch
- moved indentation patch closer to the beginning of the series
- reshuffled series to be in two groups: generic library extension
  followed by seq_file updates

Andy Shevchenko (15):
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
  seq_file: Add seq_escape_str() as replica of string_escape_str()
  seq_file: Convert seq_escape() to use seq_escape_str()
  nfsd: Avoid non-flexible API in seq_quote_mem()
  seq_file: Drop unused *_escape_mem_ascii()

 MAINTAINERS                    |   8 ++
 fs/nfsd/nfs4state.c            |   2 +-
 fs/seq_file.c                  |  43 +++++----
 include/linux/seq_file.h       |  10 ++-
 include/linux/string_helpers.h |  31 ++++---
 lib/string_helpers.c           | 102 ++++++++++++---------
 lib/test-string_helpers.c      | 157 +++++++++++++++++++++++++++++----
 7 files changed, 264 insertions(+), 89 deletions(-)

-- 
2.30.2

