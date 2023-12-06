Return-Path: <linux-fsdevel+bounces-5017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029E807533
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B001F211A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1D48CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="m3/oqph8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF039DE;
	Wed,  6 Dec 2023 07:13:17 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 903201E1A;
	Wed,  6 Dec 2023 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875211;
	bh=F097v/jB8ZR21e/O3vd36dCK4gneA3BrFHtMeimQuV4=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=m3/oqph84dOfSvsyEUrnjup2sI052twZlQVgqAS6UOH+jafuQ1FPCmz6Fu7lGEQQi
	 2/82ZDbxioT09DRo45akAqbUhutD4t5bbxSm44sL5MnKUhvjmAyx/0IIaHypmgn1vm
	 OEh6DBzuauAM8FnZ1RUItM5m01Y3W9cCWxkOJYF0=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:13:15 +0300
Message-ID: <89861d9e-f3a4-483d-b88d-4085dc2e0a8b@paragon-software.com>
Date: Wed, 6 Dec 2023 18:13:15 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 11/16] fs/ntfs3: Drop suid and sgid bits as a part of fpunch
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
  fs/ntfs3/file.c | 9 +++++++++
  1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index bb80ce2eec2f..0ff5d3af2889 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -498,10 +498,14 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
          ni_lock(ni);
          err = attr_punch_hole(ni, vbo, len, &frame_size);
          ni_unlock(ni);
+        if (!err)
+            goto ok;
+
          if (err != E_NTFS_NOTALIGNED)
              goto out;

          /* Process not aligned punch. */
+        err = 0;
          mask = frame_size - 1;
          vbo_a = (vbo + mask) & ~mask;
          end_a = end & ~mask;
@@ -524,6 +528,8 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
              ni_lock(ni);
              err = attr_punch_hole(ni, vbo_a, end_a - vbo_a, NULL);
              ni_unlock(ni);
+            if (err)
+                goto out;
          }
      } else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
          /*
@@ -563,6 +569,8 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
          ni_lock(ni);
          err = attr_insert_range(ni, vbo, len);
          ni_unlock(ni);
+        if (err)
+            goto out;
      } else {
          /* Check new size. */
          u8 cluster_bits = sbi->cluster_bits;
@@ -639,6 +647,7 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
          }
      }

+ok:
      err = file_modified(file);
      if (err)
          goto out;
-- 
2.34.1


