Return-Path: <linux-fsdevel+bounces-64641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3FBEF10A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17DB74E5903
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718E238C1A;
	Mon, 20 Oct 2025 02:13:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027522A1D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926392; cv=none; b=jmVuZaH/fT98GtwGQELHLBVyPEeWfJgS7TESE6h5FtaSfNizsqGpJbM8yNI9SpfBtwqu8BN3FGGIeukPfGbkYjpxHkbCDVlVe/eZpqVrDIvY/la7ucMzMn9ATbRG49fo2IPOOx1kCnj3CrQHz3z0qVGQFg5mhUALyR5QugYbs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926392; c=relaxed/simple;
	bh=oxDLEVFLZpBbno7jG3Vs98iWsS6qa6EpHmbRnMsqABI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2/JJ7RQaNuJCMdob9oQg+AhdkKYUSkn/9NiVQj7kSbQ0+dV4pUjuukNuALD6C+YhBWIgUzS9px3CEKRqxazhJvI8UqXGC+dYDq/4d1hKzlydu6lg+foE80IYDNRdRnOMlhBmSrFaL4hOydLCAor/ccpP+kFqJLO2wrraG+nwE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so2400256a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926377; x=1761531177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Wd6hyOYL65CPeUMDWo/9Rstkx1Rjpe8yQSHQMBxqYE=;
        b=Vuf4lYyi9lL3mMvDnYST6AvIODsFkw4yYFREyc5//E53SVrfvip4bR2yuvaS2ezpL5
         x2p635J3XLCvsnnWotxhP6pXzlr4ioGS8RVlOXNlMZJh493FEejXolBY4fdNbQaveiaC
         UQI4nbXwGkFzRbE6RDj1op3Y9mDSD45o5jvAQT3DenAMV+05pRdcEtXu4DyVhYr7cgFi
         vhFLqihCvTkoG1Sc+jy2VQb5a7BQeqqux75sTjCY6iiA4DFHVUYLG60I0mMtMtGp2njO
         jRhzpm3NZSl9YeBSg/lJoaaZH/GfKx8yM86hPHUyYYj58e3zo4qVC+VY9O+UVtTRw+Kd
         dPfA==
X-Gm-Message-State: AOJu0YyL+d4LUbcvl/sj2zL27VsTnXlnBipEJEopeaW+yfNyQW3HAMsD
	sG6jfElc/HnS0ou3K5fec4jFDOdsYNplYQfZs+mFcqscgbUUJd2dkfVV
X-Gm-Gg: ASbGncsspKk3LnP1YX1QI7AX+IHoij6ISSWseaeaMRMg736gW+PkZ6X46Zm+3WvjYgn
	6aCF0nPwYbSRPLefOSrgTljp7vNxudAboNHwQszto9B36J7jqeLu5kHwD4/pCs+Jnc81k55Lf50
	ElKx8BkHLlu9+P0LdMWAXApgvWgvmbseVdyZ+l12zdYjfv5egodyX/AiDYBmucePXhghFGRSrhr
	23C6ssaQx2SmzP8CIINCMzS3zbDi8gQRO1vvCHN+CxC/BxvSI2j7dcarqm0oCTkE53ouYUUH7Q0
	wU/O9Yivsanxr4g1GSevoAB0uOwGnAXt/8jvIYY5XP6OUFYRXQqEdHn5jtfFoVaP9+UqHix6LjO
	c5z9gIg5wdQa4pbtBTIYS47AOBa71hyYulby5EvC4xT7j5a7WjYQbfQUQ82SHvHAt/P2wpgEArf
	PQGuQYnKhhglCh+5R13xTFEicj3w==
X-Google-Smtp-Source: AGHT+IFzQNRTXyEYqmXh4fuGYhHD6DIEo+w4/lzwsheOYf9amfTzYRXDybdINVQRj3uUrderQ9dn6g==
X-Received: by 2002:a17:902:ce8c:b0:25c:392c:33be with SMTP id d9443c01a7336-290cba4dbc0mr157352825ad.59.1760926375642;
        Sun, 19 Oct 2025 19:12:55 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a764508b0sm6406849a12.0.2025.10.19.19.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:12:54 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 07/11] ntfsplus: add attrib operatrions
Date: Mon, 20 Oct 2025 11:12:23 +0900
Message-Id: <20251020021227.5965-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251020021227.5965-1-linkinjeon@kernel.org>
References: <20251020021227.5965-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the implementation of attrib operatrions for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/attrib.c   | 5373 ++++++++++++++++++++++++++++++++++++++++
 fs/ntfsplus/attrlist.c |  276 +++
 fs/ntfsplus/compress.c | 1565 ++++++++++++
 3 files changed, 7214 insertions(+)
 create mode 100644 fs/ntfsplus/attrib.c
 create mode 100644 fs/ntfsplus/attrlist.c
 create mode 100644 fs/ntfsplus/compress.c

