Return-Path: <linux-fsdevel+bounces-5019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310D80753D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FD0280CE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72864644B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="NCK6bfmA";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="cKTfILwv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC0B5;
	Wed,  6 Dec 2023 07:13:49 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 216141E1A;
	Wed,  6 Dec 2023 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875243;
	bh=CUZk88fabksVMQIwptkfOhP6XsgOcXbEpcc4odQSDSQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=NCK6bfmAVok0RLfrG2qNu60LQBlIyV8PnwhtGpjL8OHnbfVEi3NJ4VX370Q1e5hk3
	 HOzmdUxENLGFoCwvBzdk7CzHTnC0QkqbXH/Uig2v9kOtjc8kTdItbUuJFx9ZVhn1V6
	 awSW+hE0eS335PqIP4VtGv0WlMxfI8F7ZdrLM6YU=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 64E4B2117;
	Wed,  6 Dec 2023 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875627;
	bh=CUZk88fabksVMQIwptkfOhP6XsgOcXbEpcc4odQSDSQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=cKTfILwvtBLLE19pwq14wyqj1avYe8W/4CiDi8l/6aJTt4VI1IVYevoAo22826ksJ
	 ROfjf2aOvncNloeosyx2+MUuiP2wVYUZC88epJYNhDB5WBuYiKNKTKnqQBeu/gg51w
	 R0UbWXrBWjm1M6WFpRGa90JZRnpvbf+JG4wMctg4=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:13:46 +0300
Message-ID: <6e9cc7e7-b29c-4d63-a73c-9aadd1589f18@paragon-software.com>
Date: Wed, 6 Dec 2023 18:13:46 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 13/16] fs/ntfs3: ntfs3_forced_shutdown use int instead of bool
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
  fs/ntfs3/fsntfs.c  | 3 ++-
  fs/ntfs3/ntfs_fs.h | 6 +++---
  fs/ntfs3/super.c   | 2 +-
  3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index fbfe21dbb425..350461d8cece 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -853,7 +853,8 @@ void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, 
int wait)
      /*
       * sb can be NULL here. In this case sbi->flags should be 0 too.
       */
-    if (!sb || !(sbi->flags & NTFS_FLAGS_MFTMIRR))
+    if (!sb || !(sbi->flags & NTFS_FLAGS_MFTMIRR) ||
+        unlikely(ntfs3_forced_shutdown(sb)))
          return;

      blocksize = sb->s_blocksize;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index d40bc7669ae5..7510875efef6 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -62,7 +62,7 @@ enum utf16_endian;
  /* sbi->flags */
  #define NTFS_FLAGS_NODISCARD        0x00000001
  /* ntfs in shutdown state. */
-#define NTFS_FLAGS_SHUTDOWN        0x00000002
+#define NTFS_FLAGS_SHUTDOWN_BIT        0x00000002  /* == 4*/
  /* Set when LogFile is replaying. */
  #define NTFS_FLAGS_LOG_REPLAYING    0x00000008
  /* Set when we changed first MFT's which copy must be updated in 
$MftMirr. */
@@ -1001,9 +1001,9 @@ static inline struct ntfs_sb_info *ntfs_sb(struct 
super_block *sb)
      return sb->s_fs_info;
  }

-static inline bool ntfs3_forced_shutdown(struct super_block *sb)
+static inline int ntfs3_forced_shutdown(struct super_block *sb)
  {
-    return test_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+    return test_bit(NTFS_FLAGS_SHUTDOWN_BIT, &ntfs_sb(sb)->flags);
  }

  /*
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index af8521a6ed95..65ef4b57411f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -719,7 +719,7 @@ static int ntfs_show_options(struct seq_file *m, 
struct dentry *root)
   */
  static void ntfs_shutdown(struct super_block *sb)
  {
-    set_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+    set_bit(NTFS_FLAGS_SHUTDOWN_BIT, &ntfs_sb(sb)->flags);
  }

  /*
-- 
2.34.1


