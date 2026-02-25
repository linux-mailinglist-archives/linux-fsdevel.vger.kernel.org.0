Return-Path: <linux-fsdevel+bounces-78342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFSNCCGknmlPWgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:26:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFED193614
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FED73068056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE531BCA9;
	Wed, 25 Feb 2026 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOaO09bs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54084318B9E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004053; cv=none; b=Ij+yk1cuxVih1h0EWaJztjMY0AffUaJ8CxOlFymlxanxuoBh41+JHp/dvjhddfzYv/66q6sePNX9Z+AtKXqaqC/thqB6BSGVtAaBTyi/gNO3FgZ9bRKkdLRhZiNYzwSXoMu6emEG/sCiRCII48tANopetYA1vgngS8H2MPX1Mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004053; c=relaxed/simple;
	bh=+MHXSU/V11E98W6bAwMdpmIpdBoJLEJvOCREqpfDnG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otRoIGnaJydTwqD0iwKoiky2DuoWuVVoqEwGKKjM0Efad4VwGmEUnG/ouPIftaHnGGBlCWyLuoLCK05QBmf06fr/I/5uIbxOXitrkL7+i1jDEgNtDZpJ3oSvkptdXCv/mJuj9IUjk0YNQKadjTMpyIVee9buHOvEWwY6ZpbiyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOaO09bs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358e5e33ddcso1398714a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 23:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004050; x=1772608850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OzVXGrSvNTobLr90pUtUa2BKuGgT0v7RjuQ020m/80=;
        b=vOaO09bso+xnxcobuyNRaQd7HOFqUhH6anqZc4F3sIPJ20xtYFg32HjHLIVuBGkftY
         AfsT8/nZtZXB1l0Cg3e9f2pTJslLDlUsEkXP77ypCwnH6SWocOCmukxTLor07m1+eyud
         cbQW4ikwgGRO2PWRc+8QnD6B+vvoqGxS6K9vmfumQcWKefuQh3ggX8pGbIQzY96oiaw2
         +QzCjPSpsS7j9Cbi0ftIS5Ylp9alOrI975nDT/1kB3f0FBGE46yhRS+1sX1tFP1JTbvV
         pAwn4zb9diLL1cg7f6VHZpeuvPhXS7ywJTEzYpznfj47smk8x91NeXJ4LNZ/Aqwd/Mdm
         GPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004050; x=1772608850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OzVXGrSvNTobLr90pUtUa2BKuGgT0v7RjuQ020m/80=;
        b=RFiqLwm/ip5+xwrryVxxIsSRnrqnyjVYZNG6yxznqcOMYRxF1YqFVQpFymk4pjB0ml
         apA/vX5Uay6yCvSMKa4fkcasGxz6519aIU5LGNOv7zbMEDRUoOs/3IWzrXFl7WV3zEBh
         zt+m1N6voxkKwc0kmh6E0Yv8100j0mopRgAyCUAl8TfiVv3RxCWsWFdp8OxmRbDK+Yuv
         T1IkFA6d7246M6l6d8PzYlWmMtQ4SJ3VP0yFwjXhfgw6HK1CHAEPoZLxauI1zAi/Or6j
         PvwAz2BuoKVjIO+GtCSpSqA5QzP9oXV4Ft8oQsobd57JEwNjvAbPzg8OidGo9xc+dHnc
         baug==
X-Forwarded-Encrypted: i=1; AJvYcCUKTrjCWkbzo2piuXWx51hfB2epLLjbIPNBqQqcMOzIMhO721HQAcMPRDYV3Xol6x1VBZ9uY/qsAzEYERl3@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfX6K4F8bJnJ4WGud0vh+SUzixh6zHSFbUhIngHXw+w1cjZj2
	yjaf8TfjJ87ofOikn9kxL74sVIhR1m3rc6UABCFMNHyIJEzFvBwpl5YAfPZYMcydzgT2igZ2iF+
	tZdpAL2OSU2K/SPqIjhsDEPS3Vg==
