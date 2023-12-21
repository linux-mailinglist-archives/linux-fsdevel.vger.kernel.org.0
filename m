Return-Path: <linux-fsdevel+bounces-6672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB8D81B523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EF11F26227
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD56DD18;
	Thu, 21 Dec 2023 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="MmYKJO5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB06D1B7;
	Thu, 21 Dec 2023 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id CDA5F1FE6;
	Thu, 21 Dec 2023 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1703158148;
	bh=9Rn38mgkFfB/RmjsOLlzz6Pr1cAzEiI3A/7HJSLrTXg=;
	h=Date:To:CC:From:Subject;
	b=MmYKJO5nSAAVUQ3QGg7PtxmCHKfpDJNtV2ESHoHQ2fHOKCXzWBM08NKVN5A4QQAR4
	 E3Oyld0TAbtuX3195bdFkV/6s7gdBOQHomwRk0DdiNCoLhECj23PY/8X/XYYZlHE2G
	 Od9T6ej3Swumr15SZcaOi0qKZJT0GjEanQ/UMkMw=
Received: from [172.16.192.129] (192.168.211.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 21 Dec 2023 14:35:39 +0300
Message-ID: <894db108-509b-4026-a90e-666a759a3f9f@paragon-software.com>
Date: Thu, 21 Dec 2023 14:35:39 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Disable ATTR_LIST_ENTRY size check
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


The use of sizeof(struct ATTR_LIST_ENTRY) has been replaced with le_size(0)
due to alignment peculiarities on different platforms.

Reported-by: kernel test robot <lkp@intel.com>
Closes: 
https://lore.kernel.org/oe-kbuild-all/202312071005.g6YrbaIe-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrlist.c | 8 ++++----
  fs/ntfs3/ntfs.h     | 2 --
  2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 7c01735d1219..48e7da47c6b7 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -127,12 +127,13 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct 
ntfs_inode *ni,
  {
      size_t off;
      u16 sz;
+    const unsigned le_min_size = le_size(0);

      if (!le) {
          le = ni->attr_list.le;
      } else {
          sz = le16_to_cpu(le->size);
-        if (sz < sizeof(struct ATTR_LIST_ENTRY)) {
+        if (sz < le_min_size) {
              /* Impossible 'cause we should not return such le. */
              return NULL;
          }
@@ -141,7 +142,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct 
ntfs_inode *ni,

      /* Check boundary. */
      off = PtrOffset(ni->attr_list.le, le);
-    if (off + sizeof(struct ATTR_LIST_ENTRY) > ni->attr_list.size) {
+    if (off + le_min_size > ni->attr_list.size) {
          /* The regular end of list. */
          return NULL;
      }
@@ -149,8 +150,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct 
ntfs_inode *ni,
      sz = le16_to_cpu(le->size);

      /* Check le for errors. */
-    if (sz < sizeof(struct ATTR_LIST_ENTRY) ||
-        off + sz > ni->attr_list.size ||
+    if (sz < le_min_size || off + sz > ni->attr_list.size ||
          sz < le->name_off + le->name_len * sizeof(short)) {
          return NULL;
      }
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index c8981429c721..9c7478150a03 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -527,8 +527,6 @@ struct ATTR_LIST_ENTRY {

  }; // sizeof(0x20)

-static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
-
  static inline u32 le_size(u8 name_len)
  {
      return ALIGN(offsetof(struct ATTR_LIST_ENTRY, name) +
-- 
2.34.1