diff --git a/fs/ntfsplus/attrib.c b/fs/ntfsplus/attrib.c
new file mode 100644
index 000000000000..ba309d1acdcb
--- /dev/null
+++ b/fs/ntfsplus/attrib.c
@@ -0,0 +1,5373 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * NTFS attribute operations. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ * and is copyrighted by the respective authors below:
+ * Copyright (c) 2000-2010 Anton Altaparmakov
+ * Copyright (c) 2002-2005 Richard Russon
+ * Copyright (c) 2002-2008 Szabolcs Szakacsits
+ * Copyright (c) 2004-2007 Yura Pakhuchiy
+ * Copyright (c) 2007-2021 Jean-Pierre Andre
+ * Copyright (c) 2010 Erik Larsson
+ */
+
+#include <linux/writeback.h>
+#include <linux/iomap.h>
+
+#include "attrib.h"
+#include "attrlist.h"
+#include "lcnalloc.h"
+#include "misc.h"
+#include "mft.h"
+#include "ntfs.h"
+#include "aops.h"
+#include "ntfs_iomap.h"
+
+__le16 AT_UNNAMED[] = { cpu_to_le16('\0') };
+
+/**
+ * ntfs_map_runlist_nolock - map (a part of) a runlist of an ntfs inode
+ * @ni:		ntfs inode for which to map (part of) a runlist
+ * @vcn:	map runlist part containing this vcn
+ * @ctx:	active attribute search context if present or NULL if not
+ *
+ * Map the part of a runlist containing the @vcn of the ntfs inode @ni.
+ *
+ * If @ctx is specified, it is an active search context of @ni and its base mft
+ * record.  This is needed when ntfs_map_runlist_nolock() encounters unmapped
+ * runlist fragments and allows their mapping.  If you do not have the mft
+ * record mapped, you can specify @ctx as NULL and ntfs_map_runlist_nolock()
+ * will perform the necessary mapping and unmapping.
+ *
+ * Note, ntfs_map_runlist_nolock() saves the state of @ctx on entry and
+ * restores it before returning.  Thus, @ctx will be left pointing to the same
+ * attribute on return as on entry.  However, the actual pointers in @ctx may
+ * point to different memory locations on return, so you must remember to reset
+ * any cached pointers from the @ctx, i.e. after the call to
+ * ntfs_map_runlist_nolock(), you will probably want to do:
+ *	m = ctx->mrec;
+ *	a = ctx->attr;
+ * Assuming you cache ctx->attr in a variable @a of type attr_record * and that
+ * you cache ctx->mrec in a variable @m of type struct mft_record *.
+ */
+int ntfs_map_runlist_nolock(struct ntfs_inode *ni, s64 vcn, struct ntfs_attr_search_ctx *ctx)
+{
+	s64 end_vcn;
+	unsigned long flags;
+	struct ntfs_inode *base_ni;
+	struct mft_record *m;
+	struct attr_record *a;
+	struct runlist_element *rl;
+	struct folio *put_this_folio = NULL;
+	int err = 0;
+	bool ctx_is_temporary, ctx_needs_reset;
+	struct ntfs_attr_search_ctx old_ctx = { NULL, };
+	size_t new_rl_count;
+
+	ntfs_debug("Mapping runlist part containing vcn 0x%llx.",
+			(unsigned long long)vcn);
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->ext.base_ntfs_ino;
+	if (!ctx) {
+		ctx_is_temporary = ctx_needs_reset = true;
+		m = map_mft_record(base_ni);
+		if (IS_ERR(m))
+			return PTR_ERR(m);
+		ctx = ntfs_attr_get_search_ctx(base_ni, m);
+		if (unlikely(!ctx)) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+	} else {
+		s64 allocated_size_vcn;
+
+		BUG_ON(IS_ERR(ctx->mrec));
+		a = ctx->attr;
+		if (!a->non_resident) {
+			err = -EIO;
+			goto err_out;
+		}
+		ctx_is_temporary = false;
+		end_vcn = le64_to_cpu(a->data.non_resident.highest_vcn);
+		read_lock_irqsave(&ni->size_lock, flags);
+		allocated_size_vcn = ni->allocated_size >>
+				ni->vol->cluster_size_bits;
+		read_unlock_irqrestore(&ni->size_lock, flags);
+		if (!a->data.non_resident.lowest_vcn && end_vcn <= 0)
+			end_vcn = allocated_size_vcn - 1;
+		/*
+		 * If we already have the attribute extent containing @vcn in
+		 * @ctx, no need to look it up again.  We slightly cheat in
+		 * that if vcn exceeds the allocated size, we will refuse to
+		 * map the runlist below, so there is definitely no need to get
+		 * the right attribute extent.
+		 */
+		if (vcn >= allocated_size_vcn || (a->type == ni->type &&
+				a->name_length == ni->name_len &&
+				!memcmp((u8 *)a + le16_to_cpu(a->name_offset),
+				ni->name, ni->name_len) &&
+				le64_to_cpu(a->data.non_resident.lowest_vcn)
+				<= vcn && end_vcn >= vcn))
+			ctx_needs_reset = false;
+		else {
+			/* Save the old search context. */
+			old_ctx = *ctx;
+			/*
+			 * If the currently mapped (extent) inode is not the
+			 * base inode we will unmap it when we reinitialize the
+			 * search context which means we need to get a
+			 * reference to the page containing the mapped mft
+			 * record so we do not accidentally drop changes to the
+			 * mft record when it has not been marked dirty yet.
+			 */
+			if (old_ctx.base_ntfs_ino && old_ctx.ntfs_ino !=
+					old_ctx.base_ntfs_ino) {
+				put_this_folio = old_ctx.ntfs_ino->folio;
+				folio_get(put_this_folio);
+			}
+			/*
+			 * Reinitialize the search context so we can lookup the
+			 * needed attribute extent.
+			 */
+			ntfs_attr_reinit_search_ctx(ctx);
+			ctx_needs_reset = true;
+		}
+	}
+	if (ctx_needs_reset) {
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, vcn, NULL, 0, ctx);
+		if (unlikely(err)) {
+			if (err == -ENOENT)
+				err = -EIO;
+			goto err_out;
+		}
+		BUG_ON(!ctx->attr->non_resident);
+	}
+	a = ctx->attr;
+	/*
+	 * Only decompress the mapping pairs if @vcn is inside it.  Otherwise
+	 * we get into problems when we try to map an out of bounds vcn because
+	 * we then try to map the already mapped runlist fragment and
+	 * ntfs_mapping_pairs_decompress() fails.
+	 */
+	end_vcn = le64_to_cpu(a->data.non_resident.highest_vcn) + 1;
+	if (unlikely(vcn && vcn >= end_vcn)) {
+		err = -ENOENT;
+		goto err_out;
+	}
+	rl = ntfs_mapping_pairs_decompress(ni->vol, a, &ni->runlist, &new_rl_count);
+	if (IS_ERR(rl))
+		err = PTR_ERR(rl);
+	else {
+		ni->runlist.rl = rl;
+		ni->runlist.count = new_rl_count;
+	}
+err_out:
+	if (ctx_is_temporary) {
+		if (likely(ctx))
+			ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(base_ni);
+	} else if (ctx_needs_reset) {
+		/*
+		 * If there is no attribute list, restoring the search context
+		 * is accomplished simply by copying the saved context back over
+		 * the caller supplied context.  If there is an attribute list,
+		 * things are more complicated as we need to deal with mapping
+		 * of mft records and resulting potential changes in pointers.
+		 */
+		if (NInoAttrList(base_ni)) {
+			/*
+			 * If the currently mapped (extent) inode is not the
+			 * one we had before, we need to unmap it and map the
+			 * old one.
+			 */
+			if (ctx->ntfs_ino != old_ctx.ntfs_ino) {
+				/*
+				 * If the currently mapped inode is not the
+				 * base inode, unmap it.
+				 */
+				if (ctx->base_ntfs_ino && ctx->ntfs_ino !=
+						ctx->base_ntfs_ino) {
+					unmap_extent_mft_record(ctx->ntfs_ino);
+					ctx->mrec = ctx->base_mrec;
+					BUG_ON(!ctx->mrec);
+				}
+				/*
+				 * If the old mapped inode is not the base
+				 * inode, map it.
+				 */
+				if (old_ctx.base_ntfs_ino &&
+				    old_ctx.ntfs_ino !=	old_ctx.base_ntfs_ino) {
+retry_map:
+					ctx->mrec = map_mft_record(old_ctx.ntfs_ino);
+					/*
+					 * Something bad has happened.  If out
+					 * of memory retry till it succeeds.
+					 * Any other errors are fatal and we
+					 * return the error code in ctx->mrec.
+					 * Let the caller deal with it...  We
+					 * just need to fudge things so the
+					 * caller can reinit and/or put the
+					 * search context safely.
+					 */
+					if (IS_ERR(ctx->mrec)) {
+						if (PTR_ERR(ctx->mrec) == -ENOMEM) {
+							schedule();
+							goto retry_map;
+						} else
+							old_ctx.ntfs_ino =
+								old_ctx.base_ntfs_ino;
+					}
+				}
+			}
+			/* Update the changed pointers in the saved context. */
+			if (ctx->mrec != old_ctx.mrec) {
+				if (!IS_ERR(ctx->mrec))
+					old_ctx.attr = (struct attr_record *)(
+							(u8 *)ctx->mrec +
+							((u8 *)old_ctx.attr -
+							(u8 *)old_ctx.mrec));
+				old_ctx.mrec = ctx->mrec;
+			}
+		}
+		/* Restore the search context to the saved one. */
+		*ctx = old_ctx;
+		/*
+		 * We drop the reference on the page we took earlier.  In the
+		 * case that IS_ERR(ctx->mrec) is true this means we might lose
+		 * some changes to the mft record that had been made between
+		 * the last time it was marked dirty/written out and now.  This
+		 * at this stage is not a problem as the mapping error is fatal
+		 * enough that the mft record cannot be written out anyway and
+		 * the caller is very likely to shutdown the whole inode
+		 * immediately and mark the volume dirty for chkdsk to pick up
+		 * the pieces anyway.
+		 */
+		if (put_this_folio)
+			folio_put(put_this_folio);
+	}
+	return err;
+}
+
+/**
+ * ntfs_map_runlist - map (a part of) a runlist of an ntfs inode
+ * @ni:		ntfs inode for which to map (part of) a runlist
+ * @vcn:	map runlist part containing this vcn
+ *
+ * Map the part of a runlist containing the @vcn of the ntfs inode @ni.
+ */
+int ntfs_map_runlist(struct ntfs_inode *ni, s64 vcn)
+{
+	int err = 0;
+
+	down_write(&ni->runlist.lock);
+	/* Make sure someone else didn't do the work while we were sleeping. */
+	if (likely(ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn) <=
+			LCN_RL_NOT_MAPPED))
+		err = ntfs_map_runlist_nolock(ni, vcn, NULL);
+	up_write(&ni->runlist.lock);
+	return err;
+}
+
+struct runlist_element *ntfs_attr_vcn_to_rl(struct ntfs_inode *ni, s64 vcn, s64 *lcn)
+{
+	struct runlist_element *rl;
+	int err;
+	bool is_retry = false;
+
+	rl = ni->runlist.rl;
+	if (!rl) {
+		err = ntfs_attr_map_whole_runlist(ni);
+		if (err)
+			return ERR_PTR(-ENOENT);
+		rl = ni->runlist.rl;
+	}
+
+remap_rl:
+	/* Seek to element containing target vcn. */
+	while (rl->length && rl[1].vcn <= vcn)
+		rl++;
+	*lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
+
+	if (*lcn <= LCN_RL_NOT_MAPPED && is_retry == false) {
+		is_retry = true;
+		if (!ntfs_map_runlist_nolock(ni, vcn, NULL)) {
+			rl = ni->runlist.rl;
+			goto remap_rl;
+		}
+	}
+
+	return rl;
+}
+
+/**
+ * ntfs_attr_vcn_to_lcn_nolock - convert a vcn into a lcn given an ntfs inode
+ * @ni:			ntfs inode of the attribute whose runlist to search
+ * @vcn:		vcn to convert
+ * @write_locked:	true if the runlist is locked for writing
+ *
+ * Find the virtual cluster number @vcn in the runlist of the ntfs attribute
+ * described by the ntfs inode @ni and return the corresponding logical cluster
+ * number (lcn).
+ *
+ * If the @vcn is not mapped yet, the attempt is made to map the attribute
+ * extent containing the @vcn and the vcn to lcn conversion is retried.
+ *
+ * If @write_locked is true the caller has locked the runlist for writing and
+ * if false for reading.
+ *
+ * Since lcns must be >= 0, we use negative return codes with special meaning:
+ *
+ * Return code	Meaning / Description
+ * ==========================================
+ *  LCN_HOLE	Hole / not allocated on disk.
+ *  LCN_ENOENT	There is no such vcn in the runlist, i.e. @vcn is out of bounds.
+ *  LCN_ENOMEM	Not enough memory to map runlist.
+ *  LCN_EIO	Critical error (runlist/file is corrupt, i/o error, etc).
+ *
+ * Locking: - The runlist must be locked on entry and is left locked on return.
+ *	    - If @write_locked is 'false', i.e. the runlist is locked for reading,
+ *	      the lock may be dropped inside the function so you cannot rely on
+ *	      the runlist still being the same when this function returns.
+ */
+s64 ntfs_attr_vcn_to_lcn_nolock(struct ntfs_inode *ni, const s64 vcn,
+		const bool write_locked)
+{
+	s64 lcn;
+	unsigned long flags;
+	bool is_retry = false;
+
+	BUG_ON(!ni);
+	ntfs_debug("Entering for i_ino 0x%lx, vcn 0x%llx, %s_locked.",
+			ni->mft_no, (unsigned long long)vcn,
+			write_locked ? "write" : "read");
+	BUG_ON(!NInoNonResident(ni));
+	BUG_ON(vcn < 0);
+	if (!ni->runlist.rl) {
+		read_lock_irqsave(&ni->size_lock, flags);
+		if (!ni->allocated_size) {
+			read_unlock_irqrestore(&ni->size_lock, flags);
+			return LCN_ENOENT;
+		}
+		read_unlock_irqrestore(&ni->size_lock, flags);
+	}
+retry_remap:
+	/* Convert vcn to lcn.  If that fails map the runlist and retry once. */
+	lcn = ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn);
+	if (likely(lcn >= LCN_HOLE)) {
+		ntfs_debug("Done, lcn 0x%llx.", (long long)lcn);
+		return lcn;
+	}
+	if (lcn != LCN_RL_NOT_MAPPED) {
+		if (lcn != LCN_ENOENT)
+			lcn = LCN_EIO;
+	} else if (!is_retry) {
+		int err;
+
+		if (!write_locked) {
+			up_read(&ni->runlist.lock);
+			down_write(&ni->runlist.lock);
+			if (unlikely(ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn) !=
+					LCN_RL_NOT_MAPPED)) {
+				up_write(&ni->runlist.lock);
+				down_read(&ni->runlist.lock);
+				goto retry_remap;
+			}
+		}
+		err = ntfs_map_runlist_nolock(ni, vcn, NULL);
+		if (!write_locked) {
+			up_write(&ni->runlist.lock);
+			down_read(&ni->runlist.lock);
+		}
+		if (likely(!err)) {
+			is_retry = true;
+			goto retry_remap;
+		}
+		if (err == -ENOENT)
+			lcn = LCN_ENOENT;
+		else if (err == -ENOMEM)
+			lcn = LCN_ENOMEM;
+		else
+			lcn = LCN_EIO;
+	}
+	if (lcn != LCN_ENOENT)
+		ntfs_error(ni->vol->sb, "Failed with error code %lli.",
+				(long long)lcn);
+	return lcn;
+}
+
+struct runlist_element *__ntfs_attr_find_vcn_nolock(struct runlist *runlist, const s64 vcn)
+{
+	size_t lower_idx, upper_idx, idx;
+	struct runlist_element *run;
+
+	if (runlist->count <= 1)
+		return ERR_PTR(-ENOENT);
+
+	run = &runlist->rl[0];
+	if (vcn < run->vcn)
+		return ERR_PTR(-ENOENT);
+	else if (vcn < run->vcn + run->length)
+		return run;
+
+	run = &runlist->rl[runlist->count - 2];
+	if (vcn >= run->vcn && vcn < run->vcn + run->length)
+		return run;
+	if (vcn >= run->vcn + run->length)
+		return ERR_PTR(-ENOENT);
+
+	lower_idx = 1;
+	upper_idx = runlist->count - 2;
+
+	while (lower_idx <= upper_idx) {
+		idx = (lower_idx + upper_idx) >> 1;
+		run = &runlist->rl[idx];
+
+		if (vcn < run->vcn)
+			upper_idx = idx - 1;
+		else if (vcn >= run->vcn + run->length)
+			lower_idx = idx + 1;
+		else
+			return run;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+/**
+ * ntfs_attr_find_vcn_nolock - find a vcn in the runlist of an ntfs inode
+ * @ni:		ntfs inode describing the runlist to search
+ * @vcn:	vcn to find
+ * @ctx:	active attribute search context if present or NULL if not
+ *
+ * Find the virtual cluster number @vcn in the runlist described by the ntfs
+ * inode @ni and return the address of the runlist element containing the @vcn.
+ *
+ * If the @vcn is not mapped yet, the attempt is made to map the attribute
+ * extent containing the @vcn and the vcn to lcn conversion is retried.
+ *
+ * If @ctx is specified, it is an active search context of @ni and its base mft
+ * record.  This is needed when ntfs_attr_find_vcn_nolock() encounters unmapped
+ * runlist fragments and allows their mapping.  If you do not have the mft
+ * record mapped, you can specify @ctx as NULL and ntfs_attr_find_vcn_nolock()
+ * will perform the necessary mapping and unmapping.
+ *
+ * Note, ntfs_attr_find_vcn_nolock() saves the state of @ctx on entry and
+ * restores it before returning.  Thus, @ctx will be left pointing to the same
+ * attribute on return as on entry.  However, the actual pointers in @ctx may
+ * point to different memory locations on return, so you must remember to reset
+ * any cached pointers from the @ctx, i.e. after the call to
+ * ntfs_attr_find_vcn_nolock(), you will probably want to do:
+ *	m = ctx->mrec;
+ *	a = ctx->attr;
+ * Assuming you cache ctx->attr in a variable @a of type attr_record * and that
+ * you cache ctx->mrec in a variable @m of type struct mft_record *.
+ * Note you need to distinguish between the lcn of the returned runlist element
+ * being >= 0 and LCN_HOLE.  In the later case you have to return zeroes on
+ * read and allocate clusters on write.
+ */
+struct runlist_element *ntfs_attr_find_vcn_nolock(struct ntfs_inode *ni, const s64 vcn,
+		struct ntfs_attr_search_ctx *ctx)
+{
+	unsigned long flags;
+	struct runlist_element *rl;
+	int err = 0;
+	bool is_retry = false;
+
+	BUG_ON(!ni);
+	ntfs_debug("Entering for i_ino 0x%lx, vcn 0x%llx, with%s ctx.",
+			ni->mft_no, (unsigned long long)vcn, ctx ? "" : "out");
+	BUG_ON(!NInoNonResident(ni));
+	BUG_ON(vcn < 0);
+	if (!ni->runlist.rl) {
+		read_lock_irqsave(&ni->size_lock, flags);
+		if (!ni->allocated_size) {
+			read_unlock_irqrestore(&ni->size_lock, flags);
+			return ERR_PTR(-ENOENT);
+		}
+		read_unlock_irqrestore(&ni->size_lock, flags);
+	}
+
+retry_remap:
+	rl = ni->runlist.rl;
+	if (likely(rl && vcn >= rl[0].vcn)) {
+		rl = __ntfs_attr_find_vcn_nolock(&ni->runlist, vcn);
+		if (IS_ERR(rl))
+			err = PTR_ERR(rl);
+		else if (rl->lcn >= LCN_HOLE)
+			return rl;
+		else if (rl->lcn <= LCN_ENOENT)
+			err = -EIO;
+	}
+	if (!err && !is_retry) {
+		/*
+		 * If the search context is invalid we cannot map the unmapped
+		 * region.
+		 */
+		if (ctx && IS_ERR(ctx->mrec))
+			err = PTR_ERR(ctx->mrec);
+		else {
+			/*
+			 * The @vcn is in an unmapped region, map the runlist
+			 * and retry.
+			 */
+			err = ntfs_map_runlist_nolock(ni, vcn, ctx);
+			if (likely(!err)) {
+				is_retry = true;
+				goto retry_remap;
+			}
+		}
+		if (err == -EINVAL)
+			err = -EIO;
+	} else if (!err)
+		err = -EIO;
+	if (err != -ENOENT)
+		ntfs_error(ni->vol->sb, "Failed with error code %i.", err);
+	return ERR_PTR(err);
+}
+
+/**
+ * ntfs_attr_find - find (next) attribute in mft record
+ * @type:	attribute type to find
+ * @name:	attribute name to find (optional, i.e. NULL means don't care)
+ * @name_len:	attribute name length (only needed if @name present)
+ * @ic:		IGNORE_CASE or CASE_SENSITIVE (ignored if @name not present)
+ * @val:	attribute value to find (optional, resident attributes only)
+ * @val_len:	attribute value length
+ * @ctx:	search context with mft record and attribute to search from
+ *
+ * You should not need to call this function directly.  Use ntfs_attr_lookup()
+ * instead.
+ *
+ * ntfs_attr_find() takes a search context @ctx as parameter and searches the
+ * mft record specified by @ctx->mrec, beginning at @ctx->attr, for an
+ * attribute of @type, optionally @name and @val.
+ *
+ * If the attribute is found, ntfs_attr_find() returns 0 and @ctx->attr will
+ * point to the found attribute.
+ *
+ * If the attribute is not found, ntfs_attr_find() returns -ENOENT and
+ * @ctx->attr will point to the attribute before which the attribute being
+ * searched for would need to be inserted if such an action were to be desired.
+ *
+ * On actual error, ntfs_attr_find() returns -EIO.  In this case @ctx->attr is
+ * undefined and in particular do not rely on it not changing.
+ *
+ * If @ctx->is_first is 'true', the search begins with @ctx->attr itself.  If it
+ * is 'false', the search begins after @ctx->attr.
+ *
+ * If @ic is IGNORE_CASE, the @name comparisson is not case sensitive and
+ * @ctx->ntfs_ino must be set to the ntfs inode to which the mft record
+ * @ctx->mrec belongs.  This is so we can get at the ntfs volume and hence at
+ * the upcase table.  If @ic is CASE_SENSITIVE, the comparison is case
+ * sensitive.  When @name is present, @name_len is the @name length in Unicode
+ * characters.
+ *
+ * If @name is not present (NULL), we assume that the unnamed attribute is
+ * being searched for.
+ *
+ * Finally, the resident attribute value @val is looked for, if present.  If
+ * @val is not present (NULL), @val_len is ignored.
+ *
+ * ntfs_attr_find() only searches the specified mft record and it ignores the
+ * presence of an attribute list attribute (unless it is the one being searched
+ * for, obviously).  If you need to take attribute lists into consideration,
+ * use ntfs_attr_lookup() instead (see below).  This also means that you cannot
+ * use ntfs_attr_find() to search for extent records of non-resident
+ * attributes, as extents with lowest_vcn != 0 are usually described by the
+ * attribute list attribute only. - Note that it is possible that the first
+ * extent is only in the attribute list while the last extent is in the base
+ * mft record, so do not rely on being able to find the first extent in the
+ * base mft record.
+ *
+ * Warning: Never use @val when looking for attribute types which can be
+ *	    non-resident as this most likely will result in a crash!
+ */
+static int ntfs_attr_find(const __le32 type, const __le16 *name,
+		const u32 name_len, const u32 ic,
+		const u8 *val, const u32 val_len, struct ntfs_attr_search_ctx *ctx)
+{
+	struct attr_record *a;
+	struct ntfs_volume *vol = ctx->ntfs_ino->vol;
+	__le16 *upcase = vol->upcase;
+	u32 upcase_len = vol->upcase_len;
+	unsigned int space;
+
+	/*
+	 * Iterate over attributes in mft record starting at @ctx->attr, or the
+	 * attribute following that, if @ctx->is_first is 'true'.
+	 */
+	if (ctx->is_first) {
+		a = ctx->attr;
+		ctx->is_first = false;
+	} else
+		a = (struct attr_record *)((u8 *)ctx->attr +
+				le32_to_cpu(ctx->attr->length));
+	for (;;	a = (struct attr_record *)((u8 *)a + le32_to_cpu(a->length))) {
+		if ((u8 *)a < (u8 *)ctx->mrec || (u8 *)a > (u8 *)ctx->mrec +
+				le32_to_cpu(ctx->mrec->bytes_allocated))
+			break;
+
+		space = le32_to_cpu(ctx->mrec->bytes_in_use) - ((u8 *)a - (u8 *)ctx->mrec);
+		if ((space < offsetof(struct attr_record, data.resident.reserved) + 1 ||
+		      space < le32_to_cpu(a->length)) && (space < 4 || a->type != AT_END))
+			break;
+
+		ctx->attr = a;
+		if (((type != AT_UNUSED) && (le32_to_cpu(a->type) > le32_to_cpu(type))) ||
+				a->type == AT_END)
+			return -ENOENT;
+		if (unlikely(!a->length))
+			break;
+		if (type == AT_UNUSED)
+			return 0;
+		if (a->type != type)
+			continue;
+		/*
+		 * If @name is present, compare the two names.  If @name is
+		 * missing, assume we want an unnamed attribute.
+		 */
+		if (!name || name == AT_UNNAMED) {
+			/* The search failed if the found attribute is named. */
+			if (a->name_length)
+				return -ENOENT;
+		} else {
+			if (a->name_length && ((le16_to_cpu(a->name_offset) +
+					       a->name_length * sizeof(__le16)) >
+						le32_to_cpu(a->length))) {
+				ntfs_error(vol->sb, "Corrupt attribute name in MFT record %lld\n",
+					   (long long)ctx->ntfs_ino->mft_no);
+				break;
+			}
+
+			if (!ntfs_are_names_equal(name, name_len,
+					(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+					a->name_length, ic, upcase, upcase_len)) {
+				register int rc;
+
+				rc = ntfs_collate_names(name, name_len,
+						(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+						a->name_length, 1, IGNORE_CASE,
+						upcase, upcase_len);
+				/*
+				 * If @name collates before a->name, there is no
+				 * matching attribute.
+				 */
+				if (rc == -1)
+					return -ENOENT;
+				/* If the strings are not equal, continue search. */
+				if (rc)
+					continue;
+				rc = ntfs_collate_names(name, name_len,
+						(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+						a->name_length, 1, CASE_SENSITIVE,
+						upcase, upcase_len);
+				if (rc == -1)
+					return -ENOENT;
+				if (rc)
+					continue;
+			}
+		}
+		/*
+		 * The names match or @name not present and attribute is
+		 * unnamed.  If no @val specified, we have found the attribute
+		 * and are done.
+		 */
+		if (!val)
+			return 0;
+		/* @val is present; compare values. */
+		else {
+			register int rc;
+
+			rc = memcmp(val, (u8 *)a + le16_to_cpu(
+					a->data.resident.value_offset),
+					min_t(u32, val_len, le32_to_cpu(
+					a->data.resident.value_length)));
+			/*
+			 * If @val collates before the current attribute's
+			 * value, there is no matching attribute.
+			 */
+			if (!rc) {
+				register u32 avl;
+
+				avl = le32_to_cpu(a->data.resident.value_length);
+				if (val_len == avl)
+					return 0;
+				if (val_len < avl)
+					return -ENOENT;
+			} else if (rc < 0)
+				return -ENOENT;
+		}
+	}
+	ntfs_error(vol->sb, "Inode is corrupt.  Run chkdsk.");
+	NVolSetErrors(vol);
+	return -EIO;
+}
+
+void ntfs_attr_name_free(unsigned char **name)
+{
+	if (*name) {
+		ntfs_free(*name);
+		*name = NULL;
+	}
+}
+
+char *ntfs_attr_name_get(const struct ntfs_volume *vol, const __le16 *uname,
+		const int uname_len)
+{
+	unsigned char *name = NULL;
+	int name_len;
+
+	name_len = ntfs_ucstonls(vol, uname, uname_len, &name, 0);
+	if (name_len < 0) {
+		ntfs_error(vol->sb, "ntfs_ucstonls error");
+		/* This function when returns -1, memory for name might
+		 * be allocated. So lets free this memory.
+		 */
+		ntfs_attr_name_free(&name);
+		return NULL;
+
+	} else if (name_len > 0)
+		return name;
+
+	ntfs_attr_name_free(&name);
+	return NULL;
+}
+
+int load_attribute_list(struct ntfs_inode *base_ni, u8 *al_start, const s64 size)
+{
+	struct inode *attr_vi = NULL;
+	u8 *al;
+	struct attr_list_entry *ale;
+
+	if (!al_start || size <= 0)
+		return -EINVAL;
+
+	attr_vi = ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0);
+	if (IS_ERR(attr_vi)) {
+		ntfs_error(base_ni->vol->sb,
+			   "Failed to open an inode for Attribute list, mft = %ld",
+			   base_ni->mft_no);
+		return PTR_ERR(attr_vi);
+	}
+
+	if (ntfs_inode_attr_pread(attr_vi, 0, size, al_start) != size) {
+		iput(attr_vi);
+		ntfs_error(base_ni->vol->sb,
+			   "Failed to read attribute list, mft = %ld",
+			   base_ni->mft_no);
+		return -EIO;
+	}
+	iput(attr_vi);
+
+	for (al = al_start; al < al_start + size; al += le16_to_cpu(ale->length)) {
+		ale = (struct attr_list_entry *)al;
+		if (ale->name_offset != sizeof(struct attr_list_entry))
+			break;
+		if (le16_to_cpu(ale->length) <= ale->name_offset + ale->name_length ||
+		    al + le16_to_cpu(ale->length) > al_start + size)
+			break;
+		if (ale->type == AT_UNUSED)
+			break;
+		if (MSEQNO_LE(ale->mft_reference) == 0)
+			break;
+	}
+	if (al != al_start + size) {
+		ntfs_error(base_ni->vol->sb, "Corrupt attribute list, mft = %ld",
+			   base_ni->mft_no);
+		return -EIO;
+	}
+	return 0;
+}
+
+/**
+ * ntfs_external_attr_find - find an attribute in the attribute list of an inode
+ * @type:	attribute type to find
+ * @name:	attribute name to find (optional, i.e. NULL means don't care)
+ * @name_len:	attribute name length (only needed if @name present)
+ * @ic:		IGNORE_CASE or CASE_SENSITIVE (ignored if @name not present)
+ * @lowest_vcn:	lowest vcn to find (optional, non-resident attributes only)
+ * @val:	attribute value to find (optional, resident attributes only)
+ * @val_len:	attribute value length
+ * @ctx:	search context with mft record and attribute to search from
+ *
+ * You should not need to call this function directly.  Use ntfs_attr_lookup()
+ * instead.
+ *
+ * Find an attribute by searching the attribute list for the corresponding
+ * attribute list entry.  Having found the entry, map the mft record if the
+ * attribute is in a different mft record/inode, ntfs_attr_find() the attribute
+ * in there and return it.
+ *
+ * On first search @ctx->ntfs_ino must be the base mft record and @ctx must
+ * have been obtained from a call to ntfs_attr_get_search_ctx().  On subsequent
+ * calls @ctx->ntfs_ino can be any extent inode, too (@ctx->base_ntfs_ino is
+ * then the base inode).
+ *
+ * After finishing with the attribute/mft record you need to call
+ * ntfs_attr_put_search_ctx() to cleanup the search context (unmapping any
+ * mapped inodes, etc).
+ *
+ * If the attribute is found, ntfs_external_attr_find() returns 0 and
+ * @ctx->attr will point to the found attribute.  @ctx->mrec will point to the
+ * mft record in which @ctx->attr is located and @ctx->al_entry will point to
+ * the attribute list entry for the attribute.
+ *
+ * If the attribute is not found, ntfs_external_attr_find() returns -ENOENT and
+ * @ctx->attr will point to the attribute in the base mft record before which
+ * the attribute being searched for would need to be inserted if such an action
+ * were to be desired.  @ctx->mrec will point to the mft record in which
+ * @ctx->attr is located and @ctx->al_entry will point to the attribute list
+ * entry of the attribute before which the attribute being searched for would
+ * need to be inserted if such an action were to be desired.
+ *
+ * Thus to insert the not found attribute, one wants to add the attribute to
+ * @ctx->mrec (the base mft record) and if there is not enough space, the
+ * attribute should be placed in a newly allocated extent mft record.  The
+ * attribute list entry for the inserted attribute should be inserted in the
+ * attribute list attribute at @ctx->al_entry.
+ *
+ * On actual error, ntfs_external_attr_find() returns -EIO.  In this case
+ * @ctx->attr is undefined and in particular do not rely on it not changing.
+ */
+static int ntfs_external_attr_find(const __le32 type,
+		const __le16 *name, const u32 name_len,
+		const u32 ic, const s64 lowest_vcn,
+		const u8 *val, const u32 val_len, struct ntfs_attr_search_ctx *ctx)
+{
+	struct ntfs_inode *base_ni, *ni;
+	struct ntfs_volume *vol;
+	struct attr_list_entry *al_entry, *next_al_entry;
+	u8 *al_start, *al_end;
+	struct attr_record *a;
+	__le16 *al_name;
+	u32 al_name_len;
+	bool is_first_search = false;
+	int err = 0;
+	static const char *es = " Unmount and run chkdsk.";
+
+	ni = ctx->ntfs_ino;
+	base_ni = ctx->base_ntfs_ino;
+	ntfs_debug("Entering for inode 0x%lx, type 0x%x.", ni->mft_no, type);
+	if (!base_ni) {
+		/* First call happens with the base mft record. */
+		base_ni = ctx->base_ntfs_ino = ctx->ntfs_ino;
+		ctx->base_mrec = ctx->mrec;
+		ctx->mapped_base_mrec = ctx->mapped_mrec;
+	}
+	if (ni == base_ni)
+		ctx->base_attr = ctx->attr;
+	if (type == AT_END)
+		goto not_found;
+	vol = base_ni->vol;
+	al_start = base_ni->attr_list;
+	al_end = al_start + base_ni->attr_list_size;
+	if (!ctx->al_entry) {
+		ctx->al_entry = (struct attr_list_entry *)al_start;
+		is_first_search = true;
+	}
+	/*
+	 * Iterate over entries in attribute list starting at @ctx->al_entry,
+	 * or the entry following that, if @ctx->is_first is 'true'.
+	 */
+	if (ctx->is_first) {
+		al_entry = ctx->al_entry;
+		ctx->is_first = false;
+		/*
+		 * If an enumeration and the first attribute is higher than
+		 * the attribute list itself, need to return the attribute list
+		 * attribute.
+		 */
+		if ((type == AT_UNUSED) && is_first_search &&
+				le32_to_cpu(al_entry->type) >
+				le32_to_cpu(AT_ATTRIBUTE_LIST))
+			goto find_attr_list_attr;
+	} else {
+		/* Check for small entry */
+		if (((al_end - (u8 *)ctx->al_entry) <
+		      (long)offsetof(struct attr_list_entry, name)) ||
+		    (le16_to_cpu(ctx->al_entry->length) & 7) ||
+		    (le16_to_cpu(ctx->al_entry->length) < offsetof(struct attr_list_entry, name)))
+			goto corrupt;
+
+		al_entry = (struct attr_list_entry *)((u8 *)ctx->al_entry +
+				le16_to_cpu(ctx->al_entry->length));
+
+		if ((u8 *)al_entry == al_end)
+			goto not_found;
+
+		/* Preliminary check for small entry */
+		if ((al_end - (u8 *)al_entry) <
+		    (long)offsetof(struct attr_list_entry, name))
+			goto corrupt;
+
+		/*
+		 * If this is an enumeration and the attribute list attribute
+		 * is the next one in the enumeration sequence, just return the
+		 * attribute list attribute from the base mft record as it is
+		 * not listed in the attribute list itself.
+		 */
+		if ((type == AT_UNUSED) && le32_to_cpu(ctx->al_entry->type) <
+				le32_to_cpu(AT_ATTRIBUTE_LIST) &&
+				le32_to_cpu(al_entry->type) >
+				le32_to_cpu(AT_ATTRIBUTE_LIST)) {
+find_attr_list_attr:
+
+			/* Check for bogus calls. */
+			if (name || name_len || val || val_len || lowest_vcn)
+				return -EINVAL;
+
+			/* We want the base record. */
+			if (ctx->ntfs_ino != base_ni)
+				unmap_mft_record(ctx->ntfs_ino);
+			ctx->ntfs_ino = base_ni;
+			ctx->mapped_mrec = ctx->mapped_base_mrec;
+			ctx->mrec = ctx->base_mrec;
+			ctx->is_first = true;
+
+			/* Sanity checks are performed elsewhere. */
+			ctx->attr = (struct attr_record *)((u8 *)ctx->mrec +
+					le16_to_cpu(ctx->mrec->attrs_offset));
+
+			/* Find the attribute list attribute. */
+			err = ntfs_attr_find(AT_ATTRIBUTE_LIST, NULL, 0,
+					IGNORE_CASE, NULL, 0, ctx);
+
+			/*
+			 * Setup the search context so the correct
+			 * attribute is returned next time round.
+			 */
+			ctx->al_entry = al_entry;
+			ctx->is_first = true;
+
+			/* Got it. Done. */
+			if (!err)
+				return 0;
+
+			/* Error! If other than not found return it. */
+			if (err != -ENOENT)
+				return err;
+
+			/* Not found?!? Absurd! */
+			ntfs_error(ctx->ntfs_ino->vol->sb, "Attribute list wasn't found");
+			return -EIO;
+		}
+	}
+	for (;; al_entry = next_al_entry) {
+		/* Out of bounds check. */
+		if ((u8 *)al_entry < base_ni->attr_list ||
+				(u8 *)al_entry > al_end)
+			break;	/* Inode is corrupt. */
+		ctx->al_entry = al_entry;
+		/* Catch the end of the attribute list. */
+		if ((u8 *)al_entry == al_end)
+			goto not_found;
+
+		if ((((u8 *)al_entry + offsetof(struct attr_list_entry, name)) > al_end) ||
+		    ((u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end) ||
+		    (le16_to_cpu(al_entry->length) & 7) ||
+		    (le16_to_cpu(al_entry->length) <
+		     offsetof(struct attr_list_entry, name_length)) ||
+		    (al_entry->name_length && ((u8 *)al_entry + al_entry->name_offset +
+					       al_entry->name_length * sizeof(__le16)) > al_end))
+			break; /* corrupt */
+
+		next_al_entry = (struct attr_list_entry *)((u8 *)al_entry +
+				le16_to_cpu(al_entry->length));
+		if (type != AT_UNUSED) {
+			if (le32_to_cpu(al_entry->type) > le32_to_cpu(type))
+				goto not_found;
+			if (type != al_entry->type)
+				continue;
+		}
+		/*
+		 * If @name is present, compare the two names.  If @name is
+		 * missing, assume we want an unnamed attribute.
+		 */
+		al_name_len = al_entry->name_length;
+		al_name = (__le16 *)((u8 *)al_entry + al_entry->name_offset);
+
+		/*
+		 * If !@type we want the attribute represented by this
+		 * attribute list entry.
+		 */
+		if (type == AT_UNUSED)
+			goto is_enumeration;
+
+		if (!name || name == AT_UNNAMED) {
+			if (al_name_len)
+				goto not_found;
+		} else if (!ntfs_are_names_equal(al_name, al_name_len, name,
+				name_len, ic, vol->upcase, vol->upcase_len)) {
+			register int rc;
+
+			rc = ntfs_collate_names(name, name_len, al_name,
+					al_name_len, 1, IGNORE_CASE,
+					vol->upcase, vol->upcase_len);
+			/*
+			 * If @name collates before al_name, there is no
+			 * matching attribute.
+			 */
+			if (rc == -1)
+				goto not_found;
+			/* If the strings are not equal, continue search. */
+			if (rc)
+				continue;
+
+			rc = ntfs_collate_names(name, name_len, al_name,
+					al_name_len, 1, CASE_SENSITIVE,
+					vol->upcase, vol->upcase_len);
+			if (rc == -1)
+				goto not_found;
+			if (rc)
+				continue;
+		}
+		/*
+		 * The names match or @name not present and attribute is
+		 * unnamed.  Now check @lowest_vcn.  Continue search if the
+		 * next attribute list entry still fits @lowest_vcn.  Otherwise
+		 * we have reached the right one or the search has failed.
+		 */
+		if (lowest_vcn && (u8 *)next_al_entry >= al_start &&
+				(u8 *)next_al_entry + 6 < al_end &&
+				(u8 *)next_al_entry + le16_to_cpu(
+					next_al_entry->length) <= al_end &&
+				le64_to_cpu(next_al_entry->lowest_vcn) <=
+					lowest_vcn &&
+				next_al_entry->type == al_entry->type &&
+				next_al_entry->name_length == al_name_len &&
+				ntfs_are_names_equal((__le16 *)((u8 *)
+					next_al_entry +
+					next_al_entry->name_offset),
+					next_al_entry->name_length,
+					al_name, al_name_len, CASE_SENSITIVE,
+					vol->upcase, vol->upcase_len))
+			continue;
+
+is_enumeration:
+		if (MREF_LE(al_entry->mft_reference) == ni->mft_no) {
+			if (MSEQNO_LE(al_entry->mft_reference) != ni->seq_no) {
+				ntfs_error(vol->sb,
+					"Found stale mft reference in attribute list of base inode 0x%lx.%s",
+					base_ni->mft_no, es);
+				err = -EIO;
+				break;
+			}
+		} else { /* Mft references do not match. */
+			/* If there is a mapped record unmap it first. */
+			if (ni != base_ni)
+				unmap_extent_mft_record(ni);
+			/* Do we want the base record back? */
+			if (MREF_LE(al_entry->mft_reference) ==
+					base_ni->mft_no) {
+				ni = ctx->ntfs_ino = base_ni;
+				ctx->mrec = ctx->base_mrec;
+				ctx->mapped_mrec = ctx->mapped_base_mrec;
+			} else {
+				/* We want an extent record. */
+				ctx->mrec = map_extent_mft_record(base_ni,
+						le64_to_cpu(
+						al_entry->mft_reference), &ni);
+				if (IS_ERR(ctx->mrec)) {
+					ntfs_error(vol->sb,
+							"Failed to map extent mft record 0x%lx of base inode 0x%lx.%s",
+							MREF_LE(al_entry->mft_reference),
+							base_ni->mft_no, es);
+					err = PTR_ERR(ctx->mrec);
+					if (err == -ENOENT)
+						err = -EIO;
+					/* Cause @ctx to be sanitized below. */
+					ni = NULL;
+					break;
+				}
+				ctx->ntfs_ino = ni;
+				ctx->mapped_mrec = true;
+
+			}
+		}
+		a = ctx->attr = (struct attr_record *)((u8 *)ctx->mrec +
+					le16_to_cpu(ctx->mrec->attrs_offset));
+		/*
+		 * ctx->vfs_ino, ctx->mrec, and ctx->attr now point to the
+		 * mft record containing the attribute represented by the
+		 * current al_entry.
+		 */
+		/*
+		 * We could call into ntfs_attr_find() to find the right
+		 * attribute in this mft record but this would be less
+		 * efficient and not quite accurate as ntfs_attr_find() ignores
+		 * the attribute instance numbers for example which become
+		 * important when one plays with attribute lists.  Also,
+		 * because a proper match has been found in the attribute list
+		 * entry above, the comparison can now be optimized.  So it is
+		 * worth re-implementing a simplified ntfs_attr_find() here.
+		 */
+		/*
+		 * Use a manual loop so we can still use break and continue
+		 * with the same meanings as above.
+		 */
+do_next_attr_loop:
+		if ((u8 *)a < (u8 *)ctx->mrec || (u8 *)a > (u8 *)ctx->mrec +
+				le32_to_cpu(ctx->mrec->bytes_allocated))
+			break;
+		if (a->type == AT_END)
+			continue;
+		if (!a->length)
+			break;
+		if (al_entry->instance != a->instance)
+			goto do_next_attr;
+		/*
+		 * If the type and/or the name are mismatched between the
+		 * attribute list entry and the attribute record, there is
+		 * corruption so we break and return error EIO.
+		 */
+		if (al_entry->type != a->type)
+			break;
+		if (!ntfs_are_names_equal((__le16 *)((u8 *)a +
+				le16_to_cpu(a->name_offset)), a->name_length,
+				al_name, al_name_len, CASE_SENSITIVE,
+				vol->upcase, vol->upcase_len))
+			break;
+		ctx->attr = a;
+		/*
+		 * If no @val specified or @val specified and it matches, we
+		 * have found it!
+		 */
+		if ((type == AT_UNUSED) || !val || (!a->non_resident && le32_to_cpu(
+				a->data.resident.value_length) == val_len &&
+				!memcmp((u8 *)a +
+				le16_to_cpu(a->data.resident.value_offset),
+				val, val_len))) {
+			ntfs_debug("Done, found.");
+			return 0;
+		}
+do_next_attr:
+		/* Proceed to the next attribute in the current mft record. */
+		a = (struct attr_record *)((u8 *)a + le32_to_cpu(a->length));
+		goto do_next_attr_loop;
+	}
+
+corrupt:
+	if (ni != base_ni) {
+		if (ni)
+			unmap_extent_mft_record(ni);
+		ctx->ntfs_ino = base_ni;
+		ctx->mrec = ctx->base_mrec;
+		ctx->attr = ctx->base_attr;
+		ctx->mapped_mrec = ctx->mapped_base_mrec;
+	}
+
+	if (!err) {
+		ntfs_error(vol->sb,
+			"Base inode 0x%lx contains corrupt attribute list attribute.%s",
+			base_ni->mft_no, es);
+		err = -EIO;
+	}
+
+	if (err != -ENOMEM)
+		NVolSetErrors(vol);
+	return err;
+not_found:
+	/*
+	 * If we were looking for AT_END, we reset the search context @ctx and
+	 * use ntfs_attr_find() to seek to the end of the base mft record.
+	 */
+	if (type == AT_UNUSED || type == AT_END) {
+		ntfs_attr_reinit_search_ctx(ctx);
+		return ntfs_attr_find(AT_END, name, name_len, ic, val, val_len,
+				ctx);
+	}
+	/*
+	 * The attribute was not found.  Before we return, we want to ensure
+	 * @ctx->mrec and @ctx->attr indicate the position at which the
+	 * attribute should be inserted in the base mft record.  Since we also
+	 * want to preserve @ctx->al_entry we cannot reinitialize the search
+	 * context using ntfs_attr_reinit_search_ctx() as this would set
+	 * @ctx->al_entry to NULL.  Thus we do the necessary bits manually (see
+	 * ntfs_attr_init_search_ctx() below).  Note, we _only_ preserve
+	 * @ctx->al_entry as the remaining fields (base_*) are identical to
+	 * their non base_ counterparts and we cannot set @ctx->base_attr
+	 * correctly yet as we do not know what @ctx->attr will be set to by
+	 * the call to ntfs_attr_find() below.
+	 */
+	if (ni != base_ni)
+		unmap_extent_mft_record(ni);
+	ctx->mrec = ctx->base_mrec;
+	ctx->attr = (struct attr_record *)((u8 *)ctx->mrec +
+			le16_to_cpu(ctx->mrec->attrs_offset));
+	ctx->is_first = true;
+	ctx->ntfs_ino = base_ni;
+	ctx->base_ntfs_ino = NULL;
+	ctx->base_mrec = NULL;
+	ctx->base_attr = NULL;
+	ctx->mapped_mrec = ctx->mapped_base_mrec;
+	/*
+	 * In case there are multiple matches in the base mft record, need to
+	 * keep enumerating until we get an attribute not found response (or
+	 * another error), otherwise we would keep returning the same attribute
+	 * over and over again and all programs using us for enumeration would
+	 * lock up in a tight loop.
+	 */
+	do {
+		err = ntfs_attr_find(type, name, name_len, ic, val, val_len,
+				ctx);
+	} while (!err);
+	ntfs_debug("Done, not found.");
+	return err;
+}
+
+/**
+ * ntfs_attr_lookup - find an attribute in an ntfs inode
+ * @type:	attribute type to find
+ * @name:	attribute name to find (optional, i.e. NULL means don't care)
+ * @name_len:	attribute name length (only needed if @name present)
+ * @ic:		IGNORE_CASE or CASE_SENSITIVE (ignored if @name not present)
+ * @lowest_vcn:	lowest vcn to find (optional, non-resident attributes only)
+ * @val:	attribute value to find (optional, resident attributes only)
+ * @val_len:	attribute value length
+ * @ctx:	search context with mft record and attribute to search from
+ *
+ * Find an attribute in an ntfs inode.  On first search @ctx->ntfs_ino must
+ * be the base mft record and @ctx must have been obtained from a call to
+ * ntfs_attr_get_search_ctx().
+ *
+ * This function transparently handles attribute lists and @ctx is used to
+ * continue searches where they were left off at.
+ *
+ * After finishing with the attribute/mft record you need to call
+ * ntfs_attr_put_search_ctx() to cleanup the search context (unmapping any
+ * mapped inodes, etc).
+ *
+ * Return 0 if the search was successful and -errno if not.
+ *
+ * When 0, @ctx->attr is the found attribute and it is in mft record
+ * @ctx->mrec.  If an attribute list attribute is present, @ctx->al_entry is
+ * the attribute list entry of the found attribute.
+ *
+ * When -ENOENT, @ctx->attr is the attribute which collates just after the
+ * attribute being searched for, i.e. if one wants to add the attribute to the
+ * mft record this is the correct place to insert it into.  If an attribute
+ * list attribute is present, @ctx->al_entry is the attribute list entry which
+ * collates just after the attribute list entry of the attribute being searched
+ * for, i.e. if one wants to add the attribute to the mft record this is the
+ * correct place to insert its attribute list entry into.
+ */
+int ntfs_attr_lookup(const __le32 type, const __le16 *name,
+		const u32 name_len, const u32 ic,
+		const s64 lowest_vcn, const u8 *val, const u32 val_len,
+		struct ntfs_attr_search_ctx *ctx)
+{
+	struct ntfs_inode *base_ni;
+
+	ntfs_debug("Entering.");
+	BUG_ON(IS_ERR(ctx->mrec));
+	if (ctx->base_ntfs_ino)
+		base_ni = ctx->base_ntfs_ino;
+	else
+		base_ni = ctx->ntfs_ino;
+	/* Sanity check, just for debugging really. */
+	if (!base_ni || !NInoAttrList(base_ni) || type == AT_ATTRIBUTE_LIST)
+		return ntfs_attr_find(type, name, name_len, ic, val, val_len,
+				ctx);
+	return ntfs_external_attr_find(type, name, name_len, ic, lowest_vcn,
+			val, val_len, ctx);
+}
+
+/**
+ * ntfs_attr_init_search_ctx - initialize an attribute search context
+ * @ctx:        attribute search context to initialize
+ * @ni:         ntfs inode with which to initialize the search context
+ * @mrec:       mft record with which to initialize the search context
+ *
+ * Initialize the attribute search context @ctx with @ni and @mrec.
+ */
+static bool ntfs_attr_init_search_ctx(struct ntfs_attr_search_ctx *ctx,
+		struct ntfs_inode *ni, struct mft_record *mrec)
+{
+	if (!mrec) {
+		mrec = map_mft_record(ni);
+		if (IS_ERR(mrec))
+			return false;
+		ctx->mapped_mrec = true;
+	} else {
+		ctx->mapped_mrec = false;
+	}
+
+	ctx->mrec = mrec;
+	/* Sanity checks are performed elsewhere. */
+	ctx->attr = (struct attr_record *)((u8 *)mrec + le16_to_cpu(mrec->attrs_offset));
+	ctx->is_first = true;
+	ctx->ntfs_ino = ni;
+	ctx->al_entry = NULL;
+	ctx->base_ntfs_ino = NULL;
+	ctx->base_mrec = NULL;
+	ctx->base_attr = NULL;
+	ctx->mapped_base_mrec = false;
+	return true;
+}
+
+/**
+ * ntfs_attr_reinit_search_ctx - reinitialize an attribute search context
+ * @ctx:	attribute search context to reinitialize
+ *
+ * Reinitialize the attribute search context @ctx, unmapping an associated
+ * extent mft record if present, and initialize the search context again.
+ *
+ * This is used when a search for a new attribute is being started to reset
+ * the search context to the beginning.
+ */
+void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
+{
+	bool mapped_mrec;
+
+	if (likely(!ctx->base_ntfs_ino)) {
+		/* No attribute list. */
+		ctx->is_first = true;
+		/* Sanity checks are performed elsewhere. */
+		ctx->attr = (struct attr_record *)((u8 *)ctx->mrec +
+				le16_to_cpu(ctx->mrec->attrs_offset));
+		/*
+		 * This needs resetting due to ntfs_external_attr_find() which
+		 * can leave it set despite having zeroed ctx->base_ntfs_ino.
+		 */
+		ctx->al_entry = NULL;
+		return;
+	} /* Attribute list. */
+	if (ctx->ntfs_ino != ctx->base_ntfs_ino && ctx->ntfs_ino)
+		unmap_extent_mft_record(ctx->ntfs_ino);
+
+	mapped_mrec = ctx->mapped_base_mrec;
+	ntfs_attr_init_search_ctx(ctx, ctx->base_ntfs_ino, ctx->base_mrec);
+	ctx->mapped_mrec = mapped_mrec;
+}
+
+/**
+ * ntfs_attr_get_search_ctx - allocate/initialize a new attribute search context
+ * @ni:		ntfs inode with which to initialize the search context
+ * @mrec:	mft record with which to initialize the search context
+ *
+ * Allocate a new attribute search context, initialize it with @ni and @mrec,
+ * and return it. Return NULL if allocation failed.
+ */
+struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
+		struct mft_record *mrec)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	bool init;
+
+	ctx = kmem_cache_alloc(ntfs_attr_ctx_cache, GFP_NOFS);
+	if (ctx) {
+		init = ntfs_attr_init_search_ctx(ctx, ni, mrec);
+		if (init == false) {
+			kmem_cache_free(ntfs_attr_ctx_cache, ctx);
+			ctx = NULL;
+		}
+	}
+
+	return ctx;
+}
+
+/**
+ * ntfs_attr_put_search_ctx - release an attribute search context
+ * @ctx:	attribute search context to free
+ *
+ * Release the attribute search context @ctx, unmapping an associated extent
+ * mft record if present.
+ */
+void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx)
+{
+	if (ctx->mapped_mrec)
+		unmap_mft_record(ctx->ntfs_ino);
+
+	if (ctx->mapped_base_mrec && ctx->base_ntfs_ino &&
+	    ctx->ntfs_ino != ctx->base_ntfs_ino)
+		unmap_extent_mft_record(ctx->base_ntfs_ino);
+	kmem_cache_free(ntfs_attr_ctx_cache, ctx);
+}
+
+/**
+ * ntfs_attr_find_in_attrdef - find an attribute in the $AttrDef system file
+ * @vol:	ntfs volume to which the attribute belongs
+ * @type:	attribute type which to find
+ *
+ * Search for the attribute definition record corresponding to the attribute
+ * @type in the $AttrDef system file.
+ *
+ * Return the attribute type definition record if found and NULL if not found.
+ */
+static struct attr_def *ntfs_attr_find_in_attrdef(const struct ntfs_volume *vol,
+		const __le32 type)
+{
+	struct attr_def *ad;
+
+	BUG_ON(!vol->attrdef);
+	BUG_ON(!type);
+	for (ad = vol->attrdef; (u8 *)ad - (u8 *)vol->attrdef <
+			vol->attrdef_size && ad->type; ++ad) {
+		/* We have not found it yet, carry on searching. */
+		if (likely(le32_to_cpu(ad->type) < le32_to_cpu(type)))
+			continue;
+		/* We found the attribute; return it. */
+		if (likely(ad->type == type))
+			return ad;
+		/* We have gone too far already.  No point in continuing. */
+		break;
+	}
+	/* Attribute not found. */
+	ntfs_debug("Attribute type 0x%x not found in $AttrDef.",
+			le32_to_cpu(type));
+	return NULL;
+}
+
+/**
+ * ntfs_attr_size_bounds_check - check a size of an attribute type for validity
+ * @vol:	ntfs volume to which the attribute belongs
+ * @type:	attribute type which to check
+ * @size:	size which to check
+ *
+ * Check whether the @size in bytes is valid for an attribute of @type on the
+ * ntfs volume @vol.  This information is obtained from $AttrDef system file.
+ */
+int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol, const __le32 type,
+		const s64 size)
+{
+	struct attr_def *ad;
+
+	BUG_ON(size < 0);
+	/*
+	 * $ATTRIBUTE_LIST has a maximum size of 256kiB, but this is not
+	 * listed in $AttrDef.
+	 */
+	if (unlikely(type == AT_ATTRIBUTE_LIST && size > 256 * 1024))
+		return -ERANGE;
+	/* Get the $AttrDef entry for the attribute @type. */
+	ad = ntfs_attr_find_in_attrdef(vol, type);
+	if (unlikely(!ad))
+		return -ENOENT;
+	/* Do the bounds check. */
+	if (((le64_to_cpu(ad->min_size) > 0) &&
+			size < le64_to_cpu(ad->min_size)) ||
+			((le64_to_cpu(ad->max_size) > 0) && size >
+			le64_to_cpu(ad->max_size)))
+		return -ERANGE;
+	return 0;
+}
+
+/**
+ * ntfs_attr_can_be_non_resident - check if an attribute can be non-resident
+ * @vol:	ntfs volume to which the attribute belongs
+ * @type:	attribute type which to check
+ *
+ * Check whether the attribute of @type on the ntfs volume @vol is allowed to
+ * be non-resident.  This information is obtained from $AttrDef system file.
+ */
+static int ntfs_attr_can_be_non_resident(const struct ntfs_volume *vol,
+		const __le32 type)
+{
+	struct attr_def *ad;
+
+	/* Find the attribute definition record in $AttrDef. */
+	ad = ntfs_attr_find_in_attrdef(vol, type);
+	if (unlikely(!ad))
+		return -ENOENT;
+	/* Check the flags and return the result. */
+	if (ad->flags & ATTR_DEF_RESIDENT)
+		return -EPERM;
+	return 0;
+}
+
+/**
+ * ntfs_attr_can_be_resident - check if an attribute can be resident
+ * @vol:	ntfs volume to which the attribute belongs
+ * @type:	attribute type which to check
+ *
+ * Check whether the attribute of @type on the ntfs volume @vol is allowed to
+ * be resident.  This information is derived from our ntfs knowledge and may
+ * not be completely accurate, especially when user defined attributes are
+ * present.  Basically we allow everything to be resident except for index
+ * allocation and $EA attributes.
+ *
+ * Return 0 if the attribute is allowed to be non-resident and -EPERM if not.
+ *
+ * Warning: In the system file $MFT the attribute $Bitmap must be non-resident
+ *	    otherwise windows will not boot (blue screen of death)!  We cannot
+ *	    check for this here as we do not know which inode's $Bitmap is
+ *	    being asked about so the caller needs to special case this.
+ */
+int ntfs_attr_can_be_resident(const struct ntfs_volume *vol, const __le32 type)
+{
+	if (type == AT_INDEX_ALLOCATION)
+		return -EPERM;
+	return 0;
+}
+
+/**
+ * ntfs_attr_record_resize - resize an attribute record
+ * @m:		mft record containing attribute record
+ * @a:		attribute record to resize
+ * @new_size:	new size in bytes to which to resize the attribute record @a
+ *
+ * Resize the attribute record @a, i.e. the resident part of the attribute, in
+ * the mft record @m to @new_size bytes.
+ */
+int ntfs_attr_record_resize(struct mft_record *m, struct attr_record *a, u32 new_size)
+{
+	u32 old_size, alloc_size, attr_size;
+
+	old_size   = le32_to_cpu(m->bytes_in_use);
+	alloc_size = le32_to_cpu(m->bytes_allocated);
+	attr_size  = le32_to_cpu(a->length);
+
+	ntfs_debug("Sizes: old=%u alloc=%u attr=%u new=%u\n",
+			(unsigned int)old_size, (unsigned int)alloc_size,
+			(unsigned int)attr_size, (unsigned int)new_size);
+
+	/* Align to 8 bytes if it is not already done. */
+	if (new_size & 7)
+		new_size = (new_size + 7) & ~7;
+	/* If the actual attribute length has changed, move things around. */
+	if (new_size != attr_size) {
+		u32 new_muse = le32_to_cpu(m->bytes_in_use) -
+				attr_size + new_size;
+		/* Not enough space in this mft record. */
+		if (new_muse > le32_to_cpu(m->bytes_allocated))
+			return -ENOSPC;
+
+		if (a->type == AT_INDEX_ROOT && new_size > attr_size &&
+			new_muse + 120 > alloc_size && old_size + 120 <= alloc_size) {
+			ntfs_debug("Too big struct index_root (%u > %u)\n",
+					new_muse, alloc_size);
+			return -ENOSPC;
+		}
+
+		/* Move attributes following @a to their new location. */
+		memmove((u8 *)a + new_size, (u8 *)a + le32_to_cpu(a->length),
+				le32_to_cpu(m->bytes_in_use) - ((u8 *)a -
+				(u8 *)m) - attr_size);
+		/* Adjust @m to reflect the change in used space. */
+		m->bytes_in_use = cpu_to_le32(new_muse);
+		/* Adjust @a to reflect the new size. */
+		if (new_size >= offsetof(struct attr_record, length) + sizeof(a->length))
+			a->length = cpu_to_le32(new_size);
+	}
+	return 0;
+}
+
+/**
+ * ntfs_resident_attr_value_resize - resize the value of a resident attribute
+ * @m:		mft record containing attribute record
+ * @a:		attribute record whose value to resize
+ * @new_size:	new size in bytes to which to resize the attribute value of @a
+ *
+ * Resize the value of the attribute @a in the mft record @m to @new_size bytes.
+ * If the value is made bigger, the newly allocated space is cleared.
+ */
+int ntfs_resident_attr_value_resize(struct mft_record *m, struct attr_record *a,
+		const u32 new_size)
+{
+	u32 old_size;
+
+	/* Resize the resident part of the attribute record. */
+	if (ntfs_attr_record_resize(m, a,
+			le16_to_cpu(a->data.resident.value_offset) + new_size))
+		return -ENOSPC;
+	/*
+	 * The resize succeeded!  If we made the attribute value bigger, clear
+	 * the area between the old size and @new_size.
+	 */
+	old_size = le32_to_cpu(a->data.resident.value_length);
+	if (new_size > old_size)
+		memset((u8 *)a + le16_to_cpu(a->data.resident.value_offset) +
+				old_size, 0, new_size - old_size);
+	/* Finally update the length of the attribute value. */
+	a->data.resident.value_length = cpu_to_le32(new_size);
+	return 0;
+}
+
+/**
+ * ntfs_attr_make_non_resident - convert a resident to a non-resident attribute
+ * @ni:		ntfs inode describing the attribute to convert
+ * @data_size:	size of the resident data to copy to the non-resident attribute
+ *
+ * Convert the resident ntfs attribute described by the ntfs inode @ni to a
+ * non-resident one.
+ *
+ * @data_size must be equal to the attribute value size.  This is needed since
+ * we need to know the size before we can map the mft record and our callers
+ * always know it.  The reason we cannot simply read the size from the vfs
+ * inode i_size is that this is not necessarily uptodate.  This happens when
+ * ntfs_attr_make_non_resident() is called in the ->truncate call path(s).
+ */
+int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
+{
+	s64 new_size;
+	struct inode *vi = VFS_I(ni);
+	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *base_ni;
+	struct mft_record *m;
+	struct attr_record *a;
+	struct ntfs_attr_search_ctx *ctx;
+	struct folio *folio;
+	struct runlist_element *rl;
+	u8 *kaddr;
+	unsigned long flags;
+	int mp_size, mp_ofs, name_ofs, arec_size, err, err2;
+	u32 attr_size;
+	u8 old_res_attr_flags;
+
+	if (NInoNonResident(ni)) {
+		ntfs_warning(vol->sb,
+			"Trying to make non-resident attribute non-resident.  Aborting...\n");
+		return -EINVAL;
+	}
+
+	/* Check that the attribute is allowed to be non-resident. */
+	err = ntfs_attr_can_be_non_resident(vol, ni->type);
+	if (unlikely(err)) {
+		if (err == -EPERM)
+			ntfs_debug("Attribute is not allowed to be non-resident.");
+		else
+			ntfs_debug("Attribute not defined on the NTFS volume!");
+		return err;
+	}
+
+	BUG_ON(NInoEncrypted(ni));
+
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->ext.base_ntfs_ino;
+	m = map_mft_record(base_ni);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		m = NULL;
+		ctx = NULL;
+		goto err_out;
+	}
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	if (unlikely(!ctx)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT)
+			err = -EIO;
+		goto err_out;
+	}
+	m = ctx->mrec;
+	a = ctx->attr;
+
+	/*
+	 * The size needs to be aligned to a cluster boundary for allocation
+	 * purposes.
+	 */
+	new_size = (data_size + vol->cluster_size - 1) &
+			~(vol->cluster_size - 1);
+	if (new_size > 0) {
+		if ((a->flags & ATTR_COMPRESSION_MASK) == ATTR_IS_COMPRESSED) {
+			/* must allocate full compression blocks */
+			new_size =
+				((new_size - 1) |
+				 ((1L << (STANDARD_COMPRESSION_UNIT +
+					  vol->cluster_size_bits)) - 1)) + 1;
+		}
+
+		/*
+		 * Will need folio later and since folio lock nests
+		 * outside all ntfs locks, we need to get the folio now.
+		 */
+		folio = __filemap_get_folio(vi->i_mapping, 0,
+					    FGP_CREAT | FGP_LOCK,
+					    mapping_gfp_mask(vi->i_mapping));
+		if (IS_ERR(folio)) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		/* Start by allocating clusters to hold the attribute value. */
+		rl = ntfs_cluster_alloc(vol, 0, new_size >>
+				vol->cluster_size_bits, -1, DATA_ZONE, true,
+				false, false);
+		if (IS_ERR(rl)) {
+			err = PTR_ERR(rl);
+			ntfs_debug("Failed to allocate cluster%s, error code %i.",
+					(new_size >> vol->cluster_size_bits) > 1 ? "s" : "",
+					err);
+			goto folio_err_out;
+		}
+	} else {
+		rl = NULL;
+		folio = NULL;
+	}
+
+	down_write(&ni->runlist.lock);
+	/* Determine the size of the mapping pairs array. */
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl, 0, -1, -1);
+	if (unlikely(mp_size < 0)) {
+		err = mp_size;
+		ntfs_debug("Failed to get size for mapping pairs array, error code %i.\n", err);
+		goto rl_err_out;
+	}
+
+	if (NInoNonResident(ni) || a->non_resident) {
+		err = -EIO;
+		goto rl_err_out;
+	}
+
+	/*
+	 * Calculate new offsets for the name and the mapping pairs array.
+	 */
+	if (NInoSparse(ni) || NInoCompressed(ni))
+		name_ofs = (offsetof(struct attr_record,
+				data.non_resident.compressed_size) +
+				sizeof(a->data.non_resident.compressed_size) +
+				7) & ~7;
+	else
+		name_ofs = (offsetof(struct attr_record,
+				data.non_resident.compressed_size) + 7) & ~7;
+	mp_ofs = (name_ofs + a->name_length * sizeof(__le16) + 7) & ~7;
+	/*
+	 * Determine the size of the resident part of the now non-resident
+	 * attribute record.
+	 */
+	arec_size = (mp_ofs + mp_size + 7) & ~7;
+	/*
+	 * If the folio is not uptodate bring it uptodate by copying from the
+	 * attribute value.
+	 */
+	attr_size = le32_to_cpu(a->data.resident.value_length);
+	BUG_ON(attr_size != data_size);
+	if (folio && !folio_test_uptodate(folio)) {
+		kaddr = kmap_local_folio(folio, 0);
+		memcpy(kaddr, (u8 *)a +
+				le16_to_cpu(a->data.resident.value_offset),
+				attr_size);
+		memset(kaddr + attr_size, 0, PAGE_SIZE - attr_size);
+		kunmap_local(kaddr);
+		flush_dcache_folio(folio);
+		folio_mark_uptodate(folio);
+	}
+
+	/* Backup the attribute flag. */
+	old_res_attr_flags = a->data.resident.flags;
+	/* Resize the resident part of the attribute record. */
+	err = ntfs_attr_record_resize(m, a, arec_size);
+	if (unlikely(err))
+		goto rl_err_out;
+
+	/*
+	 * Convert the resident part of the attribute record to describe a
+	 * non-resident attribute.
+	 */
+	a->non_resident = 1;
+	/* Move the attribute name if it exists and update the offset. */
+	if (a->name_length)
+		memmove((u8 *)a + name_ofs, (u8 *)a + le16_to_cpu(a->name_offset),
+				a->name_length * sizeof(__le16));
+	a->name_offset = cpu_to_le16(name_ofs);
+	/* Setup the fields specific to non-resident attributes. */
+	a->data.non_resident.lowest_vcn = 0;
+	a->data.non_resident.highest_vcn = cpu_to_le64((new_size - 1) >>
+			vol->cluster_size_bits);
+	a->data.non_resident.mapping_pairs_offset = cpu_to_le16(mp_ofs);
+	memset(&a->data.non_resident.reserved, 0,
+			sizeof(a->data.non_resident.reserved));
+	a->data.non_resident.allocated_size = cpu_to_le64(new_size);
+	a->data.non_resident.data_size =
+			a->data.non_resident.initialized_size =
+			cpu_to_le64(attr_size);
+	if (NInoSparse(ni) || NInoCompressed(ni)) {
+		a->data.non_resident.compression_unit = 0;
+		if (NInoCompressed(ni) || vol->major_ver < 3)
+			a->data.non_resident.compression_unit = 4;
+		a->data.non_resident.compressed_size =
+				a->data.non_resident.allocated_size;
+	} else
+		a->data.non_resident.compression_unit = 0;
+	/* Generate the mapping pairs array into the attribute record. */
+	err = ntfs_mapping_pairs_build(vol, (u8 *)a + mp_ofs,
+			arec_size - mp_ofs, rl, 0, -1, NULL, NULL, NULL);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Failed to build mapping pairs, error code %i.",
+				err);
+		goto undo_err_out;
+	}
+
+	/* Setup the in-memory attribute structure to be non-resident. */
+	ni->runlist.rl = rl;
+	if (rl) {
+		for (ni->runlist.count = 1; rl->length != 0; rl++)
+			ni->runlist.count++;
+	} else
+		ni->runlist.count = 0;
+	write_lock_irqsave(&ni->size_lock, flags);
+	ni->allocated_size = new_size;
+	if (NInoSparse(ni) || NInoCompressed(ni)) {
+		ni->itype.compressed.size = ni->allocated_size;
+		if (a->data.non_resident.compression_unit) {
+			ni->itype.compressed.block_size = 1U <<
+				(a->data.non_resident.compression_unit +
+				 vol->cluster_size_bits);
+			ni->itype.compressed.block_size_bits =
+					ffs(ni->itype.compressed.block_size) -
+					1;
+			ni->itype.compressed.block_clusters = 1U <<
+					a->data.non_resident.compression_unit;
+		} else {
+			ni->itype.compressed.block_size = 0;
+			ni->itype.compressed.block_size_bits = 0;
+			ni->itype.compressed.block_clusters = 0;
+		}
+		vi->i_blocks = ni->itype.compressed.size >> 9;
+	} else
+		vi->i_blocks = ni->allocated_size >> 9;
+	write_unlock_irqrestore(&ni->size_lock, flags);
+	/*
+	 * This needs to be last since the address space operations ->read_folio
+	 * and ->writepage can run concurrently with us as they are not
+	 * serialized on i_mutex.  Note, we are not allowed to fail once we flip
+	 * this switch, which is another reason to do this last.
+	 */
+	NInoSetNonResident(ni);
+	NInoSetFullyMapped(ni);
+	/* Mark the mft record dirty, so it gets written back. */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+	up_write(&ni->runlist.lock);
+	if (folio) {
+		iomap_dirty_folio(vi->i_mapping, folio);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+	ntfs_debug("Done.");
+	return 0;
+undo_err_out:
+	/* Convert the attribute back into a resident attribute. */
+	a->non_resident = 0;
+	/* Move the attribute name if it exists and update the offset. */
+	name_ofs = (offsetof(struct attr_record, data.resident.reserved) +
+			sizeof(a->data.resident.reserved) + 7) & ~7;
+	if (a->name_length)
+		memmove((u8 *)a + name_ofs, (u8 *)a + le16_to_cpu(a->name_offset),
+				a->name_length * sizeof(__le16));
+	mp_ofs = (name_ofs + a->name_length * sizeof(__le16) + 7) & ~7;
+	a->name_offset = cpu_to_le16(name_ofs);
+	arec_size = (mp_ofs + attr_size + 7) & ~7;
+	/* Resize the resident part of the attribute record. */
+	err2 = ntfs_attr_record_resize(m, a, arec_size);
+	if (unlikely(err2)) {
+		/*
+		 * This cannot happen (well if memory corruption is at work it
+		 * could happen in theory), but deal with it as well as we can.
+		 * If the old size is too small, truncate the attribute,
+		 * otherwise simply give it a larger allocated size.
+		 */
+		arec_size = le32_to_cpu(a->length);
+		if ((mp_ofs + attr_size) > arec_size) {
+			err2 = attr_size;
+			attr_size = arec_size - mp_ofs;
+			ntfs_error(vol->sb,
+				"Failed to undo partial resident to non-resident attribute conversion.  Truncating inode 0x%lx, attribute type 0x%x from %i bytes to %i bytes to maintain metadata consistency.  THIS MEANS YOU ARE LOSING %i BYTES DATA FROM THIS %s.",
+					vi->i_ino,
+					(unsigned int)le32_to_cpu(ni->type),
+					err2, attr_size, err2 - attr_size,
+					((ni->type == AT_DATA) &&
+					!ni->name_len) ? "FILE" : "ATTRIBUTE");
+			write_lock_irqsave(&ni->size_lock, flags);
+			ni->initialized_size = attr_size;
+			i_size_write(vi, attr_size);
+			write_unlock_irqrestore(&ni->size_lock, flags);
+		}
+	}
+	/* Setup the fields specific to resident attributes. */
+	a->data.resident.value_length = cpu_to_le32(attr_size);
+	a->data.resident.value_offset = cpu_to_le16(mp_ofs);
+	a->data.resident.flags = old_res_attr_flags;
+	memset(&a->data.resident.reserved, 0,
+			sizeof(a->data.resident.reserved));
+	/* Copy the data from folio back to the attribute value. */
+	if (folio)
+		memcpy_from_folio((u8 *)a + mp_ofs, folio, 0, attr_size);
+	/* Setup the allocated size in the ntfs inode in case it changed. */
+	write_lock_irqsave(&ni->size_lock, flags);
+	ni->allocated_size = arec_size - mp_ofs;
+	write_unlock_irqrestore(&ni->size_lock, flags);
+	/* Mark the mft record dirty, so it gets written back. */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+rl_err_out:
+	up_write(&ni->runlist.lock);
+	if (rl) {
+		if (ntfs_cluster_free_from_rl(vol, rl) < 0) {
+			ntfs_error(vol->sb,
+				"Failed to release allocated cluster(s) in error code path.  Run chkdsk to recover the lost cluster(s).");
+			NVolSetErrors(vol);
+		}
+		ntfs_free(rl);
+folio_err_out:
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+err_out:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(base_ni);
+	ni->runlist.rl = NULL;
+
+	if (err == -EINVAL)
+		err = -EIO;
+	return err;
+}
+
+/**
+ * ntfs_attr_set - fill (a part of) an attribute with a byte
+ * @ni:		ntfs inode describing the attribute to fill
+ * @ofs:	offset inside the attribute at which to start to fill
+ * @cnt:	number of bytes to fill
+ * @val:	the unsigned 8-bit value with which to fill the attribute
+ *
+ * Fill @cnt bytes of the attribute described by the ntfs inode @ni starting at
+ * byte offset @ofs inside the attribute with the constant byte @val.
+ *
+ * This function is effectively like memset() applied to an ntfs attribute.
+ * Note thie function actually only operates on the page cache pages belonging
+ * to the ntfs attribute and it marks them dirty after doing the memset().
+ * Thus it relies on the vm dirty page write code paths to cause the modified
+ * pages to be written to the mft record/disk.
+ */
+int ntfs_attr_set(struct ntfs_inode *ni, s64 ofs, s64 cnt, const u8 val)
+{
+	struct address_space *mapping = VFS_I(ni)->i_mapping;
+	struct folio *folio;
+	pgoff_t index;
+	u8 *addr;
+	unsigned long offset;
+	size_t attr_len;
+	int ret = 0;
+
+	index = ofs >> PAGE_SHIFT;
+	while (cnt) {
+		folio = ntfs_read_mapping_folio(mapping, index);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			ntfs_error(VFS_I(ni)->i_sb, "Failed to read a page %lu for attr %#x: %ld",
+				   index, ni->type, PTR_ERR(folio));
+			break;
+		}
+
+		offset = offset_in_folio(folio, ofs);
+		attr_len = min_t(size_t, (size_t)cnt, folio_size(folio) - offset);
+
+		folio_lock(folio);
+		addr = kmap_local_folio(folio, offset);
+		memset(addr, val, attr_len);
+		kunmap_local(addr);
+
+		flush_dcache_folio(folio);
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+
+		ofs += attr_len;
+		cnt -= attr_len;
+		index++;
+		cond_resched();
+	}
+
+	return ret;
+}
+
+int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	int err = 0;
+
+	if (!NInoNonResident(ni))
+		return -EINVAL;
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx)
+		return -ENOMEM;
+
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			       CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (err)
+		goto out_ctx;
+
+	ctx->attr->data.non_resident.initialized_size = cpu_to_le64(new_size);
+	ni->initialized_size = new_size;
+	mark_mft_record_dirty(ctx->ntfs_ino);
+out_ctx:
+	ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
+/**
+ * ntfs_make_room_for_attr - make room for an attribute inside an mft record
+ * @m:		mft record
+ * @pos:	position at which to make space
+ * @size:	byte size to make available at this position
+ *
+ * @pos points to the attribute in front of which we want to make space.
+ */
+static int ntfs_make_room_for_attr(struct mft_record *m, u8 *pos, u32 size)
+{
+	u32 biu;
+
+	ntfs_debug("Entering for pos 0x%x, size %u.\n",
+			(int)(pos - (u8 *)m), (unsigned int) size);
+
+	/* Make size 8-byte alignment. */
+	size = (size + 7) & ~7;
+
+	/* Rigorous consistency checks. */
+	if (!m || !pos || pos < (u8 *)m) {
+		pr_err("%s: pos=%p  m=%p", __func__, pos, m);
+		return -EINVAL;
+	}
+
+	/* The -8 is for the attribute terminator. */
+	if (pos - (u8 *)m > (int)le32_to_cpu(m->bytes_in_use) - 8)
+		return -EINVAL;
+	/* Nothing to do. */
+	if (!size)
+		return 0;
+
+	biu = le32_to_cpu(m->bytes_in_use);
+	/* Do we have enough space? */
+	if (biu + size > le32_to_cpu(m->bytes_allocated) ||
+	    pos + size > (u8 *)m + le32_to_cpu(m->bytes_allocated)) {
+		ntfs_debug("No enough space in the MFT record\n");
+		return -ENOSPC;
+	}
+	/* Move everything after pos to pos + size. */
+	memmove(pos + size, pos, biu - (pos - (u8 *)m));
+	/* Update mft record. */
+	m->bytes_in_use = cpu_to_le32(biu + size);
+	return 0;
+}
+
+/**
+ * ntfs_resident_attr_record_add - add resident attribute to inode
+ * @ni:		opened ntfs inode to which MFT record add attribute
+ * @type:	type of the new attribute
+ * @name:	name of the new attribute
+ * @name_len:	name length of the new attribute
+ * @val:	value of the new attribute
+ * @size:	size of new attribute (length of @val, if @val != NULL)
+ * @flags:	flags of the new attribute
+ */
+int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, u32 size,
+		__le16 flags)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	u32 length;
+	struct attr_record *a;
+	struct mft_record *m;
+	int err, offset;
+	struct ntfs_inode *base_ni;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, flags 0x%x.\n",
+			(long long) ni->mft_no, (unsigned int) le32_to_cpu(type),
+			(unsigned int) le16_to_cpu(flags));
+
+	if (!ni || (!name && name_len))
+		return -EINVAL;
+
+	err = ntfs_attr_can_be_resident(ni->vol, type);
+	if (err) {
+		if (err == -EPERM)
+			ntfs_debug("Attribute can't be resident.\n");
+		else
+			ntfs_debug("ntfs_attr_can_be_resident failed.\n");
+		return err;
+	}
+
+	/* Locate place where record should be. */
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		ntfs_error(ni->vol->sb, "%s: Failed to get search context",
+				__func__);
+		return -ENOMEM;
+	}
+	/*
+	 * Use ntfs_attr_find instead of ntfs_attr_lookup to find place for
+	 * attribute in @ni->mrec, not any extent inode in case if @ni is base
+	 * file record.
+	 */
+	err = ntfs_attr_find(type, name, name_len, CASE_SENSITIVE, val, size, ctx);
+	if (!err) {
+		err = -EEXIST;
+		ntfs_debug("Attribute already present.\n");
+		goto put_err_out;
+	}
+	if (err != -ENOENT) {
+		err = -EIO;
+		goto put_err_out;
+	}
+	a = ctx->attr;
+	m = ctx->mrec;
+
+	/* Make room for attribute. */
+	length = offsetof(struct attr_record, data.resident.reserved) +
+			  sizeof(a->data.resident.reserved) +
+		((name_len * sizeof(__le16) + 7) & ~7) +
+		((size + 7) & ~7);
+	err = ntfs_make_room_for_attr(ctx->mrec, (u8 *) ctx->attr, length);
+	if (err) {
+		ntfs_debug("Failed to make room for attribute.\n");
+		goto put_err_out;
+	}
+
+	/* Setup record fields. */
+	offset = ((u8 *)a - (u8 *)m);
+	a->type = type;
+	a->length = cpu_to_le32(length);
+	a->non_resident = 0;
+	a->name_length = name_len;
+	a->name_offset =
+		name_len ? cpu_to_le16((offsetof(struct attr_record, data.resident.reserved) +
+				sizeof(a->data.resident.reserved))) : cpu_to_le16(0);
+
+	a->flags = flags;
+	a->instance = m->next_attr_instance;
+	a->data.resident.value_length = cpu_to_le32(size);
+	a->data.resident.value_offset = cpu_to_le16(length - ((size + 7) & ~7));
+	if (val)
+		memcpy((u8 *)a + le16_to_cpu(a->data.resident.value_offset), val, size);
+	else
+		memset((u8 *)a + le16_to_cpu(a->data.resident.value_offset), 0, size);
+	if (type == AT_FILE_NAME)
+		a->data.resident.flags = RESIDENT_ATTR_IS_INDEXED;
+	else
+		a->data.resident.flags = 0;
+	if (name_len)
+		memcpy((u8 *)a + le16_to_cpu(a->name_offset),
+				name, sizeof(__le16) * name_len);
+	m->next_attr_instance =
+		cpu_to_le16((le16_to_cpu(m->next_attr_instance) + 1) & 0xffff);
+	if (ni->nr_extents == -1)
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+	if (type != AT_ATTRIBUTE_LIST && NInoAttrList(base_ni)) {
+		err = ntfs_attrlist_entry_add(ni, a);
+		if (err) {
+			ntfs_attr_record_resize(m, a, 0);
+			mark_mft_record_dirty(ctx->ntfs_ino);
+			ntfs_debug("Failed add attribute entry to ATTRIBUTE_LIST.\n");
+			goto put_err_out;
+		}
+	}
+	mark_mft_record_dirty(ni);
+	ntfs_attr_put_search_ctx(ctx);
+	return offset;
+put_err_out:
+	ntfs_attr_put_search_ctx(ctx);
+	return -EIO;
+}
+
+/**
+ * ntfs_non_resident_attr_record_add - add extent of non-resident attribute
+ * @ni:			opened ntfs inode to which MFT record add attribute
+ * @type:		type of the new attribute extent
+ * @name:		name of the new attribute extent
+ * @name_len:		name length of the new attribute extent
+ * @lowest_vcn:		lowest vcn of the new attribute extent
+ * @dataruns_size:	dataruns size of the new attribute extent
+ * @flags:		flags of the new attribute extent
+ */
+static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, s64 lowest_vcn, int dataruns_size,
+		__le16 flags)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	u32 length;
+	struct attr_record *a;
+	struct mft_record *m;
+	struct ntfs_inode *base_ni;
+	int err, offset;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, lowest_vcn %lld, dataruns_size %d, flags 0x%x.\n",
+			(long long) ni->mft_no, (unsigned int) le32_to_cpu(type),
+			(long long) lowest_vcn, dataruns_size,
+			(unsigned int) le16_to_cpu(flags));
+
+	if (!ni || dataruns_size <= 0 || (!name && name_len))
+		return -EINVAL;
+
+	err = ntfs_attr_can_be_non_resident(ni->vol, type);
+	if (err) {
+		if (err == -EPERM)
+			pr_err("Attribute can't be non resident");
+		else
+			pr_err("ntfs_attr_can_be_non_resident failed");
+		return err;
+	}
+
+	/* Locate place where record should be. */
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		pr_err("%s: Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+	/*
+	 * Use ntfs_attr_find instead of ntfs_attr_lookup to find place for
+	 * attribute in @ni->mrec, not any extent inode in case if @ni is base
+	 * file record.
+	 */
+	err = ntfs_attr_find(type, name, name_len, CASE_SENSITIVE, NULL, 0, ctx);
+	if (!err) {
+		err = -EEXIST;
+		pr_err("Attribute 0x%x already present", type);
+		goto put_err_out;
+	}
+	if (err != -ENOENT) {
+		pr_err("ntfs_attr_find failed");
+		err = -EIO;
+		goto put_err_out;
+	}
+	a = ctx->attr;
+	m = ctx->mrec;
+
+	/* Make room for attribute. */
+	dataruns_size = (dataruns_size + 7) & ~7;
+	length = offsetof(struct attr_record, data.non_resident.compressed_size) +
+		((sizeof(__le16) * name_len + 7) & ~7) + dataruns_size +
+		((flags & (ATTR_IS_COMPRESSED | ATTR_IS_SPARSE)) ?
+		 sizeof(a->data.non_resident.compressed_size) : 0);
+	err = ntfs_make_room_for_attr(ctx->mrec, (u8 *) ctx->attr, length);
+	if (err) {
+		pr_err("Failed to make room for attribute");
+		goto put_err_out;
+	}
+
+	/* Setup record fields. */
+	a->type = type;
+	a->length = cpu_to_le32(length);
+	a->non_resident = 1;
+	a->name_length = name_len;
+	a->name_offset = cpu_to_le16(offsetof(struct attr_record,
+					      data.non_resident.compressed_size) +
+			((flags & (ATTR_IS_COMPRESSED | ATTR_IS_SPARSE)) ?
+			 sizeof(a->data.non_resident.compressed_size) : 0));
+	a->flags = flags;
+	a->instance = m->next_attr_instance;
+	a->data.non_resident.lowest_vcn = cpu_to_le64(lowest_vcn);
+	a->data.non_resident.mapping_pairs_offset = cpu_to_le16(length - dataruns_size);
+	a->data.non_resident.compression_unit =
+		(flags & ATTR_IS_COMPRESSED) ? STANDARD_COMPRESSION_UNIT : 0;
+	/* If @lowest_vcn == 0, than setup empty attribute. */
+	if (!lowest_vcn) {
+		a->data.non_resident.highest_vcn = cpu_to_le64(-1);
+		a->data.non_resident.allocated_size = 0;
+		a->data.non_resident.data_size = 0;
+		a->data.non_resident.initialized_size = 0;
+		/* Set empty mapping pairs. */
+		*((u8 *)a + le16_to_cpu(a->data.non_resident.mapping_pairs_offset)) = 0;
+	}
+	if (name_len)
+		memcpy((u8 *)a + le16_to_cpu(a->name_offset),
+				name, sizeof(__le16) * name_len);
+	m->next_attr_instance =
+		cpu_to_le16((le16_to_cpu(m->next_attr_instance) + 1) & 0xffff);
+	if (ni->nr_extents == -1)
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+	if (type != AT_ATTRIBUTE_LIST && NInoAttrList(base_ni)) {
+		err = ntfs_attrlist_entry_add(ni, a);
+		if (err) {
+			pr_err("Failed add attr entry to attrlist");
+			ntfs_attr_record_resize(m, a, 0);
+			goto put_err_out;
+		}
+	}
+	mark_mft_record_dirty(ni);
+	/*
+	 * Locate offset from start of the MFT record where new attribute is
+	 * placed. We need relookup it, because record maybe moved during
+	 * update of attribute list.
+	 */
+	ntfs_attr_reinit_search_ctx(ctx);
+	err = ntfs_attr_lookup(type, name, name_len, CASE_SENSITIVE,
+				lowest_vcn, NULL, 0, ctx);
+	if (err) {
+		pr_err("%s: attribute lookup failed", __func__);
+		ntfs_attr_put_search_ctx(ctx);
+		return err;
+
+	}
+	offset = (u8 *)ctx->attr - (u8 *)ctx->mrec;
+	ntfs_attr_put_search_ctx(ctx);
+	return offset;
+put_err_out:
+	ntfs_attr_put_search_ctx(ctx);
+	return -1;
+}
+
+/**
+ * ntfs_attr_record_rm - remove attribute extent
+ * @ctx:	search context describing the attribute which should be removed
+ *
+ * If this function succeed, user should reinit search context if he/she wants
+ * use it anymore.
+ */
+int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
+{
+	struct ntfs_inode *base_ni, *ni;
+	__le32 type;
+	int err;
+
+	if (!ctx || !ctx->ntfs_ino || !ctx->mrec || !ctx->attr)
+		return -EINVAL;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x.\n",
+			(long long) ctx->ntfs_ino->mft_no,
+			(unsigned int) le32_to_cpu(ctx->attr->type));
+	type = ctx->attr->type;
+	ni = ctx->ntfs_ino;
+	if (ctx->base_ntfs_ino)
+		base_ni = ctx->base_ntfs_ino;
+	else
+		base_ni = ctx->ntfs_ino;
+
+	/* Remove attribute itself. */
+	if (ntfs_attr_record_resize(ctx->mrec, ctx->attr, 0)) {
+		ntfs_debug("Couldn't remove attribute record. Bug or damaged MFT record.\n");
+		return -EIO;
+	}
+	mark_mft_record_dirty(ni);
+
+	/*
+	 * Remove record from $ATTRIBUTE_LIST if present and we don't want
+	 * delete $ATTRIBUTE_LIST itself.
+	 */
+	if (NInoAttrList(base_ni) && type != AT_ATTRIBUTE_LIST) {
+		err = ntfs_attrlist_entry_rm(ctx);
+		if (err) {
+			ntfs_debug("Couldn't delete record from $ATTRIBUTE_LIST.\n");
+			return err;
+		}
+	}
+
+	/* Post $ATTRIBUTE_LIST delete setup. */
+	if (type == AT_ATTRIBUTE_LIST) {
+		if (NInoAttrList(base_ni) && base_ni->attr_list)
+			ntfs_free(base_ni->attr_list);
+		base_ni->attr_list = NULL;
+		NInoClearAttrList(base_ni);
+	}
+
+	/* Free MFT record, if it doesn't contain attributes. */
+	if (le32_to_cpu(ctx->mrec->bytes_in_use) -
+			le16_to_cpu(ctx->mrec->attrs_offset) == 8) {
+		if (ntfs_mft_record_free(ni->vol, ni)) {
+			ntfs_debug("Couldn't free MFT record.\n");
+			return -EIO;
+		}
+		/* Remove done if we freed base inode. */
+		if (ni == base_ni)
+			return 0;
+		ntfs_inode_close(ni);
+		ctx->ntfs_ino = ni = NULL;
+	}
+
+	if (type == AT_ATTRIBUTE_LIST || !NInoAttrList(base_ni))
+		return 0;
+
+	/* Remove attribute list if we don't need it any more. */
+	if (!ntfs_attrlist_need(base_ni)) {
+		struct ntfs_attr na;
+		struct inode *attr_vi;
+
+		ntfs_attr_reinit_search_ctx(ctx);
+		if (ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, CASE_SENSITIVE,
+					0, NULL, 0, ctx)) {
+			ntfs_debug("Couldn't find attribute list. Succeed anyway.\n");
+			return 0;
+		}
+		/* Deallocate clusters. */
+		if (ctx->attr->non_resident) {
+			struct runlist_element *al_rl;
+			size_t new_rl_count;
+
+			al_rl = ntfs_mapping_pairs_decompress(base_ni->vol,
+					ctx->attr, NULL, &new_rl_count);
+			if (IS_ERR(al_rl)) {
+				ntfs_debug("Couldn't decompress attribute list runlist. Succeed anyway.\n");
+				return 0;
+			}
+			if (ntfs_cluster_free_from_rl(base_ni->vol, al_rl))
+				ntfs_debug("Leaking clusters! Run chkdsk. Couldn't free clusters from attribute list runlist.\n");
+			ntfs_free(al_rl);
+		}
+		/* Remove attribute record itself. */
+		if (ntfs_attr_record_rm(ctx)) {
+			ntfs_debug("Couldn't remove attribute list. Succeed anyway.\n");
+			return 0;
+		}
+
+		na.mft_no = VFS_I(base_ni)->i_ino;
+		na.type = AT_ATTRIBUTE_LIST;
+		na.name = NULL;
+		na.name_len = 0;
+
+		attr_vi = ilookup5(VFS_I(base_ni)->i_sb, VFS_I(base_ni)->i_ino,
+				   ntfs_test_inode, &na);
+		if (attr_vi) {
+			clear_nlink(attr_vi);
+			iput(attr_vi);
+		}
+
+	}
+	return 0;
+}
+
+/**
+ * ntfs_attr_add - add attribute to inode
+ * @ni:		opened ntfs inode to which add attribute
+ * @type:	type of the new attribute
+ * @name:	name in unicode of the new attribute
+ * @name_len:	name length in unicode characters of the new attribute
+ * @val:	value of new attribute
+ * @size:	size of the new attribute / length of @val (if specified)
+ *
+ * @val should always be specified for always resident attributes (eg. FILE_NAME
+ * attribute), for attributes that can become non-resident @val can be NULL
+ * (eg. DATA attribute). @size can be specified even if @val is NULL, in this
+ * case data size will be equal to @size and initialized size will be equal
+ * to 0.
+ *
+ * If inode haven't got enough space to add attribute, add attribute to one of
+ * it extents, if no extents present or no one of them have enough space, than
+ * allocate new extent and add attribute to it.
+ *
+ * If on one of this steps attribute list is needed but not present, than it is
+ * added transparently to caller. So, this function should not be called with
+ * @type == AT_ATTRIBUTE_LIST, if you really need to add attribute list call
+ * ntfs_inode_add_attrlist instead.
+ *
+ * On success return 0. On error return -1 with errno set to the error code.
+ */
+int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, s64 size)
+{
+	struct super_block *sb;
+	u32 attr_rec_size;
+	int err, i, offset;
+	bool is_resident;
+	bool can_be_non_resident = false;
+	struct ntfs_inode *attr_ni;
+	struct inode *attr_vi;
+	struct mft_record *ni_mrec;
+
+	if (!ni || size < 0 || type == AT_ATTRIBUTE_LIST)
+		return -EINVAL;
+
+	ntfs_debug("Entering for inode 0x%llx, attr %x, size %lld.\n",
+			(long long) ni->mft_no, type, size);
+
+	if (ni->nr_extents == -1)
+		ni = ni->ext.base_ntfs_ino;
+
+	/* Check the attribute type and the size. */
+	err = ntfs_attr_size_bounds_check(ni->vol, type, size);
+	if (err) {
+		if (err == -ENOENT)
+			err = -EIO;
+		return err;
+	}
+
+	sb = ni->vol->sb;
+	/* Sanity checks for always resident attributes. */
+	err = ntfs_attr_can_be_non_resident(ni->vol, type);
+	if (err) {
+		if (err != -EPERM) {
+			ntfs_error(sb, "ntfs_attr_can_be_non_resident failed");
+			goto err_out;
+		}
+		/* @val is mandatory. */
+		if (!val) {
+			ntfs_error(sb,
+				"val is mandatory for always resident attributes");
+			return -EINVAL;
+		}
+		if (size > ni->vol->mft_record_size) {
+			ntfs_error(sb, "Attribute is too big");
+			return -ERANGE;
+		}
+	} else
+		can_be_non_resident = true;
+
+	/*
+	 * Determine resident or not will be new attribute. We add 8 to size in
+	 * non resident case for mapping pairs.
+	 */
+	err = ntfs_attr_can_be_resident(ni->vol, type);
+	if (!err) {
+		is_resident = true;
+	} else {
+		if (err != -EPERM) {
+			ntfs_error(sb, "ntfs_attr_can_be_resident failed");
+			goto err_out;
+		}
+		is_resident = false;
+	}
+
+	/* Calculate attribute record size. */
+	if (is_resident)
+		attr_rec_size = offsetof(struct attr_record, data.resident.reserved) +
+			1 +
+			((name_len * sizeof(__le16) + 7) & ~7) +
+			((size + 7) & ~7);
+	else
+		attr_rec_size = offsetof(struct attr_record, data.non_resident.compressed_size) +
+			((name_len * sizeof(__le16) + 7) & ~7) + 8;
+
+	/*
+	 * If we have enough free space for the new attribute in the base MFT
+	 * record, then add attribute to it.
+	 */
+retry:
+	ni_mrec = map_mft_record(ni);
+	if (IS_ERR(ni_mrec)) {
+		err = -EIO;
+		goto err_out;
+	}
+
+	if (le32_to_cpu(ni_mrec->bytes_allocated) -
+			le32_to_cpu(ni_mrec->bytes_in_use) >= attr_rec_size) {
+		attr_ni = ni;
+		unmap_mft_record(ni);
+		goto add_attr_record;
+	}
+	unmap_mft_record(ni);
+
+	/* Try to add to extent inodes. */
+	err = ntfs_inode_attach_all_extents(ni);
+	if (err) {
+		ntfs_error(sb, "Failed to attach all extents to inode");
+		goto err_out;
+	}
+
+	for (i = 0; i < ni->nr_extents; i++) {
+		attr_ni = ni->ext.extent_ntfs_inos[i];
+		ni_mrec = map_mft_record(attr_ni);
+		if (IS_ERR(ni_mrec)) {
+			err = -EIO;
+			goto err_out;
+		}
+
+		if (le32_to_cpu(ni_mrec->bytes_allocated) -
+				le32_to_cpu(ni_mrec->bytes_in_use) >=
+				attr_rec_size) {
+			unmap_mft_record(attr_ni);
+			goto add_attr_record;
+		}
+		unmap_mft_record(attr_ni);
+	}
+
+	/* There is no extent that contain enough space for new attribute. */
+	if (!NInoAttrList(ni)) {
+		/* Add attribute list not present, add it and retry. */
+		err = ntfs_inode_add_attrlist(ni);
+		if (err) {
+			ntfs_error(sb, "Failed to add attribute list");
+			goto err_out;
+		}
+		goto retry;
+	}
+
+	attr_ni = NULL;
+	/* Allocate new extent. */
+	err = ntfs_mft_record_alloc(ni->vol, 0, &attr_ni, ni, NULL);
+	if (err) {
+		ntfs_error(sb, "Failed to allocate extent record");
+		goto err_out;
+	}
+	unmap_mft_record(attr_ni);
+
+add_attr_record:
+	if (is_resident) {
+		/* Add resident attribute. */
+		offset = ntfs_resident_attr_record_add(attr_ni, type, name,
+				name_len, val, size, 0);
+		if (offset < 0) {
+			if (offset == -ENOSPC && can_be_non_resident)
+				goto add_non_resident;
+			err = offset;
+			ntfs_error(sb, "Failed to add resident attribute");
+			goto free_err_out;
+		}
+		return 0;
+	}
+
+add_non_resident:
+	/* Add non resident attribute. */
+	offset = ntfs_non_resident_attr_record_add(attr_ni, type, name,
+			name_len, 0, 8, 0);
+	if (offset < 0) {
+		err = offset;
+		ntfs_error(sb, "Failed to add non resident attribute");
+		goto free_err_out;
+	}
+
+	/* If @size == 0, we are done. */
+	if (!size)
+		return 0;
+
+	/* Open new attribute and resize it. */
+	attr_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
+	if (IS_ERR(attr_vi)) {
+		ntfs_error(sb, "Failed to open just added attribute");
+		goto rm_attr_err_out;
+	}
+	attr_ni = NTFS_I(attr_vi);
+
+	/* Resize and set attribute value. */
+	if (ntfs_attr_truncate(attr_ni, size) ||
+		(val && (ntfs_inode_attr_pwrite(attr_vi, 0, size, val, false) != size))) {
+		err = -EIO;
+		ntfs_error(sb, "Failed to initialize just added attribute");
+		if (ntfs_attr_rm(attr_ni))
+			ntfs_error(sb, "Failed to remove just added attribute");
+		iput(attr_vi);
+		goto err_out;
+	}
+	iput(attr_vi);
+	return 0;
+
+rm_attr_err_out:
+	/* Remove just added attribute. */
+	ni_mrec = map_mft_record(attr_ni);
+	if (!IS_ERR(ni_mrec)) {
+		if (ntfs_attr_record_resize(ni_mrec,
+					(struct attr_record *)((u8 *)ni_mrec + offset), 0))
+			ntfs_error(sb, "Failed to remove just added attribute #2");
+		unmap_mft_record(attr_ni);
+	} else
+		pr_err("EIO when try to remove new added attr\n");
+
+free_err_out:
+	/* Free MFT record, if it doesn't contain attributes. */
+	ni_mrec = map_mft_record(attr_ni);
+	if (!IS_ERR(ni_mrec)) {
+		int attr_size;
+
+		attr_size = le32_to_cpu(ni_mrec->bytes_in_use) -
+			le16_to_cpu(ni_mrec->attrs_offset);
+		unmap_mft_record(attr_ni);
+		if (attr_size == 8) {
+			if (ntfs_mft_record_free(attr_ni->vol, attr_ni))
+				ntfs_error(sb, "Failed to free MFT record");
+			if (attr_ni->nr_extents < 0)
+				ntfs_inode_close(attr_ni);
+		}
+	} else
+		pr_err("EIO when testing mft record is free-able\n");
+
+err_out:
+	return err;
+}
+
+/**
+ * __ntfs_attr_init - primary initialization of an ntfs attribute structure
+ * @ni:		ntfs attribute inode to initialize
+ * @ni:		ntfs inode with which to initialize the ntfs attribute
+ * @type:	attribute type
+ * @name:	attribute name in little endian Unicode or NULL
+ * @name_len:	length of attribute @name in Unicode characters (if @name given)
+ *
+ * Initialize the ntfs attribute @na with @ni, @type, @name, and @name_len.
+ */
+static void __ntfs_attr_init(struct ntfs_inode *ni,
+		const __le32 type, __le16 *name, const u32 name_len)
+{
+	ni->runlist.rl = NULL;
+	ni->type = type;
+	ni->name = name;
+	if (name)
+		ni->name_len = name_len;
+	else
+		ni->name_len = 0;
+}
+
+/**
+ * ntfs_attr_init - initialize an ntfs_attr with data sizes and status
+ * Final initialization for an ntfs attribute.
+ */
+static void ntfs_attr_init(struct ntfs_inode *ni, const bool non_resident,
+		const bool compressed, const bool encrypted, const bool sparse,
+		const s64 allocated_size, const s64 data_size,
+		const s64 initialized_size, const s64 compressed_size,
+		const u8 compression_unit)
+{
+	if (non_resident)
+		NInoSetNonResident(ni);
+	if (compressed) {
+		NInoSetCompressed(ni);
+		ni->flags |= FILE_ATTR_COMPRESSED;
+	}
+	if (encrypted) {
+		NInoSetEncrypted(ni);
+		ni->flags |= FILE_ATTR_ENCRYPTED;
+	}
+	if (sparse) {
+		NInoSetSparse(ni);
+		ni->flags |= FILE_ATTR_SPARSE_FILE;
+	}
+	ni->allocated_size = allocated_size;
+	ni->data_size = data_size;
+	ni->initialized_size = initialized_size;
+	if (compressed || sparse) {
+		struct ntfs_volume *vol = ni->vol;
+
+		ni->itype.compressed.size = compressed_size;
+		ni->itype.compressed.block_clusters = 1 << compression_unit;
+		ni->itype.compressed.block_size = 1 << (compression_unit +
+				vol->cluster_size_bits);
+		ni->itype.compressed.block_size_bits = ffs(
+				ni->itype.compressed.block_size) - 1;
+	}
+}
+
+/**
+ * ntfs_attr_open - open an ntfs attribute for access
+ * @ni:		open ntfs inode in which the ntfs attribute resides
+ * @type:	attribute type
+ * @name:	attribute name in little endian Unicode or AT_UNNAMED or NULL
+ * @name_len:	length of attribute @name in Unicode characters (if @name given)
+ */
+int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	__le16 *newname = NULL;
+	struct attr_record *a;
+	bool cs;
+	struct ntfs_inode *base_ni;
+	int err;
+
+	ntfs_debug("Entering for inode %lld, attr 0x%x.\n",
+			(unsigned long long)ni->mft_no, type);
+
+	if (!ni || !ni->vol)
+		return -EINVAL;
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	if (name && name != AT_UNNAMED && name != I30) {
+		name = ntfs_ucsndup(name, name_len);
+		if (!name) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+		newname = name;
+	}
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		pr_err("%s: Failed to get search context", __func__);
+		goto err_out;
+	}
+
+	err = ntfs_attr_lookup(type, name, name_len, 0, 0, NULL, 0, ctx);
+	if (err)
+		goto put_err_out;
+
+	a = ctx->attr;
+
+	if (!name) {
+		if (a->name_length) {
+			name = ntfs_ucsndup((__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+					    a->name_length);
+			if (!name)
+				goto put_err_out;
+			newname = name;
+			name_len = a->name_length;
+		} else {
+			name = AT_UNNAMED;
+			name_len = 0;
+		}
+	}
+
+	__ntfs_attr_init(ni, type, name, name_len);
+
+	/*
+	 * Wipe the flags in case they are not zero for an attribute list
+	 * attribute.  Windows does not complain about invalid flags and chkdsk
+	 * does not detect or fix them so we need to cope with it, too.
+	 */
+	if (type == AT_ATTRIBUTE_LIST)
+		a->flags = 0;
+
+	if ((type == AT_DATA) &&
+	    (a->non_resident ? !a->data.non_resident.initialized_size :
+	     !a->data.resident.value_length)) {
+		/*
+		 * Define/redefine the compression state if stream is
+		 * empty, based on the compression mark on parent
+		 * directory (for unnamed data streams) or on current
+		 * inode (for named data streams). The compression mark
+		 * may change any time, the compression state can only
+		 * change when stream is wiped out.
+		 *
+		 * Also prevent compression on NTFS version < 3.0
+		 * or cluster size > 4K or compression is disabled
+		 */
+		a->flags &= ~ATTR_COMPRESSION_MASK;
+		if (NInoCompressed(ni)
+				&& (ni->vol->major_ver >= 3)
+				&& NVolCompression(ni->vol)
+				&& (ni->vol->cluster_size <= MAX_COMPRESSION_CLUSTER_SIZE))
+			a->flags |= ATTR_IS_COMPRESSED;
+	}
+
+	cs = a->flags & (ATTR_IS_COMPRESSED | ATTR_IS_SPARSE);
+
+	if (ni->type == AT_DATA && ni->name == AT_UNNAMED &&
+	    ((!(a->flags & ATTR_IS_COMPRESSED) != !NInoCompressed(ni)) ||
+	     (!(a->flags & ATTR_IS_SPARSE)     != !NInoSparse(ni)) ||
+	     (!(a->flags & ATTR_IS_ENCRYPTED)  != !NInoEncrypted(ni)))) {
+		err = -EIO;
+		pr_err("Inode %lld has corrupt attribute flags (0x%x <> 0x%x)\n",
+				(unsigned long long)ni->mft_no,
+				a->flags, ni->flags);
+		goto put_err_out;
+	}
+
+	if (a->non_resident) {
+		if (((a->flags & ATTR_COMPRESSION_MASK) || a->data.non_resident.compression_unit) &&
+				(ni->vol->major_ver < 3)) {
+			err = -EIO;
+			pr_err("Compressed inode %lld not allowed  on NTFS %d.%d\n",
+					(unsigned long long)ni->mft_no,
+					ni->vol->major_ver,
+					ni->vol->major_ver);
+			goto put_err_out;
+		}
+
+		if ((a->flags & ATTR_IS_COMPRESSED) && !a->data.non_resident.compression_unit) {
+			err = -EIO;
+			pr_err("Compressed inode %lld attr 0x%x has no compression unit\n",
+					(unsigned long long)ni->mft_no, type);
+			goto put_err_out;
+		}
+		if ((a->flags & ATTR_COMPRESSION_MASK) &&
+		    (a->data.non_resident.compression_unit != STANDARD_COMPRESSION_UNIT)) {
+			err = -EIO;
+			pr_err("Compressed inode %lld attr 0x%lx has an unsupported compression unit %d\n",
+					(unsigned long long)ni->mft_no,
+					(long)le32_to_cpu(type),
+					(int)a->data.non_resident.compression_unit);
+			goto put_err_out;
+		}
+		ntfs_attr_init(ni, true, a->flags & ATTR_IS_COMPRESSED,
+				a->flags & ATTR_IS_ENCRYPTED,
+				a->flags & ATTR_IS_SPARSE,
+				le64_to_cpu(a->data.non_resident.allocated_size),
+				le64_to_cpu(a->data.non_resident.data_size),
+				le64_to_cpu(a->data.non_resident.initialized_size),
+				cs ? le64_to_cpu(a->data.non_resident.compressed_size) : 0,
+				cs ? a->data.non_resident.compression_unit : 0);
+	} else {
+		s64 l = le32_to_cpu(a->data.resident.value_length);
+
+		ntfs_attr_init(ni, false, a->flags & ATTR_IS_COMPRESSED,
+				a->flags & ATTR_IS_ENCRYPTED,
+				a->flags & ATTR_IS_SPARSE, (l + 7) & ~7, l, l,
+				cs ? (l + 7) & ~7 : 0, 0);
+	}
+	ntfs_attr_put_search_ctx(ctx);
+out:
+	ntfs_debug("\n");
+	return err;
+
+put_err_out:
+	ntfs_attr_put_search_ctx(ctx);
+err_out:
+	ntfs_free(newname);
+	goto out;
+}
+
+/**
+ * ntfs_attr_close - free an ntfs attribute structure
+ * @ni:		ntfs inode to free
+ *
+ * Release all memory associated with the ntfs attribute @na and then release
+ * @na itself.
+ */
+void ntfs_attr_close(struct ntfs_inode *ni)
+{
+	if (NInoNonResident(ni) && ni->runlist.rl)
+		ntfs_free(ni->runlist.rl);
+	/* Don't release if using an internal constant. */
+	if (ni->name != AT_UNNAMED && ni->name != I30)
+		ntfs_free(ni->name);
+}
+
+/**
+ * ntfs_attr_map_whole_runlist - map the whole runlist of an ntfs attribute
+ * @ni:		ntfs inode for which to map the runlist
+ *
+ * Map the whole runlist of the ntfs attribute @na.  For an attribute made up
+ * of only one attribute extent this is the same as calling
+ * ntfs_map_runlist(ni, 0) but for an attribute with multiple extents this
+ * will map the runlist fragments from each of the extents thus giving access
+ * to the entirety of the disk allocation of an attribute.
+ */
+int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
+{
+	s64 next_vcn, last_vcn, highest_vcn;
+	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_volume *vol = ni->vol;
+	struct super_block *sb = vol->sb;
+	struct attr_record *a;
+	int err;
+	struct ntfs_inode *base_ni;
+	int not_mapped;
+	size_t new_rl_count;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x.\n",
+			(unsigned long long)ni->mft_no, ni->type);
+
+	if (NInoFullyMapped(ni) && ni->runlist.rl)
+		return 0;
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		ntfs_error(sb, "%s: Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+
+	/* Map all attribute extents one by one. */
+	next_vcn = last_vcn = highest_vcn = 0;
+	a = NULL;
+	while (1) {
+		struct runlist_element *rl;
+
+		not_mapped = 0;
+		if (ntfs_rl_vcn_to_lcn(ni->runlist.rl, next_vcn) == LCN_RL_NOT_MAPPED)
+			not_mapped = 1;
+
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+					CASE_SENSITIVE, next_vcn, NULL, 0, ctx);
+		if (err)
+			break;
+
+		a = ctx->attr;
+
+		if (not_mapped) {
+			/* Decode the runlist. */
+			rl = ntfs_mapping_pairs_decompress(ni->vol, a, &ni->runlist,
+							   &new_rl_count);
+			if (IS_ERR(rl)) {
+				err = PTR_ERR(rl);
+				goto err_out;
+			}
+			ni->runlist.rl = rl;
+			ni->runlist.count = new_rl_count;
+		}
+
+		/* Are we in the first extent? */
+		if (!next_vcn) {
+			if (a->data.non_resident.lowest_vcn) {
+				err = -EIO;
+				ntfs_error(sb,
+					"First extent of inode %llu attribute has non-zero lowest_vcn",
+					(unsigned long long)ni->mft_no);
+				goto err_out;
+			}
+			/* Get the last vcn in the attribute. */
+			last_vcn = le64_to_cpu(a->data.non_resident.allocated_size) >>
+				vol->cluster_size_bits;
+		}
+
+		/* Get the lowest vcn for the next extent. */
+		highest_vcn = le64_to_cpu(a->data.non_resident.highest_vcn);
+		next_vcn = highest_vcn + 1;
+
+		/* Only one extent or error, which we catch below. */
+		if (next_vcn <= 0) {
+			err = -ENOENT;
+			break;
+		}
+
+		/* Avoid endless loops due to corruption. */
+		if (next_vcn < le64_to_cpu(a->data.non_resident.lowest_vcn)) {
+			err = -EIO;
+			ntfs_error(sb, "Inode %llu has corrupt attribute list",
+					(unsigned long long)ni->mft_no);
+			goto err_out;
+		}
+	}
+	if (!a) {
+		ntfs_error(sb, "Couldn't find attribute for runlist mapping");
+		goto err_out;
+	}
+	if (not_mapped && highest_vcn && highest_vcn != last_vcn - 1) {
+		err = -EIO;
+		ntfs_error(sb,
+			"Failed to load full runlist: inode: %llu highest_vcn: 0x%llx last_vcn: 0x%llx",
+			(unsigned long long)ni->mft_no,
+			(long long)highest_vcn, (long long)last_vcn);
+		goto err_out;
+	}
+	ntfs_attr_put_search_ctx(ctx);
+	if (err == -ENOENT) {
+		NInoSetFullyMapped(ni);
+		return 0;
+	}
+
+	return err;
+
+err_out:
+	ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
+/**
+ * ntfs_attr_record_move_to - move attribute record to target inode
+ * @ctx:	attribute search context describing the attribute record
+ * @ni:		opened ntfs inode to which move attribute record
+ */
+int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode *ni)
+{
+	struct ntfs_attr_search_ctx *nctx;
+	struct attr_record *a;
+	int err;
+	struct mft_record *ni_mrec;
+	struct super_block *sb;
+
+	if (!ctx || !ctx->attr || !ctx->ntfs_ino || !ni) {
+		ntfs_debug("Invalid arguments passed.\n");
+		return -EINVAL;
+	}
+
+	sb = ni->vol->sb;
+	ntfs_debug("Entering for ctx->attr->type 0x%x, ctx->ntfs_ino->mft_no 0x%llx, ni->mft_no 0x%llx.\n",
+			(unsigned int) le32_to_cpu(ctx->attr->type),
+			(long long) ctx->ntfs_ino->mft_no,
+			(long long) ni->mft_no);
+
+	if (ctx->ntfs_ino == ni)
+		return 0;
+
+	if (!ctx->al_entry) {
+		ntfs_debug("Inode should contain attribute list to use this function.\n");
+		return -EINVAL;
+	}
+
+	/* Find place in MFT record where attribute will be moved. */
+	a = ctx->attr;
+	nctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!nctx) {
+		ntfs_error(sb, "%s: Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Use ntfs_attr_find instead of ntfs_attr_lookup to find place for
+	 * attribute in @ni->mrec, not any extent inode in case if @ni is base
+	 * file record.
+	 */
+	err = ntfs_attr_find(a->type, (__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+				a->name_length, CASE_SENSITIVE, NULL,
+				0, nctx);
+	if (!err) {
+		ntfs_debug("Attribute of such type, with same name already present in this MFT record.\n");
+		err = -EEXIST;
+		goto put_err_out;
+	}
+	if (err != -ENOENT) {
+		ntfs_debug("Attribute lookup failed.\n");
+		goto put_err_out;
+	}
+
+	/* Make space and move attribute. */
+	ni_mrec = map_mft_record(ni);
+	if (IS_ERR(ni_mrec)) {
+		err = -EIO;
+		goto put_err_out;
+	}
+
+	err = ntfs_make_room_for_attr(ni_mrec, (u8 *) nctx->attr,
+				le32_to_cpu(a->length));
+	if (err) {
+		ntfs_debug("Couldn't make space for attribute.\n");
+		unmap_mft_record(ni);
+		goto put_err_out;
+	}
+	memcpy(nctx->attr, a, le32_to_cpu(a->length));
+	nctx->attr->instance = nctx->mrec->next_attr_instance;
+	nctx->mrec->next_attr_instance =
+		cpu_to_le16((le16_to_cpu(nctx->mrec->next_attr_instance) + 1) & 0xffff);
+	ntfs_attr_record_resize(ctx->mrec, a, 0);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	mark_mft_record_dirty(ni);
+
+	/* Update attribute list. */
+	ctx->al_entry->mft_reference =
+		MK_LE_MREF(ni->mft_no, le16_to_cpu(ni_mrec->sequence_number));
+	ctx->al_entry->instance = nctx->attr->instance;
+	unmap_mft_record(ni);
+put_err_out:
+	ntfs_attr_put_search_ctx(nctx);
+	return err;
+}
+
+/**
+ * ntfs_attr_record_move_away - move away attribute record from it's mft record
+ * @ctx:	attribute search context describing the attribute record
+ * @extra:	minimum amount of free space in the new holder of record
+ */
+int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
+{
+	struct ntfs_inode *base_ni, *ni = NULL;
+	struct mft_record *m;
+	int i, err;
+	struct super_block *sb;
+
+	if (!ctx || !ctx->attr || !ctx->ntfs_ino || extra < 0)
+		return -EINVAL;
+
+	ntfs_debug("Entering for attr 0x%x, inode %llu\n",
+			(unsigned int) le32_to_cpu(ctx->attr->type),
+			(unsigned long long)ctx->ntfs_ino->mft_no);
+
+	if (ctx->ntfs_ino->nr_extents == -1)
+		base_ni = ctx->base_ntfs_ino;
+	else
+		base_ni = ctx->ntfs_ino;
+
+	sb = ctx->ntfs_ino->vol->sb;
+	if (!NInoAttrList(base_ni)) {
+		ntfs_error(sb, "Inode %llu has no attrlist",
+				(unsigned long long)base_ni->mft_no);
+		return -EINVAL;
+	}
+
+	err = ntfs_inode_attach_all_extents(ctx->ntfs_ino);
+	if (err) {
+		ntfs_error(sb, "Couldn't attach extents, inode=%llu",
+			(unsigned long long)base_ni->mft_no);
+		return err;
+	}
+
+	mutex_lock(&base_ni->extent_lock);
+	/* Walk through all extents and try to move attribute to them. */
+	for (i = 0; i < base_ni->nr_extents; i++) {
+		ni = base_ni->ext.extent_ntfs_inos[i];
+
+		if (ctx->ntfs_ino->mft_no == ni->mft_no)
+			continue;
+		m = map_mft_record(ni);
+		if (IS_ERR(m)) {
+			ntfs_error(sb, "Can not map mft record for mft_no %lld",
+					(unsigned long long)ni->mft_no);
+			mutex_unlock(&base_ni->extent_lock);
+			return -EIO;
+		}
+		if (le32_to_cpu(m->bytes_allocated) -
+		    le32_to_cpu(m->bytes_in_use) < le32_to_cpu(ctx->attr->length) + extra) {
+			unmap_mft_record(ni);
+			continue;
+		}
+		unmap_mft_record(ni);
+
+		/*
+		 * ntfs_attr_record_move_to can fail if extent with other lowest
+		 * s64 already present in inode we trying move record to. So,
+		 * do not return error.
+		 */
+		if (!ntfs_attr_record_move_to(ctx, ni)) {
+			mutex_unlock(&base_ni->extent_lock);
+			return 0;
+		}
+	}
+	mutex_unlock(&base_ni->extent_lock);
+
+	/*
+	 * Failed to move attribute to one of the current extents, so allocate
+	 * new extent and move attribute to it.
+	 */
+	ni = NULL;
+	err = ntfs_mft_record_alloc(base_ni->vol, 0, &ni, base_ni, NULL);
+	if (err) {
+		ntfs_error(sb, "Couldn't allocate MFT record, err : %d", err);
+		return err;
+	}
+	unmap_mft_record(ni);
+
+	err = ntfs_attr_record_move_to(ctx, ni);
+	if (err)
+		ntfs_error(sb, "Couldn't move attribute to MFT record");
+
+	return err;
+}
+
+/*
+ * If we are in the first extent, then set/clean sparse bit,
+ * update allocated and compressed size.
+ */
+static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
+		struct mft_record *m, struct ntfs_attr_search_ctx *ctx)
+{
+	int sparse, err = 0;
+	struct ntfs_inode *base_ni;
+	struct super_block *sb = ni->vol->sb;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x\n",
+			(unsigned long long)ni->mft_no, ni->type);
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	if (a->data.non_resident.lowest_vcn)
+		goto out;
+
+	a->data.non_resident.allocated_size = cpu_to_le64(ni->allocated_size);
+
+	sparse = ntfs_rl_sparse(ni->runlist.rl);
+	if (sparse < 0) {
+		err = -EIO;
+		goto out;
+	}
+
+	/* Attribute become sparse. */
+	if (sparse && !(a->flags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED))) {
+		/*
+		 * Move attribute to another mft record, if attribute is too
+		 * small to add compressed_size field to it and we have no
+		 * free space in the current mft record.
+		 */
+		if ((le32_to_cpu(a->length) -
+		     le16_to_cpu(a->data.non_resident.mapping_pairs_offset) == 8) &&
+		    !(le32_to_cpu(m->bytes_allocated) - le32_to_cpu(m->bytes_in_use))) {
+
+			if (!NInoAttrList(base_ni)) {
+				err = ntfs_inode_add_attrlist(base_ni);
+				if (err)
+					goto out;
+				err = -EAGAIN;
+				goto out;
+			}
+			err = ntfs_attr_record_move_away(ctx, 8);
+			if (err) {
+				ntfs_error(sb, "Failed to move attribute");
+				goto out;
+			}
+
+			err = ntfs_attrlist_update(base_ni);
+			if (err)
+				goto out;
+			err = -EAGAIN;
+			goto out;
+		}
+		if (!(le32_to_cpu(a->length) -
+		    le16_to_cpu(a->data.non_resident.mapping_pairs_offset))) {
+			err = -EIO;
+			ntfs_error(sb, "Mapping pairs space is 0");
+			goto out;
+		}
+
+		NInoSetSparse(ni);
+		ni->flags |= FILE_ATTR_SPARSE_FILE;
+		a->flags |= ATTR_IS_SPARSE;
+		a->data.non_resident.compression_unit = 0;
+
+		memmove((u8 *)a + le16_to_cpu(a->name_offset) + 8,
+				(u8 *)a + le16_to_cpu(a->name_offset),
+				a->name_length * sizeof(__le16));
+
+		a->name_offset = cpu_to_le16(le16_to_cpu(a->name_offset) + 8);
+
+		a->data.non_resident.mapping_pairs_offset =
+			cpu_to_le16(le16_to_cpu(a->data.non_resident.mapping_pairs_offset) + 8);
+	}
+
+	/* Attribute no longer sparse. */
+	if (!sparse && (a->flags & ATTR_IS_SPARSE) &&
+	    !(a->flags & ATTR_IS_COMPRESSED)) {
+		NInoClearSparse(ni);
+		ni->flags &= ~FILE_ATTR_SPARSE_FILE;
+		a->flags &= ~ATTR_IS_SPARSE;
+		a->data.non_resident.compression_unit = 0;
+
+		memmove((u8 *)a + le16_to_cpu(a->name_offset) - 8,
+				(u8 *)a + le16_to_cpu(a->name_offset),
+				a->name_length * sizeof(__le16));
+
+		if (le16_to_cpu(a->name_offset) >= 8)
+			a->name_offset = cpu_to_le16(le16_to_cpu(a->name_offset) - 8);
+
+		a->data.non_resident.mapping_pairs_offset =
+			cpu_to_le16(le16_to_cpu(a->data.non_resident.mapping_pairs_offset) - 8);
+	}
+
+	/* Update compressed size if required. */
+	if (NInoFullyMapped(ni) && (sparse || NInoCompressed(ni))) {
+		s64 new_compr_size;
+
+		new_compr_size = ntfs_rl_get_compressed_size(ni->vol, ni->runlist.rl);
+		if (new_compr_size < 0) {
+			err = new_compr_size;
+			goto out;
+		}
+
+		ni->itype.compressed.size = new_compr_size;
+		a->data.non_resident.compressed_size = cpu_to_le64(new_compr_size);
+	}
+
+	if (NInoSparse(ni) || NInoCompressed(ni))
+		VFS_I(base_ni)->i_blocks = ni->itype.compressed.size >> 9;
+	else
+		VFS_I(base_ni)->i_blocks = ni->allocated_size >> 9;
+	/*
+	 * Set FILE_NAME dirty flag, to update sparse bit and
+	 * allocated size in the index.
+	 */
+	if (ni->type == AT_DATA && ni->name == AT_UNNAMED)
+		NInoSetFileNameDirty(ni);
+out:
+	return err;
+}
+
+#define NTFS_VCN_DELETE_MARK -2
+/**
+ * ntfs_attr_update_mapping_pairs - update mapping pairs for ntfs attribute
+ * @ni:		non-resident ntfs inode for which we need update
+ * @from_vcn:	update runlist starting this VCN
+ *
+ * Build mapping pairs from @na->rl and write them to the disk. Also, this
+ * function updates sparse bit, allocated and compressed size (allocates/frees
+ * space for this field if required).
+ *
+ * @na->allocated_size should be set to correct value for the new runlist before
+ * call to this function. Vice-versa @na->compressed_size will be calculated and
+ * set to correct value during this function.
+ */
+int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_inode *base_ni;
+	struct mft_record *m;
+	struct attr_record *a;
+	s64 stop_vcn;
+	int err = 0, mp_size, cur_max_mp_size, exp_max_mp_size;
+	bool finished_build;
+	bool first_updated = false;
+	struct super_block *sb;
+	struct runlist_element *start_rl;
+	unsigned int de_cluster_count = 0;
+
+retry:
+	if (!ni || !ni->runlist.rl)
+		return -EINVAL;
+
+	ntfs_debug("Entering for inode %llu, attr 0x%x\n",
+			(unsigned long long)ni->mft_no, ni->type);
+
+	sb = ni->vol->sb;
+	if (!NInoNonResident(ni)) {
+		ntfs_error(sb, "%s: resident attribute", __func__);
+		return -EINVAL;
+	}
+
+	if (ni->nr_extents == -1)
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		ntfs_error(sb, "%s: Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+
+	/* Fill attribute records with new mapping pairs. */
+	stop_vcn = 0;
+	finished_build = false;
+	start_rl = ni->runlist.rl;
+	while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, from_vcn, NULL, 0, ctx))) {
+		unsigned int de_cnt = 0;
+
+		a = ctx->attr;
+		m = ctx->mrec;
+		if (!a->data.non_resident.lowest_vcn)
+			first_updated = true;
+
+		/*
+		 * If runlist is updating not from the beginning, then set
+		 * @stop_vcn properly, i.e. to the lowest vcn of record that
+		 * contain @from_vcn. Also we do not need @from_vcn anymore,
+		 * set it to 0 to make ntfs_attr_lookup enumerate attributes.
+		 */
+		if (from_vcn) {
+			s64 first_lcn;
+
+			stop_vcn = le64_to_cpu(a->data.non_resident.lowest_vcn);
+			from_vcn = 0;
+			/*
+			 * Check whether the first run we need to update is
+			 * the last run in runlist, if so, then deallocate
+			 * all attrubute extents starting this one.
+			 */
+			first_lcn = ntfs_rl_vcn_to_lcn(ni->runlist.rl, stop_vcn);
+			if (first_lcn == LCN_EINVAL) {
+				err = -EIO;
+				ntfs_error(sb, "Bad runlist");
+				goto put_err_out;
+			}
+			if (first_lcn == LCN_ENOENT ||
+			    first_lcn == LCN_RL_NOT_MAPPED)
+				finished_build = true;
+		}
+
+		/*
+		 * Check whether we finished mapping pairs build, if so mark
+		 * extent as need to delete (by setting highest vcn to
+		 * NTFS_VCN_DELETE_MARK (-2), we shall check it later and
+		 * delete extent) and continue search.
+		 */
+		if (finished_build) {
+			ntfs_debug("Mark attr 0x%x for delete in inode 0x%lx.\n",
+				(unsigned int)le32_to_cpu(a->type), ctx->ntfs_ino->mft_no);
+			a->data.non_resident.highest_vcn = cpu_to_le64(NTFS_VCN_DELETE_MARK);
+			mark_mft_record_dirty(ctx->ntfs_ino);
+			continue;
+		}
+
+		err = ntfs_attr_update_meta(a, ni, m, ctx);
+		if (err < 0) {
+			if (err == -EAGAIN) {
+				ntfs_attr_put_search_ctx(ctx);
+				goto retry;
+			}
+			goto put_err_out;
+		}
+
+		/*
+		 * Determine maximum possible length of mapping pairs,
+		 * if we shall *not* expand space for mapping pairs.
+		 */
+		cur_max_mp_size = le32_to_cpu(a->length) -
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset);
+		/*
+		 * Determine maximum possible length of mapping pairs in the
+		 * current mft record, if we shall expand space for mapping
+		 * pairs.
+		 */
+		exp_max_mp_size = le32_to_cpu(m->bytes_allocated) -
+			le32_to_cpu(m->bytes_in_use) + cur_max_mp_size;
+
+		/* Get the size for the rest of mapping pairs array. */
+		mp_size = ntfs_get_size_for_mapping_pairs(ni->vol, start_rl,
+				stop_vcn, -1, exp_max_mp_size);
+		if (mp_size <= 0) {
+			err = mp_size;
+			ntfs_error(sb, "%s: get MP size failed", __func__);
+			goto put_err_out;
+		}
+		/* Test mapping pairs for fitting in the current mft record. */
+		if (mp_size > exp_max_mp_size) {
+			/*
+			 * Mapping pairs of $ATTRIBUTE_LIST attribute must fit
+			 * in the base mft record. Try to move out other
+			 * attributes and try again.
+			 */
+			if (ni->type == AT_ATTRIBUTE_LIST) {
+				ntfs_attr_put_search_ctx(ctx);
+				if (ntfs_inode_free_space(base_ni, mp_size -
+							cur_max_mp_size)) {
+					ntfs_error(sb,
+						"Attribute list is too big. Defragment the volume\n");
+					return -EIO;
+				}
+				if (ntfs_attrlist_update(base_ni))
+					return -EIO;
+				goto retry;
+			}
+
+			/* Add attribute list if it isn't present, and retry. */
+			if (!NInoAttrList(base_ni)) {
+				ntfs_attr_put_search_ctx(ctx);
+				if (ntfs_inode_add_attrlist(base_ni)) {
+					ntfs_error(sb, "Can not add attrlist");
+					return -EIO;
+				}
+				goto retry;
+			}
+
+			/*
+			 * Set mapping pairs size to maximum possible for this
+			 * mft record. We shall write the rest of mapping pairs
+			 * to another MFT records.
+			 */
+			mp_size = exp_max_mp_size;
+		}
+
+		/* Change space for mapping pairs if we need it. */
+		if (((mp_size + 7) & ~7) != cur_max_mp_size) {
+			if (ntfs_attr_record_resize(m, a,
+					le16_to_cpu(a->data.non_resident.mapping_pairs_offset) +
+						mp_size)) {
+				err = -EIO;
+				ntfs_error(sb, "Failed to resize attribute");
+				goto put_err_out;
+			}
+		}
+
+		/* Update lowest vcn. */
+		a->data.non_resident.lowest_vcn = cpu_to_le64(stop_vcn);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		if ((ctx->ntfs_ino->nr_extents == -1 || NInoAttrList(ctx->ntfs_ino)) &&
+		    ctx->attr->type != AT_ATTRIBUTE_LIST) {
+			ctx->al_entry->lowest_vcn = cpu_to_le64(stop_vcn);
+			err = ntfs_attrlist_update(base_ni);
+			if (err)
+				goto put_err_out;
+		}
+
+		/*
+		 * Generate the new mapping pairs array directly into the
+		 * correct destination, i.e. the attribute record itself.
+		 */
+		err = ntfs_mapping_pairs_build(ni->vol,
+				(u8 *)a + le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
+				mp_size, start_rl, stop_vcn, -1, &stop_vcn, &start_rl, &de_cnt);
+		if (!err)
+			finished_build = true;
+		if (!finished_build && err != -ENOSPC) {
+			ntfs_error(sb, "Failed to build mapping pairs");
+			goto put_err_out;
+		}
+		a->data.non_resident.highest_vcn = cpu_to_le64(stop_vcn - 1);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		de_cluster_count += de_cnt;
+	}
+
+	/* Check whether error occurred. */
+	if (err && err != -ENOENT) {
+		ntfs_error(sb, "%s: Attribute lookup failed", __func__);
+		goto put_err_out;
+	}
+
+	/*
+	 * If the base extent was skipped in the above process,
+	 * we still may have to update the sizes.
+	 */
+	if (!first_updated) {
+		ntfs_attr_reinit_search_ctx(ctx);
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, 0, NULL, 0, ctx);
+		if (!err) {
+			a = ctx->attr;
+			a->data.non_resident.allocated_size = cpu_to_le64(ni->allocated_size);
+			if (NInoCompressed(ni) || NInoSparse(ni))
+				a->data.non_resident.compressed_size =
+					cpu_to_le64(ni->itype.compressed.size);
+			/* Updating sizes taints the extent holding the attr */
+			if (ni->type == AT_DATA && ni->name == AT_UNNAMED)
+				NInoSetFileNameDirty(ni);
+			mark_mft_record_dirty(ctx->ntfs_ino);
+		} else {
+			ntfs_error(sb, "Failed to update sizes in base extent\n");
+			goto put_err_out;
+		}
+	}
+
+	/* Deallocate not used attribute extents and return with success. */
+	if (finished_build) {
+		ntfs_attr_reinit_search_ctx(ctx);
+		ntfs_debug("Deallocate marked extents.\n");
+		while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, 0, NULL, 0, ctx))) {
+			if (le64_to_cpu(ctx->attr->data.non_resident.highest_vcn) !=
+					NTFS_VCN_DELETE_MARK)
+				continue;
+			/* Remove unused attribute record. */
+			err = ntfs_attr_record_rm(ctx);
+			if (err) {
+				ntfs_error(sb, "Could not remove unused attr");
+				goto put_err_out;
+			}
+			ntfs_attr_reinit_search_ctx(ctx);
+		}
+		if (err && err != -ENOENT) {
+			ntfs_error(sb, "%s: Attr lookup failed", __func__);
+			goto put_err_out;
+		}
+		ntfs_debug("Deallocate done.\n");
+		ntfs_attr_put_search_ctx(ctx);
+		goto out;
+	}
+	ntfs_attr_put_search_ctx(ctx);
+	ctx = NULL;
+
+	/* Allocate new MFT records for the rest of mapping pairs. */
+	while (1) {
+		struct ntfs_inode *ext_ni = NULL;
+		unsigned int de_cnt = 0;
+
+		/* Allocate new mft record. */
+		err = ntfs_mft_record_alloc(ni->vol, 0, &ext_ni, base_ni, NULL);
+		if (err) {
+			ntfs_error(sb, "Failed to allocate extent record");
+			goto put_err_out;
+		}
+		unmap_mft_record(ext_ni);
+
+		m = map_mft_record(ext_ni);
+		if (IS_ERR(m)) {
+			ntfs_error(sb, "Could not map new MFT record");
+			if (ntfs_mft_record_free(ni->vol, ext_ni))
+				ntfs_error(sb, "Could not free MFT record");
+			ntfs_inode_close(ext_ni);
+			err = -ENOMEM;
+			ext_ni = NULL;
+			goto put_err_out;
+		}
+		/*
+		 * If mapping size exceed available space, set them to
+		 * possible maximum.
+		 */
+		cur_max_mp_size = le32_to_cpu(m->bytes_allocated) -
+			le32_to_cpu(m->bytes_in_use) -
+			(sizeof(struct attr_record) +
+			 ((NInoCompressed(ni) || NInoSparse(ni)) ?
+			  sizeof(a->data.non_resident.compressed_size) : 0)) -
+			((sizeof(__le16) * ni->name_len + 7) & ~7);
+
+		/* Calculate size of rest mapping pairs. */
+		mp_size = ntfs_get_size_for_mapping_pairs(ni->vol,
+				start_rl, stop_vcn, -1, cur_max_mp_size);
+		if (mp_size <= 0) {
+			unmap_mft_record(ext_ni);
+			ntfs_inode_close(ext_ni);
+			err = mp_size;
+			ntfs_error(sb, "%s: get mp size failed", __func__);
+			goto put_err_out;
+		}
+
+		if (mp_size > cur_max_mp_size)
+			mp_size = cur_max_mp_size;
+		/* Add attribute extent to new record. */
+		err = ntfs_non_resident_attr_record_add(ext_ni, ni->type,
+				ni->name, ni->name_len, stop_vcn, mp_size, 0);
+		if (err < 0) {
+			ntfs_error(sb, "Could not add attribute extent");
+			unmap_mft_record(ext_ni);
+			if (ntfs_mft_record_free(ni->vol, ext_ni))
+				ntfs_error(sb, "Could not free MFT record");
+			ntfs_inode_close(ext_ni);
+			goto put_err_out;
+		}
+		a = (struct attr_record *)((u8 *)m + err);
+
+		err = ntfs_mapping_pairs_build(ni->vol, (u8 *)a +
+				le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
+				mp_size, start_rl, stop_vcn, -1, &stop_vcn, &start_rl,
+				&de_cnt);
+		if (err < 0 && err != -ENOSPC) {
+			ntfs_error(sb, "Failed to build MP");
+			unmap_mft_record(ext_ni);
+			if (ntfs_mft_record_free(ni->vol, ext_ni))
+				ntfs_error(sb, "Couldn't free MFT record");
+			goto put_err_out;
+		}
+		a->data.non_resident.highest_vcn = cpu_to_le64(stop_vcn - 1);
+		mark_mft_record_dirty(ext_ni);
+		unmap_mft_record(ext_ni);
+
+		de_cluster_count += de_cnt;
+		/* All mapping pairs has been written. */
+		if (!err)
+			break;
+	}
+out:
+	if (from_vcn == 0)
+		ni->i_dealloc_clusters = de_cluster_count;
+	return 0;
+
+put_err_out:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
+/**
+ * ntfs_attr_make_resident - convert a non-resident to a resident attribute
+ * @ni:		open ntfs attribute to make resident
+ * @ctx:	ntfs search context describing the attribute
+ *
+ * Convert a non-resident ntfs attribute to a resident one.
+ */
+static int ntfs_attr_make_resident(struct ntfs_inode *ni, struct ntfs_attr_search_ctx *ctx)
+{
+	struct ntfs_volume *vol = ni->vol;
+	struct super_block *sb = vol->sb;
+	struct attr_record *a = ctx->attr;
+	int name_ofs, val_ofs, err;
+	s64 arec_size;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x.\n",
+			(unsigned long long)ni->mft_no, ni->type);
+
+	/* Should be called for the first extent of the attribute. */
+	if (le64_to_cpu(a->data.non_resident.lowest_vcn)) {
+		ntfs_debug("Eeek!  Should be called for the first extent of the attribute.  Aborting...\n");
+		return -EINVAL;
+	}
+
+	/* Some preliminary sanity checking. */
+	if (!NInoNonResident(ni)) {
+		ntfs_debug("Eeek!  Trying to make resident attribute resident. Aborting...\n");
+		return -EINVAL;
+	}
+
+	/* Make sure this is not $MFT/$BITMAP or Windows will not boot! */
+	if (ni->type == AT_BITMAP && ni->mft_no == FILE_MFT)
+		return -EPERM;
+
+	/* Check that the attribute is allowed to be resident. */
+	err = ntfs_attr_can_be_resident(vol, ni->type);
+	if (err)
+		return err;
+
+	if (NInoCompressed(ni) || NInoEncrypted(ni)) {
+		ntfs_debug("Making compressed or encrypted files resident is not implemented yet.\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Work out offsets into and size of the resident attribute. */
+	name_ofs = 24; /* = sizeof(resident_struct attr_record); */
+	val_ofs = (name_ofs + a->name_length * sizeof(__le16) + 7) & ~7;
+	arec_size = (val_ofs + ni->data_size + 7) & ~7;
+
+	/* Sanity check the size before we start modifying the attribute. */
+	if (le32_to_cpu(ctx->mrec->bytes_in_use) - le32_to_cpu(a->length) +
+	    arec_size > le32_to_cpu(ctx->mrec->bytes_allocated)) {
+		ntfs_debug("Not enough space to make attribute resident\n");
+		return -ENOSPC;
+	}
+
+	/* Read and cache the whole runlist if not already done. */
+	err = ntfs_attr_map_whole_runlist(ni);
+	if (err)
+		return err;
+
+	/* Move the attribute name if it exists and update the offset. */
+	if (a->name_length) {
+		memmove((u8 *)a + name_ofs, (u8 *)a + le16_to_cpu(a->name_offset),
+				a->name_length * sizeof(__le16));
+	}
+	a->name_offset = cpu_to_le16(name_ofs);
+
+	/* Resize the resident part of the attribute record. */
+	if (ntfs_attr_record_resize(ctx->mrec, a, arec_size) < 0) {
+		/*
+		 * Bug, because ntfs_attr_record_resize should not fail (we
+		 * already checked that attribute fits MFT record).
+		 */
+		ntfs_error(ctx->ntfs_ino->vol->sb, "BUG! Failed to resize attribute record. ");
+		return -EIO;
+	}
+
+	/* Convert the attribute record to describe a resident attribute. */
+	a->non_resident = 0;
+	a->flags = 0;
+	a->data.resident.value_length = cpu_to_le32(ni->data_size);
+	a->data.resident.value_offset = cpu_to_le16(val_ofs);
+	/*
+	 * File names cannot be non-resident so we would never see this here
+	 * but at least it serves as a reminder that there may be attributes
+	 * for which we do need to set this flag. (AIA)
+	 */
+	if (a->type == AT_FILE_NAME)
+		a->data.resident.flags = RESIDENT_ATTR_IS_INDEXED;
+	else
+		a->data.resident.flags = 0;
+	a->data.resident.reserved = 0;
+
+	/*
+	 * Deallocate clusters from the runlist.
+	 *
+	 * NOTE: We can use ntfs_cluster_free() because we have already mapped
+	 * the whole run list and thus it doesn't matter that the attribute
+	 * record is in a transiently corrupted state at this moment in time.
+	 */
+	err = ntfs_cluster_free(ni, 0, -1, ctx);
+	if (err) {
+		ntfs_error(sb, "Eeek! Failed to release allocated clusters");
+		ntfs_debug("Ignoring error and leaving behind wasted clusters.\n");
+	}
+
+	/* Throw away the now unused runlist. */
+	ntfs_free(ni->runlist.rl);
+	ni->runlist.rl = NULL;
+	ni->runlist.count = 0;
+	/* Update in-memory struct ntfs_attr. */
+	NInoClearNonResident(ni);
+	NInoClearCompressed(ni);
+	ni->flags &= ~FILE_ATTR_COMPRESSED;
+	NInoClearSparse(ni);
+	ni->flags &= ~FILE_ATTR_SPARSE_FILE;
+	NInoClearEncrypted(ni);
+	ni->flags &= ~FILE_ATTR_ENCRYPTED;
+	ni->initialized_size = ni->data_size;
+	ni->allocated_size = ni->itype.compressed.size = (ni->data_size + 7) & ~7;
+	ni->itype.compressed.block_size = 0;
+	ni->itype.compressed.block_size_bits = ni->itype.compressed.block_clusters = 0;
+	return 0;
+}
+
+/**
+ * ntfs_non_resident_attr_shrink - shrink a non-resident, open ntfs attribute
+ * @ni:		non-resident ntfs attribute to shrink
+ * @newsize:	new size (in bytes) to which to shrink the attribute
+ *
+ * Reduce the size of a non-resident, open ntfs attribute @na to @newsize bytes.
+ */
+static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni, const s64 newsize)
+{
+	struct ntfs_volume *vol;
+	struct ntfs_attr_search_ctx *ctx;
+	s64 first_free_vcn;
+	s64 nr_freed_clusters;
+	int err;
+	struct ntfs_inode *base_ni;
+
+	ntfs_debug("Inode 0x%llx attr 0x%x new size %lld\n",
+		(unsigned long long)ni->mft_no, ni->type, (long long)newsize);
+
+	vol = ni->vol;
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	/*
+	 * Check the attribute type and the corresponding minimum size
+	 * against @newsize and fail if @newsize is too small.
+	 */
+	err = ntfs_attr_size_bounds_check(vol, ni->type, newsize);
+	if (err) {
+		if (err == -ERANGE)
+			ntfs_debug("Eeek! Size bounds check failed. Aborting...\n");
+		else if (err == -ENOENT)
+			err = -EIO;
+		return err;
+	}
+
+	/* The first cluster outside the new allocation. */
+	if (NInoCompressed(ni))
+		/*
+		 * For compressed files we must keep full compressions blocks,
+		 * but currently we do not decompress/recompress the last
+		 * block to truncate the data, so we may leave more allocated
+		 * clusters than really needed.
+		 */
+		first_free_vcn = (((newsize - 1) | (ni->itype.compressed.block_size - 1)) + 1) >>
+			vol->cluster_size_bits;
+	else
+		first_free_vcn = (newsize + vol->cluster_size - 1) >>
+			vol->cluster_size_bits;
+
+	if (first_free_vcn < 0)
+		return -EINVAL;
+	/*
+	 * Compare the new allocation with the old one and only deallocate
+	 * clusters if there is a change.
+	 */
+	if ((ni->allocated_size >> vol->cluster_size_bits) != first_free_vcn) {
+		struct ntfs_attr_search_ctx *ctx;
+
+		err = ntfs_attr_map_whole_runlist(ni);
+		if (err) {
+			ntfs_debug("Eeek! ntfs_attr_map_whole_runlist failed.\n");
+			return err;
+		}
+
+		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		if (!ctx) {
+			ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
+			return -ENOMEM;
+		}
+
+		/* Deallocate all clusters starting with the first free one. */
+		nr_freed_clusters = ntfs_cluster_free(ni, first_free_vcn, -1, ctx);
+		if (nr_freed_clusters < 0) {
+			ntfs_debug("Eeek! Freeing of clusters failed. Aborting...\n");
+			ntfs_attr_put_search_ctx(ctx);
+			return (int)nr_freed_clusters;
+		}
+		ntfs_attr_put_search_ctx(ctx);
+
+		/* Truncate the runlist itself. */
+		if (ntfs_rl_truncate_nolock(vol, &ni->runlist, first_free_vcn)) {
+			/*
+			 * Failed to truncate the runlist, so just throw it
+			 * away, it will be mapped afresh on next use.
+			 */
+			ntfs_free(ni->runlist.rl);
+			ni->runlist.rl = NULL;
+			ntfs_error(vol->sb, "Eeek! Run list truncation failed.\n");
+			return -EIO;
+		}
+
+		/* Prepare to mapping pairs update. */
+		ni->allocated_size = first_free_vcn << vol->cluster_size_bits;
+
+		if (NInoSparse(ni) || NInoCompressed(ni)) {
+			if (nr_freed_clusters) {
+				ni->itype.compressed.size -= nr_freed_clusters <<
+					vol->cluster_size_bits;
+				VFS_I(base_ni)->i_blocks = ni->itype.compressed.size >> 9;
+			}
+		} else
+			VFS_I(base_ni)->i_blocks = ni->allocated_size >> 9;
+
+		/* Write mapping pairs for new runlist. */
+		err = ntfs_attr_update_mapping_pairs(ni, 0 /*first_free_vcn*/);
+		if (err) {
+			ntfs_debug("Eeek! Mapping pairs update failed. Leaving inconstant metadata. Run chkdsk.\n");
+			return err;
+		}
+	}
+
+	/* Get the first attribute record. */
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+				0, NULL, 0, ctx);
+	if (err) {
+		if (err == -ENOENT)
+			err = -EIO;
+		ntfs_debug("Eeek! Lookup of first attribute extent failed. Leaving inconstant metadata.\n");
+		goto put_err_out;
+	}
+
+	/* Update data and initialized size. */
+	ni->data_size = newsize;
+	ctx->attr->data.non_resident.data_size = cpu_to_le64(newsize);
+	if (newsize < ni->initialized_size) {
+		ni->initialized_size = newsize;
+		ctx->attr->data.non_resident.initialized_size = cpu_to_le64(newsize);
+	}
+	/* Update data size in the index. */
+	if (ni->type == AT_DATA && ni->name == AT_UNNAMED)
+		NInoSetFileNameDirty(ni);
+
+	/* If the attribute now has zero size, make it resident. */
+	if (!newsize && !NInoEncrypted(ni) && !NInoCompressed(ni)) {
+		err = ntfs_attr_make_resident(ni, ctx);
+		if (err) {
+			/* If couldn't make resident, just continue. */
+			if (err != -EPERM)
+				ntfs_error(ni->vol->sb,
+					"Failed to make attribute resident. Leaving as is...\n");
+		}
+	}
+
+	/* Set the inode dirty so it is written out later. */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	/* Done! */
+	ntfs_attr_put_search_ctx(ctx);
+	return 0;
+put_err_out:
+	ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
+/**
+ * ntfs_non_resident_attr_expand - expand a non-resident, open ntfs attribute
+ * @ni:			non-resident ntfs attribute to expand
+ * @prealloc_size:	preallocation size (in bytes) to which to expand the attribute
+ * @newsize:		new size (in bytes) to which to expand the attribute
+ *
+ * Expand the size of a non-resident, open ntfs attribute @na to @newsize bytes,
+ * by allocating new clusters.
+ */
+static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsize,
+		const s64 prealloc_size, unsigned int holes)
+{
+	s64 lcn_seek_from;
+	s64 first_free_vcn;
+	struct ntfs_volume *vol;
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	struct runlist_element *rl, *rln;
+	s64 org_alloc_size, org_compressed_size;
+	int err, err2;
+	struct ntfs_inode *base_ni;
+	struct super_block *sb = ni->vol->sb;
+	size_t new_rl_count;
+
+	ntfs_debug("Inode 0x%llx, attr 0x%x, new size %lld old size %lld\n",
+			(unsigned long long)ni->mft_no, ni->type,
+			(long long)newsize, (long long)ni->data_size);
+
+	vol = ni->vol;
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	/*
+	 * Check the attribute type and the corresponding maximum size
+	 * against @newsize and fail if @newsize is too big.
+	 */
+	err = ntfs_attr_size_bounds_check(vol, ni->type, newsize);
+	if (err	< 0) {
+		ntfs_error(sb, "%s: bounds check failed", __func__);
+		return err;
+	}
+
+	/* Save for future use. */
+	org_alloc_size = ni->allocated_size;
+	org_compressed_size = ni->itype.compressed.size;
+
+	/* The first cluster outside the new allocation. */
+	if (prealloc_size)
+		first_free_vcn = (prealloc_size + vol->cluster_size - 1) >>
+			vol->cluster_size_bits;
+	else
+		first_free_vcn = (newsize + vol->cluster_size - 1) >>
+			vol->cluster_size_bits;
+	if (first_free_vcn < 0)
+		return -EFBIG;
+
+	/*
+	 * Compare the new allocation with the old one and only allocate
+	 * clusters if there is a change.
+	 */
+	if ((ni->allocated_size >> vol->cluster_size_bits) < first_free_vcn) {
+		err = ntfs_attr_map_whole_runlist(ni);
+		if (err) {
+			ntfs_error(sb, "ntfs_attr_map_whole_runlist failed");
+			return err;
+		}
+
+		/*
+		 * If we extend $DATA attribute on NTFS 3+ volume, we can add
+		 * sparse runs instead of real allocation of clusters.
+		 */
+		if ((ni->type == AT_DATA && (vol->major_ver >= 3 || !NInoSparseDisabled(ni))) &&
+		    (holes != HOLES_NO)) {
+			if (NInoCompressed(ni)) {
+				int last = 0, i = 0;
+				s64 alloc_size;
+				int more_entries =
+					round_up(first_free_vcn -
+						 (ni->allocated_size >>
+						  vol->cluster_size_bits),
+						 ni->itype.compressed.block_clusters) /
+					ni->itype.compressed.block_clusters;
+
+				while (ni->runlist.rl[last].length)
+					last++;
+
+				rl = ntfs_rl_realloc(ni->runlist.rl, last + 1,
+						last + more_entries + 1);
+				if (IS_ERR(rl)) {
+					err = -ENOMEM;
+					goto put_err_out;
+				}
+
+				alloc_size = ni->allocated_size;
+				while (i++ < more_entries) {
+					rl[last].vcn = round_up(alloc_size, vol->cluster_size) >>
+						vol->cluster_size_bits;
+					rl[last].length = ni->itype.compressed.block_clusters -
+						(rl[last].vcn &
+						 (ni->itype.compressed.block_clusters - 1));
+					rl[last].lcn = LCN_HOLE;
+					last++;
+					alloc_size += ni->itype.compressed.block_size;
+				}
+
+				rl[last].vcn = first_free_vcn;
+				rl[last].lcn = LCN_ENOENT;
+				rl[last].length = 0;
+
+				ni->runlist.rl = rl;
+				ni->runlist.count += more_entries;
+			} else {
+				rl = ntfs_malloc_nofs(sizeof(struct runlist_element) * 2);
+				if (!rl) {
+					err = -ENOMEM;
+					goto put_err_out;
+				}
+
+				rl[0].vcn = (ni->allocated_size >>
+						vol->cluster_size_bits);
+				rl[0].lcn = LCN_HOLE;
+				rl[0].length = first_free_vcn -
+					(ni->allocated_size >> vol->cluster_size_bits);
+				rl[1].vcn = first_free_vcn;
+				rl[1].lcn = LCN_ENOENT;
+				rl[1].length = 0;
+			}
+		} else {
+			/*
+			 * Determine first after last LCN of attribute.
+			 * We will start seek clusters from this LCN to avoid
+			 * fragmentation.  If there are no valid LCNs in the
+			 * attribute let the cluster allocator choose the
+			 * starting LCN.
+			 */
+			lcn_seek_from = -1;
+			if (ni->runlist.rl->length) {
+				/* Seek to the last run list element. */
+				for (rl = ni->runlist.rl; (rl + 1)->length; rl++)
+					;
+				/*
+				 * If the last LCN is a hole or similar seek
+				 * back to last valid LCN.
+				 */
+				while (rl->lcn < 0 && rl != ni->runlist.rl)
+					rl--;
+				/*
+				 * Only set lcn_seek_from it the LCN is valid.
+				 */
+				if (rl->lcn >= 0)
+					lcn_seek_from = rl->lcn + rl->length;
+			}
+
+			rl = ntfs_cluster_alloc(vol, ni->allocated_size >>
+					vol->cluster_size_bits, first_free_vcn -
+					(ni->allocated_size >>
+					 vol->cluster_size_bits), lcn_seek_from,
+					DATA_ZONE, false, false, false);
+			if (IS_ERR(rl)) {
+				ntfs_debug("Cluster allocation failed (%lld)",
+						(long long)first_free_vcn -
+						((long long)ni->allocated_size >>
+						 vol->cluster_size_bits));
+				return PTR_ERR(rl);
+			}
+		}
+
+		if (!NInoCompressed(ni)) {
+			/* Append new clusters to attribute runlist. */
+			rln = ntfs_runlists_merge(&ni->runlist, rl, 0, &new_rl_count);
+			if (IS_ERR(rln)) {
+				/* Failed, free just allocated clusters. */
+				ntfs_error(sb, "Run list merge failed");
+				ntfs_cluster_free_from_rl(vol, rl);
+				ntfs_free(rl);
+				return -EIO;
+			}
+			ni->runlist.rl = rln;
+			ni->runlist.count = new_rl_count;
+		}
+
+		/* Prepare to mapping pairs update. */
+		ni->allocated_size = first_free_vcn << vol->cluster_size_bits;
+		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		if (err) {
+			ntfs_error(sb, "Mapping pairs update failed");
+			goto rollback;
+		}
+	}
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		if (ni->allocated_size == org_alloc_size)
+			return err;
+		goto rollback;
+	}
+
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+			       0, NULL, 0, ctx);
+	if (err) {
+		if (err == -ENOENT)
+			err = -EIO;
+		if (ni->allocated_size != org_alloc_size)
+			goto rollback;
+		goto put_err_out;
+	}
+
+	/* Update data size. */
+	ni->data_size = newsize;
+	ctx->attr->data.non_resident.data_size = cpu_to_le64(newsize);
+	/* Update data size in the index. */
+	if (ni->type == AT_DATA && ni->name == AT_UNNAMED)
+		NInoSetFileNameDirty(ni);
+	/* Set the inode dirty so it is written out later. */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	/* Done! */
+	ntfs_attr_put_search_ctx(ctx);
+	return 0;
+rollback:
+	/* Free allocated clusters. */
+	err2 = ntfs_cluster_free(ni, org_alloc_size >>
+				vol->cluster_size_bits, -1, ctx);
+	if (err2)
+		ntfs_error(sb, "Leaking clusters");
+
+	/* Now, truncate the runlist itself. */
+	down_write(&ni->runlist.lock);
+	err2 = ntfs_rl_truncate_nolock(vol, &ni->runlist, org_alloc_size >>
+				vol->cluster_size_bits);
+	up_write(&ni->runlist.lock);
+	if (err2) {
+		/*
+		 * Failed to truncate the runlist, so just throw it away, it
+		 * will be mapped afresh on next use.
+		 */
+		ntfs_free(ni->runlist.rl);
+		ni->runlist.rl = NULL;
+		ntfs_error(sb, "Couldn't truncate runlist. Rollback failed");
+	} else {
+		/* Prepare to mapping pairs update. */
+		ni->allocated_size = org_alloc_size;
+		/* Restore mapping pairs. */
+		down_read(&ni->runlist.lock);
+		if (ntfs_attr_update_mapping_pairs(ni, 0))
+			ntfs_error(sb, "Failed to restore old mapping pairs");
+		up_read(&ni->runlist.lock);
+
+		if (NInoSparse(ni) || NInoCompressed(ni)) {
+			ni->itype.compressed.size =  org_compressed_size;
+			VFS_I(base_ni)->i_blocks = ni->itype.compressed.size >> 9;
+		} else
+			VFS_I(base_ni)->i_blocks = ni->allocated_size >> 9;
+	}
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	return err;
+put_err_out:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
+/**
+ * ntfs_resident_attr_resize - resize a resident, open ntfs attribute
+ * @attr_ni:		resident ntfs inode to resize
+ * @prealloc_size:	preallocation size (in bytes) to which to resize the attribute
+ * @newsize:		new size (in bytes) to which to resize the attribute
+ *
+ * Change the size of a resident, open ntfs attribute @na to @newsize bytes.
+ */
+static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsize,
+		const s64 prealloc_size, unsigned int holes)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_volume *vol = attr_ni->vol;
+	struct super_block *sb = vol->sb;
+	int err = -EIO;
+	struct ntfs_inode *base_ni, *ext_ni = NULL;
+
+attr_resize_again:
+	ntfs_debug("Inode 0x%llx attr 0x%x new size %lld\n",
+			(unsigned long long)attr_ni->mft_no, attr_ni->type,
+			(long long)newsize);
+
+	if (NInoAttr(attr_ni))
+		base_ni = attr_ni->ext.base_ntfs_ino;
+	else
+		base_ni = attr_ni;
+
+	/* Get the attribute record that needs modification. */
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		ntfs_error(sb, "%s: Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+	err = ntfs_attr_lookup(attr_ni->type, attr_ni->name, attr_ni->name_len,
+			0, 0, NULL, 0, ctx);
+	if (err) {
+		ntfs_error(sb, "ntfs_attr_lookup failed");
+		goto put_err_out;
+	}
+
+	/*
+	 * Check the attribute type and the corresponding minimum and maximum
+	 * sizes against @newsize and fail if @newsize is out of bounds.
+	 */
+	err = ntfs_attr_size_bounds_check(vol, attr_ni->type, newsize);
+	if (err) {
+		if (err == -ENOENT)
+			err = -EIO;
+		ntfs_debug("%s: bounds check failed", __func__);
+		goto put_err_out;
+	}
+	/*
+	 * If @newsize is bigger than the mft record we need to make the
+	 * attribute non-resident if the attribute type supports it. If it is
+	 * smaller we can go ahead and attempt the resize.
+	 */
+	if (newsize < vol->mft_record_size) {
+		/* Perform the resize of the attribute record. */
+		err = ntfs_resident_attr_value_resize(ctx->mrec, ctx->attr,
+					newsize);
+		if (!err) {
+			/* Update attribute size everywhere. */
+			attr_ni->data_size = attr_ni->initialized_size = newsize;
+			attr_ni->allocated_size = (newsize + 7) & ~7;
+			if (NInoCompressed(attr_ni) || NInoSparse(attr_ni))
+				attr_ni->itype.compressed.size = attr_ni->allocated_size;
+			if (attr_ni->type == AT_DATA && attr_ni->name == AT_UNNAMED)
+				NInoSetFileNameDirty(attr_ni);
+			goto resize_done;
+		}
+
+		/* Prefer AT_INDEX_ALLOCATION instead of AT_ATTRIBUTE_LIST */
+		if (err == -ENOSPC && ctx->attr->type == AT_INDEX_ROOT)
+			goto put_err_out;
+
+	}
+	/* There is not enough space in the mft record to perform the resize. */
+
+	/* Make the attribute non-resident if possible. */
+	err = ntfs_attr_make_non_resident(attr_ni,
+			le32_to_cpu(ctx->attr->data.resident.value_length));
+	if (!err) {
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		ntfs_attr_put_search_ctx(ctx);
+		/* Resize non-resident attribute */
+		return ntfs_non_resident_attr_expand(attr_ni, newsize, prealloc_size, holes);
+	} else if (err != -ENOSPC && err != -EPERM) {
+		ntfs_error(sb, "Failed to make attribute non-resident");
+		goto put_err_out;
+	}
+
+	/* Try to make other attributes non-resident and retry each time. */
+	ntfs_attr_reinit_search_ctx(ctx);
+	while (!(err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, 0, 0, NULL, 0, ctx))) {
+		struct inode *tvi;
+		struct attr_record *a;
+
+		a = ctx->attr;
+		if (a->non_resident || a->type == AT_ATTRIBUTE_LIST)
+			continue;
+
+		if (ntfs_attr_can_be_non_resident(vol, a->type))
+			continue;
+
+		/*
+		 * Check out whether convert is reasonable. Assume that mapping
+		 * pairs will take 8 bytes.
+		 */
+		if (le32_to_cpu(a->length) <= (sizeof(struct attr_record) - sizeof(s64)) +
+				((a->name_length * sizeof(__le16) + 7) & ~7) + 8)
+			continue;
+
+		if (a->type == AT_DATA)
+			tvi = ntfs_iget(sb, base_ni->mft_no);
+		else
+			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
+				(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+				a->name_length);
+		if (IS_ERR(tvi)) {
+			ntfs_error(sb, "Couldn't open attribute");
+			continue;
+		}
+
+		if (ntfs_attr_make_non_resident(NTFS_I(tvi),
+		    le32_to_cpu(ctx->attr->data.resident.value_length))) {
+			iput(tvi);
+			continue;
+		}
+
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		iput(tvi);
+		ntfs_attr_put_search_ctx(ctx);
+		goto attr_resize_again;
+	}
+
+	/* Check whether error occurred. */
+	if (err != -ENOENT) {
+		ntfs_error(sb, "%s: Attribute lookup failed 1", __func__);
+		goto put_err_out;
+	}
+
+	/*
+	 * The standard information and attribute list attributes can't be
+	 * moved out from the base MFT record, so try to move out others.
+	 */
+	if (attr_ni->type == AT_STANDARD_INFORMATION ||
+	    attr_ni->type == AT_ATTRIBUTE_LIST) {
+		ntfs_attr_put_search_ctx(ctx);
+
+		if (!NInoAttrList(base_ni)) {
+			err = ntfs_inode_add_attrlist(base_ni);
+			if (err)
+				return err;
+		}
+
+		err = ntfs_inode_free_space(base_ni, sizeof(struct attr_record));
+		if (err) {
+			err = -ENOSPC;
+			ntfs_error(sb,
+				"Couldn't free space in the MFT record to make attribute list non resident");
+			return err;
+		}
+		err = ntfs_attrlist_update(base_ni);
+		if (err)
+			return err;
+		goto attr_resize_again;
+	}
+
+	/*
+	 * Move the attribute to a new mft record, creating an attribute list
+	 * attribute or modifying it if it is already present.
+	 */
+
+	/* Point search context back to attribute which we need resize. */
+	ntfs_attr_reinit_search_ctx(ctx);
+	err = ntfs_attr_lookup(attr_ni->type, attr_ni->name, attr_ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (err) {
+		ntfs_error(sb, "%s: Attribute lookup failed 2", __func__);
+		goto put_err_out;
+	}
+
+	/*
+	 * Check whether attribute is already single in this MFT record.
+	 * 8 added for the attribute terminator.
+	 */
+	if (le32_to_cpu(ctx->mrec->bytes_in_use) ==
+	    le16_to_cpu(ctx->mrec->attrs_offset) + le32_to_cpu(ctx->attr->length) + 8) {
+		err = -ENOSPC;
+		ntfs_debug("MFT record is filled with one attribute\n");
+		goto put_err_out;
+	}
+
+	/* Add attribute list if not present. */
+	if (!NInoAttrList(base_ni)) {
+		ntfs_attr_put_search_ctx(ctx);
+		err = ntfs_inode_add_attrlist(base_ni);
+		if (err)
+			return err;
+		goto attr_resize_again;
+	}
+
+	/* Allocate new mft record. */
+	err = ntfs_mft_record_alloc(base_ni->vol, 0, &ext_ni, base_ni, NULL);
+	if (err) {
+		ntfs_error(sb, "Couldn't allocate MFT record");
+		goto put_err_out;
+	}
+	unmap_mft_record(ext_ni);
+
+	/* Move attribute to it. */
+	err = ntfs_attr_record_move_to(ctx, ext_ni);
+	if (err) {
+		ntfs_error(sb, "Couldn't move attribute to new MFT record");
+		err = -ENOMEM;
+		goto put_err_out;
+	}
+
+	err = ntfs_attrlist_update(base_ni);
+	if (err < 0)
+		goto put_err_out;
+
+	ntfs_attr_put_search_ctx(ctx);
+	/* Try to perform resize once again. */
+	goto attr_resize_again;
+
+resize_done:
+	/*
+	 * Set the inode (and its base inode if it exists) dirty so it is
+	 * written out later.
+	 */
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	return 0;
+
+put_err_out:
+	ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
+int __ntfs_attr_truncate_vfs(struct ntfs_inode *ni, const s64 newsize,
+		const s64 i_size)
+{
+	int err = 0;
+
+	if (newsize < 0 ||
+	    (ni->mft_no == FILE_MFT && ni->type == AT_DATA)) {
+		ntfs_debug("Invalid arguments passed.\n");
+		return -EINVAL;
+	}
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, size %lld\n",
+			(unsigned long long)ni->mft_no, ni->type, newsize);
+
+	if (NInoNonResident(ni)) {
+		if (newsize > i_size) {
+			down_write(&ni->runlist.lock);
+			err = ntfs_non_resident_attr_expand(ni, newsize, 0, HOLES_OK);
+			up_write(&ni->runlist.lock);
+		} else
+			err = ntfs_non_resident_attr_shrink(ni, newsize);
+	} else
+		err = ntfs_resident_attr_resize(ni, newsize, 0, HOLES_OK);
+	ntfs_debug("Return status %d\n", err);
+	return err;
+}
+
+int ntfs_attr_expand(struct ntfs_inode *ni, const s64 newsize, const s64 prealloc_size)
+{
+	int err = 0;
+
+	if (newsize < 0 ||
+	    (ni->mft_no == FILE_MFT && ni->type == AT_DATA)) {
+		ntfs_debug("Invalid arguments passed.\n");
+		return -EINVAL;
+	}
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, size %lld\n",
+			(unsigned long long)ni->mft_no, ni->type, newsize);
+
+	if (ni->data_size == newsize) {
+		ntfs_debug("Size is already ok\n");
+		return 0;
+	}
+
+	/*
+	 * Encrypted attributes are not supported. We return access denied,
+	 * which is what Windows NT4 does, too.
+	 */
+	if (NInoEncrypted(ni)) {
+		pr_err("Failed to truncate encrypted attribute");
+		return -EACCES;
+	}
+
+	if (NInoNonResident(ni)) {
+		if (newsize > ni->data_size)
+			err = ntfs_non_resident_attr_expand(ni, newsize, prealloc_size, HOLES_OK);
+	} else
+		err = ntfs_resident_attr_resize(ni, newsize, prealloc_size, HOLES_OK);
+	if (!err)
+		i_size_write(VFS_I(ni), newsize);
+	ntfs_debug("Return status %d\n", err);
+	return err;
+}
+
+/**
+ * ntfs_attr_truncate_i - resize an ntfs attribute
+ * @ni:		open ntfs inode to resize
+ * @newsize:	new size (in bytes) to which to resize the attribute
+ *
+ * Change the size of an open ntfs attribute @na to @newsize bytes. If the
+ * attribute is made bigger and the attribute is resident the newly
+ * "allocated" space is cleared and if the attribute is non-resident the
+ * newly allocated space is marked as not initialised and no real allocation
+ * on disk is performed.
+ */
+int ntfs_attr_truncate_i(struct ntfs_inode *ni, const s64 newsize, unsigned int holes)
+{
+	int err;
+
+	if (newsize < 0 ||
+	    (ni->mft_no == FILE_MFT && ni->type == AT_DATA)) {
+		ntfs_debug("Invalid arguments passed.\n");
+		return -EINVAL;
+	}
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, size %lld\n",
+			(unsigned long long)ni->mft_no, ni->type, newsize);
+
+	if (ni->data_size == newsize) {
+		ntfs_debug("Size is already ok\n");
+		return 0;
+	}
+
+	/*
+	 * Encrypted attributes are not supported. We return access denied,
+	 * which is what Windows NT4 does, too.
+	 */
+	if (NInoEncrypted(ni)) {
+		pr_err("Failed to truncate encrypted attribute");
+		return -EACCES;
+	}
+
+	if (NInoCompressed(ni)) {
+		pr_err("Failed to truncate compressed attribute");
+		return -EOPNOTSUPP;
+	}
+
+	if (NInoNonResident(ni)) {
+		if (newsize > ni->data_size)
+			err = ntfs_non_resident_attr_expand(ni, newsize, 0, holes);
+		else
+			err = ntfs_non_resident_attr_shrink(ni, newsize);
+	} else
+		err = ntfs_resident_attr_resize(ni, newsize, 0, holes);
+	ntfs_debug("Return status %d\n", err);
+	return err;
+}
+
+/*
+ * Resize an attribute, creating a hole if relevant
+ */
+int ntfs_attr_truncate(struct ntfs_inode *ni, const s64 newsize)
+{
+	return ntfs_attr_truncate_i(ni, newsize, HOLES_OK);
+}
+
+int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
+		s64 *lcn_count, s64 max_clu_count, bool *balloc, bool update_mp,
+		bool skip_holes)
+{
+	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_attr_search_ctx *ctx;
+	struct runlist_element *rl, *rlc;
+	s64 vcn = vcn_start, lcn, clu_count;
+	s64 lcn_seek_from = -1;
+	int err = 0;
+	size_t new_rl_count;
+
+	BUG_ON(!NInoNonResident(ni));
+
+	err = ntfs_attr_map_whole_runlist(ni);
+	if (err)
+		return err;
+
+	if (NInoAttr(ni))
+		ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+	else
+		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, vcn, NULL, 0, ctx);
+	if (err) {
+		ntfs_error(vol->sb,
+			   "ntfs_attr_lookup failed, ntfs inode(mft_no : %ld) type : 0x%x, err : %d",
+			   ni->mft_no, ni->type, err);
+		goto out;
+	}
+
+	rl = ntfs_attr_find_vcn_nolock(ni, vcn, ctx);
+	if (IS_ERR(rl)) {
+		ntfs_error(vol->sb, "Failed to find run after mapping runlist.");
+		err = PTR_ERR(rl);
+		goto out;
+	}
+
+	lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
+	clu_count = min(max_clu_count, rl->length - (vcn - rl->vcn));
+	if (lcn >= LCN_HOLE) {
+		if (lcn > LCN_DELALLOC ||
+		    (lcn == LCN_HOLE && skip_holes)) {
+			*lcn_start = lcn;
+			*lcn_count = clu_count;
+			*balloc = false;
+			goto out;
+		}
+	} else {
+		BUG_ON(lcn == LCN_RL_NOT_MAPPED);
+		if (lcn == LCN_ENOENT)
+			err = -ENOENT;
+		else
+			err = -EIO;
+		goto out;
+	}
+
+	/* Search backwards to find the best lcn to start seek from. */
+	rlc = rl;
+	while (rlc->vcn) {
+		rlc--;
+		if (rlc->lcn >= 0) {
+			/*
+			 * avoid fragmenting a compressed file
+			 * Windows does not do that, and that may
+			 * not be desirable for files which can
+			 * be updated
+			 */
+			if (NInoCompressed(ni))
+				lcn_seek_from = rlc->lcn + rlc->length;
+			else
+				lcn_seek_from = rlc->lcn + (vcn - rlc->vcn);
+			break;
+		}
+	}
+
+	if (lcn_seek_from == -1) {
+		/* Backwards search failed, search forwards. */
+		rlc = rl;
+		while (rlc->length) {
+			rlc++;
+			if (rlc->lcn >= 0) {
+				lcn_seek_from = rlc->lcn - (rlc->vcn - vcn);
+				if (lcn_seek_from < -1)
+					lcn_seek_from = -1;
+				break;
+			}
+		}
+	}
+
+	if (lcn_seek_from == -1 && ni->lcn_seek_trunc != LCN_RL_NOT_MAPPED) {
+		lcn_seek_from = ni->lcn_seek_trunc;
+		ni->lcn_seek_trunc = LCN_RL_NOT_MAPPED;
+	}
+
+	rlc = ntfs_cluster_alloc(vol, vcn, clu_count, lcn_seek_from, DATA_ZONE,
+			false, true, true);
+	if (IS_ERR(rlc)) {
+		err = PTR_ERR(rlc);
+		goto out;
+	}
+
+	BUG_ON(rlc->vcn != vcn);
+	lcn = rlc->lcn;
+	clu_count = rlc->length;
+
+	rl = ntfs_runlists_merge(&ni->runlist, rlc, 0, &new_rl_count);
+	if (IS_ERR(rl)) {
+		ntfs_error(vol->sb, "Failed to merge runlists");
+		err = PTR_ERR(rl);
+		if (ntfs_cluster_free_from_rl(vol, rlc))
+			ntfs_error(vol->sb, "Failed to free hot clusters.");
+		ntfs_free(rlc);
+		goto out;
+	}
+	ni->runlist.rl = rl;
+	ni->runlist.count = new_rl_count;
+
+	if (!update_mp) {
+		if (((long long)atomic64_read(&vol->free_clusters) * 100) /
+				(long)vol->nr_clusters <= 5)
+			update_mp = true;
+	}
+
+	if (update_mp) {
+		ntfs_attr_reinit_search_ctx(ctx);
+		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		if (err) {
+			int err2;
+
+			err2 = ntfs_cluster_free(ni, vcn, clu_count, ctx);
+			if (err2 < 0)
+				ntfs_error(vol->sb,
+					   "Failed to free cluster allocation. Leaving inconstant metadata.\n");
+			goto out;
+		}
+	} else {
+		VFS_I(ni)->i_blocks += clu_count << (vol->cluster_size_bits - 9);
+		NInoSetRunlistDirty(ni);
+		mark_mft_record_dirty(ni);
+	}
+
+	*lcn_start = lcn;
+	*lcn_count = clu_count;
+	*balloc = true;
+out:
+	ntfs_attr_put_search_ctx(ctx);
+	return err;
+}
+
+/**
+ * ntfs_attr_rm - remove attribute from ntfs inode
+ * @ni:		opened ntfs attribute to delete
+ *
+ * Remove attribute and all it's extents from ntfs inode. If attribute was non
+ * resident also free all clusters allocated by attribute.
+ */
+int ntfs_attr_rm(struct ntfs_inode *ni)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	int err = 0, ret = 0;
+	struct ntfs_inode *base_ni;
+	struct super_block *sb = ni->vol->sb;
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x.\n",
+			(long long) ni->mft_no, ni->type);
+
+	/* Free cluster allocation. */
+	if (NInoNonResident(ni)) {
+		struct ntfs_attr_search_ctx *ctx;
+
+		err = ntfs_attr_map_whole_runlist(ni);
+		if (err)
+			return err;
+		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		if (!ctx) {
+			ntfs_error(sb, "%s: Failed to get search context", __func__);
+			return -ENOMEM;
+		}
+
+		ret = ntfs_cluster_free(ni, 0, -1, ctx);
+		if (ret < 0)
+			ntfs_error(sb,
+				"Failed to free cluster allocation. Leaving inconstant metadata.\n");
+		ntfs_attr_put_search_ctx(ctx);
+	}
+
+	/* Search for attribute extents and remove them all. */
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	if (!ctx) {
+		ntfs_error(sb, "%s: Failed to get search context", __func__);
+		return -ENOMEM;
+	}
+	while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, 0, NULL, 0, ctx))) {
+		err = ntfs_attr_record_rm(ctx);
+		if (err) {
+			ntfs_error(sb,
+				"Failed to remove attribute extent. Leaving inconstant metadata.\n");
+			ret = err;
+		}
+		ntfs_attr_reinit_search_ctx(ctx);
+	}
+	ntfs_attr_put_search_ctx(ctx);
+	if (err != -ENOENT) {
+		ntfs_error(sb, "Attribute lookup failed. Probably leaving inconstant metadata.\n");
+		ret = err;
+	}
+
+	return ret;
+}
+
+int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
+		u32 name_len)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	int ret;
+
+	ntfs_debug("Entering\n");
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		ntfs_error(ni->vol->sb, "%s: Failed to get search context",
+				__func__);
+		return 0;
+	}
+
+	ret = ntfs_attr_lookup(type, name, name_len, CASE_SENSITIVE,
+			0, NULL, 0, ctx);
+	ntfs_attr_put_search_ctx(ctx);
+
+	return !ret;
+}
+
+int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
+		u32 name_len)
+{
+	struct super_block *sb;
+	int err;
+	struct inode *attr_vi;
+	struct ntfs_inode *attr_ni;
+
+	ntfs_debug("Entering\n");
+
+	sb = ni->vol->sb;
+	if (!ni) {
+		ntfs_error(sb, "NULL inode pointer\n");
+		return -EINVAL;
+	}
+
+	attr_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
+	if (IS_ERR(attr_vi)) {
+		err = PTR_ERR(attr_vi);
+		ntfs_error(sb, "Failed to open attribute 0x%02x of inode 0x%llx",
+				type, (unsigned long long)ni->mft_no);
+		return err;
+	}
+	attr_ni = NTFS_I(attr_vi);
+
+	err = ntfs_attr_rm(attr_ni);
+	if (err)
+		ntfs_error(sb, "Failed to remove attribute 0x%02x of inode 0x%llx",
+				type, (unsigned long long)ni->mft_no);
+	iput(attr_vi);
+	return err;
+}
+
+/**
+ * ntfs_attr_readall - read the entire data from an ntfs attribute
+ * @ni:		open ntfs inode in which the ntfs attribute resides
+ * @type:	attribute type
+ * @name:	attribute name in little endian Unicode or AT_UNNAMED or NULL
+ * @name_len:	length of attribute @name in Unicode characters (if @name given)
+ * @data_size:	if non-NULL then store here the data size
+ *
+ * This function will read the entire content of an ntfs attribute.
+ * If @name is AT_UNNAMED then look specifically for an unnamed attribute.
+ * If @name is NULL then the attribute could be either named or not.
+ * In both those cases @name_len is not used at all.
+ *
+ * On success a buffer is allocated with the content of the attribute
+ * and which needs to be freed when it's not needed anymore. If the
+ * @data_size parameter is non-NULL then the data size is set there.
+ */
+void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len, s64 *data_size)
+{
+	struct ntfs_inode *bmp_ni;
+	struct inode *bmp_vi;
+	void *data, *ret = NULL;
+	s64 size;
+	struct super_block *sb = ni->vol->sb;
+
+	ntfs_debug("Entering\n");
+
+	bmp_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
+	if (IS_ERR(bmp_vi)) {
+		ntfs_debug("ntfs_attr_iget failed");
+		goto err_exit;
+	}
+	bmp_ni = NTFS_I(bmp_vi);
+
+	data = ntfs_malloc_nofs(bmp_ni->data_size);
+	if (!data) {
+		ntfs_error(sb, "ntfs_malloc_nofs failed");
+		goto out;
+	}
+
+	size = ntfs_inode_attr_pread(VFS_I(bmp_ni), 0, bmp_ni->data_size,
+			(u8 *)data);
+	if (size != bmp_ni->data_size) {
+		ntfs_error(sb, "ntfs_attr_pread failed");
+		ntfs_free(data);
+		goto out;
+	}
+	ret = data;
+	if (data_size)
+		*data_size = size;
+out:
+	iput(bmp_vi);
+err_exit:
+	ntfs_debug("\n");
+	return ret;
+}
+
+int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
+{
+	struct ntfs_volume *vol = ni->vol;
+	struct runlist_element *hole_rl, *rl;
+	struct ntfs_attr_search_ctx *ctx;
+	int ret;
+	size_t new_rl_count;
+
+	if (NInoAttr(ni) || ni->type != AT_DATA)
+		return -EOPNOTSUPP;
+	if (start_vcn > (ni->allocated_size >> vol->cluster_size_bits))
+		return -EINVAL;
+
+	hole_rl = ntfs_malloc_nofs(sizeof(*hole_rl) * 2);
+	if (!hole_rl)
+		return -ENOMEM;
+	hole_rl[0].vcn = start_vcn;
+	hole_rl[0].lcn = LCN_HOLE;
+	hole_rl[0].length = len;
+	hole_rl[1].vcn = start_vcn + len;
+	hole_rl[1].lcn = LCN_ENOENT;
+	hole_rl[1].length = 0;
+
+	down_write(&ni->runlist.lock);
+	ret = ntfs_attr_map_whole_runlist(ni);
+	if (ret) {
+		up_write(&ni->runlist.lock);
+		return ret;
+	}
+
+	rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
+	if (!rl) {
+		up_write(&ni->runlist.lock);
+		ntfs_free(hole_rl);
+		return -EIO;
+	}
+
+	rl = ntfs_rl_insert_range(ni->runlist.rl, (int)ni->runlist.count,
+				  hole_rl, 1, &new_rl_count);
+	if (IS_ERR(rl)) {
+		up_write(&ni->runlist.lock);
+		ntfs_free(hole_rl);
+		return PTR_ERR(rl);
+	}
+	ni->runlist.rl =  rl;
+	ni->runlist.count = new_rl_count;
+
+	ni->allocated_size += len << vol->cluster_size_bits;
+	ni->data_size += len << vol->cluster_size_bits;
+	if ((start_vcn << vol->cluster_size_bits) < ni->initialized_size)
+		ni->initialized_size += len << vol->cluster_size_bits;
+	ret = ntfs_attr_update_mapping_pairs(ni, 0);
+	up_write(&ni->runlist.lock);
+	if (ret)
+		return ret;
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+			       0, NULL, 0, ctx);
+	if (ret) {
+		ntfs_attr_put_search_ctx(ctx);
+		return ret;
+	}
+
+	ctx->attr->data.non_resident.data_size = cpu_to_le64(ni->data_size);
+	ctx->attr->data.non_resident.initialized_size = cpu_to_le64(ni->initialized_size);
+	if (ni->type == AT_DATA && ni->name == AT_UNNAMED)
+		NInoSetFileNameDirty(ni);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	return ret;
+}
+
+int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
+{
+	struct ntfs_volume *vol = ni->vol;
+	struct runlist_element *punch_rl, *rl;
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	s64 end_vcn;
+	int dst_cnt;
+	int ret;
+	size_t new_rl_cnt;
+
+	if (NInoAttr(ni) || ni->type != AT_DATA)
+		return -EOPNOTSUPP;
+
+	end_vcn = ni->allocated_size >> vol->cluster_size_bits;
+	if (start_vcn >= end_vcn)
+		return -EINVAL;
+
+	down_write(&ni->runlist.lock);
+	ret = ntfs_attr_map_whole_runlist(ni);
+	if (ret)
+		return ret;
+
+	len = min(len, end_vcn - start_vcn);
+	for (rl = ni->runlist.rl, dst_cnt = 0; rl && rl->length; rl++)
+		dst_cnt++;
+	rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
+	if (!rl) {
+		up_write(&ni->runlist.lock);
+		return -EIO;
+	}
+
+	rl = ntfs_rl_collapse_range(ni->runlist.rl, dst_cnt + 1,
+				    start_vcn, len, &punch_rl, &new_rl_cnt);
+	if (IS_ERR(rl)) {
+		up_write(&ni->runlist.lock);
+		return PTR_ERR(rl);
+	}
+	ni->runlist.rl = rl;
+	ni->runlist.count = new_rl_cnt;
+
+	ni->allocated_size -= len << vol->cluster_size_bits;
+	if (ni->data_size > (start_vcn << vol->cluster_size_bits)) {
+		if (ni->data_size > (start_vcn + len) << vol->cluster_size_bits)
+			ni->data_size -= len << vol->cluster_size_bits;
+		else
+			ni->data_size = start_vcn << vol->cluster_size_bits;
+	}
+	if (ni->initialized_size > (start_vcn << vol->cluster_size_bits)) {
+		if (ni->initialized_size >
+		    (start_vcn + len) << vol->cluster_size_bits)
+			ni->initialized_size -= len << vol->cluster_size_bits;
+		else
+			ni->initialized_size = start_vcn << vol->cluster_size_bits;
+	}
+
+	if (ni->allocated_size > 0) {
+		ret = ntfs_attr_update_mapping_pairs(ni, 0);
+		if (ret) {
+			up_write(&ni->runlist.lock);
+			goto out_rl;
+		}
+	}
+	up_write(&ni->runlist.lock);
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		ret = -ENOMEM;
+		goto out_rl;
+	}
+
+	ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+			       0, NULL, 0, ctx);
+	if (ret)
+		goto out_ctx;
+
+	ctx->attr->data.non_resident.data_size = cpu_to_le64(ni->data_size);
+	ctx->attr->data.non_resident.initialized_size = cpu_to_le64(ni->initialized_size);
+	if (ni->allocated_size == 0)
+		ntfs_attr_make_resident(ni, ctx);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+
+	ret = ntfs_cluster_free_from_rl(vol, punch_rl);
+	if (ret)
+		ntfs_error(vol->sb, "Freeing of clusters failed");
+out_ctx:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+out_rl:
+	ntfs_free(punch_rl);
+	mark_mft_record_dirty(ni);
+	return ret;
+}
+
+int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64 len)
+{
+	struct ntfs_volume *vol = ni->vol;
+	struct runlist_element *punch_rl, *rl;
+	s64 end_vcn;
+	int dst_cnt;
+	int ret;
+	size_t new_rl_count;
+
+	if (NInoAttr(ni) || ni->type != AT_DATA)
+		return -EOPNOTSUPP;
+
+	end_vcn = ni->allocated_size >> vol->cluster_size_bits;
+	if (start_vcn >= end_vcn)
+		return -EINVAL;
+
+	down_write(&ni->runlist.lock);
+	ret = ntfs_attr_map_whole_runlist(ni);
+	if (ret) {
+		up_write(&ni->runlist.lock);
+		return ret;
+	}
+
+	len = min(len, end_vcn - start_vcn + 1);
+	for (rl = ni->runlist.rl, dst_cnt = 0; rl && rl->length; rl++)
+		dst_cnt++;
+	rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
+	if (!rl) {
+		up_write(&ni->runlist.lock);
+		return -EIO;
+	}
+
+	rl = ntfs_rl_punch_hole(ni->runlist.rl, dst_cnt + 1,
+				start_vcn, len, &punch_rl, &new_rl_count);
+	if (IS_ERR(rl)) {
+		up_write(&ni->runlist.lock);
+		return PTR_ERR(rl);
+	}
+	ni->runlist.rl = rl;
+	ni->runlist.count = new_rl_count;
+
+	ret = ntfs_attr_update_mapping_pairs(ni, 0);
+	up_write(&ni->runlist.lock);
+	if (ret) {
+		ntfs_free(punch_rl);
+		return ret;
+	}
+
+	ret = ntfs_cluster_free_from_rl(vol, punch_rl);
+	if (ret)
+		ntfs_error(vol->sb, "Freeing of clusters failed");
+
+	ntfs_free(punch_rl);
+	mark_mft_record_dirty(ni);
+	return ret;
+}
+
+int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bool keep_size)
+{
+	struct ntfs_volume *vol = ni->vol;
+	struct mft_record *mrec;
+	struct ntfs_attr_search_ctx *ctx;
+	s64 old_data_size;
+	s64 vcn_start, vcn_end, vcn_uninit, vcn, try_alloc_cnt;
+	s64 lcn, alloc_cnt;
+	int err = 0;
+	struct runlist_element *rl;
+	bool balloc;
+
+	if (NInoAttr(ni) || ni->type != AT_DATA)
+		return -EINVAL;
+
+	if (NInoNonResident(ni) && !NInoFullyMapped(ni)) {
+		down_write(&ni->runlist.lock);
+		err = ntfs_attr_map_whole_runlist(ni);
+		up_write(&ni->runlist.lock);
+		if (err)
+			return err;
+	}
+
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	mrec = map_mft_record(ni);
+	if (IS_ERR(mrec)) {
+		mutex_unlock(&ni->mrec_lock);
+		return PTR_ERR(mrec);
+	}
+
+	ctx = ntfs_attr_get_search_ctx(ni, mrec);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto out_unmap;
+	}
+
+	err = ntfs_attr_lookup(AT_DATA, AT_UNNAMED, 0, 0, 0, NULL, 0, ctx);
+	if (err) {
+		err = -EIO;
+		goto out_unmap;
+	}
+
+	old_data_size = ni->data_size;
+	if (start + byte_len > ni->data_size) {
+		err = ntfs_attr_truncate(ni, start + byte_len);
+		if (err)
+			goto out_unmap;
+		if (keep_size) {
+			ntfs_attr_reinit_search_ctx(ctx);
+			err = ntfs_attr_lookup(AT_DATA, AT_UNNAMED, 0, 0, 0, NULL, 0, ctx);
+			if (err) {
+				err = -EIO;
+				goto out_unmap;
+			}
+			ni->data_size = old_data_size;
+			if (NInoNonResident(ni))
+				ctx->attr->data.non_resident.data_size =
+					cpu_to_le64(old_data_size);
+			else
+				ctx->attr->data.resident.value_length =
+					cpu_to_le64(old_data_size);
+			mark_mft_record_dirty(ni);
+		}
+	}
+
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(ni);
+	mutex_unlock(&ni->mrec_lock);
+
+	if (!NInoNonResident(ni))
+		goto out;
+
+	vcn_start = (s64)(start >> vol->cluster_size_bits);
+	vcn_end = (s64)(round_up(start + byte_len, vol->cluster_size) >>
+			vol->cluster_size_bits);
+	vcn_uninit = (s64)(round_up(ni->initialized_size, vol->cluster_size) /
+			       vol->cluster_size);
+	vcn_uninit = min_t(s64, vcn_uninit, vcn_end);
+
+	/*
+	 * we have to allocate clusters for holes and delayed within initialized_size,
+	 * and zero out the clusters only for the holes.
+	 */
+	vcn = vcn_start;
+	while (vcn < vcn_uninit) {
+		down_read(&ni->runlist.lock);
+		rl = ntfs_attr_find_vcn_nolock(ni, vcn, NULL);
+		up_read(&ni->runlist.lock);
+		if (IS_ERR(rl)) {
+			err = PTR_ERR(rl);
+			goto out;
+		}
+
+		if (rl->lcn > 0) {
+			vcn += rl->length - (vcn - rl->vcn);
+		} else if (rl->lcn == LCN_DELALLOC || rl->lcn == LCN_HOLE) {
+			try_alloc_cnt = min(rl->length - (vcn - rl->vcn),
+					    vcn_uninit - vcn);
+
+			if (rl->lcn == LCN_DELALLOC) {
+				vcn += try_alloc_cnt;
+				continue;
+			}
+
+			while (try_alloc_cnt > 0) {
+				mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+				down_write(&ni->runlist.lock);
+				err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
+							    try_alloc_cnt, &balloc, false, false);
+				up_write(&ni->runlist.lock);
+				mutex_unlock(&ni->mrec_lock);
+				if (err)
+					goto out;
+
+				err = ntfs_zeroed_clusters(VFS_I(ni), lcn, alloc_cnt);
+				if (err > 0)
+					goto out;
+
+				if (signal_pending(current))
+					goto out;
+
+				vcn += alloc_cnt;
+				try_alloc_cnt -= alloc_cnt;
+			}
+		} else {
+			err = -EIO;
+			goto out;
+		}
+	}
+
+	/* allocate clusters outside of initialized_size */
+	try_alloc_cnt = vcn_end - vcn;
+	while (try_alloc_cnt > 0) {
+		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		down_write(&ni->runlist.lock);
+		err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
+					    try_alloc_cnt, &balloc, false, false);
+		up_write(&ni->runlist.lock);
+		mutex_unlock(&ni->mrec_lock);
+		if (err || signal_pending(current))
+			goto out;
+
+		vcn += alloc_cnt;
+		try_alloc_cnt -= alloc_cnt;
+		cond_resched();
+	}
+
+	if (NInoRunlistDirty(ni)) {
+		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		down_write(&ni->runlist.lock);
+		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		if (err)
+			ntfs_error(ni->vol->sb, "Updating mapping pairs failed");
+		else
+			NInoClearRunlistDirty(ni);
+		up_write(&ni->runlist.lock);
+		mutex_unlock(&ni->mrec_lock);
+	}
+	return err;
+out_unmap:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(ni);
+	mutex_unlock(&ni->mrec_lock);
+out:
+	return err >= 0 ? 0 : err;
+}
diff --git a/fs/ntfsplus/attrlist.c b/fs/ntfsplus/attrlist.c
new file mode 100644
index 000000000000..d83be752a846
--- /dev/null
+++ b/fs/ntfsplus/attrlist.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Attribute list attribute handling code.  Originated from the Linux-NTFS
+ * project.
+ * Part of this file is based on code from the NTFS-3G project.
+ *
+ * Copyright (c) 2004-2005 Anton Altaparmakov
+ * Copyright (c) 2004-2005 Yura Pakhuchiy
+ * Copyright (c)      2006 Szabolcs Szakacsits
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include "mft.h"
+#include "attrib.h"
+#include "misc.h"
+#include "attrlist.h"
+
+/**
+ * ntfs_attrlist_need - check whether inode need attribute list
+ * @ni:	opened ntfs inode for which perform check
+ *
+ * Check whether all are attributes belong to one MFT record, in that case
+ * attribute list is not needed.
+ */
+int ntfs_attrlist_need(struct ntfs_inode *ni)
+{
+	struct attr_list_entry *ale;
+
+	if (!ni) {
+		ntfs_debug("Invalid arguments.\n");
+		return -EINVAL;
+	}
+	ntfs_debug("Entering for inode 0x%llx.\n", (long long) ni->mft_no);
+
+	if (!NInoAttrList(ni)) {
+		ntfs_debug("Inode haven't got attribute list.\n");
+		return -EINVAL;
+	}
+
+	if (!ni->attr_list) {
+		ntfs_debug("Corrupt in-memory struct.\n");
+		return -EINVAL;
+	}
+
+	ale = (struct attr_list_entry *)ni->attr_list;
+	while ((u8 *)ale < ni->attr_list + ni->attr_list_size) {
+		if (MREF_LE(ale->mft_reference) != ni->mft_no)
+			return 1;
+		ale = (struct attr_list_entry *)((u8 *)ale + le16_to_cpu(ale->length));
+	}
+	return 0;
+}
+
+int ntfs_attrlist_update(struct ntfs_inode *base_ni)
+{
+	struct inode *attr_vi;
+	struct ntfs_inode *attr_ni;
+	int err;
+
+	BUG_ON(!NInoAttrList(base_ni));
+
+	attr_vi = ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0);
+	if (IS_ERR(attr_vi)) {
+		err = PTR_ERR(attr_vi);
+		return err;
+	}
+	attr_ni = NTFS_I(attr_vi);
+
+	if (ntfs_attr_truncate_i(attr_ni, base_ni->attr_list_size, HOLES_NO) != 0) {
+		iput(attr_vi);
+		ntfs_error(base_ni->vol->sb,
+			   "Failed to truncate attribute list of inode %#llx",
+			   (long long)base_ni->mft_no);
+		return -EIO;
+	}
+	i_size_write(attr_vi, base_ni->attr_list_size);
+
+	if (NInoNonResident(attr_ni) && !NInoAttrListNonResident(base_ni))
+		NInoSetAttrListNonResident(base_ni);
+
+	if (ntfs_inode_attr_pwrite(attr_vi, 0, base_ni->attr_list_size,
+				   base_ni->attr_list, false) !=
+	    base_ni->attr_list_size) {
+		iput(attr_vi);
+		ntfs_error(base_ni->vol->sb,
+			   "Failed to write attribute list of inode %#llx",
+			   (long long)base_ni->mft_no);
+		return -EIO;
+	}
+
+	NInoSetAttrListDirty(base_ni);
+	iput(attr_vi);
+	return 0;
+}
+
+/**
+ * ntfs_attrlist_entry_add - add an attribute list attribute entry
+ * @ni:	opened ntfs inode, which contains that attribute
+ * @attr: attribute record to add to attribute list
+ */
+int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
+{
+	struct attr_list_entry *ale;
+	__le64 mref;
+	struct ntfs_attr_search_ctx *ctx;
+	u8 *new_al;
+	int entry_len, entry_offset, err;
+	struct mft_record *ni_mrec;
+	u8 *old_al;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x.\n",
+			(long long) ni->mft_no,
+			(unsigned int) le32_to_cpu(attr->type));
+
+	if (!ni || !attr) {
+		ntfs_debug("Invalid arguments.\n");
+		return -EINVAL;
+	}
+
+	ni_mrec = map_mft_record(ni);
+	if (IS_ERR(ni_mrec)) {
+		ntfs_debug("Invalid arguments.\n");
+		return -EIO;
+	}
+
+	mref = MK_LE_MREF(ni->mft_no, le16_to_cpu(ni_mrec->sequence_number));
+	unmap_mft_record(ni);
+
+	if (ni->nr_extents == -1)
+		ni = ni->ext.base_ntfs_ino;
+
+	if (!NInoAttrList(ni)) {
+		ntfs_debug("Attribute list isn't present.\n");
+		return -ENOENT;
+	}
+
+	/* Determine size and allocate memory for new attribute list. */
+	entry_len = (sizeof(struct attr_list_entry) + sizeof(__le16) *
+			attr->name_length + 7) & ~7;
+	new_al = ntfs_malloc_nofs(ni->attr_list_size + entry_len);
+	if (!new_al)
+		return -ENOMEM;
+
+	/* Find place for the new entry. */
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		ntfs_error(ni->vol->sb, "Failed to get search context");
+		goto err_out;
+	}
+
+	err = ntfs_attr_lookup(attr->type, (attr->name_length) ? (__le16 *)
+			((u8 *)attr + le16_to_cpu(attr->name_offset)) :
+			AT_UNNAMED, attr->name_length, CASE_SENSITIVE,
+			(attr->non_resident) ? le64_to_cpu(attr->data.non_resident.lowest_vcn) :
+			0, (attr->non_resident) ? NULL : ((u8 *)attr +
+			le16_to_cpu(attr->data.resident.value_offset)), (attr->non_resident) ?
+			0 : le32_to_cpu(attr->data.resident.value_length), ctx);
+	if (!err) {
+		/* Found some extent, check it to be before new extent. */
+		if (ctx->al_entry->lowest_vcn == attr->data.non_resident.lowest_vcn) {
+			err = -EEXIST;
+			ntfs_debug("Such attribute already present in the attribute list.\n");
+			ntfs_attr_put_search_ctx(ctx);
+			goto err_out;
+		}
+		/* Add new entry after this extent. */
+		ale = (struct attr_list_entry *)((u8 *)ctx->al_entry +
+				le16_to_cpu(ctx->al_entry->length));
+	} else {
+		/* Check for real errors. */
+		if (err != -ENOENT) {
+			ntfs_debug("Attribute lookup failed.\n");
+			ntfs_attr_put_search_ctx(ctx);
+			goto err_out;
+		}
+		/* No previous extents found. */
+		ale = ctx->al_entry;
+	}
+	/* Don't need it anymore, @ctx->al_entry points to @ni->attr_list. */
+	ntfs_attr_put_search_ctx(ctx);
+
+	/* Determine new entry offset. */
+	entry_offset = ((u8 *)ale - ni->attr_list);
+	/* Set pointer to new entry. */
+	ale = (struct attr_list_entry *)(new_al + entry_offset);
+	memset(ale, 0, entry_len);
+	/* Form new entry. */
+	ale->type = attr->type;
+	ale->length = cpu_to_le16(entry_len);
+	ale->name_length = attr->name_length;
+	ale->name_offset = offsetof(struct attr_list_entry, name);
+	if (attr->non_resident)
+		ale->lowest_vcn = attr->data.non_resident.lowest_vcn;
+	else
+		ale->lowest_vcn = 0;
+	ale->mft_reference = mref;
+	ale->instance = attr->instance;
+	memcpy(ale->name, (u8 *)attr + le16_to_cpu(attr->name_offset),
+			attr->name_length * sizeof(__le16));
+
+	/* Copy entries from old attribute list to new. */
+	memcpy(new_al, ni->attr_list, entry_offset);
+	memcpy(new_al + entry_offset + entry_len, ni->attr_list +
+			entry_offset, ni->attr_list_size - entry_offset);
+
+	/* Set new runlist. */
+	old_al = ni->attr_list;
+	ni->attr_list = new_al;
+	ni->attr_list_size = ni->attr_list_size + entry_len;
+
+	err = ntfs_attrlist_update(ni);
+	if (err) {
+		ni->attr_list = old_al;
+		ni->attr_list_size -= entry_len;
+		goto err_out;
+	}
+	ntfs_free(old_al);
+	return 0;
+err_out:
+	ntfs_free(new_al);
+	return err;
+}
+
+/**
+ * ntfs_attrlist_entry_rm - remove an attribute list attribute entry
+ * @ctx:	attribute search context describing the attribute list entry
+ *
+ * Remove the attribute list entry @ctx->al_entry from the attribute list.
+ */
+int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
+{
+	u8 *new_al;
+	int new_al_len;
+	struct ntfs_inode *base_ni;
+	struct attr_list_entry *ale;
+
+	if (!ctx || !ctx->ntfs_ino || !ctx->al_entry) {
+		ntfs_debug("Invalid arguments.\n");
+		return -EINVAL;
+	}
+
+	if (ctx->base_ntfs_ino)
+		base_ni = ctx->base_ntfs_ino;
+	else
+		base_ni = ctx->ntfs_ino;
+	ale = ctx->al_entry;
+
+	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, lowest_vcn %lld.\n",
+			(long long)ctx->ntfs_ino->mft_no,
+			(unsigned int)le32_to_cpu(ctx->al_entry->type),
+			(long long)le64_to_cpu(ctx->al_entry->lowest_vcn));
+
+	if (!NInoAttrList(base_ni)) {
+		ntfs_debug("Attribute list isn't present.\n");
+		return -ENOENT;
+	}
+
+	/* Allocate memory for new attribute list. */
+	new_al_len = base_ni->attr_list_size - le16_to_cpu(ale->length);
+	new_al = ntfs_malloc_nofs(new_al_len);
+	if (!new_al)
+		return -ENOMEM;
+
+	/* Copy entries from old attribute list to new. */
+	memcpy(new_al, base_ni->attr_list, (u8 *)ale - base_ni->attr_list);
+	memcpy(new_al + ((u8 *)ale - base_ni->attr_list), (u8 *)ale + le16_to_cpu(
+				ale->length), new_al_len - ((u8 *)ale - base_ni->attr_list));
+
+	/* Set new runlist. */
+	ntfs_free(base_ni->attr_list);
+	base_ni->attr_list = new_al;
+	base_ni->attr_list_size = new_al_len;
+
+	return ntfs_attrlist_update(base_ni);
+}
diff --git a/fs/ntfsplus/compress.c b/fs/ntfsplus/compress.c
new file mode 100644
index 000000000000..5de465a00788
--- /dev/null
+++ b/fs/ntfsplus/compress.c
@@ -0,0 +1,1565 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * NTFS kernel compressed attributes handling.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ * and is copyrighted by the respective authors below:
+ * Copyright (c) 2004-2005 Anton Altaparmakov
+ * Copyright (c) 2004-2006 Szabolcs Szakacsits
+ * Copyright (c)      2005 Yura Pakhuchiy
+ * Copyright (c) 2009-2014 Jean-Pierre Andre
+ * Copyright (c)      2014 Eric Biggers
+ */
+
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+
+#include "attrib.h"
+#include "inode.h"
+#include "misc.h"
+#include "ntfs.h"
+#include "misc.h"
+#include "aops.h"
+#include "lcnalloc.h"
+#include "mft.h"
+
+/**
+ * enum of constants used in the compression code
+ */
+enum {
+	/* Token types and access mask. */
+	NTFS_SYMBOL_TOKEN	=	0,
+	NTFS_PHRASE_TOKEN	=	1,
+	NTFS_TOKEN_MASK		=	1,
+
+	/* Compression sub-block constants. */
+	NTFS_SB_SIZE_MASK	=	0x0fff,
+	NTFS_SB_SIZE		=	0x1000,
+	NTFS_SB_IS_COMPRESSED	=	0x8000,
+
+	/*
+	 * The maximum compression block size is by definition 16 * the cluster
+	 * size, with the maximum supported cluster size being 4kiB. Thus the
+	 * maximum compression buffer size is 64kiB, so we use this when
+	 * initializing the compression buffer.
+	 */
+	NTFS_MAX_CB_SIZE	= 64 * 1024,
+};
+
+/**
+ * ntfs_compression_buffer - one buffer for the decompression engine
+ */
+static u8 *ntfs_compression_buffer;
+
+/**
+ * ntfs_cb_lock - mutex lock which protects ntfs_compression_buffer
+ */
+static DEFINE_MUTEX(ntfs_cb_lock);
+
+/**
+ * allocate_compression_buffers - allocate the decompression buffers
+ *
+ * Caller has to hold the ntfs_lock mutex.
+ *
+ * Return 0 on success or -ENOMEM if the allocations failed.
+ */
+int allocate_compression_buffers(void)
+{
+	if (ntfs_compression_buffer)
+		return 0;
+
+	ntfs_compression_buffer = vmalloc(NTFS_MAX_CB_SIZE);
+	if (!ntfs_compression_buffer)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * free_compression_buffers - free the decompression buffers
+ *
+ * Caller has to hold the ntfs_lock mutex.
+ */
+void free_compression_buffers(void)
+{
+	mutex_lock(&ntfs_cb_lock);
+	if (!ntfs_compression_buffer) {
+		mutex_unlock(&ntfs_cb_lock);
+		return;
+	}
+
+	vfree(ntfs_compression_buffer);
+	ntfs_compression_buffer = NULL;
+	mutex_unlock(&ntfs_cb_lock);
+}
+
+/**
+ * zero_partial_compressed_page - zero out of bounds compressed page region
+ */
+static void zero_partial_compressed_page(struct page *page,
+		const s64 initialized_size)
+{
+	u8 *kp = page_address(page);
+	unsigned int kp_ofs;
+
+	ntfs_debug("Zeroing page region outside initialized size.");
+	if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
+		clear_page(kp);
+		return;
+	}
+	kp_ofs = initialized_size & ~PAGE_MASK;
+	memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
+}
+
+/**
+ * handle_bounds_compressed_page - test for&handle out of bounds compressed page
+ */
+static inline void handle_bounds_compressed_page(struct page *page,
+		const loff_t i_size, const s64 initialized_size)
+{
+	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
+			(initialized_size < i_size))
+		zero_partial_compressed_page(page, initialized_size);
+}
+
+/**
+ * ntfs_decompress - decompress a compression block into an array of pages
+ * @dest_pages:		destination array of pages
+ * @completed_pages:	scratch space to track completed pages
+ * @dest_index:		current index into @dest_pages (IN/OUT)
+ * @dest_ofs:		current offset within @dest_pages[@dest_index] (IN/OUT)
+ * @dest_max_index:	maximum index into @dest_pages (IN)
+ * @dest_max_ofs:	maximum offset within @dest_pages[@dest_max_index] (IN)
+ * @xpage:		the target page (-1 if none) (IN)
+ * @xpage_done:		set to 1 if xpage was completed successfully (IN/OUT)
+ * @cb_start:		compression block to decompress (IN)
+ * @cb_size:		size of compression block @cb_start in bytes (IN)
+ * @i_size:		file size when we started the read (IN)
+ * @initialized_size:	initialized file size when we started the read (IN)
+ *
+ * The caller must have disabled preemption. ntfs_decompress() reenables it when
+ * the critical section is finished.
+ *
+ * This decompresses the compression block @cb_start into the array of
+ * destination pages @dest_pages starting at index @dest_index into @dest_pages
+ * and at offset @dest_pos into the page @dest_pages[@dest_index].
+ *
+ * When the page @dest_pages[@xpage] is completed, @xpage_done is set to 1.
+ * If xpage is -1 or @xpage has not been completed, @xpage_done is not modified.
+ *
+ * @cb_start is a pointer to the compression block which needs decompressing
+ * and @cb_size is the size of @cb_start in bytes (8-64kiB).
+ *
+ * Return 0 if success or -EOVERFLOW on error in the compressed stream.
+ * @xpage_done indicates whether the target page (@dest_pages[@xpage]) was
+ * completed during the decompression of the compression block (@cb_start).
+ *
+ * Warning: This function *REQUIRES* PAGE_SIZE >= 4096 or it will blow up
+ * unpredicatbly! You have been warned!
+ *
+ * Note to hackers: This function may not sleep until it has finished accessing
+ * the compression block @cb_start as it is a per-CPU buffer.
+ */
+static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
+		int *dest_index, int *dest_ofs, const int dest_max_index,
+		const int dest_max_ofs, const int xpage, char *xpage_done,
+		u8 *const cb_start, const u32 cb_size, const loff_t i_size,
+		const s64 initialized_size)
+{
+	/*
+	 * Pointers into the compressed data, i.e. the compression block (cb),
+	 * and the therein contained sub-blocks (sb).
+	 */
+	u8 *cb_end = cb_start + cb_size; /* End of cb. */
+	u8 *cb = cb_start;	/* Current position in cb. */
+	u8 *cb_sb_start = cb;	/* Beginning of the current sb in the cb. */
+	u8 *cb_sb_end;		/* End of current sb / beginning of next sb. */
+
+	/* Variables for uncompressed data / destination. */
+	struct page *dp;	/* Current destination page being worked on. */
+	u8 *dp_addr;		/* Current pointer into dp. */
+	u8 *dp_sb_start;	/* Start of current sub-block in dp. */
+	u8 *dp_sb_end;		/* End of current sb in dp (dp_sb_start + NTFS_SB_SIZE). */
+	u16 do_sb_start;	/* @dest_ofs when starting this sub-block. */
+	u16 do_sb_end;		/* @dest_ofs of end of this sb (do_sb_start + NTFS_SB_SIZE). */
+
+	/* Variables for tag and token parsing. */
+	u8 tag;			/* Current tag. */
+	int token;		/* Loop counter for the eight tokens in tag. */
+	int nr_completed_pages = 0;
+
+	/* Default error code. */
+	int err = -EOVERFLOW;
+
+	ntfs_debug("Entering, cb_size = 0x%x.", cb_size);
+do_next_sb:
+	ntfs_debug("Beginning sub-block at offset = 0x%zx in the cb.",
+			cb - cb_start);
+	/*
+	 * Have we reached the end of the compression block or the end of the
+	 * decompressed data?  The latter can happen for example if the current
+	 * position in the compression block is one byte before its end so the
+	 * first two checks do not detect it.
+	 */
+	if (cb == cb_end || !le16_to_cpup((__le16 *)cb) ||
+			(*dest_index == dest_max_index &&
+			*dest_ofs == dest_max_ofs)) {
+		int i;
+
+		ntfs_debug("Completed. Returning success (0).");
+		err = 0;
+return_error:
+		/* We can sleep from now on, so we drop lock. */
+		mutex_unlock(&ntfs_cb_lock);
+		/* Second stage: finalize completed pages. */
+		if (nr_completed_pages > 0) {
+			for (i = 0; i < nr_completed_pages; i++) {
+				int di = completed_pages[i];
+
+				dp = dest_pages[di];
+				/*
+				 * If we are outside the initialized size, zero
+				 * the out of bounds page range.
+				 */
+				handle_bounds_compressed_page(dp, i_size,
+						initialized_size);
+				flush_dcache_page(dp);
+				kunmap_local(page_address(dp));
+				SetPageUptodate(dp);
+				unlock_page(dp);
+				if (di == xpage)
+					*xpage_done = 1;
+				else
+					put_page(dp);
+				dest_pages[di] = NULL;
+			}
+		}
+		return err;
+	}
+
+	/* Setup offsets for the current sub-block destination. */
+	do_sb_start = *dest_ofs;
+	do_sb_end = do_sb_start + NTFS_SB_SIZE;
+
+	/* Check that we are still within allowed boundaries. */
+	if (*dest_index == dest_max_index && do_sb_end > dest_max_ofs)
+		goto return_overflow;
+
+	/* Does the minimum size of a compressed sb overflow valid range? */
+	if (cb + 6 > cb_end)
+		goto return_overflow;
+
+	/* Setup the current sub-block source pointers and validate range. */
+	cb_sb_start = cb;
+	cb_sb_end = cb_sb_start + (le16_to_cpup((__le16 *)cb) & NTFS_SB_SIZE_MASK)
+			+ 3;
+	if (cb_sb_end > cb_end)
+		goto return_overflow;
+
+	/* Get the current destination page. */
+	dp = dest_pages[*dest_index];
+	if (!dp) {
+		/* No page present. Skip decompression of this sub-block. */
+		cb = cb_sb_end;
+
+		/* Advance destination position to next sub-block. */
+		*dest_ofs = (*dest_ofs + NTFS_SB_SIZE) & ~PAGE_MASK;
+		if (!*dest_ofs && (++*dest_index > dest_max_index))
+			goto return_overflow;
+		goto do_next_sb;
+	}
+
+	/* We have a valid destination page. Setup the destination pointers. */
+	dp_addr = (u8 *)page_address(dp) + do_sb_start;
+
+	/* Now, we are ready to process the current sub-block (sb). */
+	if (!(le16_to_cpup((__le16 *)cb) & NTFS_SB_IS_COMPRESSED)) {
+		ntfs_debug("Found uncompressed sub-block.");
+		/* This sb is not compressed, just copy it into destination. */
+
+		/* Advance source position to first data byte. */
+		cb += 2;
+
+		/* An uncompressed sb must be full size. */
+		if (cb_sb_end - cb != NTFS_SB_SIZE)
+			goto return_overflow;
+
+		/* Copy the block and advance the source position. */
+		memcpy(dp_addr, cb, NTFS_SB_SIZE);
+		cb += NTFS_SB_SIZE;
+
+		/* Advance destination position to next sub-block. */
+		*dest_ofs += NTFS_SB_SIZE;
+		*dest_ofs &= ~PAGE_MASK;
+		if (!(*dest_ofs)) {
+finalize_page:
+			/*
+			 * First stage: add current page index to array of
+			 * completed pages.
+			 */
+			completed_pages[nr_completed_pages++] = *dest_index;
+			if (++*dest_index > dest_max_index)
+				goto return_overflow;
+		}
+		goto do_next_sb;
+	}
+	ntfs_debug("Found compressed sub-block.");
+	/* This sb is compressed, decompress it into destination. */
+
+	/* Setup destination pointers. */
+	dp_sb_start = dp_addr;
+	dp_sb_end = dp_sb_start + NTFS_SB_SIZE;
+
+	/* Forward to the first tag in the sub-block. */
+	cb += 2;
+do_next_tag:
+	if (cb == cb_sb_end) {
+		/* Check if the decompressed sub-block was not full-length. */
+		if (dp_addr < dp_sb_end) {
+			int nr_bytes = do_sb_end - *dest_ofs;
+
+			ntfs_debug("Filling incomplete sub-block with zeroes.");
+			/* Zero remainder and update destination position. */
+			memset(dp_addr, 0, nr_bytes);
+			*dest_ofs += nr_bytes;
+		}
+		/* We have finished the current sub-block. */
+		*dest_ofs &= ~PAGE_MASK;
+		if (!(*dest_ofs))
+			goto finalize_page;
+		goto do_next_sb;
+	}
+
+	/* Check we are still in range. */
+	if (cb > cb_sb_end || dp_addr > dp_sb_end)
+		goto return_overflow;
+
+	/* Get the next tag and advance to first token. */
+	tag = *cb++;
+
+	/* Parse the eight tokens described by the tag. */
+	for (token = 0; token < 8; token++, tag >>= 1) {
+		register u16 i;
+		u16 lg, pt, length, max_non_overlap;
+		u8 *dp_back_addr;
+
+		/* Check if we are done / still in range. */
+		if (cb >= cb_sb_end || dp_addr > dp_sb_end)
+			break;
+
+		/* Determine token type and parse appropriately.*/
+		if ((tag & NTFS_TOKEN_MASK) == NTFS_SYMBOL_TOKEN) {
+			/*
+			 * We have a symbol token, copy the symbol across, and
+			 * advance the source and destination positions.
+			 */
+			*dp_addr++ = *cb++;
+			++*dest_ofs;
+
+			/* Continue with the next token. */
+			continue;
+		}
+
+		/*
+		 * We have a phrase token. Make sure it is not the first tag in
+		 * the sb as this is illegal and would confuse the code below.
+		 */
+		if (dp_addr == dp_sb_start)
+			goto return_overflow;
+
+		/*
+		 * Determine the number of bytes to go back (p) and the number
+		 * of bytes to copy (l). We use an optimized algorithm in which
+		 * we first calculate log2(current destination position in sb),
+		 * which allows determination of l and p in O(1) rather than
+		 * O(n). We just need an arch-optimized log2() function now.
+		 */
+		lg = 0;
+		for (i = *dest_ofs - do_sb_start - 1; i >= 0x10; i >>= 1)
+			lg++;
+
+		/* Get the phrase token into i. */
+		pt = le16_to_cpup((__le16 *)cb);
+
+		/*
+		 * Calculate starting position of the byte sequence in
+		 * the destination using the fact that p = (pt >> (12 - lg)) + 1
+		 * and make sure we don't go too far back.
+		 */
+		dp_back_addr = dp_addr - (pt >> (12 - lg)) - 1;
+		if (dp_back_addr < dp_sb_start)
+			goto return_overflow;
+
+		/* Now calculate the length of the byte sequence. */
+		length = (pt & (0xfff >> lg)) + 3;
+
+		/* Advance destination position and verify it is in range. */
+		*dest_ofs += length;
+		if (*dest_ofs > do_sb_end)
+			goto return_overflow;
+
+		/* The number of non-overlapping bytes. */
+		max_non_overlap = dp_addr - dp_back_addr;
+
+		if (length <= max_non_overlap) {
+			/* The byte sequence doesn't overlap, just copy it. */
+			memcpy(dp_addr, dp_back_addr, length);
+
+			/* Advance destination pointer. */
+			dp_addr += length;
+		} else {
+			/*
+			 * The byte sequence does overlap, copy non-overlapping
+			 * part and then do a slow byte by byte copy for the
+			 * overlapping part. Also, advance the destination
+			 * pointer.
+			 */
+			memcpy(dp_addr, dp_back_addr, max_non_overlap);
+			dp_addr += max_non_overlap;
+			dp_back_addr += max_non_overlap;
+			length -= max_non_overlap;
+			while (length--)
+				*dp_addr++ = *dp_back_addr++;
+		}
+
+		/* Advance source position and continue with the next token. */
+		cb += 2;
+	}
+
+	/* No tokens left in the current tag. Continue with the next tag. */
+	goto do_next_tag;
+
+return_overflow:
+	ntfs_error(NULL, "Failed. Returning -EOVERFLOW.");
+	goto return_error;
+}
+
+/**
+ * ntfs_read_compressed_block - read a compressed block into the page cache
+ * @folio:	locked folio in the compression block(s) we need to read
+ *
+ * When we are called the page has already been verified to be locked and the
+ * attribute is known to be non-resident, not encrypted, but compressed.
+ *
+ * 1. Determine which compression block(s) @page is in.
+ * 2. Get hold of all pages corresponding to this/these compression block(s).
+ * 3. Read the (first) compression block.
+ * 4. Decompress it into the corresponding pages.
+ * 5. Throw the compressed data away and proceed to 3. for the next compression
+ *    block or return success if no more compression blocks left.
+ *
+ * Warning: We have to be careful what we do about existing pages. They might
+ * have been written to so that we would lose data if we were to just overwrite
+ * them with the out-of-date uncompressed data.
+ */
+int ntfs_read_compressed_block(struct folio *folio)
+{
+	struct page *page = &folio->page;
+	loff_t i_size;
+	s64 initialized_size;
+	struct address_space *mapping = page->mapping;
+	struct ntfs_inode *ni = NTFS_I(mapping->host);
+	struct ntfs_volume *vol = ni->vol;
+	struct super_block *sb = vol->sb;
+	struct runlist_element *rl;
+	unsigned long flags;
+	u8 *cb, *cb_pos, *cb_end;
+	unsigned long offset, index = page->__folio_index;
+	u32 cb_size = ni->itype.compressed.block_size;
+	u64 cb_size_mask = cb_size - 1UL;
+	s64 vcn;
+	s64 lcn;
+	/* The first wanted vcn (minimum alignment is PAGE_SIZE). */
+	s64 start_vcn = (((s64)index << PAGE_SHIFT) & ~cb_size_mask) >>
+			vol->cluster_size_bits;
+	/*
+	 * The first vcn after the last wanted vcn (minimum alignment is again
+	 * PAGE_SIZE.
+	 */
+	s64 end_vcn = ((((s64)(index + 1UL) << PAGE_SHIFT) + cb_size - 1)
+			& ~cb_size_mask) >> vol->cluster_size_bits;
+	/* Number of compression blocks (cbs) in the wanted vcn range. */
+	unsigned int nr_cbs = (end_vcn - start_vcn) << vol->cluster_size_bits
+			>> ni->itype.compressed.block_size_bits;
+	/*
+	 * Number of pages required to store the uncompressed data from all
+	 * compression blocks (cbs) overlapping @page. Due to alignment
+	 * guarantees of start_vcn and end_vcn, no need to round up here.
+	 */
+	unsigned int nr_pages = (end_vcn - start_vcn) <<
+			vol->cluster_size_bits >> PAGE_SHIFT;
+	unsigned int xpage, max_page, cur_page, cur_ofs, i, page_ofs, page_index;
+	unsigned int cb_clusters, cb_max_ofs;
+	int cb_max_page, err = 0;
+	struct page **pages;
+	int *completed_pages;
+	unsigned char xpage_done = 0;
+	struct page *lpage;
+
+	ntfs_debug("Entering, page->index = 0x%lx, cb_size = 0x%x, nr_pages = %i.",
+			index, cb_size, nr_pages);
+	/*
+	 * Bad things happen if we get here for anything that is not an
+	 * unnamed $DATA attribute.
+	 */
+	BUG_ON(ni->type != AT_DATA);
+	BUG_ON(ni->name_len);
+
+	pages = kmalloc_array(nr_pages, sizeof(struct page *), GFP_NOFS);
+	completed_pages = kmalloc_array(nr_pages + 1, sizeof(int), GFP_NOFS);
+
+	if (unlikely(!pages || !completed_pages)) {
+		kfree(pages);
+		kfree(completed_pages);
+		unlock_page(page);
+		ntfs_error(vol->sb, "Failed to allocate internal buffers.");
+		return -ENOMEM;
+	}
+
+	/*
+	 * We have already been given one page, this is the one we must do.
+	 * Once again, the alignment guarantees keep it simple.
+	 */
+	offset = start_vcn << vol->cluster_size_bits >> PAGE_SHIFT;
+	xpage = index - offset;
+	pages[xpage] = page;
+	/*
+	 * The remaining pages need to be allocated and inserted into the page
+	 * cache, alignment guarantees keep all the below much simpler. (-8
+	 */
+	read_lock_irqsave(&ni->size_lock, flags);
+	i_size = i_size_read(VFS_I(ni));
+	initialized_size = ni->initialized_size;
+	read_unlock_irqrestore(&ni->size_lock, flags);
+	max_page = ((i_size + PAGE_SIZE - 1) >> PAGE_SHIFT) -
+			offset;
+	/* Is the page fully outside i_size? (truncate in progress) */
+	if (xpage >= max_page) {
+		kfree(pages);
+		kfree(completed_pages);
+		zero_user_segments(page, 0, PAGE_SIZE, 0, 0);
+		ntfs_debug("Compressed read outside i_size - truncated?");
+		SetPageUptodate(page);
+		unlock_page(page);
+		return 0;
+	}
+	if (nr_pages < max_page)
+		max_page = nr_pages;
+
+	for (i = 0; i < max_page; i++, offset++) {
+		if (i != xpage)
+			pages[i] = grab_cache_page_nowait(mapping, offset);
+		page = pages[i];
+		if (page) {
+			/*
+			 * We only (re)read the page if it isn't already read
+			 * in and/or dirty or we would be losing data or at
+			 * least wasting our time.
+			 */
+			if (!PageDirty(page) && (!PageUptodate(page))) {
+				kmap_local_page(page);
+				continue;
+			}
+			unlock_page(page);
+			put_page(page);
+			pages[i] = NULL;
+		}
+	}
+
+	/*
+	 * We have the runlist, and all the destination pages we need to fill.
+	 * Now read the first compression block.
+	 */
+	cur_page = 0;
+	cur_ofs = 0;
+	cb_clusters = ni->itype.compressed.block_clusters;
+do_next_cb:
+	nr_cbs--;
+
+	mutex_lock(&ntfs_cb_lock);
+	if (!ntfs_compression_buffer)
+		if (allocate_compression_buffers()) {
+			mutex_unlock(&ntfs_cb_lock);
+			goto err_out;
+		}
+
+
+	cb = ntfs_compression_buffer;
+
+	BUG_ON(!cb);
+
+	cb_pos = cb;
+	cb_end = cb + cb_size;
+
+	rl = NULL;
+	for (vcn = start_vcn, start_vcn += cb_clusters; vcn < start_vcn;
+			vcn++) {
+		bool is_retry = false;
+
+		if (!rl) {
+lock_retry_remap:
+			down_read(&ni->runlist.lock);
+			rl = ni->runlist.rl;
+		}
+		if (likely(rl != NULL)) {
+			/* Seek to element containing target vcn. */
+			while (rl->length && rl[1].vcn <= vcn)
+				rl++;
+			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
+		} else
+			lcn = LCN_RL_NOT_MAPPED;
+		ntfs_debug("Reading vcn = 0x%llx, lcn = 0x%llx.",
+				(unsigned long long)vcn,
+				(unsigned long long)lcn);
+		if (lcn < 0) {
+			/*
+			 * When we reach the first sparse cluster we have
+			 * finished with the cb.
+			 */
+			if (lcn == LCN_HOLE)
+				break;
+			if (is_retry || lcn != LCN_RL_NOT_MAPPED) {
+				mutex_unlock(&ntfs_cb_lock);
+				goto rl_err;
+			}
+			is_retry = true;
+			/*
+			 * Attempt to map runlist, dropping lock for the
+			 * duration.
+			 */
+			up_read(&ni->runlist.lock);
+			if (!ntfs_map_runlist(ni, vcn))
+				goto lock_retry_remap;
+			mutex_unlock(&ntfs_cb_lock);
+			goto map_rl_err;
+		}
+
+		page_ofs = (lcn << vol->cluster_size_bits) & ~PAGE_MASK;
+		page_index = (lcn << vol->cluster_size_bits) >> PAGE_SHIFT;
+
+retry:
+		lpage = read_mapping_page(sb->s_bdev->bd_mapping,
+					  page_index, NULL);
+		if (PTR_ERR(page) == -EINTR)
+			goto retry;
+		else if (IS_ERR(lpage)) {
+			err = PTR_ERR(lpage);
+			mutex_unlock(&ntfs_cb_lock);
+			goto read_err;
+		}
+
+		lock_page(lpage);
+		memcpy(cb_pos, page_address(lpage) + page_ofs,
+		       vol->cluster_size);
+		unlock_page(lpage);
+		put_page(lpage);
+		cb_pos += vol->cluster_size;
+	}
+
+	/* Release the lock if we took it. */
+	if (rl)
+		up_read(&ni->runlist.lock);
+
+	/* Just a precaution. */
+	if (cb_pos + 2 <= cb + cb_size)
+		*(u16 *)cb_pos = 0;
+
+	/* Reset cb_pos back to the beginning. */
+	cb_pos = cb;
+
+	/* We now have both source (if present) and destination. */
+	ntfs_debug("Successfully read the compression block.");
+
+	/* The last page and maximum offset within it for the current cb. */
+	cb_max_page = (cur_page << PAGE_SHIFT) + cur_ofs + cb_size;
+	cb_max_ofs = cb_max_page & ~PAGE_MASK;
+	cb_max_page >>= PAGE_SHIFT;
+
+	/* Catch end of file inside a compression block. */
+	if (cb_max_page > max_page)
+		cb_max_page = max_page;
+
+	if (vcn == start_vcn - cb_clusters) {
+		/* Sparse cb, zero out page range overlapping the cb. */
+		ntfs_debug("Found sparse compression block.");
+		/* We can sleep from now on, so we drop lock. */
+		mutex_unlock(&ntfs_cb_lock);
+		if (cb_max_ofs)
+			cb_max_page--;
+		for (; cur_page < cb_max_page; cur_page++) {
+			page = pages[cur_page];
+			if (page) {
+				if (likely(!cur_ofs))
+					clear_page(page_address(page));
+				else
+					memset(page_address(page) + cur_ofs, 0,
+							PAGE_SIZE -
+							cur_ofs);
+				flush_dcache_page(page);
+				kunmap_local(page_address(page));
+				SetPageUptodate(page);
+				unlock_page(page);
+				if (cur_page == xpage)
+					xpage_done = 1;
+				else
+					put_page(page);
+				pages[cur_page] = NULL;
+			}
+			cb_pos += PAGE_SIZE - cur_ofs;
+			cur_ofs = 0;
+			if (cb_pos >= cb_end)
+				break;
+		}
+		/* If we have a partial final page, deal with it now. */
+		if (cb_max_ofs && cb_pos < cb_end) {
+			page = pages[cur_page];
+			if (page)
+				memset(page_address(page) + cur_ofs, 0,
+						cb_max_ofs - cur_ofs);
+			/*
+			 * No need to update cb_pos at this stage:
+			 *	cb_pos += cb_max_ofs - cur_ofs;
+			 */
+			cur_ofs = cb_max_ofs;
+		}
+	} else if (vcn == start_vcn) {
+		/* We can't sleep so we need two stages. */
+		unsigned int cur2_page = cur_page;
+		unsigned int cur_ofs2 = cur_ofs;
+		u8 *cb_pos2 = cb_pos;
+
+		ntfs_debug("Found uncompressed compression block.");
+		/* Uncompressed cb, copy it to the destination pages. */
+		if (cb_max_ofs)
+			cb_max_page--;
+		/* First stage: copy data into destination pages. */
+		for (; cur_page < cb_max_page; cur_page++) {
+			page = pages[cur_page];
+			if (page)
+				memcpy(page_address(page) + cur_ofs, cb_pos,
+						PAGE_SIZE - cur_ofs);
+			cb_pos += PAGE_SIZE - cur_ofs;
+			cur_ofs = 0;
+			if (cb_pos >= cb_end)
+				break;
+		}
+		/* If we have a partial final page, deal with it now. */
+		if (cb_max_ofs && cb_pos < cb_end) {
+			page = pages[cur_page];
+			if (page)
+				memcpy(page_address(page) + cur_ofs, cb_pos,
+						cb_max_ofs - cur_ofs);
+			cb_pos += cb_max_ofs - cur_ofs;
+			cur_ofs = cb_max_ofs;
+		}
+		/* We can sleep from now on, so drop lock. */
+		mutex_unlock(&ntfs_cb_lock);
+		/* Second stage: finalize pages. */
+		for (; cur2_page < cb_max_page; cur2_page++) {
+			page = pages[cur2_page];
+			if (page) {
+				/*
+				 * If we are outside the initialized size, zero
+				 * the out of bounds page range.
+				 */
+				handle_bounds_compressed_page(page, i_size,
+						initialized_size);
+				flush_dcache_page(page);
+				kunmap_local(page_address(page));
+				SetPageUptodate(page);
+				unlock_page(page);
+				if (cur2_page == xpage)
+					xpage_done = 1;
+				else
+					put_page(page);
+				pages[cur2_page] = NULL;
+			}
+			cb_pos2 += PAGE_SIZE - cur_ofs2;
+			cur_ofs2 = 0;
+			if (cb_pos2 >= cb_end)
+				break;
+		}
+	} else {
+		/* Compressed cb, decompress it into the destination page(s). */
+		unsigned int prev_cur_page = cur_page;
+
+		ntfs_debug("Found compressed compression block.");
+		err = ntfs_decompress(pages, completed_pages, &cur_page,
+				&cur_ofs, cb_max_page, cb_max_ofs, xpage,
+				&xpage_done, cb_pos, cb_size - (cb_pos - cb),
+				i_size, initialized_size);
+		/*
+		 * We can sleep from now on, lock already dropped by
+		 * ntfs_decompress().
+		 */
+		if (err) {
+			ntfs_error(vol->sb,
+				"ntfs_decompress() failed in inode 0x%lx with error code %i. Skipping this compression block.",
+				ni->mft_no, -err);
+			/* Release the unfinished pages. */
+			for (; prev_cur_page < cur_page; prev_cur_page++) {
+				page = pages[prev_cur_page];
+				if (page) {
+					flush_dcache_page(page);
+					kunmap_local(page_address(page));
+					unlock_page(page);
+					if (prev_cur_page != xpage)
+						put_page(page);
+					pages[prev_cur_page] = NULL;
+				}
+			}
+		}
+	}
+
+	/* Do we have more work to do? */
+	if (nr_cbs)
+		goto do_next_cb;
+
+	/* Clean up if we have any pages left. Should never happen. */
+	for (cur_page = 0; cur_page < max_page; cur_page++) {
+		page = pages[cur_page];
+		if (page) {
+			ntfs_error(vol->sb,
+				"Still have pages left! Terminating them with extreme prejudice.  Inode 0x%lx, page index 0x%lx.",
+				ni->mft_no, page->__folio_index);
+			flush_dcache_page(page);
+			kunmap_local(page_address(page));
+			unlock_page(page);
+			if (cur_page != xpage)
+				put_page(page);
+			pages[cur_page] = NULL;
+		}
+	}
+
+	/* We no longer need the list of pages. */
+	kfree(pages);
+	kfree(completed_pages);
+
+	/* If we have completed the requested page, we return success. */
+	if (likely(xpage_done))
+		return 0;
+
+	ntfs_debug("Failed. Returning error code %s.", err == -EOVERFLOW ?
+			"EOVERFLOW" : (!err ? "EIO" : "unknown error"));
+	return err < 0 ? err : -EIO;
+
+map_rl_err:
+	ntfs_error(vol->sb, "ntfs_map_runlist() failed. Cannot read compression block.");
+	goto err_out;
+
+rl_err:
+	up_read(&ni->runlist.lock);
+	ntfs_error(vol->sb, "ntfs_rl_vcn_to_lcn() failed. Cannot read compression block.");
+	goto err_out;
+
+read_err:
+	up_read(&ni->runlist.lock);
+	ntfs_error(vol->sb, "IO error while reading compressed data.");
+
+err_out:
+	for (i = cur_page; i < max_page; i++) {
+		page = pages[i];
+		if (page) {
+			flush_dcache_page(page);
+			kunmap_local(page_address(page));
+			unlock_page(page);
+			if (i != xpage)
+				put_page(page);
+		}
+	}
+	kfree(pages);
+	kfree(completed_pages);
+	return -EIO;
+}
+
+/*
+ * Match length at or above which ntfs_best_match() will stop searching for
+ * longer matches.
+ */
+#define NICE_MATCH_LEN		18
+
+/*
+ * Maximum number of potential matches that ntfs_best_match() will consider at
+ * each position.
+ */
+#define MAX_SEARCH_DEPTH	24
+
+/* log base 2 of the number of entries in the hash table for match-finding.  */
+#define HASH_SHIFT		14
+
+/* Constant for the multiplicative hash function.  */
+#define HASH_MULTIPLIER		0x1E35A7BD
+
+struct COMPRESS_CONTEXT {
+	const unsigned char *inbuf;
+	int bufsize;
+	int size;
+	int rel;
+	int mxsz;
+	s16 head[1 << HASH_SHIFT];
+	s16 prev[NTFS_SB_SIZE];
+};
+
+/*
+ * Hash the next 3-byte sequence in the input buffer
+ */
+static inline unsigned int ntfs_hash(const u8 *p)
+{
+	u32 str;
+	u32 hash;
+
+	/*
+	 * Unaligned access allowed, and little endian CPU.
+	 * Callers ensure that at least 4 (not 3) bytes are remaining.
+	 */
+	str = *(const u32 *)p & 0xFFFFFF;
+	hash = str * HASH_MULTIPLIER;
+
+	/* High bits are more random than the low bits.  */
+	return hash >> (32 - HASH_SHIFT);
+}
+
+/*
+ * Search for the longest sequence matching current position
+ *
+ * A hash table, each entry of which points to a chain of sequence
+ * positions sharing the corresponding hash code, is maintained to speed up
+ * searching for matches.  To maintain the hash table, either
+ * ntfs_best_match() or ntfs_skip_position() has to be called for each
+ * consecutive position.
+ *
+ * This function is heavily used; it has to be optimized carefully.
+ *
+ * This function sets pctx->size and pctx->rel to the length and offset,
+ * respectively, of the longest match found.
+ *
+ * The minimum match length is assumed to be 3, and the maximum match
+ * length is assumed to be pctx->mxsz.  If this function produces
+ * pctx->size < 3, then no match was found.
+ *
+ * Note: for the following reasons, this function is not guaranteed to find
+ * *the* longest match up to pctx->mxsz:
+ *
+ *      (1) If this function finds a match of NICE_MATCH_LEN bytes or greater,
+ *          it ends early because a match this long is good enough and it's not
+ *          worth spending more time searching.
+ *
+ *      (2) If this function considers MAX_SEARCH_DEPTH matches with a single
+ *          position, it ends early and returns the longest match found so far.
+ *          This saves a lot of time on degenerate inputs.
+ */
+static void ntfs_best_match(struct COMPRESS_CONTEXT *pctx, const int i,
+		int best_len)
+{
+	const u8 * const inbuf = pctx->inbuf;
+	const u8 * const strptr = &inbuf[i]; /* String we're matching against */
+	s16 * const prev = pctx->prev;
+	const int max_len = min(pctx->bufsize - i, pctx->mxsz);
+	const int nice_len = min(NICE_MATCH_LEN, max_len);
+	int depth_remaining = MAX_SEARCH_DEPTH;
+	const u8 *best_matchptr = strptr;
+	unsigned int hash;
+	s16 cur_match;
+	const u8 *matchptr;
+	int len;
+
+	if (max_len < 4)
+		goto out;
+
+	/* Insert the current sequence into the appropriate hash chain. */
+	hash = ntfs_hash(strptr);
+	cur_match = pctx->head[hash];
+	prev[i] = cur_match;
+	pctx->head[hash] = i;
+
+	if (best_len >= max_len) {
+		/*
+		 * Lazy match is being attempted, but there aren't enough length
+		 * bits remaining to code a longer match.
+		 */
+		goto out;
+	}
+
+	/* Search the appropriate hash chain for matches. */
+
+	for (; cur_match >= 0 && depth_remaining--; cur_match = prev[cur_match]) {
+		matchptr = &inbuf[cur_match];
+
+		/*
+		 * Considering the potential match at 'matchptr':  is it longer
+		 * than 'best_len'?
+		 *
+		 * The bytes at index 'best_len' are the most likely to differ,
+		 * so check them first.
+		 *
+		 * The bytes at indices 'best_len - 1' and '0' are less
+		 * important to check separately.  But doing so still gives a
+		 * slight performance improvement, at least on x86_64, probably
+		 * because they create separate branches for the CPU to predict
+		 * independently of the branches in the main comparison loops.
+		 */
+		if (matchptr[best_len] != strptr[best_len] ||
+				matchptr[best_len - 1] != strptr[best_len - 1] ||
+				matchptr[0] != strptr[0])
+			goto next_match;
+
+		for (len = 1; len < best_len - 1; len++)
+			if (matchptr[len] != strptr[len])
+				goto next_match;
+
+		/*
+		 * The match is the longest found so far ---
+		 * at least 'best_len' + 1 bytes.  Continue extending it.
+		 */
+
+		best_matchptr = matchptr;
+
+		do {
+			if (++best_len >= nice_len) {
+				/*
+				 * 'nice_len' reached; don't waste time
+				 * searching for longer matches.  Extend the
+				 * match as far as possible and terminate the
+				 * search.
+				 */
+				while (best_len < max_len &&
+				       (best_matchptr[best_len] ==
+					strptr[best_len]))
+					best_len++;
+				goto out;
+			}
+		} while (best_matchptr[best_len] == strptr[best_len]);
+
+		/* Found a longer match, but 'nice_len' not yet reached.  */
+
+next_match:
+		/* Continue to next match in the chain.  */
+		;
+	}
+
+	/*
+	 * Reached end of chain, or ended early due to reaching the maximum
+	 * search depth.
+	 */
+
+out:
+	/* Return the longest match we were able to find.  */
+	pctx->size = best_len;
+	pctx->rel = best_matchptr - strptr; /* given as a negative number! */
+}
+
+/*
+ * Advance the match-finder, but don't search for matches.
+ */
+static void ntfs_skip_position(struct COMPRESS_CONTEXT *pctx, const int i)
+{
+	unsigned int hash;
+
+	if (pctx->bufsize - i < 4)
+		return;
+
+	/* Insert the current sequence into the appropriate hash chain.  */
+	hash = ntfs_hash(pctx->inbuf + i);
+	pctx->prev[i] = pctx->head[hash];
+	pctx->head[hash] = i;
+}
+
+/*
+ * Compress a 4096-byte block
+ *
+ * Returns a header of two bytes followed by the compressed data.
+ * If compression is not effective, the header and an uncompressed
+ * block is returned.
+ *
+ * Note : two bytes may be output before output buffer overflow
+ * is detected, so a 4100-bytes output buffer must be reserved.
+ *
+ * Returns the size of the compressed block, including the
+ * header (minimal size is 2, maximum size is 4098)
+ * 0 if an error has been met.
+ */
+static unsigned int ntfs_compress_block(const char *inbuf, const int bufsize,
+		char *outbuf)
+{
+	struct COMPRESS_CONTEXT *pctx;
+	int i; /* current position */
+	int j; /* end of best match from current position */
+	int k; /* end of best match from next position */
+	int offs; /* offset to best match */
+	int bp; /* bits to store offset */
+	int bp_cur; /* saved bits to store offset at current position */
+	int mxoff; /* max match offset : 1 << bp */
+	unsigned int xout;
+	unsigned int q; /* aggregated offset and size */
+	int have_match; /* do we have a match at the current position? */
+	char *ptag; /* location reserved for a tag */
+	int tag;    /* current value of tag */
+	int ntag;   /* count of bits still undefined in tag */
+
+	pctx = ntfs_malloc_nofs(sizeof(struct COMPRESS_CONTEXT));
+	if (!pctx)
+		return -ENOMEM;
+
+	/*
+	 * All hash chains start as empty.  The special value '-1' indicates the
+	 * end of each hash chain.
+	 */
+	memset(pctx->head, 0xFF, sizeof(pctx->head));
+
+	pctx->inbuf = (const unsigned char *)inbuf;
+	pctx->bufsize = bufsize;
+	xout = 2;
+	i = 0;
+	bp = 4;
+	mxoff = 1 << bp;
+	pctx->mxsz = (1 << (16 - bp)) + 2;
+	have_match = 0;
+	tag = 0;
+	ntag = 8;
+	ptag = &outbuf[xout++];
+
+	while ((i < bufsize) && (xout < (NTFS_SB_SIZE + 2))) {
+
+		/*
+		 * This implementation uses "lazy" parsing: it always chooses
+		 * the longest match, unless the match at the next position is
+		 * longer.  This is the same strategy used by the high
+		 * compression modes of zlib.
+		 */
+		if (!have_match) {
+			/*
+			 * Find the longest match at the current position.  But
+			 * first adjust the maximum match length if needed.
+			 * (This loop might need to run more than one time in
+			 * the case that we just output a long match.)
+			 */
+			while (mxoff < i) {
+				bp++;
+				mxoff <<= 1;
+				pctx->mxsz = (pctx->mxsz + 2) >> 1;
+			}
+			ntfs_best_match(pctx, i, 2);
+		}
+
+		if (pctx->size >= 3) {
+			/* Found a match at the current position.  */
+			j = i + pctx->size;
+			bp_cur = bp;
+			offs = pctx->rel;
+
+			if (pctx->size >= NICE_MATCH_LEN) {
+				/* Choose long matches immediately.  */
+				q = (~offs << (16 - bp_cur)) + (j - i - 3);
+				outbuf[xout++] = q & 255;
+				outbuf[xout++] = (q >> 8) & 255;
+				tag |= (1 << (8 - ntag));
+
+				if (j == bufsize) {
+					/*
+					 * Shortcut if the match extends to the
+					 * end of the buffer.
+					 */
+					i = j;
+					--ntag;
+					break;
+				}
+				i += 1;
+				do {
+					ntfs_skip_position(pctx, i);
+				} while (++i != j);
+				have_match = 0;
+			} else {
+				/*
+				 * Check for a longer match at the next
+				 * position.
+				 */
+
+				/*
+				 * Doesn't need to be while() since we just
+				 * adjusted the maximum match length at the
+				 * previous position.
+				 */
+				if (mxoff < i + 1) {
+					bp++;
+					mxoff <<= 1;
+					pctx->mxsz = (pctx->mxsz + 2) >> 1;
+				}
+				ntfs_best_match(pctx, i + 1, pctx->size);
+				k = i + 1 + pctx->size;
+
+				if (k > (j + 1)) {
+					/*
+					 * Next match is longer.
+					 * Output a literal.
+					 */
+					outbuf[xout++] = inbuf[i++];
+					have_match = 1;
+				} else {
+					/*
+					 * Next match isn't longer.
+					 * Output the current match.
+					 */
+					q = (~offs << (16 - bp_cur)) +
+						(j - i - 3);
+					outbuf[xout++] = q & 255;
+					outbuf[xout++] = (q >> 8) & 255;
+					tag |= (1 << (8 - ntag));
+
+					/*
+					 * The minimum match length is 3, and
+					 * we've run two bytes through the
+					 * matchfinder already.  So the minimum
+					 * number of positions we need to skip
+					 * is 1.
+					 */
+					i += 2;
+					do {
+						ntfs_skip_position(pctx, i);
+					} while (++i != j);
+					have_match = 0;
+				}
+			}
+		} else {
+			/* No match at current position.  Output a literal. */
+			outbuf[xout++] = inbuf[i++];
+			have_match = 0;
+		}
+
+		/* Store the tag if fully used. */
+		if (!--ntag) {
+			*ptag = tag;
+			ntag = 8;
+			ptag = &outbuf[xout++];
+			tag = 0;
+		}
+	}
+
+	/* Store the last tag if partially used. */
+	if (ntag == 8)
+		xout--;
+	else
+		*ptag = tag;
+
+	/* Determine whether to store the data compressed or uncompressed. */
+	if ((i >= bufsize) && (xout < (NTFS_SB_SIZE + 2))) {
+		/* Compressed. */
+		outbuf[0] = (xout - 3) & 255;
+		outbuf[1] = 0xb0 + (((xout - 3) >> 8) & 15);
+	} else {
+		/* Uncompressed.  */
+		memcpy(&outbuf[2], inbuf, bufsize);
+		if (bufsize < NTFS_SB_SIZE)
+			memset(&outbuf[bufsize + 2], 0, NTFS_SB_SIZE - bufsize);
+		outbuf[0] = 0xff;
+		outbuf[1] = 0x3f;
+		xout = NTFS_SB_SIZE + 2;
+	}
+
+	/*
+	 * Free the compression context and return the total number of bytes
+	 * written to 'outbuf'.
+	 */
+	ntfs_free(pctx);
+	return xout;
+}
+
+static int ntfs_write_cb(struct ntfs_inode *ni, loff_t pos, struct page **pages,
+		int pages_per_cb)
+{
+	struct ntfs_volume *vol = ni->vol;
+	char *outbuf = NULL, *pbuf, *inbuf;
+	u32 compsz, p, insz = pages_per_cb << PAGE_SHIFT;
+	s32 rounded, bio_size;
+	unsigned int sz, bsz;
+	bool fail = false, allzeroes;
+	/* a single compressed zero */
+	static char onezero[] = {0x01, 0xb0, 0x00, 0x00};
+	/* a couple of compressed zeroes */
+	static char twozeroes[] = {0x02, 0xb0, 0x00, 0x00, 0x00};
+	/* more compressed zeroes, to be followed by some count */
+	static char morezeroes[] = {0x03, 0xb0, 0x02, 0x00};
+	struct page **pages_disk = NULL, *pg;
+	s64 bio_lcn;
+	struct runlist_element *rlc, *rl;
+	int i, err;
+	int pages_count = (round_up(ni->itype.compressed.block_size + 2 *
+		(ni->itype.compressed.block_size / NTFS_SB_SIZE) + 2, PAGE_SIZE)) / PAGE_SIZE;
+	size_t new_rl_count;
+	struct bio *bio = NULL;
+	loff_t new_length;
+	s64 new_vcn;
+
+	inbuf = vmap(pages, pages_per_cb, VM_MAP, PAGE_KERNEL_RO);
+	if (!inbuf)
+		return -ENOMEM;
+
+	/* may need 2 extra bytes per block and 2 more bytes */
+	pages_disk = kcalloc(pages_count, sizeof(struct page *), GFP_NOFS);
+	if (!pages_disk) {
+		vunmap(inbuf);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < pages_count; i++) {
+		pg = alloc_page(GFP_KERNEL);
+		if (!pg) {
+			err = -ENOMEM;
+			goto out;
+		}
+		pages_disk[i] = pg;
+		lock_page(pg);
+		kmap_local_page(pg);
+	}
+
+	outbuf = vmap(pages_disk, pages_count, VM_MAP, PAGE_KERNEL);
+	if (!outbuf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	compsz = 0;
+	allzeroes = true;
+	for (p = 0; (p < insz) && !fail; p += NTFS_SB_SIZE) {
+		if ((p + NTFS_SB_SIZE) < insz)
+			bsz = NTFS_SB_SIZE;
+		else
+			bsz = insz - p;
+		pbuf = &outbuf[compsz];
+		sz = ntfs_compress_block(&inbuf[p], bsz, pbuf);
+		/* fail if all the clusters (or more) are needed */
+		if (!sz || ((compsz + sz + vol->cluster_size + 2) >
+			    ni->itype.compressed.block_size))
+			fail = true;
+		else {
+			if (allzeroes) {
+				/* check whether this is all zeroes */
+				switch (sz) {
+				case 4:
+					allzeroes = !memcmp(pbuf, onezero, 4);
+					break;
+				case 5:
+					allzeroes = !memcmp(pbuf, twozeroes, 5);
+					break;
+				case 6:
+					allzeroes = !memcmp(pbuf, morezeroes, 4);
+					break;
+				default:
+					allzeroes = false;
+					break;
+				}
+			}
+			compsz += sz;
+		}
+	}
+
+	if (!fail && !allzeroes) {
+		outbuf[compsz++] = 0;
+		outbuf[compsz++] = 0;
+		rounded = ((compsz - 1) | (vol->cluster_size - 1)) + 1;
+		memset(&outbuf[compsz], 0, rounded - compsz);
+		bio_size = rounded;
+		pages = pages_disk;
+	} else if (allzeroes) {
+		err = 0;
+		goto out;
+	} else {
+		bio_size = insz;
+	}
+
+	new_vcn = (pos & ~(ni->itype.compressed.block_size - 1)) >> vol->cluster_size_bits;
+	new_length = round_up(bio_size, vol->cluster_size) >> vol->cluster_size_bits;
+
+	err = ntfs_non_resident_attr_punch_hole(ni, new_vcn, ni->itype.compressed.block_clusters);
+	if (err < 0)
+		goto out;
+
+	rlc = ntfs_cluster_alloc(vol, new_vcn, new_length, -1, DATA_ZONE,
+			false, true, true);
+	if (IS_ERR(rlc)) {
+		err = PTR_ERR(rlc);
+		goto out;
+	}
+
+	bio_lcn = rlc->lcn;
+	down_write(&ni->runlist.lock);
+	rl = ntfs_runlists_merge(&ni->runlist, rlc, 0, &new_rl_count);
+	if (IS_ERR(rl)) {
+		up_write(&ni->runlist.lock);
+		ntfs_error(vol->sb, "Failed to merge runlists");
+		err = PTR_ERR(rl);
+		if (ntfs_cluster_free_from_rl(vol, rlc))
+			ntfs_error(vol->sb, "Failed to free hot clusters.");
+		ntfs_free(rlc);
+		goto out;
+	}
+
+	ni->runlist.count = new_rl_count;
+	ni->runlist.rl = rl;
+
+	err = ntfs_attr_update_mapping_pairs(ni, 0);
+	up_write(&ni->runlist.lock);
+	if (err) {
+		err = -EIO;
+		goto out;
+	}
+
+	i = 0;
+	while (bio_size > 0) {
+		int page_size;
+
+		if (bio_size >= PAGE_SIZE) {
+			page_size = PAGE_SIZE;
+			bio_size -= PAGE_SIZE;
+		} else {
+			page_size = bio_size;
+			bio_size = 0;
+		}
+
+setup_bio:
+		if (!bio) {
+			bio = ntfs_setup_bio(vol, REQ_OP_WRITE, bio_lcn + i, 0);
+			if (!bio) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
+
+		if (!bio_add_page(bio, pages[i], page_size, 0)) {
+			err = submit_bio_wait(bio);
+			bio_put(bio);
+			if (err)
+				goto out;
+			bio = NULL;
+			goto setup_bio;
+		}
+		i++;
+	}
+
+	err = submit_bio_wait(bio);
+	bio_put(bio);
+out:
+	vunmap(outbuf);
+	for (i = 0; i < pages_count; i++) {
+		pg = pages_disk[i];
+		if (pg) {
+			kunmap_local(page_address(pg));
+			unlock_page(pg);
+			put_page(pg);
+		}
+	}
+	kfree(pages_disk);
+	vunmap(inbuf);
+	NInoSetFileNameDirty(ni);
+	mark_mft_record_dirty(ni);
+
+	return err;
+}
+
+int ntfs_compress_write(struct ntfs_inode *ni, loff_t pos, size_t count,
+		struct iov_iter *from)
+{
+	struct folio *folio;
+	struct page **pages = NULL, *page;
+	int pages_per_cb = ni->itype.compressed.block_size >> PAGE_SHIFT;
+	int cb_size = ni->itype.compressed.block_size, cb_off, err = 0;
+	int i, ip;
+	size_t written = 0;
+	struct address_space *mapping = VFS_I(ni)->i_mapping;
+
+	pages = kmalloc_array(pages_per_cb, sizeof(struct page *), GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;
+
+	while (count) {
+		pgoff_t index;
+		size_t copied, bytes;
+		int off;
+
+		off = pos & (cb_size - 1);
+		bytes = cb_size - off;
+		if (bytes > count)
+			bytes = count;
+
+		cb_off = pos & ~(cb_size - 1);
+		index = cb_off >> PAGE_SHIFT;
+
+		if (unlikely(fault_in_iov_iter_readable(from, bytes))) {
+			err = -EFAULT;
+			goto out;
+		}
+
+		for (i = 0; i < pages_per_cb; i++) {
+			folio = ntfs_read_mapping_folio(mapping, index + i);
+			if (IS_ERR(folio)) {
+				for (ip = 0; ip < i; ip++) {
+					folio_unlock(page_folio(pages[ip]));
+					folio_put(page_folio(pages[ip]));
+				}
+				err = PTR_ERR(folio);
+				goto out;
+			}
+
+			folio_lock(folio);
+			pages[i] = folio_page(folio, 0);
+		}
+
+		WARN_ON(!bytes);
+		copied = 0;
+		ip = off >> PAGE_SHIFT;
+		off = offset_in_page(pos);
+
+		for (;;) {
+			size_t cp, tail = PAGE_SIZE - off;
+
+			page = pages[ip];
+			cp = copy_folio_from_iter_atomic(page_folio(page), off,
+					min(tail, bytes), from);
+			flush_dcache_page(page);
+
+			copied += cp;
+			bytes -= cp;
+			if (!bytes || !cp)
+				break;
+
+			if (cp < tail) {
+				off += cp;
+			} else {
+				ip++;
+				off = 0;
+			}
+		}
+
+		err = ntfs_write_cb(ni, pos, pages, pages_per_cb);
+
+		for (i = 0; i < pages_per_cb; i++) {
+			folio = page_folio(pages[i]);
+			if (i < ip) {
+				folio_clear_dirty(folio);
+				folio_mark_uptodate(folio);
+			}
+			folio_unlock(folio);
+			folio_put(folio);
+		}
+
+		if (err)
+			goto out;
+
+		cond_resched();
+		pos += copied;
+		written += copied;
+		count = iov_iter_count(from);
+	}
+
+out:
+	kfree(pages);
+	if (err < 0)
+		written = err;
+
+	return written;
+}
-- 
2.34.1


