Return-Path: <linux-fsdevel+bounces-57672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697F3B245A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E456849B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1379A2F7446;
	Wed, 13 Aug 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BKf0/QlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4292F28E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077934; cv=none; b=aEJ9jfJ394C4joxDHpyCqBiaLRn0Ap583yRCK5yxwxAmmovARlTCyImWGUiFgBg+kJshkSu5MYePEarCxG6oRYwBJ1J43heOljhg00Aq9C6qkCBZUXEAObWVOMIe6JU+EIclA4f0Q3YaebaPlC2lNHa52/JNtnmshg0KZbMgEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077934; c=relaxed/simple;
	bh=MY08B+cUlvfBZyb6Dy1hscwDCqHgtltO7YPxqsxTHNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ae6soCTI7VFd6jLGh7l26Q9yivvTrYII7ktqJUf/enV31N8RnEVUV2ZZ5hiv4klpJKMmFoFdoeMbHMpVYOzWvn/PjlrysOr6QhMgTkAhh5Zvnr4gQqjZbOfdVJOBkS0oeLa8xeZXVqdtZ23TOh4FbsWm0CTuebVRvJ97jVn2Lbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BKf0/QlO; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bO
	NKsUC7ZrwOatI+C3p8fv5cu28QuxUoAhI9QsXEo/Q=; b=BKf0/QlOsu/D4kuwsc
	9H6ksDtavdGeTxPefWpcM7CL75Uql0QMB7cJ7e09jshJlEKTHaeOVffPtnelzHmt
	D2VgSBFolHNNK1KzByOMoK6jW5rx7EZpz5aHEoq3TZokqyCQ6wv2l262hiQjFxq8
	YmHhA9e94pznjDfUv9zUQFQro=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3tyv8XJxo_MzyBQ--.54250S4;
	Wed, 13 Aug 2025 17:38:22 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [RFC PATCH 2/9] f2fs: Integrate f2fs_iomap_folio_state into f2fs page private helpers
Date: Wed, 13 Aug 2025 17:37:48 +0800
Message-Id: <20250813093755.47599-3-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813093755.47599-1-nzzhao@126.com>
References: <20250813093755.47599-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3tyv8XJxo_MzyBQ--.54250S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFWrKrW3GFW5Zw4fuF1Utrb_yoW8Jr4fto
	WFgr42g3W8ur43JrW2kr1UXa4DZF1Yyr1xtF93ZF4kZFnrAasrWFW29r4DJa4xCr15GFy7
	Zan7Xa12kFW3X3Wxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjWlkDUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiEwOoz2icVjth3AAAsT

Integrate f2fs_iomap_folio_state into the f2fs page private helper
functions.

In these functions, we adopt a two-stage strategy to handle the
folio->private field, now supporting both direct bit flags and the
new f2fs_iomap_folio_state pointer.

Note that my implementation does not rely on checking the folio's
order to distinguish whether the folio's private field stores
a flag or an f2fs_iomap_folio_state.
This is because in the folio_set_f2fs_xxx
functions, we will forcibly allocate an f2fs_iomap_folio_state
struct even for order-0 folios under certain conditions.

The reason for doing this is that if an order-0 folio's private field
is set to an f2fs private flag by a thread like gc, the generic
iomap_folio_state helper functions used in iomap buffered write will
mistakenly interpret it as an iomap_folio_state pointer.
We cannot, or rather should not, modify fs/iomap to make it recognize
f2fs's private flags.
Therefore, for now, I have to uniformly allocate an
f2fs_iomap_folio_state for all folios that will need to store an
f2fs private flag to ensure correctness.

I am also thinking about other ways to eliminate the extra memory
overhead this approach introduces. Suggestions would be grateful.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/f2fs.h | 278 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 225 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8df0443dd189..a14bef4dc394 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -27,7 +27,10 @@
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
-
+#include <linux/iomap.h>
+#ifdef CONFIG_F2FS_IOMAP_FOLIO_STATE
+#include "f2fs_ifs.h"
+#endif
 struct pagevec;
 
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -2509,58 +2512,227 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return -ENOSPC;
 }
 
