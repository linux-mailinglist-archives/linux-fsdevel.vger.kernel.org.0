Return-Path: <linux-fsdevel+bounces-62263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F1B8B62F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 23:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E8516B7BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A32D374D;
	Fri, 19 Sep 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhPHqaeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15226B76A
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318259; cv=none; b=kIlZ8f3Q9EMBTEeMSuTygF2e/IPiFOu3nnUdY06lJgd3TR9XJ8k5WxKMFaANYBOGhIX8ql+31UnoZIdn3vTXNGZlrsBneHGbaCxFDGcqdWdJgmn9zFKIlh591szaprp1mAUrIcDYa0yA/ECtMSK9QsEt2aqBlVv8CNu/gT0FkyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318259; c=relaxed/simple;
	bh=dzfLM/82+JxX9V2WeG5Z7WbY5zSyeHOs5SzYw+9rdWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1u/2MvadKNYuD2NHqpdLLWzxGyUeboZkUAStBGaUmO9u8SKKfJ8rtpl7MUiH+gdHiD/SSoBKkA/6qnTM85IOOnquLoZYgCZQpZVXRn0YA/l+Evciz+gPUQBdledRa0dy8ziL3+wAduLcg86bZd+Gn3+Q91bJUtxinNg3iHDvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhPHqaeb; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b551b040930so695970a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758318257; x=1758923057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3gOft1CQ8ZEnAwSpPiegFF6d8oz+KFXcTmKlmNsfto=;
        b=jhPHqaeb/oInoNS0qjbE8uFA0R7Rt7+v4n7/ejKX1wSBTW949u/ZWxVkvoJhrbS5Iu
         msRerntgF9wfqLdoonNMB+BIVX0WmDBii0c//J6V3jixye8CHuM6oJB6KN/A9lQjLLwb
         d/o9FMm7mM37rAc5Lw6RVwjmTavN5gbZSxLQSen4z3pGsvi9Sryv6cn52nQc9tBzHlKH
         DIfDyMiTAo/St3qJxm9EGfn08v1GHlGMa1+1M/QOFMZ653NIuLPpNhtBqpvGXoGdeD/h
         qHGQwcTw/npmsZk9xR2tBMoMHOMHl5h7JiOEDb9kib4u7PjVOQbqqH3DG4GSZo0t3nNA
         z95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758318257; x=1758923057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3gOft1CQ8ZEnAwSpPiegFF6d8oz+KFXcTmKlmNsfto=;
        b=Glm5hVe9ZRbt9u4uobAqfqVeK2/FPvdGCEhmU59BWm0XyD/T8w7zaIDBQNDzI1jIGL
         6+7sXi9MAQ7gIHtwhdYgbpAf7Nxnlr9YLdo6iE2Z/Z+qzCqRPgh0EDaX+S5/SvXFZFDf
         ZT88BKVga5MqF7KHkKrUttqQFZbaCkSEwPB9OW5EH8JrcAeYw8+/l9okxUqxxzQXJTog
         edjFBnk74acQJVyHkrSaIWkBeJsxxr8OBe2yrRGKmL6ROjGKPvhztEJqTRD9MFy0AMz2
         B+z2LfUdGm7sUt8YyeVxL5QiwCdjn7jTuoc3zWjqE6VXgjNptcplNbIHcgzMPXSfVUVW
         Zr2A==
X-Forwarded-Encrypted: i=1; AJvYcCXX/FFKSmT080sbsVzFav2QiWaX7U2nYxoIzOFqGqeUlhDH7Pma8vyoOQVgbjwEch7vg1v9HqU3xAQ6dVFn@vger.kernel.org
X-Gm-Message-State: AOJu0YxFySrtTIiH6NGwfJd1yeP16VL3no8sLh2WOQKJ+0tg34nm9xE7
	BM80O9XmgQG7jG80v/6L5H8hl4t73ltL+2EE7fQEnlB3Gs7TcEhdgj2Z
X-Gm-Gg: ASbGncvzrhaBikQtZNOUb7C9W4O2FTWX43ENfP59luEijXPt1tQgDwaX0Lgu3G1biRA
	GJ54SpIVW6OgZn3JucliVsA8QS+NaNxMwkDFWZFriwlN2H1H6Camk+vsSaI6Q3mV9rKsT0kAt9J
	fMiUDcvraP1AOs9hzVaCOz6ISGyJWlWnziyOOL9QW54tcmGwT1lIxnK1bzypv+X+QM9USRq21og
	teg4as6L6CN3tTdaxKG9AosdZ7VqbkMhUJH5O13kK7MixLPdWzrHS6QednV/kPNiGs7IzbIvM27
	gEr2riItovaPNA/Kvl4/HZu6aoEXQHFgPWxe2F7V0FnYY9Qa4ljs2nPcLPAgbf8NKn1gqKfBpyQ
	nA6RO4NRd030IpjalG3CDF6Neb5TlLZmz0yPakZBjvU5GkHZHwGLOV/yN
