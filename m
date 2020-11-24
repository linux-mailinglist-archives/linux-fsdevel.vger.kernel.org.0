Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694872C1DF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgKXGIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:51611 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgKXGIF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:05 -0500
IronPort-SDR: 6fG57QLT5M3i0ErJL+KAAIrc22J6QvDpxe+VvNWmu54XDTSnQBSpHTZwjTeh9ijPFJsbLk66xj
 +f0R0i0eXD6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171114718"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="171114718"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:05 -0800
IronPort-SDR: lfFU9ijJ/yT2fs02p0urCEZFiJL9rzYwbCr8oqpexUvHQPy+rjpMQ4ao3qTWUilsOyx2pqDXMo
 AuGffm+kjQLw==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="332448426"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:04 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/17] fs/afs: Convert to memzero_page()
Date:   Mon, 23 Nov 2020 22:07:42 -0800
Message-Id: <20201124060755.1405602-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Convert the kmap()/memcpy()/kunmap() pattern to memzero_page().

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/afs/write.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 50371207f327..ed7419de0178 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -30,7 +30,6 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 {
 	struct afs_read *req;
 	size_t p;
-	void *data;
 	int ret;
 
 	_enter(",,%llu", (unsigned long long)pos);
@@ -38,9 +37,7 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 	if (pos >= vnode->vfs_inode.i_size) {
 		p = pos & ~PAGE_MASK;
 		ASSERTCMP(p + len, <=, PAGE_SIZE);
-		data = kmap(page);
-		memset(data + p, 0, len);
-		kunmap(page);
+		memzero_page(page, p, len);
 		return 0;
 	}
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

