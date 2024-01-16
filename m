Return-Path: <linux-fsdevel+bounces-8033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2AA82EAEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72367B230E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302312B7F;
	Tue, 16 Jan 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Tmh2CNU0";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Hsp2M8Hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1A12B66;
	Tue, 16 Jan 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E94B126;
	Tue, 16 Jan 2024 08:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1705393200;
	bh=xtKnc81qgkt1hp+yrgP4nxQ9fcDthRgPBw7xJL7BYSI=;
	h=Date:To:CC:From:Subject;
	b=Tmh2CNU0YPPx7m00AJ8Ts3TC0cvRijx7y5OQAghP2q4LAOj1teg55gQ9M/Pqg2XUo
	 XzC4lBOqxRSQckTX3O8jGHYLwKH6p6cHkFJfn8ECtw93HPN+HsvIK8Z9pBHmjkpNTU
	 ZE3+MNpGIGy1G9MM/jUiOXTG/WiSq9UeDFWYclGw=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E95371DF9;
	Tue, 16 Jan 2024 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1705393603;
	bh=xtKnc81qgkt1hp+yrgP4nxQ9fcDthRgPBw7xJL7BYSI=;
	h=Date:To:CC:From:Subject;
	b=Hsp2M8HdMaGF1tAVu4ui6wCeB6rYF4iWde/iHCQy0hsmyhUH1Ad4GxCxJWwYqqASC
	 xfmP5DiWsUHmdK1ITnGmLikpv7/3aWh3kTgEsa8C1Ocib3mwjGlsCATy5mXD2Hlehw
	 NxVIbqgEW+E0IOhhqFilnFxI1YIWsiSs/LopraQ8=
Received: from [192.168.211.197] (192.168.211.197) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 16 Jan 2024 11:26:43 +0300
Message-ID: <667a5bc4-8cb5-47ce-a7f1-749479b25bec@paragon-software.com>
Date: Tue, 16 Jan 2024 11:26:41 +0300
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
Subject: [PATCH] fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrlist.c | 4 ++--
  fs/ntfs3/bitmap.c   | 4 ++--
  fs/ntfs3/frecord.c  | 4 ++--
  fs/ntfs3/super.c    | 2 +-
  4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 48e7da47c6b7..9f4bd8d26090 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -29,7 +29,7 @@ static inline bool al_is_valid_le(const struct 
ntfs_inode *ni,
  void al_destroy(struct ntfs_inode *ni)
  {
      run_close(&ni->attr_list.run);
-    kfree(ni->attr_list.le);
+    kvfree(ni->attr_list.le);
      ni->attr_list.le = NULL;
      ni->attr_list.size = 0;
      ni->attr_list.dirty = false;
@@ -318,7 +318,7 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE 
type, const __le16 *name,
          memcpy(ptr, al->le, off);
          memcpy(Add2Ptr(ptr, off + sz), le, old_size - off);
          le = Add2Ptr(ptr, off);
-        kfree(al->le);
+        kvfree(al->le);
          al->le = ptr;
      } else {
          memmove(Add2Ptr(le, sz), le, old_size - off);
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 63f14a0232f6..845f9b22deef 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -124,7 +124,7 @@ void wnd_close(struct wnd_bitmap *wnd)
  {
      struct rb_node *node, *next;

-    kfree(wnd->free_bits);
+    kvfree(wnd->free_bits);
      wnd->free_bits = NULL;
      run_close(&wnd->run);

@@ -1360,7 +1360,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t 
new_bits)
          memcpy(new_free, wnd->free_bits, wnd->nwnd * sizeof(short));
          memset(new_free + wnd->nwnd, 0,
                 (new_wnd - wnd->nwnd) * sizeof(short));
-        kfree(wnd->free_bits);
+        kvfree(wnd->free_bits);
          wnd->free_bits = new_free;
      }

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 6ff4f70ba077..2636ab7640ac 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -778,7 +778,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode 
*ni)
      run_deallocate(sbi, &ni->attr_list.run, true);
      run_close(&ni->attr_list.run);
      ni->attr_list.size = 0;
-    kfree(ni->attr_list.le);
+    kvfree(ni->attr_list.le);
      ni->attr_list.le = NULL;
      ni->attr_list.dirty = false;

@@ -927,7 +927,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
      return 0;

  out:
-    kfree(ni->attr_list.le);
+    kvfree(ni->attr_list.le);
      ni->attr_list.le = NULL;
      ni->attr_list.size = 0;
      return err;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 65ef4b57411f..c55a29793a8d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -625,7 +625,7 @@ static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
  {
      kfree(sbi->new_rec);
      kvfree(ntfs_put_shared(sbi->upcase));
-    kfree(sbi->def_table);
+    kvfree(sbi->def_table);
      kfree(sbi->compress.lznt);
  #ifdef CONFIG_NTFS3_LZX_XPRESS
      xpress_free_decompressor(sbi->compress.xpress);
-- 
2.34.1


