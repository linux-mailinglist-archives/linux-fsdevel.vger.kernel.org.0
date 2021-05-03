Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0203721FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhECUuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:50:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:37488 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhECUt4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:49:56 -0400
IronPort-SDR: kdsxvwmAZrpOQJVuCJU+YhRKw03Bn7WbXGUQQO9UNnI9vjIHXup8+Vo5Vm7W0vbNWbVY+ga80n
 KtHNMBXjTnaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="178040335"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="178040335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:48:58 -0700
IronPort-SDR: wxkmPQKQe+fGdU417U8JD9bWknTs03m8kq/DHNeBNfSpFJZyxRaCPwPRB+RJWGRQoWX6Sz7T1a
 ZydjXVIdwDQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="432922886"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 May 2021 13:48:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 826C861D; Mon,  3 May 2021 23:49:11 +0300 (EEST)
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
Subject: [PATCH v1 10/12] nfsd: Avoid non-flexible API in seq_quote_mem()
Date:   Mon,  3 May 2021 23:49:05 +0300
Message-Id: <20210503204907.34013-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

string_escape_mem_ascii() followed by seq_escape_mem_ascii() is completely
non-flexible and shouldn't be exist from day 1.

Replace it with properly called string_escape_mem().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/nfsd/nfs4state.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b517a8794400..15535589e5e4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2350,8 +2350,14 @@ static struct nfs4_client *get_nfsdfs_clp(struct inode *inode)
 
 static void seq_quote_mem(struct seq_file *m, char *data, int len)
 {
+	char *buf;
+	size_t size = seq_get_buf(m, &buf);
+	const char *only = "\"\\";
+	int ret;
+
 	seq_printf(m, "\"");
-	seq_escape_mem_ascii(m, data, len);
+	ret = string_escape_mem(data, len, buf, size, ESCAPE_HEX | ESCAPE_APPEND, only);
+	seq_commit(m, ret < size ? ret : -1);
 	seq_printf(m, "\"");
 }
 
-- 
2.30.2

