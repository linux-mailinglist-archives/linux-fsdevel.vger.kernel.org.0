Return-Path: <linux-fsdevel+bounces-5009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7662C807524
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072CEB20DAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615A36AEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="bV1feHdO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BBADE;
	Wed,  6 Dec 2023 07:10:27 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D92B11E1A;
	Wed,  6 Dec 2023 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875040;
	bh=/GAY4vh49Ey49PjOB0D7aW4BJClWKFEVXZZb9RVpvm8=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=bV1feHdOoc85vxuNTcRIuuIj4OKvvVliIheZoWfeIjMagZtKTIExoG1tZP5GKcmcC
	 2Xm3LxPkbcoWDpxWt3fxCzNeybO3lNj/Zk/uh1gmH2/1enCbGpFcHF7wyUjchAGCIv
	 2RCP2b2+LXWKnHQCqKpaT1lY7nUqnYMKO5UJM8XU=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:10:24 +0300
Message-ID: <d39096b0-3bea-4044-9fdf-0decb1011ec4@paragon-software.com>
Date: Wed, 6 Dec 2023 18:10:24 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 03/16] fs/ntfs3: Improve ntfs_dir_count
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
  fs/ntfs3/dir.c | 10 +++-------
  1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 22ede4da0450..726122ecd39b 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -515,11 +515,9 @@ static int ntfs_dir_count(struct inode *dir, bool 
*is_empty, size_t *dirs,
      struct INDEX_HDR *hdr;
      const struct ATTR_FILE_NAME *fname;
      u32 e_size, off, end;
-    u64 vbo = 0;
      size_t drs = 0, fles = 0, bit = 0;
-    loff_t i_size = ni->vfs_inode.i_size;
      struct indx_node *node = NULL;
-    u8 index_bits = ni->dir.index_bits;
+    size_t max_indx = ni->vfs_inode.i_size >> ni->dir.index_bits;

      if (is_empty)
          *is_empty = true;
@@ -563,7 +561,7 @@ static int ntfs_dir_count(struct inode *dir, bool 
*is_empty, size_t *dirs,
                  fles += 1;
          }

-        if (vbo >= i_size)
+        if (bit >= max_indx)
              goto out;

          err = indx_used_bit(&ni->dir, ni, &bit);
@@ -573,8 +571,7 @@ static int ntfs_dir_count(struct inode *dir, bool 
*is_empty, size_t *dirs,
          if (bit == MINUS_ONE_T)
              goto out;

-        vbo = (u64)bit << index_bits;
-        if (vbo >= i_size)
+        if (bit >= max_indx)
              goto out;

          err = indx_read(&ni->dir, ni, bit << ni->dir.idx2vbn_bits,
@@ -584,7 +581,6 @@ static int ntfs_dir_count(struct inode *dir, bool 
*is_empty, size_t *dirs,

          hdr = &node->index->ihdr;
          bit += 1;
-        vbo = (u64)bit << ni->dir.idx2vbn_bits;
      }

  out:
-- 
2.34.1


