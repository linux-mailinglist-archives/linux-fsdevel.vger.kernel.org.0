Return-Path: <linux-fsdevel+bounces-73242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F12D13554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DFFD30A7BFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E02BEFFB;
	Mon, 12 Jan 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKBEKRDl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r+6fbCj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F92BEC43
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229397; cv=none; b=pGSBw7WTD1wbn+AkpAtgyj2rArCrcVVcALcYVJeOv5VaPRqY8CCwsUqSpgODaNPaAdsf/ZhvXIXJ7eUHkNElYordcQ1qNVNJv9d8rRrxzwXBSYQhR6DAuSieRQaB+NuG91a/KmfZDtJoxuclyFwV73DlZmFIqBPWp5FKnjP5UBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229397; c=relaxed/simple;
	bh=4pIvem8pTEBLg0KjsB8Rdb+YjFU50+kOccXs+aqTA3g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBnbpRanu3M9JMdMjdmlTDgLtdFxHpVJpZ+JXSYSKiR/977WveuPPVQN8Wujshu92QYDLim4WJXqAQraHRxW9zaVbFqEPKsr2rEzN9ZXd/K9KC/2M/gkD2Qbg0mmoajsKwqZ/KCteYB4ucGUI1LIqzy1rrQnKbyoPskLPV16Jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKBEKRDl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r+6fbCj0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1J1NsEeqAiSWKeOnLnnShK9Aap7A5is4sYRY8AfigM=;
	b=hKBEKRDl15pHO9/qkx4F+C3lV+0Q3RpO4UUdArqZ9OAX46F2LagKS73eEbPRhiEGHRj45s
	KqI42mDCEXGqdI523q75gc3I+1UyoJsuFFCcN6Piu6aqjij+jJqzFsgk0vGJ/9efLa7ATq
	wLPJIpIBN0RCzjzZw5KcFVE/GZrYIvc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-dthVy7adM8ifRHWIXrESDQ-1; Mon, 12 Jan 2026 09:49:53 -0500
X-MC-Unique: dthVy7adM8ifRHWIXrESDQ-1
X-Mimecast-MFC-AGG-ID: dthVy7adM8ifRHWIXrESDQ_1768229392
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64d29b6e198so6792305a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229392; x=1768834192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1J1NsEeqAiSWKeOnLnnShK9Aap7A5is4sYRY8AfigM=;
        b=r+6fbCj01JX8AV84w6mmusfJsNdJl2Y7AQ8Gyc9nbN8O3VTv8k3ddb9HAP+2tSLnyL
         oAtCvU+KLLugDmYjMBi1Ox2Jbc9F+YXmSX+Hea1Wmvh918JgXMcFI4SlIbRBht5GNndW
         H7UnhWBAvf/qFYG7EsRKvfpeGjlhq+sMvfthDzLEbcfazRBE7Wnql3cKFBpxT+RTxZos
         krv2fCK/gE01ZRllqSm/BdL6NpAQ4Afx+DDZedM5xH6gQSEdmMsgk8RJK5N7bmueDlGV
         b974DNNkYBR7wzS8CrP0Fsa4n0P6OiEUod0JOkZpqTuqudGtzdb9GbH6+diwriGBiTL5
         gTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229392; x=1768834192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1J1NsEeqAiSWKeOnLnnShK9Aap7A5is4sYRY8AfigM=;
        b=NS3+vLTqR5TRvKJvK/qKnukvSMoWWRH6liCDOgMV2yjDv+XhpW4LnyVXSm9YvrDPeR
         XuynrnYBOUG7PPKRctjQucwmMc71ObhVrf2AG/pGO3clOsrxB9ZSiJNT6j163AEUu/Dr
         vZEljjGz1rQIimVkQVHwP5G7DFXTe97FWBwzx9YYJpFu4UBNlMSGC+BhEIJiZbnjIjD2
         M8r2FhLoPsn/LjInpl9HVTLPkbgQlLyMVaw6DPjaIImrTyf2edVCdKOgweIcaQOvrrOY
         T7e57jp2i6TncQ54hUF7iiCOuCXFFIpVjR26twMbFSvFUGv09M6ukrtPFJ0I4E42S4qn
         ILsA==
X-Forwarded-Encrypted: i=1; AJvYcCUiH0xLZRpCamNFArKPQxpnI9PMcJE/nC4u1aXCjyg5L2wzCmlwYoyIlOFNQUZ0u4o/wTfQXNzrrA3hO2pp@vger.kernel.org
X-Gm-Message-State: AOJu0YzgawOtMfoKO0kCm3ot72QTm0ggXlvTkCRKEpX1+GHiRQp8/Xnj
	INo8sB4cWUsZ8nMwmswqbJk/F/PsKhhnCz4jBvRr31qiUOL7KORpxW3/RMbJqsvlT91GK5ZVj3S
	dIx543dK2TpR09CjHPRubiYGAkn1nIlZrvE0dRu2gx6A4Thom3fkEbEkbwpBvtcnBtQ==
