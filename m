Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E19372F74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhEDSJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:09:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:41081 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232296AbhEDSJH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:07 -0400
IronPort-SDR: 7gsjRJ41jfpITRFnOQox4Rgx6k66lEev+zxbrEza+IalF0XXzWoZB7H4mbgDpcAXGO7J2JLrV4
 8/YdXgNHHLmw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="261993809"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="261993809"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:11 -0700
IronPort-SDR: PQOMb/9wLk+RMgypUdybc+z8/u++MCkNQYwFCu20hVNz/5+FbuIgq3z5eGEEQchCh+FTvOZ28l
 2vCHiang+sHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="463341899"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2021 11:08:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2EBC89FA; Tue,  4 May 2021 21:08:24 +0300 (EEST)
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
Subject: [PATCH v3 13/15] seq_file: Convert seq_escape() to use seq_escape_str()
Date:   Tue,  4 May 2021 21:08:17 +0300
Message-Id: <20210504180819.73127-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert seq_escape() to use seq_escape_str() rather than open coding it.

Note, for now we leave it as an exported symbol due to some old code
that can't tolerate ctype.h being (indirectly) included.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/seq_file.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 532cac2eae0f..08f54029c2b1 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -392,12 +392,7 @@ EXPORT_SYMBOL(seq_escape_mem);
  */
 void seq_escape(struct seq_file *m, const char *s, const char *esc)
 {
-	char *buf;
-	size_t size = seq_get_buf(m, &buf);
-	int ret;
-
-	ret = string_escape_str(s, buf, size, ESCAPE_OCTAL, esc);
-	seq_commit(m, ret < size ? ret : -1);
+	seq_escape_str(m, s, ESCAPE_OCTAL, esc);
 }
 EXPORT_SYMBOL(seq_escape);
 
-- 
2.30.2

