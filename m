Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79B7372F8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhEDSKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:10:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:4512 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhEDSJG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:06 -0400
IronPort-SDR: DLKSIfnjA28kP/9JLP3S4RiEmZgqpFtxbk8kLwtTuJ98gdr2kHddsvU+E7xZYO0ObQQo9jRMEr
 muNBb8WxJxsw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198102793"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198102793"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:11 -0700
IronPort-SDR: JNFpGkilIQ16ds4+KDGVzPEhaSbBgzpRaPHchsRrldhf1fNEBRVRKrVtpiZJbi65Rq3pVRJHFK
 +qrka7NrIlxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618574585"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2021 11:08:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 259529EB; Tue,  4 May 2021 21:08:24 +0300 (EEST)
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
Subject: [PATCH v3 12/15] seq_file: Add seq_escape_str() as replica of string_escape_str()
Date:   Tue,  4 May 2021 21:08:16 +0300
Message-Id: <20210504180819.73127-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In some cases we want to escape characters from NULL-terminated strings.
Add seq_escape_str() as replica of string_escape_str() for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/seq_file.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 6de442182784..63f021cb1b12 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -128,6 +128,13 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 
 void seq_escape_mem(struct seq_file *m, const char *src, size_t len,
 		    unsigned int flags, const char *esc);
+
+static inline void seq_escape_str(struct seq_file *m, const char *src,
+				  unsigned int flags, const char *esc)
+{
+	seq_escape_mem(m, src, strlen(src), flags, esc);
+}
+
 void seq_escape(struct seq_file *m, const char *s, const char *esc);
 void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz);
 
-- 
2.30.2