-#define PAGE_PRIVATE_GET_FUNC(name, flagname) \
-static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
-{									\
-	unsigned long priv = (unsigned long)folio->private;		\
-	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
-			     (1UL << PAGE_PRIVATE_##flagname);		\
-	return (priv & v) == v;						\
-}									\
-static inline bool page_private_##name(struct page *page) \
-{ \
-	return PagePrivate(page) && \
-		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
-		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-}
-
-#define PAGE_PRIVATE_SET_FUNC(name, flagname) \
-static inline void folio_set_f2fs_##name(struct folio *folio)		\
-{									\
-	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
-			     (1UL << PAGE_PRIVATE_##flagname);		\
-	if (!folio->private)						\
-		folio_attach_private(folio, (void *)v);			\
-	else {								\
-		v |= (unsigned long)folio->private;			\
-		folio->private = (void *)v;				\
-	}								\
-}									\
-static inline void set_page_private_##name(struct page *page) \
-{ \
-	if (!PagePrivate(page)) \
-		attach_page_private(page, (void *)0); \
-	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
-	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-}
-
-#define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
-static inline void folio_clear_f2fs_##name(struct folio *folio)		\
-{									\
-	unsigned long v = (unsigned long)folio->private;		\
-									\
-	v &= ~(1UL << PAGE_PRIVATE_##flagname);				\
-	if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))			\
-		folio_detach_private(folio);				\
-	else								\
-		folio->private = (void *)v;				\
-}									\
-static inline void clear_page_private_##name(struct page *page) \
-{ \
-	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
-		detach_page_private(page); \
+extern bool f2fs_should_use_buffered_iomap(struct inode *inode);
+#ifdef CONFIG_F2FS_IOMAP_FOLIO_STATE
+#define F2FS_FOLIO_PRIVATE_GET_FUNC(name, flagname)                            \
+	static inline bool folio_test_f2fs_##name(const struct folio *folio)   \
+	{                                                                      \
+		/* First try direct folio->private access for meta folio */    \
+		if (folio_test_private(folio) &&                               \
+		    test_bit(PAGE_PRIVATE_NOT_POINTER,                         \
+			     (unsigned long *)&folio->private)) {              \
+			return test_bit(PAGE_PRIVATE_##flagname,               \
+					(unsigned long *)&folio->private);     \
+		}                                                              \
+		/* For higher-order folios, use iomap folio state */           \
+		struct f2fs_iomap_folio_state *fifs =                          \
+			(struct f2fs_iomap_folio_state *)folio->private;       \
+		unsigned long *private_p;                                      \
+		if (unlikely(!fifs || !folio->mapping))                        \
+			return false;                                          \
+		/* Check magic number before accessing private data */         \
+		if (READ_ONCE(fifs->read_bytes_pending) != F2FS_IFS_MAGIC)     \
+			return false;                                          \
+		private_p = f2fs_ifs_private_flags_ptr(fifs, folio);           \
+		if (!private_p)                                                \
+			return false;                                          \
+		/* Test bits directly on the 'private' slot */                 \
+		return test_bit(PAGE_PRIVATE_##flagname, private_p);           \
+	}                                                                      \
+	static inline bool page_private_##name(struct page *page)              \
+	{                                                                      \
+		return PagePrivate(page) &&                                    \
+		       test_bit(PAGE_PRIVATE_NOT_POINTER,                      \
+				&page_private(page)) &&                        \
+		       test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
+	}
+#define F2FS_FOLIO_PRIVATE_SET_FUNC(name, flagname)                              \
+	static inline int folio_set_f2fs_##name(struct folio *folio)             \
+	{                                                                        \
+		/* For higher-order folios, use iomap folio state */             \
+		if (unlikely(!folio->mapping))                                   \
+			return -ENOENT;                                          \
+		bool force_alloc =                                               \
+			f2fs_should_use_buffered_iomap(folio_inode(folio));      \
+		if (!force_alloc && !folio_test_private(folio)) {                \
+			folio_attach_private(folio, (void *)0);                  \
+			set_bit(PAGE_PRIVATE_NOT_POINTER,                        \
+				(unsigned long *)&folio->private);               \
+			set_bit(PAGE_PRIVATE_##flagname,                         \
+				(unsigned long *)&folio->private);               \
+			return 0;                                                \
+		}                                                                \
+		struct f2fs_iomap_folio_state *fifs =                            \
+			f2fs_ifs_alloc(folio, GFP_NOFS, true);                   \
+		if (unlikely(!fifs))                                             \
+			return -ENOMEM;                                          \
+		unsigned long *private_p;                                        \
+		WRITE_ONCE(fifs->read_bytes_pending, F2FS_IFS_MAGIC);            \
+		private_p = f2fs_ifs_private_flags_ptr(fifs, folio);             \
+		if (!private_p)                                                  \
+			return -EINVAL;                                          \
+		/* Set the bit atomically */                                     \
+		set_bit(PAGE_PRIVATE_##flagname, private_p);                     \
+		/* Ensure NOT_POINTER bit is also set if any F2FS flag is set */ \
+		if (PAGE_PRIVATE_##flagname != PAGE_PRIVATE_NOT_POINTER)         \
+			set_bit(PAGE_PRIVATE_NOT_POINTER, private_p);            \
+		return 0;                                                        \
+	}                                                                        \
+	static inline void set_page_private_##name(struct page *page)            \
+	{                                                                        \
+		if (!PagePrivate(page))                                          \
+			attach_page_private(page, (void *)0);                    \
+		set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));          \
+		set_bit(PAGE_PRIVATE_##flagname, &page_private(page));           \
+	}
+
+#define F2FS_FOLIO_PRIVATE_CLEAR_FUNC(name, flagname)                      \
+	static inline void folio_clear_f2fs_##name(struct folio *folio)    \
+	{                                                                  \
+		/* First try direct folio->private access */               \
+		if (folio_test_private(folio) &&                           \
+		    test_bit(PAGE_PRIVATE_NOT_POINTER,                     \
+			     (unsigned long *)&folio->private)) {          \
+			clear_bit(PAGE_PRIVATE_##flagname,                 \
+				  (unsigned long *)&folio->private);       \
+			folio_detach_private(folio);                       \
+			return;                                            \
+		}                                                          \
+		/* For higher-order folios, use iomap folio state */       \
+		struct f2fs_iomap_folio_state *fifs =                      \
+			(struct f2fs_iomap_folio_state *)folio->private;   \
+		unsigned long *private_p;                                  \
+		if (unlikely(!fifs || !folio->mapping))                    \
+			return;                                            \
+		/* Check magic number before clearing */                   \
+		if (READ_ONCE(fifs->read_bytes_pending) != F2FS_IFS_MAGIC) \
+			return; /* Not ours or state unclear */            \
+		private_p = f2fs_ifs_private_flags_ptr(fifs, folio);       \
+		if (!private_p)                                            \
+			return;                                            \
+		clear_bit(PAGE_PRIVATE_##flagname, private_p);             \
+	}                                                                  \
+	static inline void clear_page_private_##name(struct page *page)    \
+	{                                                                  \
+		clear_bit(PAGE_PRIVATE_##flagname, &page_private(page));   \
+		if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))   \
+			detach_page_private(page);                         \
+	}
+// Generate the accessor functions using the macros
+F2FS_FOLIO_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
+F2FS_FOLIO_PRIVATE_GET_FUNC(inline, INLINE_INODE);
+F2FS_FOLIO_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
+F2FS_FOLIO_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
+F2FS_FOLIO_PRIVATE_GET_FUNC(reference, REF_RESOURCE);
+
+F2FS_FOLIO_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
+F2FS_FOLIO_PRIVATE_SET_FUNC(inline, INLINE_INODE);
+F2FS_FOLIO_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
+F2FS_FOLIO_PRIVATE_SET_FUNC(atomic, ATOMIC_WRITE);
+
+F2FS_FOLIO_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
+F2FS_FOLIO_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
+F2FS_FOLIO_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
+F2FS_FOLIO_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
+static inline int folio_set_f2fs_data(struct folio *folio, unsigned long data)
+{
+	if (unlikely(!folio->mapping))
+		return -ENOENT;
+
+	struct f2fs_iomap_folio_state *fifs =
+		f2fs_ifs_alloc(folio, GFP_NOFS, true);
+	if (unlikely(!fifs))
+		return -ENOMEM;
+
+	unsigned long *private_p;
+
+	private_p = f2fs_ifs_private_flags_ptr(fifs, folio);
+	if (!private_p)
+		return -EINVAL;
+
+	*private_p &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
+	*private_p |= (data << PAGE_PRIVATE_MAX);
+	set_bit(PAGE_PRIVATE_NOT_POINTER, private_p);
+
+	return 0;
 }
+static inline unsigned long folio_get_f2fs_data(struct folio *folio)
+{
+	struct f2fs_iomap_folio_state *fifs =
+		(struct f2fs_iomap_folio_state *)folio->private;
+	unsigned long *private_p;
+	unsigned long data_val;
+
+	if (!folio->mapping)
+		return 0;
+	f2fs_bug_on(F2FS_I_SB(folio_inode(folio)), !fifs);
+	if (READ_ONCE(fifs->read_bytes_pending) != F2FS_IFS_MAGIC)
+		return 0;
+
+	private_p = f2fs_ifs_private_flags_ptr(fifs, folio);
+	if (!private_p)
+		return 0;
+
+	data_val = READ_ONCE(*private_p);
+
+	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data_val))
+		return 0;
+
+	return data_val >> PAGE_PRIVATE_MAX;
+}
+#else
+#define PAGE_PRIVATE_GET_FUNC(name, flagname)                                  \
+	static inline bool folio_test_f2fs_##name(const struct folio *folio)   \
+	{                                                                      \
+		unsigned long priv = (unsigned long)folio->private;            \
+		unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |          \
+				  (1UL << PAGE_PRIVATE_##flagname);            \
+		return (priv & v) == v;                                        \
+	}                                                                      \
+	static inline bool page_private_##name(struct page *page)              \
+	{                                                                      \
+		return PagePrivate(page) &&                                    \
+		       test_bit(PAGE_PRIVATE_NOT_POINTER,                      \
+				&page_private(page)) &&                        \
+		       test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
+	}
+
+#define PAGE_PRIVATE_SET_FUNC(name, flagname)                           \
+	static inline void folio_set_f2fs_##name(struct folio *folio)   \
+	{                                                               \
+		unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |   \
+				  (1UL << PAGE_PRIVATE_##flagname);     \
+		if (!folio->private)                                    \
+			folio_attach_private(folio, (void *)v);         \
+		else {                                                  \
+			v |= (unsigned long)folio->private;             \
+			folio->private = (void *)v;                     \
+		}                                                       \
+	}                                                               \
+	static inline void set_page_private_##name(struct page *page)   \
+	{                                                               \
+		if (!PagePrivate(page))                                 \
+			attach_page_private(page, (void *)0);           \
+		set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
+		set_bit(PAGE_PRIVATE_##flagname, &page_private(page));  \
+	}
+
+#define PAGE_PRIVATE_CLEAR_FUNC(name, flagname)                          \
+	static inline void folio_clear_f2fs_##name(struct folio *folio)  \
+	{                                                                \
+		unsigned long v = (unsigned long)folio->private;         \
+		v &= ~(1UL << PAGE_PRIVATE_##flagname);                  \
+		if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))              \
+			folio_detach_private(folio);                     \
+		else                                                     \
+			folio->private = (void *)v;                      \
+	}                                                                \
+	static inline void clear_page_private_##name(struct page *page)  \
+	{                                                                \
+		clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
+		if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
+			detach_page_private(page);                       \
+	}
 
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
 PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
@@ -2595,7 +2767,7 @@ static inline void folio_set_f2fs_data(struct folio *folio, unsigned long data)
 	else
 		folio->private = (void *)((unsigned long)folio->private | data);
 }
-
+#endif
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,
 						block_t count)
-- 
2.34.1


