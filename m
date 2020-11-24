Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD23F2C1DF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgKXGIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:19536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbgKXGIJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:09 -0500
IronPort-SDR: 8aAdjn1A9sPIz/WfzfctdS4DrGiBWsRhfJSNpv0BRb+hbUHL4JbF+nWcSRm3Qj17VsbUQdF7OX
 OLAy4Avl9ZJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="190018260"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="190018260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:09 -0800
IronPort-SDR: taQMImkhmEjtM7b3OBWdgwUOIuhOREAPpl273PPI4iZcnkxolkoTg1yHOTZj3fHHblmGNXOOgs
 UMsejyzPVMDQ==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="364905156"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:09 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
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
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
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
Subject: [PATCH 11/17] fs/reiserfs: Use memcpy_from_page()
Date:   Mon, 23 Nov 2020 22:07:49 -0800
Message-Id: <20201124060755.1405602-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201124060755.1405602-1-ira.weiny@intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove the open coding of kmap/memcpy/kunmap and use the new
memcpy_from_page() function.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/reiserfs/journal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index e98f99338f8f..e288bbbe80ff 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -4184,7 +4184,6 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
 		/* copy all the real blocks into log area.  dirty log blocks */
 		if (buffer_journaled(cn->bh)) {
 			struct buffer_head *tmp_bh;
-			char *addr;
 			struct page *page;
 			tmp_bh =
 			    journal_getblk(sb,
@@ -4194,11 +4193,9 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
 					    SB_ONDISK_JOURNAL_SIZE(sb)));
 			set_buffer_uptodate(tmp_bh);
 			page = cn->bh->b_page;
-			addr = kmap(page);
-			memcpy(tmp_bh->b_data,
-			       addr + offset_in_page(cn->bh->b_data),
-			       cn->bh->b_size);
-			kunmap(page);
+			memcpy_from_page(tmp_bh->b_data, page,
+					 offset_in_page(cn->bh->b_data),
+					 cn->bh->b_size);
 			mark_buffer_dirty(tmp_bh);
 			jindex++;
 			set_buffer_journal_dirty(cn->bh);
-- 
2.28.0.rc0.12.gb6a658bd00c9

