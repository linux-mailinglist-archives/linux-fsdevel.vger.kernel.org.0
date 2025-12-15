Return-Path: <linux-fsdevel+bounces-71278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6F4CBC4A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EBB63012DED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 03:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7D27EFE9;
	Mon, 15 Dec 2025 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQbbKKOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9D317700
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765767918; cv=none; b=f9qraMiwIFD8MWt1yQ0s+jA+DLLUGhj3IeJXh3AwGvX8de0KhZmary0e7gm3JRHAXiA/l+WSgV/q5utwOYl71yJJLAgtW2RQKgMnT0T+7fsf1X0aCn31hFxfMsPmGG+PEM4UuYBKGrHIVpzPSJKk65ASni9nOcPJFm0cDrbMy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765767918; c=relaxed/simple;
	bh=oN767t555H1kIiWjLDwGJZ6hCrsDHha3zysjC6xAxPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMxZ44l3Zges5eRn8TE5PwRtAE2f6we0h9L0ZWoy6hxQrfmF0g+0ryP2ZICoi+5azArMdzRe4irClQ3sXWzi1ux2ZQKTNrT4u2K9I0qVpQyFnZ94rmKLgjPcgfumI5xoXcCQWYvWy443plxviG7d1aYEz3Cn/w2KAPlb88rTbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQbbKKOy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so3344387b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 19:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765767917; x=1766372717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBRV01n6Z10+Z5Vfi/wD7Tb0wVdvo9mjj3mwV2A1JME=;
        b=cQbbKKOyjkNEJFJk1UK1+iHp2ve9EfhOTAFivLpqLRO4zMqLhtZF8VxaBkbaPlBQji
         luKU/Yf2nJMvx/7uj5npSis4vav8tPUMUFAlM+QHZbvO8BSD6goc2aIdaJaTDaK2zr7V
         d6+ngrYaNXIqyqKlpUE50vLXUMR9uvVvnB4RUmaeifBw0g8Of5c9FfIzgM8GA6x5ufmQ
         uK+4orquawlS7wl7FAPAP5aIiOd9hyeQl0pQ+ETDZDh3nxlcwrA6ptD9hdYzP0OH4Cdn
         hdEC57F1APQtKlZw9ite4cbSKHg2qu9HKbvgQGSq+pxsTA7ycgJTqV6zKJAtv/kMB0i/
         ZeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765767917; x=1766372717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBRV01n6Z10+Z5Vfi/wD7Tb0wVdvo9mjj3mwV2A1JME=;
        b=jRluZjPYhrrKvbuQ4Iyd/hYzQIfYVkYBTamn5XN6OrNyV5+h+LaOMIGMSB7yvqFmhv
         xajMQyl7jkb+OTgTuilocrafqOFQupYqrrAcIS6cF+jCVPZWL+bWhCW9+KyPcOoRbuaf
         5sd50J+S/q+nFEQIYIZdfF1HcpbF4Q2p5GnrdW/j0fmwHdb0IAYd7WufbsboVr/tTO3U
         Bl7BP+uZKz18VnkMD4cc5+f05UTPLGdJl0LCAY8rMcuWz+SV4wvDqJSRGA6khPQ4ZURp
         1+MJAt098RlF/FdGhIY7N4E7Wybei+AIvjTdvHSWA44n7xT/dR+a5McCntO5rXdoQjFw
         jHDA==
X-Forwarded-Encrypted: i=1; AJvYcCXRtX8FCRy4m5CE932HOR2ju0KB34Y4o51musqoydSuueRd0X4sSnAUNBVeYuox3XjT9fCkXE+m1WBfp8FU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LW2btGfT1qXvJFexB4NPaZynBXAcG4MsW5v7pQFjvpB6xZX5
	jRxrrZ4pUlAtpCZcPIuWBvU0LzzZth+C8OJEGk+BWD0C9A/j72KMl4PL0MoLRspfci0=
X-Gm-Gg: AY/fxX624aVOpkM+Sf96s1Crk5PLArqSAt1/qVl58YuIbUuYTD4ba1+hoBF0ZJtgO/v
	URfQWPiwvz/48GQ7i5pRkpkWwFeERtwLDThe/ytYVgRql/Tx3VkkLsjoUQFQVNd+6IZw8SNi2wB
	xipKg3uBvOdiHx5cDTaCfrl+U5p6cFOIdkVwmSCzjK9vXO5Fu9gEZt2+V99/W0YtdcBTeuu6vRB
	YInDpOSWHBGzLylr0adRfwOtLtK5qWkBNayP4pLaHcMEiYnko23JLREjYY/oQZUomNmijydbJ06
	rxudmouktivUIHQcyV2Zo3HJBkuYPpymVr1O2Tep2d89BPMMtnvmG6tvcEtqbMI0dMeCcoHbaec
	gmaVDFtlRK0o32tesbbCYV1R7mL+uIuBMWraYz6yqK/piGE45w7NAOck9WGjiZ2Rn1ngY8ks4Yi
	Zp1obAtK5oZsBzbREFEw==
X-Google-Smtp-Source: AGHT+IEn+Y8AE3kEX5AkB/sFeGPR4t6lVQuTq+UDwlWj5SFZcATCZ4c86Jekd4k01WrcvjN481NL6w==
X-Received: by 2002:a05:6a20:3d8b:b0:364:13c3:3dd0 with SMTP id adf61e73a8af0-369ae58ce09mr8734759637.36.1765767916868;
        Sun, 14 Dec 2025 19:05:16 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad5663dsm11335787a12.17.2025.12.14.19.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:05:16 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net,
	carnil@debian.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()
Date: Sun, 14 Dec 2025 19:00:43 -0800
Message-ID: <20251215030043.1431306-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215030043.1431306-1-joannelkoong@gmail.com>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Skip waiting on writeback for inodes that belong to mappings that do not
have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
mapping flag).

This restores fuse back to prior behavior where syncs are no-ops. This
is needed because otherwise, if a system is running a faulty fuse
server that does not reply to issued write requests, this will cause
wait_sb_inodes() to wait forever.

Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
Reported-by: J. Neuschäfer <j.neuschaefer@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c       |  3 ++-
 fs/fuse/file.c          |  4 +++-
 include/linux/pagemap.h | 11 +++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..ab2e279ed3c2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb)
 		 * do not have the mapping lock. Skip it here, wb completion
 		 * will remove it.
 		 */
-		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
+		    mapping_no_data_integrity(mapping))
 			continue;
 
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..3b2a171e652f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
-	if (fc->writeback_cache)
+	if (fc->writeback_cache) {
 		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
+		mapping_set_no_data_integrity(&inode->i_data);
+	}
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..ec442af3f886 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
+	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
+static inline void mapping_set_no_data_integrity(struct address_space *mapping)
+{
+	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
+}
+
+static inline bool mapping_no_data_integrity(const struct address_space *mapping)
+{
+	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
 	return mapping->gfp_mask;
-- 
2.47.3


