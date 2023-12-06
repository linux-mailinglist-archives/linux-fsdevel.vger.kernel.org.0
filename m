Return-Path: <linux-fsdevel+bounces-5013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ABD807529
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3AA1C20A79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956A48CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ml0RcwIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FF1C6;
	Wed,  6 Dec 2023 07:12:06 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2AAFC2120;
	Wed,  6 Dec 2023 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875140;
	bh=KEnz3KTE1Z9/osOlDauLKgWtI6LdwFBhWwhEahHqNQo=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=ml0RcwIB/jbk6KHc50rd9/kLCglaBQgfFiOHbhazURkapxReFpC4vxnpvlYMS8nrP
	 58adYEG0RnhgyeLDEMwND0AqrD9TZFlz6HTNiuDEmvzUmC5+PXmjU2b3YGybT7p0QH
	 p4lAjZYfowSTC2GQFaBSEjxTjNgDlilQX4n/rSpU=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:12:03 +0300
Message-ID: <7ae15d02-7745-4241-8b28-197eebbb6b7b@paragon-software.com>
Date: Wed, 6 Dec 2023 18:12:03 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 07/16] fs/ntfs3: Fix multithreaded stress test
Content-Language: en-US
From: Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
In-Reply-To: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c | 21 ++++++++++++++-------
  1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 63f70259edc0..4b78b669a3bd 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -886,7 +886,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST 
vcn, CLST clen, CLST *lcn,
      struct runs_tree *run = &ni->file.run;
      struct ntfs_sb_info *sbi;
      u8 cluster_bits;
-    struct ATTRIB *attr = NULL, *attr_b;
+    struct ATTRIB *attr, *attr_b;
      struct ATTR_LIST_ENTRY *le, *le_b;
      struct mft_inode *mi, *mi_b;
      CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
@@ -904,12 +904,8 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST 
vcn, CLST clen, CLST *lcn,
          *len = 0;
      up_read(&ni->file.run_lock);

-    if (*len) {
-        if (*lcn != SPARSE_LCN || !new)
-            return 0; /* Fast normal way without allocation. */
-        else if (clen > *len)
-            clen = *len;
-    }
+    if (*len && (*lcn != SPARSE_LCN || !new))
+        return 0; /* Fast normal way without allocation. */

      /* No cluster in cache or we need to allocate cluster in hole. */
      sbi = ni->mi.sbi;
@@ -918,6 +914,17 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST 
vcn, CLST clen, CLST *lcn,
      ni_lock(ni);
      down_write(&ni->file.run_lock);

+    /* Repeat the code above (under write lock). */
+    if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+        *len = 0;
+
+    if (*len) {
+        if (*lcn != SPARSE_LCN || !new)
+            goto out; /* normal way without allocation. */
+        if (clen > *len)
+            clen = *len;
+    }
+
      le_b = NULL;
      attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, 
&mi_b);
      if (!attr_b) {
-- 
2.34.1