X-Gm-Gg: AY/fxX5IbrxLcSb8rBZ4W1PxCE0iuFB2rb3WU9zkjQ759JJ1hkGMZzMRHzBcDsiumZH
	QxKBFqTvWvKL6/dWn1HLTruncjtKcONqvXzw0lXHwER87eo9dwewHdruLHvawcQKHyLG3SfErAy
	V9z1Mg7vpLj6jYGrgXqnfRgWf63ibpUKECd1O6bUkT8z/0LjjbM4d3kDIMPo+nkTc6O7UKv8mu3
	Elp67697wEYZ7uDtRH6sKhbnuI1I+Dkf+zcpq1DMJNHqLj4joUn6MLdsT5UcSphB1YOIx8yhEOK
	vsRALCBdFz1OgxzD+Zk5CG4Qd/vajnd92lPsEcMTXxnRt3m408NEEFhfH4vhyXWTV+fhJlt9
X-Received: by 2002:aa7:df83:0:b0:64b:5771:8fbd with SMTP id 4fb4d7f45d1cf-6507bc6074dmr15225860a12.5.1768229392534;
        Mon, 12 Jan 2026 06:49:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg3PYG3ssKkijdwkuNYFR4RE+iz8xuOvUCCQ6SXhVaANeWsiyZJ3Lv3ASL045hcT/Z291XKA==
X-Received: by 2002:aa7:df83:0:b0:64b:5771:8fbd with SMTP id 4fb4d7f45d1cf-6507bc6074dmr15225841a12.5.1768229392054;
        Mon, 12 Jan 2026 06:49:52 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6648fsm17707771a12.28.2026.01.12.06.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:49:51 -0800 (PST)
From: "Darrick J. Wong" <aalbersh@redhat.com>
X-Google-Original-From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Jan 2026 15:49:50 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 1/22] fsverity: report validation errors back to the
 filesystem
Message-ID: <dx6z2f5lrnevosqoqr4a2aa5bmxldmishn6ln22hvdkuxxmjqa@rddd4kri6bce>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

Provide a new function call so that validation errors can be reported
back to the filesystem.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/verify.c              |  4 ++++
 include/linux/fsverity.h        | 14 ++++++++++++++
 include/trace/events/fsverity.h | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 47a66f088f..ef411cf5d8 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -271,6 +271,10 @@
 		data_pos, level - 1, params->hash_alg->name, hsize, want_hash,
 		params->hash_alg->name, hsize,
 		level == 0 ? dblock->real_hash : real_hash);
+	trace_fsverity_file_corrupt(inode, data_pos, params->block_size);
+	if (inode->i_sb->s_vop->file_corrupt)
+		inode->i_sb->s_vop->file_corrupt(inode, data_pos,
+						 params->block_size);
 error:
 	for (; level > 0; level--) {
 		kunmap_local(hblocks[level - 1].addr);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 5bc7280425..b75e232890 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -128,6 +128,20 @@
 	 */
 	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
 				       u64 pos, unsigned int size);
+
+	/**
+	 * Notify the filesystem that file data is corrupt.
+	 *
+	 * @inode: the inode being validated
+	 * @pos: the file position of the invalid data
+	 * @len: the length of the invalid data
+	 *
+	 * This function is called when fs-verity detects that a portion of a
+	 * file's data is inconsistent with the Merkle tree, or a Merkle tree
+	 * block needed to validate the data is inconsistent with the level
+	 * above it.
+	 */
+	void (*file_corrupt)(struct inode *inode, loff_t pos, size_t len);
 };
 
 #ifdef CONFIG_FS_VERITY
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
index dab220884b..375fdddac6 100644
--- a/include/trace/events/fsverity.h
+++ b/include/trace/events/fsverity.h
@@ -137,6 +137,25 @@
 		__entry->hidx)
 );
 
+TRACE_EVENT(fsverity_file_corrupt,
+	TP_PROTO(const struct inode *inode, loff_t pos, size_t len),
+	TP_ARGS(inode, pos, len),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(loff_t, pos)
+		__field(size_t, len)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->pos = pos;
+		__entry->len = len;
+	),
+	TP_printk("ino %lu pos %llu len %zu",
+		(unsigned long) __entry->ino,
+		__entry->pos,
+		__entry->len)
+);
+
 #endif /* _TRACE_FSVERITY_H */
 
 /* This part must be outside protection */

-- 
- Andrey


