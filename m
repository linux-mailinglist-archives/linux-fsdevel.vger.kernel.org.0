Return-Path: <linux-fsdevel+bounces-61857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F9AB7DA36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28B11891B48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 00:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E51DC985;
	Wed, 17 Sep 2025 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgcbLlYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2813B2A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069671; cv=none; b=n/Kek/M5c+gpfaE4ehdLV4Oh/I+Oi00SNu6qtnBcRfg0etzOl/hJJGKh1QGu9BV7oDUku6p/NHorlED5Kk0SfupkYHJ1kovvEWMXsSeiPlJzCo2giECuHtGEyzvKmGURfIaRIRmNvf1Yo9Y/QmyCtd1BlkcAuJpc+HSuWyScScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069671; c=relaxed/simple;
	bh=r3pwdMfHcDuYy5oS85Sz+K3aKJVzZ0jOE3F36ZhdQxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+le/hS9Ei3ekN1K9yUmhc6ygnqiU4hz2K6NHQj653g11f5NY14x/B3f13oVlKK7lLSvzAmlu5CXkTkl2XmPrdBmHWfsTedhz/wlMqxcyxC6DyvX75iG36xiIdlvYvtOrUKHrwd5jc2heU3tVBycRgBcR7v0jVfMno6DMcf1+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgcbLlYl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77459bc5d18so4719790b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758069669; x=1758674469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L50uyacI+fKRhLJZUrl3vWKghBsXMmXrTunRinCwAxI=;
        b=PgcbLlYlBnz6CcgvGfZxjgU1c/FNO0Kq+6GVXXFfhjLSqNEBlUTSSEehMjvVmHwVZc
         UKquvYqwjydRXSQpmrfmEeMdk3/VqVYuBJnV/8M2/oLYWylxzjwSqU5n+r9Tik0djS6y
         mDuQXworGjWNWhB57QWBMz/RLhFPO/dclaqb7katLCC2hsSI04k6P0JyW8AvunvbnZv+
         MBqNunq/MRa0CK+FrSyIGfODVxKpNWAQf+RyojI0L4hOBC2zqU+eycbidK64iXiD6nf8
         MQRWsOlF4dIs62aoaG539XQAFjiDnTW1n8VzwX+TVYb7J2gfXeIz6DUFRXcgS1nuzqiE
         y0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069669; x=1758674469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L50uyacI+fKRhLJZUrl3vWKghBsXMmXrTunRinCwAxI=;
        b=gVXXNoQrBliG/WBQx9dQSZNuSXh7Mqh9tzyB+wA5NA8rnT2sDMizxAeqVshI6Jxd0E
         PfQkDFjq7qk6hMTaUhpxNCyjRD8KEMjHeLCWvsjLhIU/WQDTvyQAcAc+ofFu8buqVpJh
         hi1Hp824FXVoIbulYGc/N9OSTxCHtNAYVMRETiKed+0MGQm355XfsuD9gb2kHjubauca
         1N9bykQX/K8X5uHUTc0vEJOe8bUNtAQR6dkzVLplDz4DRnU3sAwLb/F66m4wrZHEgV9r
         1ii45FZOzfGD1U4vFzJGp3xL1/8zNGAQzpNw0rvWuJugOe/S7RuY3+rAMa01IcKtj2Gm
         Raqg==
X-Forwarded-Encrypted: i=1; AJvYcCU633O1eM2DPk55IuBPDqbcipLwjSdZvKLTzARofXUfyX6zGTjyrABjtAelJJF8UbAkrQBNOSZpIPefuByw@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZgg34i20pubtLeQOw1cZ0JdgDLOgn0NJGJ2tBHsDRVo6X2cj
	gbep+XETcx7thHDOSXhXF9uKyLNzYbgf6AoRqiKK38qHgbSPGvq07Qa4UPxReg==
X-Gm-Gg: ASbGncu2X/2DjZeBqiCmAQbPtcZ4rnX3dODMu9TgHwvswBRPJru22UtOjk7b0ycclMt
	1chCHE6AsL08wKzvnvMaod0xjIRfFvTFJ5kjKCKekejXo4OSjhrZ9/X8lvHSe/NVaJKRLXdcWWv
	MCSb3s15lzm6epVzi3R7IqvsF3+j8Oaiy1n6GNlwnF2Z6tcH6JCTeM57/kp1rEngcJhpawoCJBT
	phxfMDD7tradZl7QGOqzNxRvH25fciFi4cqE5t1FNvwRsK13UuOtXco1iQ4P8sRXrep9L1AiaDZ
	0bDsUu1VtDSemhDulEpjFi8dqBTiEZmCw66R+m1oG8giBVddVH5VFmNFgTyjsOgNj8KWVzwmg0C
	GMcgFUchjEL7QpdDC6jr9nYsgOiNzrTP/R+rkRRfmjZgIEpRP