X-Google-Smtp-Source: AGHT+IE5lKsgNP+6i0AqceL/mh+GjClgKv34vusumIwtkS3yPLQ8bxBvFolt/deCdINCwKQXcEo14g==
X-Received: by 2002:a17:90b:288f:b0:32b:d8af:b636 with SMTP id 98e67ed59e1d1-330983570demr5628799a91.19.1758318257369;
        Fri, 19 Sep 2025 14:44:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306085c115sm6270063a91.27.2025.09.19.14.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 14:44:17 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] iomap: simplify iomap_iter_advance()
Date: Fri, 19 Sep 2025 14:42:50 -0700
Message-ID: <20250919214250.4144807-1-joannelkoong@gmail.com>
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
iomap_iter_advance() does.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 fs/dax.c               | 30 ++++++++++++------------------
 fs/iomap/buffered-io.c | 18 +++++++++---------
 fs/iomap/direct-io.c   |  6 +++---
 fs/iomap/iter.c        | 14 +++++---------
 fs/iomap/seek.c        |  8 ++++----
 include/linux/iomap.h  |  6 ++----
 6 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 20ecf652c129..039ad6c3c2b1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1534,7 +1534,7 @@ static int dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 	/* already zeroed?  we're done. */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
-		return iomap_iter_advance(iter, &length);
+		return iomap_iter_advance(iter, length);
 
 	/*
 	 * invalidate the pages whose sharing state is to be changed
@@ -1563,10 +1563,10 @@ static int dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (ret < 0)
 			return ret;
 
-		ret = iomap_iter_advance(iter, &length);
+		ret = iomap_iter_advance(iter, length);
 		if (ret)
 			return ret;
-	} while (length > 0);
+	} while ((length = iomap_length(iter)) > 0);
 
 	if (did_zero)
 		*did_zero = true;
@@ -1624,7 +1624,7 @@ static int dax_iomap_iter(struct iomap_iter *iomi, struct iov_iter *iter)
 
 		if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN) {
 			done = iov_iter_zero(min(length, end - pos), iter);
-			return iomap_iter_advance(iomi, &done);
+			return iomap_iter_advance(iomi, done);
 		}
 	}
 
@@ -1708,12 +1708,12 @@ static int dax_iomap_iter(struct iomap_iter *iomi, struct iov_iter *iter)
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 
-		length = xfer;
-		ret = iomap_iter_advance(iomi, &length);
+		ret = iomap_iter_advance(iomi, xfer);
 		if (!ret && xfer == 0)
 			ret = -EFAULT;
 		if (xfer < map_len)
 			break;
+		length = iomap_length(iomi);
 	}
 	dax_read_unlock(id);
 
@@ -1946,10 +1946,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, unsigned long *pfnp,
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
@@ -2061,10 +2059,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
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
@@ -2190,7 +2186,6 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	const struct iomap *smap = &it_src->iomap;
 	const struct iomap *dmap = &it_dest->iomap;
 	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
-	u64 dest_len;
 	void *saddr, *daddr;
 	int id, ret;
 
@@ -2223,10 +2218,9 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
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
index 8b847a1e27f1..6cc2ee44bbca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -376,7 +376,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		ret = iomap_read_inline_data(iter, folio);
 		if (ret)
 			return ret;
-		return iomap_iter_advance(iter, &length);
+		return iomap_iter_advance(iter, length);
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
@@ -437,7 +437,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	 * iteration.
 	 */
 	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, &length);
+	return iomap_iter_advance(iter, length);
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
@@ -1041,7 +1041,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 			}
 		} else {
 			total_written += written;
-			iomap_iter_advance(iter, &written);
+			iomap_iter_advance(iter, written);
 		}
 	} while (iov_iter_count(i) && iomap_length(iter));
 
@@ -1310,7 +1310,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 	int status;
 
 	if (!iomap_want_unshare_iter(iter))
-		return iomap_iter_advance(iter, &bytes);
+		return iomap_iter_advance(iter, bytes);
 
 	do {
 		struct folio *folio;
@@ -1334,10 +1334,10 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 
 		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
 
-		status = iomap_iter_advance(iter, &bytes);
+		status = iomap_iter_advance(iter, bytes);
 		if (status)
 			break;
-	} while (bytes > 0);
+	} while ((bytes = iomap_length(iter)) > 0);
 
 	return status;
 }
@@ -1412,10 +1412,10 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-		status = iomap_iter_advance(iter, &bytes);
+		status = iomap_iter_advance(iter, bytes);
 		if (status)
 			break;
-	} while (bytes > 0);
+	} while ((bytes = iomap_length(iter)) > 0);
 
 	if (did_zero)
 		*did_zero = true;
@@ -1526,7 +1526,7 @@ static int iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 		folio_mark_dirty(folio);
 	}
 
-	return iomap_iter_advance(iter, &length);
+	return iomap_iter_advance(iter, length);
 }
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 46aa85af13dc..ec8e7a26c9ab 100644
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
@@ -542,7 +542,7 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
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


