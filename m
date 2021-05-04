Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8717D372F6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhEDSJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:09:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:4503 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232273AbhEDSJG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:06 -0400
IronPort-SDR: zpOihsyrWo3MCdhbJr3xH8kkMUVJsh+gX0bXIfcwFd8G9zMrI4aOoalVuVQr0eXtAH+MTdj8eM
 hEFwiI32Nv/w==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198102786"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198102786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:10 -0700
IronPort-SDR: tV6c1J8jOO09UiO212iYCFlXnUv8Zfdkt9vVVSuIJiOxO30kZVlYeZ8ziy3iZg3P3Ozx9pEOwY
 Klb8aY9BDT/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="539267692"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2021 11:08:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 375F3AFA; Tue,  4 May 2021 21:08:24 +0300 (EEST)
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
Subject: [PATCH v3 14/15] nfsd: Avoid non-flexible API in seq_quote_mem()
Date:   Tue,  4 May 2021 21:08:18 +0300
Message-Id: <20210504180819.73127-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The seq_escape_mem_ascii() is completely non-flexible and shouldn't be used.
Replace it with properly called seq_escape_mem().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b517a8794400..cd5eac2ba054 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2351,7 +2351,7 @@ static struct nfs4_client *get_nfsdfs_clp(struct inode *inode)
 static void seq_quote_mem(struct seq_file *m, char *data, int len)
 {
 	seq_printf(m, "\"");
-	seq_escape_mem_ascii(m, data, len);
+	seq_escape_mem(m, data, len, ESCAPE_HEX | ESCAPE_NAP | ESCAPE_APPEND, "\"\\");
 	seq_printf(m, "\"");
 }
 
-- 
2.30.2