X-Received: from pgar14.prod.google.com ([2002:a05:6a02:2e8e:b0:c6e:4387:496a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3297:b0:35f:27d:2ded with SMTP id adf61e73a8af0-39545ea8a07mr12406592637.25.1772004049471;
 Tue, 24 Feb 2026 23:20:49 -0800 (PST)
Date: Wed, 25 Feb 2026 07:20:38 +0000
In-Reply-To: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772004043; l=3726;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=+MHXSU/V11E98W6bAwMdpmIpdBoJLEJvOCREqpfDnG0=; b=KKEMJylkZyQJS+IxTxG9HS0TUG+xGT7E9m0Nde3MM1Szh24vjYNbYhe+Zg9jWgMOtoQmg2xvM
 IBdn2AEimOhD80lhpH2xrQdgnNMxZuX0jFXVYJErsuwoepz+kV933x6
X-Mailer: b4 0.14.3
Message-ID: <20260225-gmem-st-blocks-v2-3-87d7098119a9@google.com>
Subject: [PATCH RFC v2 3/6] fs: Add .unaccount_folio callback
From: Ackerley Tng <ackerleytng@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	seanjc@google.com, rientjes@google.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, fvdl@google.com, jthoughton@google.com, 
	vannapurve@google.com, shivankg@amd.com, michael.roth@amd.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78342-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BFED193614
X-Rspamd-Action: no action

Add .unaccount_folio callback to allow filesystems to do accounting-related
updates to the inode or struct address_space mapping, when the folio is
about to be removed from the filemap/page_cache.

.free_folio cannot be used since .free_folio cannot assume that struct
address_space mapping still exists.

From the name, .invalidate_folio and .release_folio seem suitable, but
those are meant only to handle freeing of a folio's private
data. .release_folio is also not called in the truncation path.

An alternative would be to add a more general callback and call that from
filemap_remove_folio() and delete_from_page_cache_batch(). .unaccount_folio
was chosen as it is more specific to the how guest_memfd will be using this
callback in later patches. Also, .unaccount_folio only needs a single call
site.

This further refactoring was considered:

if (mapping->a_ops->unaccount_folio &&
    mapping->a_ops->unaccount_folio(folio))
	... do generic page_cache unaccounting ...

but that was abandoned since a hugetlb folio may not have an associated
mapping.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/filesystems/vfs.rst | 8 ++++++++
 include/linux/fs.h                | 1 +
 mm/filemap.c                      | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 670ba66b60e49..5ed5c43d5768b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -809,6 +809,7 @@ cache in your filesystem.  The following members are defined:
 		sector_t (*bmap)(struct address_space *, sector_t);
 		void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 		bool (*release_folio)(struct folio *, gfp_t);
+		void (*unaccount_folio)(struct folio *folio);
 		void (*free_folio)(struct folio *);
 		ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 		int (*migrate_folio)(struct mapping *, struct folio *dst,
@@ -967,6 +968,13 @@ cache in your filesystem.  The following members are defined:
 	its release_folio will need to ensure this.  Possibly it can
 	clear the uptodate flag if it cannot free private data yet.
 
+``unaccount_folio``
+       unaccount_folio is called under inode lock and struct
+       address_space's xa_lock, just before the folio is removed from
+       the page cache in order to allow updating any kind of
+       accounting on the inode or address_space mapping while the
+       address_space mapping still exists.
+
 ``free_folio``
 	free_folio is called once the folio is no longer visible in the
 	page cache in order to allow the cleanup of any private data.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a01621fa636a6..c71f327032142 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -422,6 +422,7 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
+	void (*unaccount_folio)(struct folio *folio);
 	void (*free_folio)(struct folio *folio);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a7..ff957929e6087 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -176,6 +176,9 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 		}
 	}
 
+	if (unlikely(mapping->a_ops->unaccount_folio))
+		mapping->a_ops->unaccount_folio(folio);
+
 	/* hugetlb folios do not participate in page cache accounting. */
 	if (folio_test_hugetlb(folio))
 		return;

-- 
2.53.0.414.gf7e9f6c205-goog