X-Google-Smtp-Source: AGHT+IHoSQNpM6cHWoGmflIVdakvzK2cu2V9M/FTGSPEO7Lw2GW2PfNToPq1Ix6zUs9FKyxPXBa3cQ==
X-Received: by 2002:a05:6a00:3a1c:b0:76b:ec81:bcc9 with SMTP id d2e1a72fcca58-77bf936b0a9mr223134b3a.21.1758069668691;
        Tue, 16 Sep 2025 17:41:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77618a7feefsm13881984b3a.58.2025.09.16.17.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:41:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] iomap: simplify iomap_iter_advance()
Date: Tue, 16 Sep 2025 17:40:01 -0700
Message-ID: <20250917004001.2602922-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most callers of iomap_iter_advance() do not need the remaining length
returned. Get rid of the extra iomap_length() call that
iomap_iter_advance() does. If the caller wants the remaining length,
they can make the call to iomap_length().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/dax.c               | 28 ++++++++++++----------------
 fs/iomap/buffered-io.c | 16 +++++++++-------
 fs/iomap/direct-io.c   |  6 +++---
 fs/iomap/iter.c        | 14 +++++---------
 fs/iomap/seek.c        |  8 ++++----
 include/linux/iomap.h  |  6 ++----
 6 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 20ecf652c129..29e7a150b6f9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1534,7 +1534,7 @@ static int dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 	/* already zeroed?  we're done. */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
-		return iomap_iter_advance(iter, &length);
+		return iomap_iter_advance(iter, length);
 
 	/*
 	 * invalidate the pages whose sharing state is to be changed
@@ -1563,9 +1563,10 @@ static int dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (ret < 0)
 			return ret;
 
-		ret = iomap_iter_advance(iter, &length);
+		ret = iomap_iter_advance(iter, length);
 		if (ret)
 			return ret;
+		length = iomap_length(iter);
 	} while (length > 0);
 
 	if (did_zero)
@@ -1624,7 +1625,7 @@ static int dax_iomap_iter(struct iomap_iter *iomi, struct iov_iter *iter)
 
 		if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN) {
 			done = iov_iter_zero(min(length, end - pos), iter);
-			return iomap_iter_advance(iomi, &done);
+			return iomap_iter_advance(iomi, done);
 		}
 	}
 
@@ -1709,11 +1710,12 @@ static int dax_iomap_iter(struct iomap_iter *iomi, struct iov_iter *iter)
 					map_len, iter);
 
 		length = xfer;
-		ret = iomap_iter_advance(iomi, &length);
+		ret = iomap_iter_advance(iomi, length);
 		if (!ret && xfer == 0)
 			ret = -EFAULT;
 		if (xfer < map_len)
 			break;
+		length = iomap_length(iomi);
 	}
 	dax_read_unlock(id);
 
@@ -1946,10 +1948,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			ret |= VM_FAULT_MAJOR;
 		}
 
-		if (!(ret & VM_FAULT_ERROR)) {
-			u64 length = PAGE_SIZE;
-			iter.status = iomap_iter_advance(&iter, &length);
-		}
+		if (!(ret & VM_FAULT_ERROR))
+			iter.status = iomap_iter_advance(&iter, PAGE_SIZE);
 	}
 
 	if (iomap_errp)
@@ -2061,10 +2061,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			continue; /* actually breaks out of the loop */
 
 		ret = dax_fault_iter(vmf, &iter, pfnp, &xas, &entry, true);
-		if (ret != VM_FAULT_FALLBACK) {
-			u64 length = PMD_SIZE;
-			iter.status = iomap_iter_advance(&iter, &length);
-		}
+		if (ret != VM_FAULT_FALLBACK)
+			iter.status = iomap_iter_advance(&iter, PMD_SIZE);
 	}
 
 unlock_entry:
@@ -2190,7 +2188,6 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	const struct iomap *smap = &it_src->iomap;
 	const struct iomap *dmap = &it_dest->iomap;
 	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
-	u64 dest_len;
 	void *saddr, *daddr;
 	int id, ret;
 
@@ -2223,10 +2220,9 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	dax_read_unlock(id);
 
 advance:
-	dest_len = len;
-	ret = iomap_iter_advance(it_src, &len);
+	ret = iomap_iter_advance(it_src, len);
 	if (!ret)
-		ret = iomap_iter_advance(it_dest, &dest_len);
+		ret = iomap_iter_advance(it_dest, len);
 	return ret;
 
 out_unlock:
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..fe6588ab0922 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -373,7 +373,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		ret = iomap_read_inline_data(iter, folio);
 		if (ret)
 			return ret;
-		return iomap_iter_advance(iter, &length);
+		return iomap_iter_advance(iter, length);
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
@@ -434,7 +434,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	 * iteration.
 	 */
 	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, &length);
