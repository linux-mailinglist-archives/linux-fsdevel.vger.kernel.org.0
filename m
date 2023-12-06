Return-Path: <linux-fsdevel+bounces-5008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7DF807523
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC121C208D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783E48CD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="CM28fQWf"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 07:09:48 PST
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADDC6;
	Wed,  6 Dec 2023 07:09:47 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 75DD71E1A;
	Wed,  6 Dec 2023 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875001;
	bh=Ifmg2OmIcc1e099M3eAc7+M0D09LHndtu4YB0fZ10AE=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=CM28fQWfl2jtqKv/4Q00K5fqN1XehGPo+klnsLEdY+l3HE67RQZYkzBqf6GrkQUfr
	 djhTyaAxCW/vH267eQpmpDRK6Px0x/CmTqlYadmRB8vyT2X9uyiv7/Ivcky6dxEE49
	 O+rzp55tAH/NRfKemZdi/99Qye5kO0nISMZtbgX8=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:09:45 +0300
Message-ID: <c005f117-6c66-40d8-95d4-e6384cffbcbf@paragon-software.com>
Date: Wed, 6 Dec 2023 18:09:45 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 02/16] fs/ntfs3: Modified fix directory element type detection
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

Unfortunately reparse attribute is used for many purposes (several dozens).
It is not possible here to know is this name symlink or not.
To get exactly the type of name we should to open inode (read mft).
getattr for opened file (fstat) correctly returns symlink.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/dir.c | 30 +++++++++++++++++++++++++-----
  1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index ec0566b322d5..22ede4da0450 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -309,11 +309,31 @@ static inline int ntfs_filldir(struct ntfs_sb_info 
*sbi, struct ntfs_inode *ni,
          return 0;
      }

-    /* NTFS: symlinks are "dir + reparse" or "file + reparse" */
-    if (fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT)
-        dt_type = DT_LNK;
-    else
-        dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : 
DT_REG;
+    /*
+     * NTFS: symlinks are "dir + reparse" or "file + reparse"
+     * Unfortunately reparse attribute is used for many purposes 
(several dozens).
+     * It is not possible here to know is this name symlink or not.
+     * To get exactly the type of name we should to open inode (read mft).
+     * getattr for opened file (fstat) correctly returns symlink.
+     */
+    dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+
+    /*
+     * It is not reliable to detect the type of name using duplicated 
information
+     * stored in parent directory.
+     * The only correct way to get the type of name - read MFT record 
and find ATTR_STD.
+     * The code below is not good idea.
+     * It does additional locks/reads just to get the type of name.
+     * Should we use additional mount option to enable branch below?
+     */
+    if ((fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT) &&
+        ino != ni->mi.rno) {
+        struct inode *inode = ntfs_iget5(sbi->sb, &e->ref, NULL);
+        if (!IS_ERR_OR_NULL(inode)) {
+            dt_type = fs_umode_to_dtype(inode->i_mode);
+            iput(inode);
+        }
+    }

      return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
  }
-- 
2.34.1


