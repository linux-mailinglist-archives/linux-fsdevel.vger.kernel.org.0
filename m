Return-Path: <linux-fsdevel+bounces-5023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3755807544
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E474F1C20AB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B72D48CE1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="uB7SJ5ZV";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HwerjDqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B67112;
	Wed,  6 Dec 2023 07:14:26 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E6D181D0B;
	Wed,  6 Dec 2023 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875280;
	bh=W/TNdgmKDqNDYIi7mUSo5ayyxeI6Wi55D54a4MJS5O8=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=uB7SJ5ZV34Sc6PLOrZBUBpCENFmPGqlFtRZvqJoH9vKlKM7YeJH4IMKAHPy9I9iEa
	 ejo/mhQFbObUfY7QSS46h7IJ+xwplvgdoZFTxSFtWgAmYnNnVdXzTJPHQhaaWOBNo5
	 SWLDXhH3caMbQcpe06yX7DO97jt+0K3UDKKUucwE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 32A922117;
	Wed,  6 Dec 2023 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875665;
	bh=W/TNdgmKDqNDYIi7mUSo5ayyxeI6Wi55D54a4MJS5O8=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=HwerjDqSLEHZuqFn+zzPuEhCBWA0uFcD4nADai1942YJ983cNo0j/pryidiex2rWP
	 H0uuBaQ306w3AFnBoJcJRFcIIK8vQDQuWbmPIeusCe3s3FXdqFM+hDeHsYQD0L0g+x
	 O29n04DNf2rqk9XpwAgCpKfKdguOdnw9nTpi3aCo=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:14:24 +0300
Message-ID: <f876d196-bfeb-4b0d-bb10-dc793717db49@paragon-software.com>
Date: Wed, 6 Dec 2023 18:14:24 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 15/16] fs/ntfs3: Add NULL ptr dereference checking at the end
 of attr_allocate_frame()
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

It is preferable to exit through the out: label because
internal debugging functions are located there.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c | 20 ++++++++++++--------
  1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 4b78b669a3bd..646e2dad1b75 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1743,8 +1743,10 @@ int attr_allocate_frame(struct ntfs_inode *ni, 
CLST frame, size_t compr_size,
              le_b = NULL;
              attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
                            0, NULL, &mi_b);
-            if (!attr_b)
-                return -ENOENT;
+            if (!attr_b) {
+                err = -ENOENT;
+                goto out;
+            }

              attr = attr_b;
              le = le_b;
@@ -1825,13 +1827,15 @@ int attr_allocate_frame(struct ntfs_inode *ni, 
CLST frame, size_t compr_size,
  ok:
      run_truncate_around(run, vcn);
  out:
-    if (new_valid > data_size)
-        new_valid = data_size;
+    if (attr_b) {
+        if (new_valid > data_size)
+            new_valid = data_size;

-    valid_size = le64_to_cpu(attr_b->nres.valid_size);
-    if (new_valid != valid_size) {
-        attr_b->nres.valid_size = cpu_to_le64(valid_size);
-        mi_b->dirty = true;
+        valid_size = le64_to_cpu(attr_b->nres.valid_size);
+        if (new_valid != valid_size) {
+            attr_b->nres.valid_size = cpu_to_le64(valid_size);
+            mi_b->dirty = true;
+        }
      }

      return err;
-- 
2.34.1