+	return iomap_iter_advance(iter, length);
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
@@ -1036,7 +1036,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 			}
 		} else {
 			total_written += written;
-			iomap_iter_advance(iter, &written);
+			iomap_iter_advance(iter, written);
 		}
 	} while (iov_iter_count(i) && iomap_length(iter));
 
@@ -1305,7 +1305,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 	int status;
 
 	if (!iomap_want_unshare_iter(iter))
-		return iomap_iter_advance(iter, &bytes);
+		return iomap_iter_advance(iter, bytes);
 
 	do {
 		struct folio *folio;
@@ -1329,9 +1329,10 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 
 		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
 
-		status = iomap_iter_advance(iter, &bytes);
+		status = iomap_iter_advance(iter, bytes);
 		if (status)
 			break;
+		bytes = iomap_length(iter);
 	} while (bytes > 0);
 
 	return status;
@@ -1404,9 +1405,10 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-		status = iomap_iter_advance(iter, &bytes);
+		status = iomap_iter_advance(iter, bytes);
 		if (status)
 			break;
+		bytes = iomap_length(iter);
 	} while (bytes > 0);
 
 	if (did_zero)
@@ -1518,7 +1520,7 @@ static int iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 		folio_mark_dirty(folio);
 	}
 
-	return iomap_iter_advance(iter, &length);
+	return iomap_iter_advance(iter, length);
 }
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b84f6af2eb4c..e3544a6719a7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -496,7 +496,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	/* Undo iter limitation to current extent */
 	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
 	if (copied)
-		return iomap_iter_advance(iter, &copied);
+		return iomap_iter_advance(iter, copied);
 	return ret;
 }
 
@@ -507,7 +507,7 @@ static int iomap_dio_hole_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	dio->size += length;
 	if (!length)
 		return -EFAULT;
-	return iomap_iter_advance(iter, &length);
+	return iomap_iter_advance(iter, length);
 }
 
 static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
@@ -539,7 +539,7 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
 	dio->size += copied;
 	if (!copied)
 		return -EFAULT;
-	return iomap_iter_advance(iomi, &copied);
+	return iomap_iter_advance(iomi, copied);
 }
 
 static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index cef77ca0c20b..91d2024e00da 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -13,17 +13,13 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
 	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
 }
 
-/*
- * Advance the current iterator position and output the length remaining for the
- * current mapping.
- */
-int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
+/* Advance the current iterator position and decrement the remaining length */
+int iomap_iter_advance(struct iomap_iter *iter, u64 count)
 {
-	if (WARN_ON_ONCE(*count > iomap_length(iter)))
+	if (WARN_ON_ONCE(count > iomap_length(iter)))
 		return -EIO;
-	iter->pos += *count;
-	iter->len -= *count;
-	*count = iomap_length(iter);
+	iter->pos += count;
+	iter->len -= count;
 	return 0;
 }
 
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 56db2dd4b10d..6cbc587c93da 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -16,13 +16,13 @@ static int iomap_seek_hole_iter(struct iomap_iter *iter,
 		*hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
 				iter->pos, iter->pos + length, SEEK_HOLE);
 		if (*hole_pos == iter->pos + length)
-			return iomap_iter_advance(iter, &length);
+			return iomap_iter_advance(iter, length);
 		return 0;
 	case IOMAP_HOLE:
 		*hole_pos = iter->pos;
 		return 0;
 	default:
-		return iomap_iter_advance(iter, &length);
+		return iomap_iter_advance(iter, length);
 	}
 }
 
@@ -59,12 +59,12 @@ static int iomap_seek_data_iter(struct iomap_iter *iter,
 
 	switch (iter->iomap.type) {
 	case IOMAP_HOLE:
-		return iomap_iter_advance(iter, &length);
+		return iomap_iter_advance(iter, length);
 	case IOMAP_UNWRITTEN:
 		*hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
 				iter->pos, iter->pos + length, SEEK_DATA);
 		if (*hole_pos < 0)
-			return iomap_iter_advance(iter, &length);
+			return iomap_iter_advance(iter, length);
 		return 0;
 	default:
 		*hole_pos = iter->pos;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..4469b2318b08 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -245,7 +245,7 @@ struct iomap_iter {
 };
 
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
-int iomap_iter_advance(struct iomap_iter *iter, u64 *count);
+int iomap_iter_advance(struct iomap_iter *iter, u64 count);
 
 /**
  * iomap_length_trim - trimmed length of the current iomap iteration
@@ -282,9 +282,7 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
  */
 static inline int iomap_iter_advance_full(struct iomap_iter *iter)
 {
-	u64 length = iomap_length(iter);
-
-	return iomap_iter_advance(iter, &length);
+	return iomap_iter_advance(iter, iomap_length(iter));
 }
 
 /**
-- 
2.47.3


