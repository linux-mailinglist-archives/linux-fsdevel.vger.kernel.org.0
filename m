Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F656A82D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiGGQgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiGGQgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:36:39 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F98345054;
        Thu,  7 Jul 2022 09:36:38 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 784E61D5D;
        Thu,  7 Jul 2022 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657211733;
        bh=u1JrIeuaLqGDHjQvEYZJzgoBWDe5t+TsYMJ94XUgDBg=;
        h=Date:To:CC:From:Subject;
        b=W+iNGlFbw4MDmBwPubUZCsxpWZ+fz/CX4rpS+TTtMLNiESJIk9TygE/X0btO+npaM
         Ss3EjNCDGbjNNWFzx3m/5icfPJ1DBoE95G6jizg5yZz7jlsx9otB6rrzq2vJFTWLEa
         t9tdbun8vPeOpTSc2zfK4LLbZtU4J6lddI77vcjM=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0BA4820F5;
        Thu,  7 Jul 2022 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657211796;
        bh=u1JrIeuaLqGDHjQvEYZJzgoBWDe5t+TsYMJ94XUgDBg=;
        h=Date:To:CC:From:Subject;
        b=owc2eDIrKMMVinRIr3kOMRsMcHDcUeze6pEoD47ZnesYUKUsOpSo8lxdyaYk8iH0J
         t32gXu2IpRibhzDCiwDOZ+tvElEXIo3M8Tzlrs3PcvG4CIq3mgLEJXlYtQpcpTe2H+
         F9W08ArWyQ1cwsEg/ssQ/XWxqJMI3KHUP/ZFWt/0=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 7 Jul 2022 19:36:35 +0300
Message-ID: <24343399-2866-2a52-ef86-3b1722fc04cd@paragon-software.com>
Date:   Thu, 7 Jul 2022 19:36:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Make MFT zone less fragmented
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we take free space after the MFT zone if the MFT zone shrinks.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c  | 39 +++++++++++++++++++++++++--------------
  fs/ntfs3/ntfs_fs.h |  1 +
  fs/ntfs3/super.c   |  7 +++++++
  3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index c53dd4c9e47b..ed9a1b851ce9 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -783,7 +783,7 @@ int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to)
   */
  int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
  {
-	CLST zone_limit, zone_max, lcn, vcn, len;
+	CLST lcn, vcn, len;
  	size_t lcn_s, zlen;
  	struct wnd_bitmap *wnd = &sbi->used.bitmap;
  	struct ntfs_inode *ni = sbi->mft.ni;
@@ -792,16 +792,6 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
  	if (wnd_zone_len(wnd))
  		return 0;
  
-	/*
-	 * Compute the MFT zone at two steps.
-	 * It would be nice if we are able to allocate 1/8 of
-	 * total clusters for MFT but not more then 512 MB.
-	 */
-	zone_limit = (512 * 1024 * 1024) >> sbi->cluster_bits;
-	zone_max = wnd->nbits >> 3;
-	if (zone_max > zone_limit)
-		zone_max = zone_limit;
-
  	vcn = bytes_to_cluster(sbi,
  			       (u64)sbi->mft.bitmap.nbits << sbi->record_bits);
  
@@ -815,7 +805,7 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
  	lcn_s = lcn + 1;
  
  	/* Try to allocate clusters after last MFT run. */
-	zlen = wnd_find(wnd, zone_max, lcn_s, 0, &lcn_s);
+	zlen = wnd_find(wnd, sbi->zone_max, lcn_s, 0, &lcn_s);
  	if (!zlen) {
  		ntfs_notice(sbi->sb, "MftZone: unavailable");
  		return 0;
@@ -1398,7 +1388,7 @@ int ntfs_write_bh(struct ntfs_sb_info *sbi, struct NTFS_RECORD_HEADER *rhdr,
  		if (buffer_locked(bh))
  			__wait_on_buffer(bh);
  
-		lock_buffer(nb->bh[idx]);
+		lock_buffer(bh);
  
  		bh_data = bh->b_data + off;
  		end_data = Add2Ptr(bh_data, op);
@@ -2427,7 +2417,7 @@ static inline void ntfs_unmap_and_discard(struct ntfs_sb_info *sbi, CLST lcn,
  
  void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
  {
-	CLST end, i;
+	CLST end, i, zone_len, zlen;
  	struct wnd_bitmap *wnd = &sbi->used.bitmap;
  
  	down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
@@ -2462,6 +2452,27 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
  		ntfs_unmap_and_discard(sbi, lcn, len);
  	wnd_set_free(wnd, lcn, len);
  
+	/* append to MFT zone, if possible. */
+	zone_len = wnd_zone_len(wnd);
+	zlen = min(zone_len + len, sbi->zone_max);
+
+	if (zlen == zone_len) {
+		/* MFT zone already has maximum size. */
+	} else if (!zone_len) {
+		/* Create MFT zone. */
+		wnd_zone_set(wnd, lcn, zlen);
+	} else {
+		CLST zone_lcn = wnd_zone_bit(wnd);
+
+		if (lcn + len == zone_lcn) {
+			/* Append into head MFT zone. */
+			wnd_zone_set(wnd, lcn, zlen);
+		} else if (zone_lcn + zone_len == lcn) {
+			/* Append into tail MFT zone. */
+			wnd_zone_set(wnd, zone_lcn, zlen);
+		}
+	}
+
  out:
  	up_write(&wnd->rw_lock);
  }
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index cf1fa69a0eb8..54c20700afd3 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -220,6 +220,7 @@ struct ntfs_sb_info {
  
  	u32 flags; // See NTFS_FLAGS_XXX.
  
+	CLST zone_max; // Maximum MFT zone length in clusters
  	CLST bad_clusters; // The count of marked bad clusters.
  
  	u16 max_bytes_per_attr; // Maximum attribute size in record.
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index eacea72ff92f..6fad173a8b8f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -867,6 +867,13 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
  	sb->s_maxbytes = 0xFFFFFFFFull << sbi->cluster_bits;
  #endif
  
+	/*
+	 * Compute the MFT zone at two steps.
+	 * It would be nice if we are able to allocate 1/8 of
+	 * total clusters for MFT but not more then 512 MB.
+	 */
+	sbi->zone_max = min_t(CLST, 0x20000000 >> sbi->cluster_bits, clusters >> 3);
+
  	err = 0;
  
  out:
-- 
2.37.0

