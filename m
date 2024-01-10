Return-Path: <linux-fsdevel+bounces-7690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F292829631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DB41C21930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411E3F8D4;
	Wed, 10 Jan 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VvT59FfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CB3EA8A;
	Wed, 10 Jan 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vemtm26RZJwq2BkJen0DsgudNpnNIQOHTlEDhkpMTMQ=; b=VvT59FfZyGViQ4E9bybilVlr/n
	E58xcBMqiG7yHbZRyzY+MeZqOUO73LE+/oyqen6J0wutWRO0UD5OylhJ4Mqx1GoUwrpWkQ9ockMTO
	zyTTGC4l3K2AVsMneNh/767/v9arpPkmZu6jv9Kpv6xyiCQwY2IKXC2f87wwmXRPgcGR0L6ncNvtJ
	bRz65LMjl5Yq3e1j5b56u9hCiLVBySWQ/Sr/aid4EvqC/7O7zhvFA590kdpkdOalJHAgkUUs+n+Vw
	EHaNxwv8+03GiryNOsM8jEJ2KcP9yx6govhS285icE+S4S6N7L/QIGjZIj5ny8VRfIkY7q9yV3/yB
	MgyUdYOw==;
Received: from [2001:4bb8:191:2f6b:27f:45ef:e74a:3466] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUlv-00AsAi-1t;
	Wed, 10 Jan 2024 09:21:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	x86@kernel.org,
	linux-sgx@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH 1/2] mm: add a mapping_clear_large_folios helper
Date: Wed, 10 Jan 2024 10:21:08 +0100
Message-Id: <20240110092109.1950011-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110092109.1950011-1-hch@lst.de>
References: <20240110092109.1950011-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Users of shmem_kernel_file_setup might not be able to deal with large
folios (yet).  Give them a way to disable large folio support on their
mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 06142ff7f9ce0e..352d1f8423292c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -343,6 +343,20 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
+/**
+ * mapping_clear_large_folios() - Disable large folio support for a mapping
+ * @mapping: The mapping.
+ *
+ * This can be called to undo the effect of mapping_set_large_folios().
+ *
+ * Context: This should not be called while the inode is active as it
+ * is non-atomic.
+ */
+static inline void mapping_clear_large_folios(struct address_space *mapping)
+{
+	__clear_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+}
+
 /*
  * Large folio support currently depends on THP.  These dependencies are
  * being worked on but are not yet fixed.
-- 
2.39.2


